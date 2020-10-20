Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8030DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D509A22251
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axEbR89O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D509A22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxGK-00036n-He
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUxEw-0002Gt-7J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUxEu-0007hh-9o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603221846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ha976sjSQpmbDoykCbkQtiuh0E8jZdzYcn+h61TyUHo=;
 b=axEbR89O5aFYQ0H2ciTxo0AECKsDZXoRtqK9bOPUCjRzE2T3vai1dJMR6P4aP8ptPnbc0q
 BZFmMq8jlgtWUdyyvVTqXcZYbKPxQeSAb01zMuQzuT1xzLTdp4LhyUYylcJE8vT2YhzZaT
 VH7siOz462V/s2OoZ/O0l7rwYKRb6VI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-qOLMiFjeOiutRSm0k-yfNQ-1; Tue, 20 Oct 2020 15:24:04 -0400
X-MC-Unique: qOLMiFjeOiutRSm0k-yfNQ-1
Received: by mail-qt1-f200.google.com with SMTP id d22so2558161qtn.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 12:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ha976sjSQpmbDoykCbkQtiuh0E8jZdzYcn+h61TyUHo=;
 b=EJ15qbsYCZ4iKXTsRiUhTYbVjhY7kpuXxjY0csBlXAnuuffmxCUicMotgMg4aHrhqb
 nWJb48oLOUzc/eMaayDf2TZp15k5yGBm/VCL/zRMGwhZ3fnradgDwZ69zGXmDa45E6NB
 bCpgKWmVt4+Et/55yKgj239ZxKgpuYcoaI6+7K61VCoFxpBTpgPmAc5zS702/aAUbQ9K
 +qCMV0eXzWp1QfMwD9l0MDOh9A1TJF8Hw90LSKEuaG4M4JbZAF6Uj37MbTpcHstrkayN
 NtAOAFdCdrpwcRHI9fUGpVi65uafsczZmLdD5tcWNkBZNpE+CGqDJc69oVV4MrXcg2yY
 /mtA==
X-Gm-Message-State: AOAM532sEq80JbdxT4gkrqa5VKkLP+g72FTMV2N9QX/58bEvGy2c/YTf
 8ZeLkn3zUn5xM+xUjSj9B0ey5X4sONaAyTwT/nZBcvJfx3edK2/xfhKBml1q8H6xjq3htrlZLV0
 zyvX5EhlzDA2s50E=
X-Received: by 2002:a05:620a:5b9:: with SMTP id
 q25mr4309422qkq.501.1603221843839; 
 Tue, 20 Oct 2020 12:24:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoxj3apvSGiWZqiJOg4j743g7vGHan0JIZb6YgCSg5XG5h+d/KitudlGuUBlF/8tfa0i5cuA==
X-Received: by 2002:a05:620a:5b9:: with SMTP id
 q25mr4309397qkq.501.1603221843633; 
 Tue, 20 Oct 2020 12:24:03 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id t1sm1306184qkh.19.2020.10.20.12.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 12:24:02 -0700 (PDT)
Date: Tue, 20 Oct 2020 15:24:01 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 1/6] memory: Introduce sparse RAM handler for
 memory regions
Message-ID: <20201020192401.GC200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-2-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924160423.106747-2-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 06:04:18PM +0200, David Hildenbrand wrote:
> +static inline void memory_region_set_sparse_ram_handler(MemoryRegion *mr,
> +                                                        SparseRAMHandler *srh)
> +{
> +    g_assert(memory_region_is_ram(mr));

Nit: Maybe assert mr->srh==NULL here?  If sparse ram handler is exclusive,
which afaiu, is a yes.

> +    mr->srh = srh;
> +}
> +
> +static inline void memory_region_register_sparse_ram_notifier(MemoryRegion *mr,
> +                                                           SparseRAMNotifier *n)
> +{
> +    SparseRAMHandler *srh = memory_region_get_sparse_ram_handler(mr);
> +    SparseRAMHandlerClass *srhc = SPARSE_RAM_HANDLER_GET_CLASS(srh);
> +
> +    srhc->register_listener(srh, mr, n);

I feel like you need to check srhc!=NULL first or vfio may start crash without
virtio-mem...  Same question to the other ones (at least unregister).

-- 
Peter Xu


