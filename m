Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11762C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862852225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUVRZvd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862852225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQvh-0006ge-JA
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXQg6-0004t2-48
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXQg3-0007JB-RX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9puvHd+TppYeB2OtdvwcCuHfZmKJpXzcXqOoGDE7144=;
 b=OUVRZvd0lNbrTgzStwvwaYqLZ7kgC2/bsyF6eAaAMW8+IFdGr0e4KCZE50Kew9HGFH3msp
 M98uk0+aAZhFlL/ZhsmBHPjVx+Qp2UPkWBJPpZCnVWsLTca9HIHhO6rWHyqqEjmOReJI4K
 guYhKZubk6ugQQiC+PAu+XFBK301KQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-i8ovsGeqNMGFnJ5qvlf8gw-1; Tue, 27 Oct 2020 11:14:15 -0400
X-MC-Unique: i8ovsGeqNMGFnJ5qvlf8gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A18610E21BE;
 Tue, 27 Oct 2020 15:14:14 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D639B55781;
 Tue, 27 Oct 2020 15:14:01 +0000 (UTC)
Date: Tue, 27 Oct 2020 15:14:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201027151400.GA138065@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.g.johnson@oracle.com,
 "mst@redhat.com" <mtsirkin@redhat.com>, jag.raman@oracle.com, slp@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 thanos.makatos@nutanix.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There will be a birds-of-a-feather session at KVM Forum, a chance for
us to get together and discuss Out-of-Process Device Emulation.

Please send suggestions for the agenda!

These sessions are a good opportunity to reach agreement on topics that
are hard to discuss via mailing lists.

Ideas:
 * How will we decide that the protocol is stable? Can third-party
   applications like DPDK/SPDK use the protocol in the meantime?
 * QEMU build system requirements: how to configure and build device
   emulator binaries?
 * Common sandboxing solution shared between C and Rust-based binaries?
   minijail (https://github.com/google/minijail)? bubblewrap
   (https://github.com/containers/bubblewrap)? systemd-run?

Stefan

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+YOTgACgkQnKSrs4Gr
c8jwZAgAht/2ykkqq1RBgoAqIjcA4+CRwxXkL3euZLoB9Hk7SBS9bI5IMloQliiT
dRu7pxOdpaaVlPu/9NS1V3vEIBMwpidIqWCZbkJ+oaYScj6rcUnto0t7hsHfnerz
A3W2CSKUDRZqpX6wm2cW4RwyNlzbyXrLrBZckdn7MKnJaO2/oZzI/ls6VGa1WNaT
9P3jNGQB9oIGHfPsy0KRUTaTKUW0ajorDYdaLm2IxBXaT6g0n5NVBphyxhrVpzgp
ISO4fGtzqPQ/dvspRwMX3zByLYQJHTflbEJErtOCJgdFAGts1m2ERTAvjwRV5rtD
MZTzks84lGG4A3h7C2RcOjCJaxk3Og==
=z4Jr
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


