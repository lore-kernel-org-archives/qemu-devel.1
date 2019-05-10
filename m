Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF9C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F29E20989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1yg-0005mf-SQ
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:38:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP1xK-0004z9-4i
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP1xJ-0005TA-1W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hP1xI-0005Sl-PN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2575F86675;
	Fri, 10 May 2019 09:36:40 +0000 (UTC)
Received: from localhost (ovpn-117-147.ams2.redhat.com [10.36.117.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB2865D717;
	Fri, 10 May 2019 09:36:39 +0000 (UTC)
Date: Fri, 10 May 2019 10:36:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190510093637.GA22311@stefanha-x1.localdomain>
References: <20190510081526.15507-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190510081526.15507-1-kchamart@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 10 May 2019 09:36:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: armbru@redhat.com, rjones@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 10:15:25AM +0200, Kashyap Chamarthy wrote:
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
>=20
> Why prefer `/dev/urandom` over `/dev/random`?
> ---------------------------------------------
>=20
> The man pages of urandom(4) and random(4) state:
>=20
>     "The /dev/random device is a legacy interface which dates back to a
>     time where the cryptographic primitives used in the implementation
>     of /dev/urandom were not widely trusted.  It will return random
>     bytes only within the estimated number of bits of fresh noise in the
>     entropy pool, blocking if necessary.  /dev/random is suitable for
>     applications that need high quality randomness, and can afford
>     indeterminate delays."
>=20
> Further, the "Usage" section of the said man pages state:
>=20
>     "The /dev/random interface is considered a legacy interface, and
>     /dev/urandom is preferred and sufficient in all use cases, with the
>     exception of applications which require randomness during early boot
>     time; for these applications, getrandom(2) must be used instead,
>     because it will block until the entropy pool is initialized.
>=20
>     "If a seed file is saved across reboots as recommended below (all
>     major Linux distributions have done this since 2000 at least), the
>     output is cryptographically secure against attackers without local
>     root access as soon as it is reloaded in the boot sequence, and
>     perfectly adequate for network encryption session keys.  Since reads
>     from /dev/random may block, users will usually want to open it in
>     nonblocking mode (or perform a read with timeout), and provide some
>     sort of user notification if the desired entropy is not immediately
>     available."
>=20
> And refer to random(7) for a comparison of `/dev/random` and
> `/dev/urandom`.
>=20
>     - - -
>=20
> Given the above, change the entropy source for VirtIO-RNG device to
> `/dev/urandom`.
>=20
> Related discussion in these[1][2] past threads.
>=20
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> v2:
>  - Update commit message to mention justification for preferring
>    `/dev/urandom` over `/dev/random` [stefanha]
> ---
>  backends/rng-random.c | 2 +-
>  qemu-options.hx       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVRiUACgkQnKSrs4Gr
c8iPtQgArz4dly2f5lcX4md1qBL9hHEoPsXrWo/q2AV+md2BS4nXc6Hxtwc27AFC
DJyMcgahNT18NbWv9mOEsS466u/MUvHw73UVJ9QRlZJd0rW3ky+EXkyFU/Scs2Vv
YvUxVV55v9cNJz2uijYiUBs8AcIiY86KFq5l61UnIKT4WdLre8zCMoafsMbDIl0f
yANh704WqZuKzpZnwI7tS+bKvVc8yq4Mnv2tlCWi3FnG9lxAg4p7zoBLfBnA993z
84YmcJZENR6EQ1DciM61VHgnfkbgitqbKK8aTyIv0FP3fYV50A8ZId6HBVYE/qUb
IXBCsirygCu7brSeL3r/VoCUtKLB7w==
=LMC5
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

