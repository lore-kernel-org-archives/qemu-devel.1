Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E97C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C5220675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biP0brQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsYCq-0002zw-U8
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jsYC4-0002ZQ-BG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:58:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jsYC2-0005sV-3b
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594069104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac57fPTkiE53ruVql7T+IQT6w2FyRLLLGu6rmcFd894=;
 b=biP0brQKXOp47IiETqvwkXvpzFVjpS2aqER/0srPqldExU6MPXVi5H9CApwO/chdyAocpk
 a9Vpj21+J7kq9K78HG2RFFoDcnEAvGKmESO2Ohb1WgQc9snPHErFj9OWIAXVabu/qfVacY
 Bxj8xTpAEZM5ykB1serMAu1jiAjvmwo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-KYvf88G7NXu3IwtOkV8_aQ-1; Mon, 06 Jul 2020 16:58:22 -0400
X-MC-Unique: KYvf88G7NXu3IwtOkV8_aQ-1
Received: by mail-qk1-f197.google.com with SMTP id 124so18815008qko.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 13:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ac57fPTkiE53ruVql7T+IQT6w2FyRLLLGu6rmcFd894=;
 b=Vprw/UjU9mJNA25Rt4Xku5hBNMQ3euCjIiShwljE94M+WHJanq+S0+5BhcwlMyyWcf
 EwgUwKmm2g+0LafdwrWeAwKqpYaNbGevNv8y4d23UIJGDAmpw3MVQk4+KDpF6PoWY6+l
 LR9xMGPvHb+uSJkM52Qwn2YGgxE3PDiw84hRReHzN1fJ4C+nMX+2zZK2WSGUbtsPfx9c
 Y31igxW+KsUJtaDmXELTThsGgsglSMPMrJ1bFSSkFOLdre3teSpKkClZMICMXMfVtS1T
 ccPL8l0QqLpcTyfc+4pPvWj61K3LYJbhysF+mKnU6jKm6gUXqCNtKt/B9yYLDPfve5VB
 v6Yw==
X-Gm-Message-State: AOAM533dsmcjM6O2qVXqbk9QwmHUXHNoJOr+BOLRepjhpwB5n1W6gRcc
 LHzo3xNOQlNOuLy/cWYonZKi1xyg8GM+OeoYnJXPKBrwwWBRRoooTfut7FUZ3PjkZV8Hz1I+PBQ
 McbEYFz+VPQIW4rw=
X-Received: by 2002:ae9:ed0d:: with SMTP id c13mr43079857qkg.181.1594069102153; 
 Mon, 06 Jul 2020 13:58:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrHOcLhdd9b3XLZbWMJW3BOFSnrg2Q/wcxWYUc+olknEd/CsxWtke/kr1a1nWWFfHb+HXJ7Q==
X-Received: by 2002:ae9:ed0d:: with SMTP id c13mr43079845qkg.181.1594069101935; 
 Mon, 06 Jul 2020 13:58:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id f54sm25635939qte.76.2020.07.06.13.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 13:58:21 -0700 (PDT)
Date: Mon, 6 Jul 2020 16:58:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH] intel_iommu: Use correct shift for 256 bits qi descriptor
Message-ID: <20200706205819.GC88106@xz-x1>
References: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 04, 2020 at 01:07:15AM -0700, Liu Yi L wrote:
> In chapter 10.4.23 of VT-d spec 3.0, Descriptor Width bit was introduced
> in VTD_IQA_REG. Sfotware could set this bit to tell VT-d the QI descriptor
> from software would be 256 bits. Accordingly, the VTD_IQH_QH_SHIFT should
> be 5 when descriptor size is 256 bits.
> 
> This patch adds the DW bit check when deciding the shift used to update
> VTD_IQH_REG.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


