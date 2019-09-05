Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AFDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 02:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7AB206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 02:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7AB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5hgR-0008LC-8N
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 22:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i5hfk-0007wI-E5
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 22:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i5hfi-00029T-Cd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 22:38:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60963 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i5hfg-0001vh-Ot
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 22:38:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46P4cz17Qbz9sNT; Thu,  5 Sep 2019 12:38:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567651123;
 bh=mdVr2a2qDcAlf/csiQh4T630fvQLer7O4WeQhQu0S6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WV3tEzR8EToItLAtpZfATrErvG1eR7O3I3KAuGuRWGAVoX3nAiMXPC0q3XdEok4Xm
 DqmbvJjeu0vdCT+mCsH5lTxKFUOarDGtEXSIZvQPzvJXePw0oqDSzpTAJKPR3ZT0BW
 TnilnlgR9++dhwW5EA2B9MO5Pa3POU9o/4uXI4Qw=
Date: Thu, 5 Sep 2019 12:09:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190905020924.GB2120@umbus.fritz.box>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20190904195717.GA2311@localhost.localdomain>
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
Cc: ldoktor@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> On Sat, Aug 31, 2019 at 11:48:34AM +1000, David Gibson wrote:
> > On Fri, Aug 30, 2019 at 02:56:48PM -0300, Eduardo Habkost wrote:
> > > On Thu, Aug 29, 2019 at 11:31:25AM +1000, David Gibson wrote:
> > > > If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
> > > > machine when the openssl-devel package isn't installed, I get the
> > > > following very cryptic error:
> > > >=20
> > > >   VENV    /home/dwg/qemu/build/rhel8/tests/venv
> > > >   PIP     /home/dwg/qemu/tests/requirements.txt
> > > > Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "im=
port setuptools, tokenize;__file__=3D'/tmp/pip-build-la4el5r5/cryptography/=
setup.py';f=3Dgetattr(tokenize, 'open', open)(__file__);code=3Df.read().rep=
lace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install=
 --record /tmp/pip-1efs22iz-record/install-record.txt --single-version-exte=
