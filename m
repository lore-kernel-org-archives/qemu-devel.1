Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FFC56201
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37DC20719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqCgb+n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37DC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPFU-0008WR-Rn
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYPBc-0005is-1M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYPBX-0003CG-T3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604044253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=nnyV6U2LzEaiS5MFaLvH7gk9T2CEit3FqFKfvdnfNXw=;
 b=cqCgb+n1vqx0FvgxnNejJl5QRk43q9ewl4OKwYpzJJVgqycNkVvGlr1I0UT/s+6vm19qRD
 wY3lem2+w8kAmEzSko5p2rX1c3ecYe6di5K1t/V/rolDKWa0hLkRzGxoFwchETt8BLxzTS
 ZxgL+sPoSooCPkWA5fo3hV6dQb5Dz4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-dShenltaMHK7QgdCTee-qA-1; Fri, 30 Oct 2020 03:50:48 -0400
X-MC-Unique: dShenltaMHK7QgdCTee-qA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 935486D581;
 Fri, 30 Oct 2020 07:50:47 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35BB855761;
 Fri, 30 Oct 2020 07:50:46 +0000 (UTC)
Date: Fri, 30 Oct 2020 07:50:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: hao.wu@intel.com
Subject: ENQCMD
Message-ID: <20201030075046.GA307361@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kevin.tian@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
The "Scalable Work Submission in Device Virtualization" talk at KVM
Forum 2020 was interesting and I have some beginner questions about
ENQCMD:
https://static.sched.com/hosted_files/kvmforum2020/22/Scalable_Work_Submission_In_Device_Virtualization.pdf

Security
--------
If the ENQCMD instruction is allowed for userspace applications, how can
they be prevented from writing to the MMIO address directly (without the
ENQCMD instruction) and faking the 64-byte enqueue register data format?
For example, they could set the PRIV bit or an arbitrary PASID.

Work Queue Design
-----------------
Have you looked at extending existing hardware interfaces like NVMe or
VIRTIO to support enqueue registers?

Have you benchmarked NVMe or VIRTIO devices using ENQCMD instead of
the traditional submission queuing mechanism?

Is ENQCMD faster than traditional I/O request submission? If not, then I
guess it's only intended for shared queues where the PASID translation
is needed?

A few thoughts come to mind:

 * Traditional submission queues are no longer needed and can be
   replaced by an enqueue register. NVMe sqs and VIRTIO avail rings
   aren't needed anymore, although the sqes and vring descriptors are
   still needed to represent commands and buffers.

   Or the enqueue register can be used simply as a doorbell to start DMA
   reading requests from a traditional submission queue. In this case
   the advantage is that a single shared hardware unit (ADI) can emulate
   multiple queues at the same time.

 * In order to support submitting multiple requests in a single enqueue
   register access there needs to be some kind of chaining mechanism.
   For example, the Device Specific Command field contains a num_reqs
   field telling the device how many requests to DMA.

I don't know much about ENQCMD and am trying to figure out where it fits
in. Please let me know if this matches how this feature is intended to
be used.

Thanks,
Stefan

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+bxdYACgkQnKSrs4Gr
c8iPYwf/ZjOUVGQQz4TZmbc4n+G6uPHONhvDQPA24rQNQ1uOtao0JrmwNqM9y4YQ
jOrbuyY+Ne+ElupVu5oaHUIcJkzqCCuxR5iPCVno/qUPiL64tq67yMwhEXwQ93+I
pKnK9Jm5aZLNFP/VK9QAJxnZTj/r8jZDunjFxQyd1EV4y3BqBNJxmg8XqOEW9PVA
8zdOdl89z1VB6lKCAvaFslU+nWW4UAjs6af9rgqYp1r/EHh2c+LcsxibvwX56f2i
33YRwE40dsDm1UgW0w9OiqCw+RvqUf4GU45oE4/aA7M1PCoL6US6zrAfUtFx9ize
z1nEmiGy4tdfcgjgVihOo2Bc89jJ1w==
=+rfy
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


