Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3612054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3612054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO8sm-0007d0-LO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iO8qp-0005Jr-Ks
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iO8qo-00084P-9y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:18:35 -0400
Received: from home.keithp.com ([63.227.221.253]:46956 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iO8qo-00083d-0V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:18:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id D8D083F2314D;
 Fri, 25 Oct 2019 16:18:28 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id LifoAZ1kDRHH; Fri, 25 Oct 2019 16:18:28 -0700 (PDT)
Received: from keithp.com (c-73-35-169-234.hsd1.wa.comcast.net [73.35.169.234])
 by elaine.keithp.com (Postfix) with ESMTPSA id 72E0E3F23129;
 Fri, 25 Oct 2019 16:18:28 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 0B88C158212D; Fri, 25 Oct 2019 16:18:27 -0700 (PDT)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
Date: Fri, 25 Oct 2019 16:18:26 -0700
Message-ID: <87h83w4dod.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> I'm going to push for somebody actually writing out a
> document and putting it somewhere that we can point to
> and say "that's the authoritative spec", please...
> it doesn't have to be a big formal thing, but I do
> think you want it written down, because the whole point
> is for multiple implementations and users to interoperate.

I can work within the RISC-V foundation to get an 'official' document
written. Having a handful of existing inter-operable implementations
will make that really easy to do :-)

> Yeah, the mux works fine for this kind of thing. There's
> no inherent reason why semihosting ought to "win" as
> the initially selected thing on the mux, though --
> typically that would be expected to be the UART/serial
> console.

That would just require moving the call to qemu_semihosting_console_init
up in the function. Doesn't really matter to me; I suspect that most
users will either user serial or semihosting, but probably not both
(except when debugging the serial driver).

This does the trick (on top of the latest patch). Let me know if this is
what you want. To get semihosting to be first, you have to disable the
serial driver if the hardware has a serial port:

        qemu -chardev stdio,mux=3Don,id=3Dstdio0 \
             -serial null \
             -semihosting-config enable=3Don,chardev=3Dstdio0 \
             -mon chardev=3Dstdio0,mode=3Dreadline"

diff --git a/vl.c b/vl.c
index ac584d97ea..7ea8a907fd 100644
=2D-- a/vl.c
+++ b/vl.c
@@ -4284,6 +4284,9 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
=20
+    /* connect semihosting console input if requested */
+    qemu_semihosting_console_init();
+
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
@@ -4381,9 +4384,6 @@ int main(int argc, char **argv, char **envp)
     ds =3D init_displaystate();
     qemu_display_init(ds, &dpy);
=20
=2D    /* connect semihosting console input if requested */
=2D    qemu_semihosting_console_init();
=2D
     /* must be after terminal init, SDL library changes signal handlers */
     os_setup_signal_handling();
=20
=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl2zgsIACgkQ2yIaaQAA
ABE1NxAAohblIr7emExOPtzbGVQhW9EFg8uenMvDJtawfeOFDRVXujjWS2ludtUx
LWXovi3++RkykMRIEyc1jVXjg5KvCBtuPJVwyLglQxrvnYivRWwh57nZdMGgiGlR
qNCiPiONfDrMJGndWmcpXR+niJ4J4ZkDRWAesJWA68gbcejYXBfQ+l5V1IjMYaLo
wdckJuy1hUAt1ZM7t8/gm1MmyCbfVmAkBQs8itUVN7cLnKksD0rXZUf/oFdgweLU
NUNuwK21mumyhIklWlrc/xU4uuKmABp94K8uxhgFsm74poWAmlcuTnw4YFo9Yggj
adjup0MDHd0bk1qALVdiJUq6S9i7HMDhjZt6xfcC4wrLzzNxZREiw8WLK5N4OOrv
h0f1J6l/OJ6XxiaxgmxptvwLcTAkViqjZ5t5Fiix+7tvTjzHhLkg5z8jJihqdffS
TCEqcx66OwN8qu2XOlhT6XbcbRDxdc92vRN0k1zzEgf0uQoRljoLIEFuVeDQxCgP
gtLjrk69xeCrUJV0LBiadVFokcvCdXGKDFj8EJjcJFTPXQqznhNB4zg+HtXy3v35
9/jZ+uIuDZpA808yLiKZL27euOFhcc0a7+sJTQKTala/vx2ajw+qs0O00IyvHILI
uKEL54gnno0C4X67DGP73Z8zzehwZHOxdDaVWNShye9YO/q//jU=
=9usu
-----END PGP SIGNATURE-----
--=-=-=--

