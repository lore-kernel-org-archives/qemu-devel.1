Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BDC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EA124679
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0e+2OQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EA124679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igZwG-0007Ko-SB
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 14:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igZvf-0006vg-2z
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igZvc-00014k-1B
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:51:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igZvb-0000yR-G0
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576439501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2QBU7bplt5H5h77E13Vv4s4yKzTSYpb2cd5keim3eQ=;
 b=T0e+2OQfPRe12eZpQ4fOMSy0YwmAaRF9LRc3U6d1R2HgDKEBDO0ytiTxhZeDUG+oluPZgA
 Ueln5lg/TbkkPxMhiZMw5B5ssbDnhh9cvNY8lCx1LlNs8JiOyE19cmovhcKJ6HSUXeRqE+
 6/nh2JdgM2YO0bPdyhZ5hLq2i1h5NMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Epd7E1h6OByvME7mMpqwtQ-1; Sun, 15 Dec 2019 14:51:40 -0500
X-MC-Unique: Epd7E1h6OByvME7mMpqwtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EA9DB20
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DA46BF9A;
 Sun, 15 Dec 2019 19:51:33 +0000 (UTC)
Date: Sun, 15 Dec 2019 14:51:30 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
Message-ID: <20191215195130.GA22814@localhost.localdomain>
References: <20191211185536.16962-1-wainersm@redhat.com>
 <20191211185536.16962-2-wainersm@redhat.com>
 <20191212141342.GA26584@localhost.localdomain>
 <cfae5351-ec67-53a3-b945-5300cb834d37@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cfae5351-ec67-53a3-b945-5300cb834d37@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 10:46:17AM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 12/12/19 12:13 PM, Cleber Rosa wrote:
> > On Wed, Dec 11, 2019 at 01:55:35PM -0500, Wainer dos Santos Moschetta w=
rote:
> > > The QEMUMachine VM has a monitor setup on which an QMP
> > > connection is always attempted on _post_launch() (executed
> > > by launch()). In case the QEMU process immediatly exits
> > > then the qmp.accept() (used to establish the connection) stalls
> > > until it reaches timeout and consequently an exception raises.
> > >=20
> > > That behavior is undesirable when, for instance, it needs to
> > > gather information from the QEMU binary ($ qemu -cpu list) or a
> > > test which launches the VM expecting its failure.
> > >=20
> > > This patch adds the set_qmp_monitor() method to QEMUMachine that
> > > allows turn off the creation of the monitor machinery on VM launch.
> > >=20
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> > > ---

FIY, queued on my python-next branch.

- Cleber.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl32jr8ACgkQZX6NM6Xy
CfMnaQ/+La5IxGjJcL2vrxgFYMq+zPIav8Edyax6dD/xLhrkikDWEpNLuT71BKh+
F5drP7n4uaUQvyweMZfNBpuvqgqCSoCbLD47tEDEiKyAvFyO0K++56KF2VbUUNs7
JAklQhhZFVC1LYfudO0z7ZJoIPgd9FdfKR29MWgCQwtp0C+bGx/mOrd53/Hq7gEk
B5gjhTBvtKvUmFSHlSCwi6VTSu1wvpGRclPagKlNRBxYXaRv6RH3OfsTl2LbUaKI
T9rTB/7rp4t56zkSdkCLT6rBrh8ylZZ50kDCVzvlBVyXnxkIj2AhX4uUJumzvU8O
VXV5QZw3I/mxPkqRhOveZdv2ALFtuNoh8nTxqDfFI8OI7Tr/8H1G/hMNeOplwr+I
LrMTmHo/g/Ab0wXa8lNwBZAi6XGZK7Mfo+hw/WaivNidVzwJX07PqAXIDxS7cCN6
dBsgqrwB0LOeMDOldJN+YWmt7K7XTz5yUjM15kOx7aPDC6uuslWxht0KBxizpC++
j9HZIU03mChqTHj/WokIhfBXKZ/76mXOU2uCwYhM1njLHiHSqIz3IInkzX6fqhp3
o9bZmpRewWrYrUVBnun2OBXKxGJagRn4onb3B7bDkzjCeHWv7JTKpWWs30LZP2pm
CaXgN3fbkMr8wxslh2dld/eexnffiurddxw6lK+t4kr3kaifbAs=
=CSLg
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


