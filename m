Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F7C3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 05:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C769623711
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 05:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pH5qBKWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C769623711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3va5-0005iz-Gr
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 01:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3vWq-0004Sw-93
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3vWn-0006QH-MB
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:02:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i3vWm-000661-4S
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 01:02:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46L42s0Df8z9sDB; Sat, 31 Aug 2019 15:02:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567227733;
 bh=9EsDDtM7orDnL7p5D3oH93uY8/Lk+mVnejLrW04y0rE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pH5qBKWd2t3vlEUpTXtCSRyrG5joNTRB1sRwIrDdcivDp+bWGEp/F/lSgbbpz7mal
 lmimD5/8G8rayHbJ3wcHa3p0EM+Ut+NxCkgvJVlm27MEM2fH1SKQ5iVU/7lSvD0T0Q
 C5EIzPrxWL14z7+AEtItAImTOCbVlBZKpHmUttEI=
Date: Sat, 31 Aug 2019 11:48:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190831014834.GC12065@umbus.fritz.box>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20190830175648.GE3694@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 02:56:48PM -0300, Eduardo Habkost wrote:
> On Thu, Aug 29, 2019 at 11:31:25AM +1000, David Gibson wrote:
> > If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
> > machine when the openssl-devel package isn't installed, I get the
> > following very cryptic error:
> >=20
> >   VENV    /home/dwg/qemu/build/rhel8/tests/venv
> >   PIP     /home/dwg/qemu/tests/requirements.txt
> > Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "import=
 setuptools, tokenize;__file__=3D'/tmp/pip-build-la4el5r5/cryptography/setu=
p.py';f=3Dgetattr(tokenize, 'open', open)(__file__);code=3Df.read().replace=
('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --r=
ecord /tmp/pip-1efs22iz-record/install-record.txt --single-version-external=
ly-managed --compile --install-headers /home/dwg/qemu/build/rhel8/tests/ven=
v/include/site/python3.6/cryptography" failed with error code 1 in /tmp/pip=
-build-la4el5r5/cryptography/
> >=20
> > Using V=3D1 doesn't give any more useful information, and it's not
> > (easily) possible to manually re-run the given command since it relies
> > on things in /tmp that are removed once the attempt finishes.
>=20
> V=3D1 is supposed to show the actual pip command being run.  I see
> it here:
>=20
>   $ make check-venv V=3D1
>   [...]
>   python3 -B -m venv --system-site-packages /home/ehabkost/rh/proj/virt/q=
emu/tests/venv
> * /home/ehabkost/rh/proj/virt/qemu/tests/venv/bin/python -m pip -q instal=
l -r /home/ehabkost/rh/proj/virt/qemu/tests/requirements.txt
>   You are using pip version 19.0.3, however version 19.2.3 is available.
>   You should consider upgrading via the 'pip install --upgrade pip' comma=
nd.
>   touch /home/ehabkost/rh/proj/virt/qemu/tests/venv
>=20
> Can you reproduce the problem if you re-run the pip command?

Yes, I can, but it's basically just the same error without any extra
information.

> > I only figured out it was openssl-devel being missing that was the
> > problem by (mostly) guesswork.  It would be really great if we could
> > generate a more helpful error here.
>=20
> I don't think there's much we can do about it, as the error is generated =
by a
> package being built by pip.
>=20
> There's one thing we can do to make it slightly better: not passing `-q` =
to pip
> if running with V=3D1, so people can see which packages are being install=
ed and
> which one is generating the error.

That sounds like a good start to me.

> > In addition, if I rerun "make check-acceptance" it no longer even
> > attempts the PIP install, since tests/venv already exists in my build
> > environment.  It then sort of works, but I think it might be hitting
> > other errors because of the missing python packages.  Sorry that's a
> > bit vague - I also seem to be getting unrelated errors that I'm still
> > trying to figure out.
>=20
> This sounds like a bug and we need to fix it.

I agree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1p0fIACgkQbDjKyiDZ
s5Ju/w/5AR1aC304co6i5130va7fA/B8yNQNH23/w1dyjgb7QaM7ocI0HgwD3XkG
jhEaNY0h/ALz6DM4znLKtsEyMcxLYabqGxZEmG8GWUYDJ/LeIhLFcqhVOneADry2
YQRglpmR0H9j4WXadVyRcQLcifrYIaUw4TC2/NYshcjQaCFuqcc0hUM+pgSHJrdH
SxX7Y0kPnYgp0KUyXOBjnFh/rci4gsDDFMdONoNignWb2T//w/Ht2BogBeoLnAP+
LuBq6VLcMnquX4QXhjCbOUVqvh5nYngp9ssiQ3TrsG3wJWaCAe+Qz57pepweVWuV
y3Ox9HkaJGSY6bW2QkQJWSzWLMpAlwv9Rejaj/OWb3h8pi4mMhtcwtupWo3cu1wj
LrEu+sKvMO382D1Mb7Y0Bk1G5UKHeQ/WDNhDJs+37AQ1sQjxLiVufW/kgvF4iQZj
0zBctIs7UmAVCje0RYE6J87KOoDIizDr/4sh4jLW209LFVJS2hLaneJ1wI1ibT6F
+/iVKTy2Mt6JRrxH6MWnrrQhALnZzODtJoc6Kqgjwv8Qu4x4UdOvGNZH8c0Pc3KC
jUYf4yFJ7gKJS10QUmiovWim9YACYMq1Pg6BJCksyJ3a7aindF5prOxpRlKjcK31
OsXUWuLfjF+jUEgauMJbQsir8ozennmB20l5j7T8duCNypy+TOY=
=O1wn
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--

