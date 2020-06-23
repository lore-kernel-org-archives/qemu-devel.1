Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B96E2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqinJkzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B96E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneHO-0002GM-HC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jneGQ-0001Rd-Kw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:26:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jneGO-0004In-O3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592900799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJ/jqKSruetAbPv/0pR4k3wMshX/lxk3A5EUZsrPN/A=;
 b=PqinJkzFt52RgQ102reVBdmDv1cdLE8fKHAfDLJNJUTzmB+14323ghjLGIGlW/kjNa2BB+
 cWyKexC30GZgpfvSBnVkBtTSKoCop2cNZANSF40oMgFILoA+K+BY054cmL/TO8BdOJQdjz
 fyFOnCKtHu9EiHieZAmNT75nG6JM6kA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-0wFQGRVKMdiKuFPWz8KJkQ-1; Tue, 23 Jun 2020 04:26:37 -0400
X-MC-Unique: 0wFQGRVKMdiKuFPWz8KJkQ-1
Received: by mail-wm1-f71.google.com with SMTP id l2so3142488wmi.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 01:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gJ/jqKSruetAbPv/0pR4k3wMshX/lxk3A5EUZsrPN/A=;
 b=j1eIVlT3QBVb4qo0U0IXEV69mT/tmsKYc6afto91k8i3MpkVNChrPfU77i4GMv+23+
 w8PbweDc3PgyGB0giP0Ea6jZSCTPkgqLJB+xANgRZoDaHNidGEVbg086Hbfy/k0Ps+7X
 NCploLvKKEq4AjU5BdyAdmEZpaLix8/RclvLpuv9XoF/oCpu51EIlscYnEyOEdrTsEhQ
 /Co3hyNFfzyApH8Mjy+zaOqbQ5ewBTVXHvZcfwR3DgGI63mDzBlMPS1psPJOO7t88Fww
 mUAuc1/VT1xwbA2eVSOhXf7gFht1Kao0z6nb+GRw5LhOCUrtKpFhKEAqqx4BSiuwn3vR
 Ggsw==
X-Gm-Message-State: AOAM533G2QqIasYOaa/UkxqaJGPRiWHXv/qCXlSmCMxf7+jNMzOReElg
 2jGuv0qgX5fENxQT47AR3ggGn1DIUsHgON0y9bRS3YdQCUeZbyqm3+E+ig2EofidonWxu0B3Stx
 bURnO4hjocck4uvE=
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr22978630wmh.150.1592900796518; 
 Tue, 23 Jun 2020 01:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpcjKCnH84EfOPj2FlkbExr/PMOZGbnKNmRlyTbvA98cSBYNXUOtL+1V4ycBiaPNzAF9KC8w==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr22978617wmh.150.1592900796344; 
 Tue, 23 Jun 2020 01:26:36 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 65sm1528437wma.48.2020.06.23.01.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 01:26:35 -0700 (PDT)
Date: Tue, 23 Jun 2020 04:26:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 0/2] checkpatch: Do appropriate kernel->qemu renaming
Message-ID: <20200623042626-mutt-send-email-mst@kernel.org>
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 20, 2020 at 03:32:05PM +0200, Aleksandar Markovic wrote:
> There are several places where 'kernel' is mentioned instead of
> 'qemu' in checkpatch.pl.
> 
> This small series corrects this.


fine by me

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Aleksandar Markovic (2):
>   checkpatch: Rename top_of_kernel_tree() to top_of_qemu_tree()
>   checkpatch: Change occurences of 'kernel' to 'qemu' in user messages
> 
>  scripts/checkpatch.pl | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1


