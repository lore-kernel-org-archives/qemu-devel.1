Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB9C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF0E21473
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF0E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59301 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQD3H-00015j-OU
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:39:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hQD1p-0000Ck-Lb
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hQD1o-0002V3-FG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hQD1o-0002To-8H
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F71C307D850;
	Mon, 13 May 2019 15:38:10 +0000 (UTC)
Received: from localhost (ovpn-116-138.ams2.redhat.com [10.36.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D74CE1001E75;
	Mon, 13 May 2019 15:38:07 +0000 (UTC)
Date: Mon, 13 May 2019 16:38:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Rob Bradford <robert.bradford@intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Cleber Rosa <crosa@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <20190513153806.GA28978@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 15:38:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Porting NATS test cases to Avocado
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
NEMU has test cases written with the NATS framework.  They could be
upstreamed into qemu.git and converted to use the Avocado framework.
This way the existing NATS test cases can become part of qemu.git and
also run by upstream CI.

At the OpenStack Denver PTG event I suggested to Samuel that an Avocado
developer could convert a NATS test case as an example.  Cleber and/or
Wainer can help do that.

Is a NEMU developer willing to port the remaining tests and upstream
them?

Thanks,
Stefan

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzZj14ACgkQnKSrs4Gr
c8iFMgf+PWwcQ9kmeY2wAErvv7zrJdci2DBR5SVH06tMVQqCFsh1aDBrgb65Xvph
E8IWqwE9+sXrZG7oBi09joMQyglwxIIcSfRXzGWbfMZFTAsPWhkMyP+tH1gAZM0/
HGDT43Gx7Ng41dd89okMWa+ySusuTCsqQocgcDtu/FjTLRceEU/GUO5xeXsYVgB9
3f5zDLsfbN4OBCqeVsP5XVmvK+DE1LK9M8yfH0xTPka+IzJAwgRffpbpc4k2Ov/q
zTQa79X3UGcP+jcTIQ7nqXuh6JbvVva4bXjEQ5YfLLbvzRqNca3Od/KHeHQ5ecM+
DV5HA5C0JXwN/6+SQKdzOnCS3E+wVg==
=BjtF
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

