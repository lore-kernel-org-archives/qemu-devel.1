Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34FCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821FA2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeYkxj9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821FA2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSgU-0001zn-Dd
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iQSeO-0000Zo-PV
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iQSeM-0006IO-Jw
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iQSeL-0006CZ-Tq
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572598277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ktp9lhDtVKvIHfR99rgDCIdSp2yeuZotk6sUT/R7FA=;
 b=PeYkxj9V5PYlUQRjYQN9D4AuCnZoWtgZ+HQLpkKIkNbKawxPFn6tOvjMl6txLYV1/pkE77
 oeDSSNiXGQnx8xexeo+U/CrlCzi5xriJ7wNVAe75r6Jijkmd8Q5pcllPuklSp6xl5gaETo
 Sjr+uNoQCUpb0MqWysGKhLcIR7Rewr0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-mJON-rfYOCu-G-eV4x0ugA-1; Fri, 01 Nov 2019 04:51:15 -0400
Received: by mail-qt1-f199.google.com with SMTP id v23so9188877qth.20
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P5XOZGyw2oG7H0SnvrpnKTJA5LnJvwTZ0jVxtaaPC4g=;
 b=ucuYVUY+yzPU6z7/I1ZgbcTpoqfavvTeuWiXBGw75kW0oSguqlj7rDAQtNqK0tCwsK
 2fSxJ+7OiFQYyTw060ub6VeOm4uOt1uU4OFa+py9DJgyamxG39xavRhqrW4h9QCnwfVL
 Vox/tElKSNWZy+sXWdxXVDa9+CcPnT2sXdKLfknmvrgvCphlSpKOhFRpyg5qfxb1HL7+
 oXOrpvZxMVzp2rKh9DioHZV3tnzSe95Cc5el03s1JEFpQ3C2/NbdSms8lKmLIrt62rSt
 BwCEccNlmOedRtgB32M293ecVqzHdS/e7/sE55U+B0ktTltiU/CarWLlo5nAIQ77aiff
 eU8w==
X-Gm-Message-State: APjAAAVogkwfqNEqoJKIpqg9NOfcnEhmUarIBP1Nt82lQVN5tZDY5dZP
 EKWkN/evAkLF3h+2WdDCICdJzCIjbWnmIszzrBjdL2yuoTbwm7CkF7IGgeuWrw2aYPb6SSzvhhs
 d6OANEN/On9HFhzs=
X-Received: by 2002:a37:4ccb:: with SMTP id z194mr1660268qka.128.1572598275218; 
 Fri, 01 Nov 2019 01:51:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznVLmhcvqDP9+wbCuzkX2TVWL1sCyMMrKm8HTrClFL3Is3yNefPoiinVdvNFThvIqtAV7wqA==
X-Received: by 2002:a37:4ccb:: with SMTP id z194mr1660256qka.128.1572598274910; 
 Fri, 01 Nov 2019 01:51:14 -0700 (PDT)
Received: from redhat.com ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id h23sm3910913qkk.56.2019.11.01.01.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:13 -0700 (PDT)
Date: Fri, 1 Nov 2019 04:51:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org
Subject: Re: presentation at kvm forum and pagefaults
Message-ID: <20191101044700-mutt-send-email-mst@kernel.org>
References: <20191031234601-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191031234601-mutt-send-email-mst@kernel.org>
X-MC-Unique: mJON-rfYOCu-G-eV4x0ugA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 01, 2019 at 12:07:01AM -0400, Michael S. Tsirkin wrote:
> Regarding the presentation I gave at the kvm forum
> on pagefaults.
>=20
> Two points:
>=20
>=20
> 1. pagefaults are important not just for migration.
> They are important for performance features such as
> autonuma and huge pages, since this relies on moving
> pages around.
> Migration can maybe be solved by switch to software but
> this is not a good solution for numa and thp  since
> at a given time some page is likely being moved.
>=20

Also, pagefaults might allow iommu page table shadowing to scale better
to huge guests. As in, the host IOMMU page tables can be populated
lazily on fault. I'm not sure what the performance of such an approach
would be though, but this space might be worth exploring.


>=20
>=20
>=20
> 2.  For devices such as networking RX order in which buffers are
> used *does not matter*.
> Thus if a device gets a fault in response to attempt to store a buffer
> into memory, it can just re-try, using the next buffer in queue instead.
>=20
> This works because normally buffers can be used out of order by device.
>=20
> The faulted buffer will be reused by another buffer when driver notifies
> device page has been faulted in.
>=20
> Note buffers are processed by buffer in the order in which they have
> been used, *not* the order in which they have been put in the queue.  So
> this will *not* cause any packet reordering for the driver.
>=20
> Packets will only get dropped if all buffers are swapped
> out, which should be rare with a large RX queue.
>=20
>=20
> As I said at the forum, a side buffer for X packets
> to be stored temporarily is also additionally possible. But with the abov=
e
> it is no longer strictly required.
>=20
>=20
> This conflicts with the IN_ORDER feature flag, I guess we will have to
> re-think this flag then. If we do feel we need to salvage IN_ORDER as is,
> maybe device can use the buffer with length 0 and driver will re-post it
> later, but I am not I am not sure about this since involving the VF
> driver seems inelegant.
>=20
> --=20
> MST


