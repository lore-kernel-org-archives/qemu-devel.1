Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B0B22CBE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I34XU4XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B0B22CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3IJM-0002uD-Cb
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3IIg-0002Ul-QN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:13:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3IIe-0002QN-Hd
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596629619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGoi0B4kj3W5XHRCo3N77V3Rcg+Q0MTsjbF40Jk1jXM=;
 b=I34XU4XY/VCGgRblpPoyLkNj5/u9iQz/F6+rQfFJBOX9LT8dOhMCmC5Vk7/pVgrX/X8y2t
 pX2OfE0UJml7u1GnDs0hTo9JltAb5yR9OyVJi4+DkJbBvVuS1YHgwwfiec70jIvNKgfN+j
 giENzXw+t2T1LV5LW9LKPtjRjIFY30I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-4Nuin3KXODuL2d8ufKvY7A-1; Wed, 05 Aug 2020 08:13:37 -0400
X-MC-Unique: 4Nuin3KXODuL2d8ufKvY7A-1
Received: by mail-wm1-f71.google.com with SMTP id t26so2648485wmn.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 05:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oGoi0B4kj3W5XHRCo3N77V3Rcg+Q0MTsjbF40Jk1jXM=;
 b=lTS2fax7sB+Z8OdnpRMTbQEj73mUCRaStBD8JNB0LyiZ21vthEopvFHG4EdlyjqqYi
 JX8MenR4bpxQ6SnoN9N2XyUcGey7Chfe3T4JV/vTalCd+kAnY4tDdS7b2ajDhYAi/GGt
 aFMqqsQoWVQtXXlGequKabus7emzL0yQFFi0Op5OnvRYUVhbMd5ZKqiMOj5oxA82z+qz
 4MoNd1Gq4c1KGmDDR4g9j2fbjK4Sl7iH0Y92du43sZpzw/V5TjF3MarirGRZ8x3oZfPp
 TagPboGO+w070x/4Zs5ZGsrkyFA0hygNNm9TqX3eczV5yJ7YfeeeUCMdIN0/Xa8IPwTI
 9MZA==
X-Gm-Message-State: AOAM532naptZCkbge6DulWv5vw4D2e51XLur8BqIV6NYOQbf1wHRD948
 c33FqFGFPNeGa+c8zejJOaxzMHqu7MatT72JdS92+ipxaUczBXOd8z/mHpEYwFBfLegJbvjcsyy
 VeQIN59d47HSOnGs=
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr3087162wmh.33.1596629613848;
 Wed, 05 Aug 2020 05:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymyjFDNeb1jhUwW//lbtLG8Rw0zF9rq000aCjoxmThyAvFDVFsFBN20gA9IV/N1EzhPrAIAQ==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr3087145wmh.33.1596629613657;
 Wed, 05 Aug 2020 05:13:33 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 v67sm2650262wma.46.2020.08.05.05.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 05:13:32 -0700 (PDT)
Date: Wed, 5 Aug 2020 08:13:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
Message-ID: <20200805081144-mutt-send-email-mst@kernel.org>
References: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
 <20200805121107.GG361702@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200805121107.GG361702@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: jasowang@redhat.com, Yajun Wu <yajunw@mellanox.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 01:11:07PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2020 at 07:46:09AM +0000, Yajun Wu wrote:
> > I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
> > Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
> > Basically increase queue size can get better RX rate for my case.
> > 
> > Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly gain better performance?
> 
> Hi,
> The VIRTIO 1.1 specification says the maximum number of descriptors is
> 32768 for both split and packed virtqueues.
> 
> The vhost kernel code seems to support 32768.
> 
> The 1024 limit is an implementation limit in QEMU. Increasing it would
> require QEMU code changes. For example, VIRTQUEUE_MAX_SIZE is used as
> the size of arrays.
> 
> I can't think of a fundamental reason why QEMU needs to limit itself to
> 1024 descriptors. Raising the limit would require fixing up the code and
> ensuring that live migration remains compatible with older versions of
> QEMU.
> 
> Stefan

There's actually a reason for a limit: in theory the vq size
also sets a limit on the number of scatter/gather entries.
both QEMU and vhost can't handle a packet split over > 1k chunks.

We could add an extra limit for s/g size like block and scsi do,
this will need spec, guest and host side work.

-- 
MST


