Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA7F20658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UT358/Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA7F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfWg-0003xv-GR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvfW8-0003XY-06
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:24:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvfW6-00058a-3s
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594812241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWZTkzAA9DPHcbpakWqj0PIztNWmUWrWx7WehE0uGxY=;
 b=UT358/Sf5dqpzqy0uCBUCjdqyTl60xemNLq5nRa3L5bS5MKKKj7LTOdGY2Rf0FIuODFT5I
 ubeTI0VBXnfQ79bKiYy3kvwISvD8EYlFAnsgZSkWJEjCDwtFrnTpaIOKR+przt70BggvW3
 BbAIMuN/QrwVSqcCoa6L/KBCHmNmYkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-g5yh5mM0NC2f_gxsTnHCZQ-1; Wed, 15 Jul 2020 07:23:51 -0400
X-MC-Unique: g5yh5mM0NC2f_gxsTnHCZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38DE5801E6A;
 Wed, 15 Jul 2020 11:23:50 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 883A661463;
 Wed, 15 Jul 2020 11:23:43 +0000 (UTC)
Date: Wed, 15 Jul 2020 12:23:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nikos Dragazis <ndragazis@arrikto.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200715112342.GD18817@stefanha-x1.localdomain>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Several projects are underway to create an inter-VM device emulation
interface:

 * ivshmem v2
   https://www.mail-archive.com/qemu-devel@nongnu.org/msg706465.html

   A PCI device that provides shared-memory communication between VMs.
   This device already exists but is limited in its current form. The
   "v2" project updates IVSHMEM's capabilities and makes it suitable as
   a VIRTIO transport.

   Jan Kiszka is working on this and has posted specs for review.

 * virtio-vhost-user
   https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06429.html

   A VIRTIO device that transports the vhost-user protocol. Allows
   vhost-user device emulation to be implemented by another VM.

   Nikos Dragazis is working on this with QEMU, DPDK, and VIRTIO patches
   posted.

 * VFIO-over-socket
   https://github.com/tmakatos/qemu/blob/master/docs/devel/vfio-over-socket.rst

   Similar to the vhost-user protocol in spirit but for any PCI device.
   Uses the Linux VFIO ioctl API as the protocol instead of vhost.

   It doesn't have a virtio-vhost-user equivalent yet, but the same
   approach could be applied to VFIO-over-socket too.

   Thanos Makatos and John G. Johnson are working on this. The draft
   spec is available.

Let's have a call to figure out:

1. What is unique about these approaches and how do they overlap?
2. Can we focus development and code review efforts to get something
   merged sooner?

Jan and Nikos: do you have time to join on Monday, 20th of July at 15:00
UTC?
https://www.timeanddate.com/worldclock/fixedtime.html?iso=20200720T1500

Video call URL: https://bluejeans.com/240406010

It would be nice if Thanos and/or JJ could join the call too. Others
welcome too (feel free to forward this email)!

Stefan

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8O5z0ACgkQnKSrs4Gr
c8hjeAf/cWBoN6BvfVBV9auavDcf7KWOyIGyAQ1Km9eixV3EALOXNevMK7Nx7pWM
JVHpTDwQu9fafM2tryPtQFmOSYB6xddYMbXXKzuXiZyE95OAVOSUMS76Fr5X3Z9r
pPn4TjK00P2WG/ztfjLO3HyxCpVkinWaaEAFcaFK6sIZ0U+GbbL758QfAvc9Z0Xp
uwhk3ldruGEvNeq0iMYp1LzNurX/1vI9m+P2gkNcFxwe/xI0NtgJ0cmlZh5efCkA
4in3ac+qs1lfM8W6MI1/XHSUv5qKvCe9scWiN4eXNuzxqmTht2ti+RyoN8cJ4wwT
REBQPTd6KNnBTgu8URZjHU1cjKBi6w==
=ATKX
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--


