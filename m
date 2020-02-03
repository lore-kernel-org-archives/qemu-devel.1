Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767CEC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439F52080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaEOFscW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439F52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydWQ-0003X6-Cz
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iydVV-0002Jh-5L
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iydVU-0001G2-2W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:19:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iydVT-0001E3-Rw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580743163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RlFIj4DI9wFk+wxoebdBLLHLRZp8ZSyr2deFmmZbems=;
 b=IaEOFscWDKWI2A2G6H3PFapcZjnLj8aIEJiHAZ4Lh2b0klYTeqnrdrpdZIyMYJO9l2yPwW
 LWFvTHvbDZSGd+YthG/+XE5JTk0HgA3TQ2tfPD3yd/Y46n4kRCPwSNE+QZVVbo3v9bVQnc
 2cDhBc+bso5VG/aSdhhBl/1QZyq4EjQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-FTeSUc57PQKOqH-4j7BjMg-1; Mon, 03 Feb 2020 10:19:21 -0500
Received: by mail-qk1-f200.google.com with SMTP id f22so9615134qka.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rJ3sKqXuDt9hRqfvlS1b0ePFFWqQ5OZ6wqtBD+VGOGY=;
 b=IGT67Ns2OaVBYRg110eTvgZHY8dQaA5nY45HmO4qzuFzlKn/lkL49Ol9hu8k+rMLYh
 Ydfu+3piR7vUKNTmktSCSMNwG/+uPJOpWsJsTE4BgxnxTrX8pdXI/EychpwjZNG/Orvm
 LiHzh/7nIk0VGjv/7mtIUKEoWKame2WiJ6EZHtmuf+Ype5VhDx/PKZr0uNu25XcsBaa1
 td3FosO5QsdnGjRdcYOu0/QpFJJF6RCs/0te3xq0OE2igPRl0ATkKtGWC8vFD08hXpTo
 /zI5U+BzFRCDOJRXRd3dtzI8oVTf1hpIiRfw5jDT5snpNCCbwIJusYJqLAZ37RsZnUWp
 yUew==
X-Gm-Message-State: APjAAAXfc1YkQNtuIJNtHiROY10PH/Ej/Ba7nVebYfxvqz8ocKDKlNvC
 39c+dkXrBW8JMH+l3/BcSHt8YPIQmgOmv9Pry8NsFX8KpDGYuCY2eRcQmSLZ9GueXdYUA5mvcnf
 RTuAM00KMPEUAwXw=
X-Received: by 2002:ae9:f408:: with SMTP id y8mr23059164qkl.97.1580743161062; 
 Mon, 03 Feb 2020 07:19:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcXZiQI3j3qlZCj6HQTFVm9yIEdFXLp4yciH/Q0NwqJEzI3VJ4k2xOlopkYu3U/nfMdBDujQ==
X-Received: by 2002:ae9:f408:: with SMTP id y8mr23059134qkl.97.1580743160784; 
 Mon, 03 Feb 2020 07:19:20 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id r13sm9802840qtt.70.2020.02.03.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 07:19:20 -0800 (PST)
Date: Mon, 3 Feb 2020 10:19:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 03/10] virtio-iommu: Implement attach/detach command
Message-ID: <20200203151917.GD155875@xz-x1>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-4-eric.auger@redhat.com>
 <20200203134915.GA155875@xz-x1>
 <ce49f691-d944-2e5e-87a3-7e7c9651c2af@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce49f691-d944-2e5e-87a3-7e7c9651c2af@redhat.com>
X-MC-Unique: FTeSUc57PQKOqH-4j7BjMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 03:59:00PM +0100, Auger Eric wrote:

[...]

> >> +static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpo=
int *ep)
> >> +{
> >> +    QLIST_REMOVE(ep, next);
> >> +    g_tree_unref(ep->domain->mappings);
> >=20
> > Here domain->mapping is unreferenced for each endpoint, while at [1]
> > below you only reference the domain->mappings if it's the first
> > endpoint.  Is that problematic?
> in [1] I take a ref to the domain->mappings if it is *not* the 1st
> endpoint. This aims at deleting the mappings gtree when the last EP is
> detached from the domain.
>=20
> This fixes the issue reported by Jean in:
> https://patchwork.kernel.org/patch/11258267/#23046313

Ah OK. :)

However this is tricky.  How about do explicit g_tree_destroy() in
virtio_iommu_detach() when it's the last endpoint?  I see that you
have:

    /*
     * when the last EP is detached, simply remove the domain for
     * the domain list and destroy it. Note its mappings were already
     * freed by the ref count mechanism. Next operation involving
     * the same domain id will re-create one domain object.
     */
    if (QLIST_EMPTY(&domain->endpoint_list)) {
        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
    }

Then it becomes:

    if (QLIST_EMPTY(&domain->endpoint_list)) {
        g_tree_destroy(domain->mappings);
        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
    }

And also remove the trick in attach() so you take the domain ref
unconditionally.  Would that work?

Thanks,

--=20
Peter Xu


