Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC2C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BBB217F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BKmCyVQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BBB217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOoAE-0003Bw-3z
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:53:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47809)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOo9M-0002sv-5b
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOo9K-0007qn-8s
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:52:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:45229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hOo9J-0007q8-UB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557427898;
	bh=taU56wQr3iCTxfLVSZ7m0EBFzDHiFtZqGqu6+HhSL5U=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=BKmCyVQ0iQIg6wi86f/KmBvCAPseieKSlccmmcLPrwp9TnR9boONDF2wYOPW0PuBX
	apdGkVKnd9L5A+jYvKD/JugLOQrEDV3lU3rE2RyVqQ+SSJfTAxrUVJm1d7BvrBkdK/
	4LjqDuOd3ZIBekyc1WnFkv0cI95YwixeAiL527J0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
	[212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1gr7wt18IP-00cyxK;
	Thu, 09 May 2019 20:51:38 +0200
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190508085645.11595-1-kraxel@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
	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
	4XSbcg==
Message-ID: <afb9fa7b-64df-74e6-86b4-e6254d82555e@gmx.com>
Date: Thu, 9 May 2019 20:52:23 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190508085645.11595-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hW3qivGdIMCqqanfIRNl6GfAAPYOrqbMm"
X-Provags-ID: V03:K1:ZB+/yYQ0ijC0hxoKLrh+XndoAhXHMUWXHsJ/I43V5zeSSypjAv8
	zwj/fsvskgkVSnflaS2ZRVy6iUJ5rdA9IR4PoVBFpS+9SGPfkHACgyLf7kGEvwtsdOqDTJw
	HEy6dlXBSzPMVC/gk+aIQ9LLvisT73ZAm7oYzKJhqRy7PXTzCTvUxjOYC512wsccnmpxks0
	3BSU+JtzH2aj/1xn1xWUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iuZbTvQE2k=:qQEnURTWXO1M4pjM0hHyny
	l9TiVK5hu8Y59suyqNVN507mT2oATD41ayzGLhfHYxbGStXendo+fxJWdAeg0qn99i9v+Lix3
	ez47YBhVV3xih7LZ4i6stev8ufAc1ZqopoYNSDbkhAsV5egdI/lOUEbjDbFkwm+kNP4E2P3PH
	leLBei9RV9Mzi/6c7jq5AYaps49ceKmRUOECGdVwRnf4arg7eSi/QvdhEiv34pkbzz9rgd3zh
	ij+nSavOCxJwiY87a9ew9bGcclX+87KMwXboxe0xqRXyNeLhj0xGjTmfRFgy4mCDlqW49cNDt
	tqlzB4DRLthiy2N6Usp1XKUIlgjAVMEDrQNchKkGFFAv9oMsCQS7Hfn6AvLgvwlCNjFVrmg6Z
	5gvlncujyixQ+E6sgV7p9oRMJYABIvtCj4/Lp555ujeJY8sQYqTF5okOm2jws/aZvUehET89e
	3M2no0svqZzmxVRPJsBk4fcL51TzfVNgY8zjBSynE7ggEiCq4MzCheOOTRek/wfuacEm9/yg1
	Oj5+KGa83AIXP0MpAdVIzrnpcAm7WWa8DElduk7nQ25gt7qxx1GgZ+FO5/WY6TgeitMO0ap4P
	qEb9Q4QyNNY0CRUqez0rGc9G9oy7IMTVxRrUjdzd4/epcPepwtDY8HaiE8TUyOSL5MxrDjdGK
	fX4tFXXgSCLIkN0BxLbd6eNq+/3Ht1sQm9kKSGlxr1uiqrpl4JNSJIQhLuCWZ3DQhaAOB2YaA
	x9cJK8vd5Sf0OhosO+VDSRHiRFKiI/DD8zHJ1oE8FtdSgvG2iST4+O3CKFhUBJ2WZVZs5TWL9
	K0AfZbqyVnpowqa+I5r8JQOqiyGnmsyf2FSdl8YkYajaKXDbMgBtXL9nR6a+CGJ04esuCYozp
	ucJajp7tqurwbFfKMyyOzinhC+W2j6f/hyhhEIN+Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 00/13] tests/vm: serial console autoinstall,
 misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hW3qivGdIMCqqanfIRNl6GfAAPYOrqbMm
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Message-ID: <afb9fa7b-64df-74e6-86b4-e6254d82555e@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] tests/vm: serial console autoinstall,
 misc fixes.
References: <20190508085645.11595-1-kraxel@redhat.com>
In-Reply-To: <20190508085645.11595-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2019 10:56, Gerd Hoffmann wrote:
> This patch series changes the way virtual machines for test builds are
> managed.  They are created locally on the developer machine now.  The
> installer is booted on the serial console and the scripts walks through=