rnally-managed --compile --install-headers /home/dwg/qemu/build/rhel8/tests=
/venv/include/site/python3.6/cryptography" failed with error code 1 in /tmp=
/pip-build-la4el5r5/cryptography/
> > > >=20
> > > > Using V=3D1 doesn't give any more useful information, and it's not
> > > > (easily) possible to manually re-run the given command since it rel=
ies
> > > > on things in /tmp that are removed once the attempt finishes.
> > >=20
> > > V=3D1 is supposed to show the actual pip command being run.  I see
> > > it here:
> > >=20
> > >   $ make check-venv V=3D1
> > >   [...]
> > >   python3 -B -m venv --system-site-packages /home/ehabkost/rh/proj/vi=
rt/qemu/tests/venv
> > > * /home/ehabkost/rh/proj/virt/qemu/tests/venv/bin/python -m pip -q in=
stall -r /home/ehabkost/rh/proj/virt/qemu/tests/requirements.txt
> > >   You are using pip version 19.0.3, however version 19.2.3 is availab=
le.
> > >   You should consider upgrading via the 'pip install --upgrade pip' c=
ommand.
> > >   touch /home/ehabkost/rh/proj/virt/qemu/tests/venv
> > >=20
> > > Can you reproduce the problem if you re-run the pip command?
> >=20
> > Yes, I can, but it's basically just the same error without any extra
> > information.
> >=20
> > > > I only figured out it was openssl-devel being missing that was the
> > > > problem by (mostly) guesswork.  It would be really great if we could
> > > > generate a more helpful error here.
> > >=20
> > > I don't think there's much we can do about it, as the error is genera=
ted by a
> > > package being built by pip.
> > >=20
> > > There's one thing we can do to make it slightly better: not passing `=
-q` to pip
> > > if running with V=3D1, so people can see which packages are being ins=
talled and
> > > which one is generating the error.
> >=20
> > That sounds like a good start to me.
> >=20
> > > > In addition, if I rerun "make check-acceptance" it no longer even
> > > > attempts the PIP install, since tests/venv already exists in my bui=
ld
> > > > environment.  It then sort of works, but I think it might be hitting
> > > > other errors because of the missing python packages.  Sorry that's a
> > > > bit vague - I also seem to be getting unrelated errors that I'm sti=
ll
> > > > trying to figure out.
> > >=20
> > > This sounds like a bug and we need to fix it.
> >=20
> > I agree.
>=20
> Hi David,
>=20
> I've pushed a branch here (most of the commits have already been sent
> separately):
>=20
>    https://github.com/clebergnu/qemu/tree/ppc64
>=20
> I've tested on a RHEL 8 ppc64le Power 9, and it seems to work for me.
> My steps for building QEMU:
>=20
>   - Configured with: '/home/cleber/src/qemu/configure' '--enable-slirp=3D=
git' '--python=3D/usr/bin/python3' '--target-list=3Dx86_64-softmmu,ppc64-so=
ftmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-softmmu,mips64-softmm=
u,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-softmmu,m68k-softmmu,ris=
cv64-softmmu'
>   - make
>   - make check-acceptance
>=20
> Would you be able to test if that branch works smoothly for you?

So, with this tree I'm no longer getting problems if openssl-devel is
not installed, so that much looks good.

I am getting some different errors - I was seeing this before (with
openssl-devel installed) sometimes, but only sometimes.  I haven't yet
worked out a pattern for when they appeared.  They also don't appear
to be fatal, the rest of the tests seem to be running ok.  Any ideas?

 VENV    /home/dwg/qemu/build/rhel8/tests/venv
  PIP     /home/dwg/qemu/tests/requirements.txt
  AVOCADO tests/acceptance
Error running method "run" of plugin "html": 'Namespace' object has no attr=
ibute 'get'
Error running method "run" of plugin "varianter_cit": 'Namespace' object ha=
s no attribute 'get'
JOB ID     : 6808bb316632af2bf7652586b3fbb22ac497e090
JOB LOG    : /home/dwg/qemu/build/rhel8/tests/results/job-2019-09-04T22.06-=
6808bb3/job.log
Error running method "initialize" of plugin "varianter_cit": 'Namespace' ob=
ject has no attribute 'get'
Error running method "initialize" of plugin "yaml_to_mux": 'Namespace' obje=
ct has no attribute 'get'
 (01/34) /home/dwg/qemu/tests/acceptance/boot_linux_console.py:BootLinuxCon=
sole.test_x86_64_pc: PASS (4.45 s)

=2E..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1wblQACgkQbDjKyiDZ
s5KSDBAA5MaCceG5L8GsuEoLvsvtni0/2O6mUaUYXfw0OPXmTeFr9C7zC5Iw1SGV
lRqe2Sosx5M3dOhT2SGLivte3lvgyONBscPPZh0BFQEUnp/05tudYgu8E7i5FCXO
L1J6KlNb2fym6/+Ag+FXRclYblOi6IY0BFv4jEWVsEksVuch4CGHu7J4XPqkaN/q
69amsz584H4wOzo8sAbgMG0vHy/wYyxmhV94uhiv5/yiLdoECOcjrdhtr5u4hgzG
5Y5+QWfIT/XTYkCAGqymYAH5vTxa8QaAPK1zjm/v8A4V8j5ugPffZQr56YIFPcnH
OwUgT7Iu98aL1vhepwgokYPUh39rQVREHIuHrrOxcW9+UO+51NeqsUK1lDn+s2VQ
b3Sb6f7VyxMs27RQbPrrcDgwq8JqZR4/Q+DPPDAD6Ma5Gp0OcJU3Ef+seHMfM3AE
0Q0gJygGp2rM7/gm4zDlmk888Nzk8q5KUp5WK31o4RmyNC4vUpankosXVEA5cs+J
MlbXAlwteHqINt7eL4KB+Ayn/XoQM+E4TrmVPmyw8SoExi2y6mpq9gx2un94jErc
+lqFz/GPn1QlPRJ6515gQp4ZhLAv14f+RDydLjCKpIMChoUaXoKifir2qjjqDF5M
YkJqhl9OCoMqq4a8rL4cQYwCmxOFsx74XK4doX9d57tDx1vfCcs=
=gm91
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

