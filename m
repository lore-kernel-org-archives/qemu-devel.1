Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4717C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A4A207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YISPmw9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A4A207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYFS-0006zA-34
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZYEQ-00060F-CP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZYEN-0006DK-Lv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604317353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byB6Fo+xWPOZENbYpwNc+fejH+A8uFdFlnKg90/yJq4=;
 b=YISPmw9jWXKyTMmy92LasfunfPa/eXE/lKDfjFWfqnMAOSJzA0zFOCWQyyDO2vO0BW0/55
 U7ttipoG2YugmiG+Xgy1p7hWe+vp1AIZCMqwvJozlNu+D5HWf5aCSSZ+5Slp7+ogYsCcF/
 BlYp1R1F7x/T2tYzu6wPR283NETxRPM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-9ydFXTbAMQegCewDaXQLvA-1; Mon, 02 Nov 2020 06:42:32 -0500
X-MC-Unique: 9ydFXTbAMQegCewDaXQLvA-1
Received: by mail-wr1-f72.google.com with SMTP id 33so6276741wrf.22
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=byB6Fo+xWPOZENbYpwNc+fejH+A8uFdFlnKg90/yJq4=;
 b=a+CHj7rmccOPboHklDiJc1C00LPR32bcobf+k5EmD+MT19zluH3TH3V6bUJcUIleX6
 ORLuJ0s7V+TBxFUVueBzzgNElHd70I6ogp2FvrCJ4R9TsI74Vlk6WhnjcoI4f6+xpA4D
 lYbIqlsXxxkx46PyDZqW/2HmNxZ0/GZIOKBXkgvlRNGruBtF+cvyEvdobnEhG+Ia0GJx
 lGUCy+tAK+WJefPKYPKHUVOrIwi3acXf1HRYwktjeUvSMRnyBLyRKCOuQoyRLrImm/eB
 Qi9sXhj/eUJLoI2/nod+vC+k3JjBxQhUd6AIiGEQ41t3TrfkafGrg5okKHmdueQXncJE
 fKdQ==
X-Gm-Message-State: AOAM530IsZDAAt+uymm85zWNdkhj8QgMP4YQ2ADbiC5t/i1M1zMB8fha
 m5mWdhsWJhGca3/3nWX1EVuYHgiM83B0hcl5KnzxamAv0LRmnL9ftbYyQQx5IbwlI2ebgiK9tWi
 N46tN1v0abh5q8Q4=
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19506963wrq.129.1604317350274; 
 Mon, 02 Nov 2020 03:42:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWPCflAGzCLPXdm4rjGOZqwX0yW1OOmDwZZ5SCi2CIWuGj/UFCmswpVRlnQsWtkfsUQNRtbg==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19506952wrq.129.1604317350115; 
 Mon, 02 Nov 2020 03:42:30 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id m8sm21542322wrw.17.2020.11.02.03.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 03:42:29 -0800 (PST)
Date: Mon, 2 Nov 2020 12:42:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/input/ps2.c: Remove remnants of printf debug
Message-ID: <20201102114227.ogssja4k53qj2abz@steredhat>
References: <20201101133258.4240-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201101133258.4240-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 01, 2020 at 01:32:58PM +0000, Peter Maydell wrote:
>In commit 5edab03d4040 we added tracepoints to the ps2 keyboard
>and mouse emulation. However we didn't remove all the debug-by-printf
>support. In fact there is only one printf() remaining, and it is
>redundant with the trace_ps2_write_mouse() event next to it.
>Remove the printf() and the now-unused DEBUG* macros.
>
>Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>---
> hw/input/ps2.c | 9 ---------
> 1 file changed, 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