> the dialogs to install and configure the guest.
>=20
> That takes the download.patchew.org server out of the loop and makes it=

> alot easier to tweak the guest images (adding build dependencies for
> example).
>=20
> The install scripts take care to apply host proxy settings (from *_prox=
y
> environment variables) to the guest, so any package downloads will be
> routed through the proxy and can be cached that way.  This also makes
> them work behind strict firewalls.
>=20
> There are also a bunch of smaller tweaks for tests/vm to fix issues I
> was struggling with.  See commit messages of individual patches for
> details.
>=20
> Known issue:  NetBSD package install is not working for me right now.
> It did work a while ago.  Not sure what is going on here.
>=20

Error log? What is the command? pkgin install?

> Do we have accelerator support for the BSDs?

KVM-style?

NetBSD does support HAXM (--accel hax) and in a downstream copy NVMM
(-accel nvmm).

http://blog.netbsd.org/tnf/entry/the_hardware_assisted_virtualization_cha=
llenge

http://blog.netbsd.org/tnf/entry/from_zero_to_nvmm

Once NVMM will stabilize we intend to submit it upstream.

There is no support for hardware assisted acceleration in qemu for any
other BSD.

>  A "make check" for a full
> build takes ages, and I suspect tcg being used is part of the problem.
> I did my tests using "TARGET_LIST=3Dx86_64-softmmu" because of that.
>=20
> Gerd Hoffmann (13):
>   scripts: use git archive in archive-source
>   tests/vm: send proxy environment variables over ssh
>   tests/vm: send locale environment variables over ssh
>   tests/vm: use ssh with pty unconditionally
>   tests/vm: run test builds on snapshot
>   tests/vm: add vm-boot-{ssh,serial}-<guest> targets
>   tests/vm: add DEBUG=3D1 to help text
>   tests/vm: serial console support helpers
>   tests/vm: openbsd autoinstall, using serial console
>   tests/vm: freebsd autoinstall, using serial console
>   tests/vm: netbsd autoinstall, using serial console
>   tests/vm: fedora autoinstall, using serial console
>   tests/vm: ubuntu.i386: apt proxy setup
>=20
>  tests/vm/basevm.py        | 125 ++++++++++++++++++++++---
>  scripts/archive-source.sh |  72 +++++++--------
>  tests/vm/Makefile.include |  25 ++++-
>  tests/vm/fedora           | 187 ++++++++++++++++++++++++++++++++++++++=

>  tests/vm/freebsd          | 172 +++++++++++++++++++++++++++++++++--
>  tests/vm/netbsd           | 178 ++++++++++++++++++++++++++++++++++--
>  tests/vm/openbsd          | 150 +++++++++++++++++++++++++++---
>  tests/vm/ubuntu.i386      |   4 +
>  8 files changed, 830 insertions(+), 83 deletions(-)
>  create mode 100755 tests/vm/fedora
>=20



--hW3qivGdIMCqqanfIRNl6GfAAPYOrqbMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzUducACgkQS7MI6bAu
dmzpBA//T4kNCw+No+VAnpYvs6QICnTP2PxNlg2lBiFImapW6ffX3SUcFzeqjQBv
QTwsGC5zRDpt0QSr3SJbnfbRzLMyN1/WwhkT5lpDgFs3lwtm0qLZ9RKMfrjDveAJ
6WWxfla0wXfYNG7+cZFGgG93Qid8GUJ1vBhjq2DZW9NVo1QVb/WeRrqEnQcQZr27
FedW/I1WTrYWn4ZRVdxwqsZBx1fDQldXXJc7FJnJuLHIqtUVZErd5UIDFCxVyL+B
2ldsbJqCNdxIxZc9RbII78IBgNHbnbAHv2W+FPnOjIQye4MNH/4iIDCSGmwiWhkq
RpOHJknp683AT7F6deVzTRzhMG1rezwgUNkFC8gj3fiz7HXer9rtOLQmbMti02bU
LocOLcbeugZ8841/SamHgj6bxw3TK1eMVWJCEMommVY/CsdO568KRFA+AX1LJeW3
KmX2ok3ODVtThzH0Kv6UOxfXKHUAsFFZCdLVEX3XuceP0VSjDmEMqRu+1I9FMxTT
LhyBinptVlNPrhTbP6zt0rWZuGmBt/OP6b35eKu6UkIv2aIVNXuF7lwY9DjQSX3z
tItSC1Ci0f06x69gWA7L4VcHfG54lZ+L22W+7RHsWK2Lq0WAe2OtC6CFMcrCkWoO
S735XOvRI9fFHRCE3e1WOADdXRIHi2pb150DnT3iGMORwOTx6lc=
=jKxT
-----END PGP SIGNATURE-----

--hW3qivGdIMCqqanfIRNl6GfAAPYOrqbMm--

