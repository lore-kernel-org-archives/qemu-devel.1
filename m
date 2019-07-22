Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BBC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93094217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93094217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUqg-0002Cs-QU
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hpUqW-0001kG-8o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hpUqV-0006DU-6y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hpUqS-00069W-5i; Mon, 22 Jul 2019 05:43:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79F0083F4C;
 Mon, 22 Jul 2019 09:42:58 +0000 (UTC)
Received: from localhost (ovpn-117-250.ams2.redhat.com [10.36.117.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4E6C10027B9;
 Mon, 22 Jul 2019 09:42:55 +0000 (UTC)
Date: Mon, 22 Jul 2019 10:42:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190722094254.GG24934@stefanha-x1.localdomain>
References: <156342034915.10055.15996927583486522727@c4a48874b076>
 <413e6326-159c-f84a-ed5c-0918f8dd359c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <413e6326-159c-f84a-ed5c-0918f8dd359c@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 22 Jul 2019 09:42:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: remove unused argument to
 virtio_scsi_common_realize
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
Cc: no-reply@patchew.org, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 07:00:37AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing qemu-block@
>=20
> On 7/18/19 5:25 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20190717094728.31006-1-pbonzini@r=
edhat.com/
> [...]> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu
> J=3D14 NETWORK=3D1
> [...]
> > PASS 18 test-bdrv-drain /bdrv-drain/iothread/drain_all
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D8106=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x61200002c7f0 at pc 0x5622ea95c8b6 bp 0x7f174fdb8680 sp 0x7f174fdb8678
> > WRITE of size 1 at 0x61200002c7f0 thread T9
> > =3D=3D8108=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text functions and may produce false positives in some cases!
> >     #0 0x5622ea95c8b5 in aio_notify /tmp/qemu-test/src/util/async.c:351=
:9

The 1-byte write is probably atomic_mb_set(&ctx->notified, true) on a
freed AioContext:

000000000073b580 <aio_notify>:
  73b580:       0f ae f0                mfence
  73b583:       8b 87 98 00 00 00       mov    0x98(%rdi),%eax
  73b589:       85 c0                   test   %eax,%eax
  73b58b:       75 03                   jne    73b590 <aio_notify+0x10>
  73b58d:       c3                      retq
  73b58e:       66 90                   xchg   %ax,%ax
  73b590:       53                      push   %rbx
  73b591:       48 89 fb                mov    %rdi,%rbx
  73b594:       48 8d bf ac 00 00 00    lea    0xac(%rdi),%rdi
  73b59b:       e8 40 40 00 00          callq  73f5e0 <event_notifier_set>
  73b5a0:       b8 01 00 00 00          mov    $0x1,%eax
***
  73b5a5:       86 83 a8 00 00 00       xchg   %al,0xa8(%rbx)
***
  73b5ab:       5b                      pop    %rbx
  73b5ac:       c3                      retq

I'll take a closer look and try to reproduce this.

Stefan

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01hR4ACgkQnKSrs4Gr
c8iz9Af9GXti9WSbL1XCCxSg/L0PKn+QqiEXTJabcScnP7wtq59FLPL3psFLTDaV
7+jyXu0hUewbKLMbzQpNclGQQYaEsgRkF6hp/AQPV47Tu52LtECqcmIhPtWe/J7l
UDrsfeFw89OUE85EoAsK6AvVA14NtYvOwBBPYkVyfLQU9jP3yZeVx6WZ1A6SSXoV
1U++efs3T0UGMVLCZ6bzEYrrRBubhdku6bK0Q9HKu91YrcxOkHAtnT9ZmWH3wN3j
FX9X8QLVsRpx8Kh+dMbqExe5LZnwr2UdqfPQn9847hfc9US/zirNYxVA8OFyn2xz
f0T58U1ZJAqmQi8Xww8hkkCG6r0xvg==
=Ycoj
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

