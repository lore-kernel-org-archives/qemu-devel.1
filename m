Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A23C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4016207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLj0oDkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4016207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm12b-0002Bw-SF
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jm11w-0001U1-KB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:21:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jm11t-0002xC-Tk
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592511656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbyqWcm6o2kcczVip3aMWL8oS1Jz4+QJRJ4J186ARW0=;
 b=hLj0oDkXGkyU5RPEUkQHqNaocjy668WwJEjLru0dtslBWS0bg//fEQRJT/S4MQiCHB6AsU
 7PWkxW+SPPT3ncvhDfkC3Ke7GP0XhQzwkCs+ggxNNqB/QTolDhG+AMQ3DEG1YyXF9Us8gb
 ZN96gikRmd1cnbz3OmtGHCjvy040ShA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-BLBSY4kBOve0MihxUrtLaA-1; Thu, 18 Jun 2020 16:20:54 -0400
X-MC-Unique: BLBSY4kBOve0MihxUrtLaA-1
Received: by mail-wm1-f71.google.com with SMTP id b63so3397980wme.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=K4kGD57BvON4Ob8LozgwfQ+eJAY2Yc5b1u8LHPXTcJY=;
 b=grgYsTxMhUBm7SbNkxlBWNvRC7NyDXlOcb4YwS+2zSCbngVj7ZyZ2rmCYoqMaSxNHS
 8fugyQFNNntAcghD+89ltHkoyH7JSZR8IeKnyntOe15tuHqy/a8VMxDQmcLvRmucC8Ra
 w1uzOdNAUj5lPcZUrOIuIfHBl5Tb7aq4+xrMa4sBwg9eMBM+uhHxIoas2+7/AYVepSZd
 x7141D/6MQVLwtlB2LMdZOOyv75vZu3VBZge2Xvfo7UFRR6oXH+ubvS++p5DJ+VwwiI6
 hNvBEzxphsLy5Ly9cy2Be7ArcJ0cOmhykvGnZblRYw+02lRO+/ETKZCdbXI/z6W2WwBg
 CIJQ==
X-Gm-Message-State: AOAM531zv/4U8v+nCKSmSj4dpLAEKeqVrM4FuHUe8g/ZVGCndh37LzfQ
 b1MBPyl7rpRunT+zwqQUI299EzQCRIP3NvQQgdYsxyVWmfUhH04069T9++5f7qGiHTBxmRKLNxK
 nlaRJG4HrIgGTX4g=
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr102403wmf.18.1592511653323; 
 Thu, 18 Jun 2020 13:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4OpjY2CQS9852v//FzUZ3G/P7fc9TZE+axy00mvolQtUJL8DeuEIf31Ls3HdDZMBuPxf7QA==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr102374wmf.18.1592511653024; 
 Thu, 18 Jun 2020 13:20:53 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6868.dip0.t-ipconnect.de. [91.12.104.104])
 by smtp.gmail.com with ESMTPSA id a6sm4869746wrn.38.2020.06.18.13.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 13:20:52 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Date: Thu, 18 Jun 2020 22:20:51 +0200
Message-Id: <B304BB6D-DBDB-4C36-B376-896945E5AE6D@redhat.com>
References: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
In-Reply-To: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:52:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
>> 2. Unclear semantics. Alex tried to document what the actual semantics
>> of hinted pages are. Assume the following in the guest to a previously
>> hinted page
>>=20
>> /* page was hinted and is reused now */
>> if (page[x] !=3D Y)
>>        page[x] =3D=3D Y;
>> /* migration ends, we now run on the destination */
>> BUG_ON(page[x] !=3D Y);
>> /* BUG, because the content chan
>>=20
>> A guest can observe that. And that could be a random driver that just
>> allocated a page.
>>=20
>> (I *assume* in Linux we might catch that using kasan, but I am not 100%
>> sure, also, the actual semantics to document are unclear - e.g., for
>> other guests)
>>=20
>> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
>> zero page on the destination, it could also be something else (e.g.,
>> previously migrated values).
>=20
> So this is only an issue for pages that are pushed out of the balloon
> as a part of the shrinker process though. So fixing it would be pretty
> straightforward as we would just have to initialize or at least dirty
> pages that are leaked as a part of the shrinker. That may have an
> impact on performance though as it would result in us dirtying pages
> that are freed as a result of the shrinker being triggered.
>=20

It really depends on the desired semantics, which are unclear because there=
 is no doc/spec. Either QEMU is buggy or the kernel is buggy.

>> 3. If I am not wrong, the iothread works in
>> virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
>> the free_page_lock (no BQL).
>>=20
>> Assume we're migrating, the iothread is active, and the guest triggers a
>> device reset.
>>=20
>> virtio_balloon_device_reset() will trigger a
>> virtio_balloon_free_page_stop(s). That won't actually wait for the
>> iothread to stop, it will only temporarily lock free_page_lock and
>> update s->free_page_report_status.
>>=20
>> I think there can be a race between the device reset and the iothread.
>> Once virtio_balloon_free_page_stop() returned,
>> virtio_ballloon_get_free_page_hints() can still call
>> - virtio_queue_set_notification(vq, 0);
>> - virtio_queue_set_notification(vq, 1);
>> - virtio_notify(vdev, vq);
>> - virtqueue_pop()
>>=20
>> I doubt this is very nice.
>=20
> And our conversation had me start looking though reference to
> virtio_balloon_free_page_stop. It looks like we call it for when we
> unrealize the device or reset the device. It might make more sense for
> us to look at pushing the status to DONE and forcing the iothread to
> be flushed out.
>=20
>> There are other concerns I had regarding the iothread (e.g., while
>> reporting is active, virtio_ballloon_get_free_page_hints() is
>> essentially a busy loop, in contrast to documented -
>> continue_to_get_hints will always be true).
>>=20
>>> The appeal of hinting is that it's 0 overhead outside migration,
>>> and pains were taken to avoid keeping pages locked while
>>> hypervisor is busy.
>>>=20
>>> If we are to drop hinting completely we need to show that reporting
>>> can be comparable, and we'll probably want to add a mode for
>>> reporting that behaves somewhat similarly.
>>=20
>> Depends on the actual users. If we're dropping a feature that nobody is
>> actively using, I don't think we have to show anything.
>>=20
>> This feature obviously saw no proper review.
>=20
> I'm pretty sure it had some, as it went through several iterations as
> I recall. However I don't think the review of the virtio interface was
> very detailed as I think most of the attention was on the kernel
> interface.

Yes, that=E2=80=98s what I meant. The kernel side and the migration code (Q=
EMU) got a lot of attention.


