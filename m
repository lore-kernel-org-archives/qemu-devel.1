Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E1C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E293207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U1zFt074"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E293207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY24f-0000uY-NV
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23a-0007uN-Sv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:36:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54623 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jY23Y-000743-Rp
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:36:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49LB6k5tHlz9sSs; Mon, 11 May 2020 16:36:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589179006;
 bh=LU/g/1Jm4lQvc8vkDsb2IV5IrzbgdZwWHuU8KdDTJiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U1zFt074Vq01AQQDtTQMpq1De7o7J+hV2X0BbUtVhn6uLWTdZR77ntT9ejv4uZ9VM
 KvULJ5AdITQDJ/Fg+O+xqcLjYE5i66x/A5g+9AICDkKAGEH9jbECbRBLjY+6D6bRmt
 WbtrDcx4Mqj39KHjLydmSDFKS/tDZiFTiJoUBREU=
Date: Mon, 11 May 2020 16:33:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH RESEND v3 0/2] Makefile: libfdt: build only the strict
 necessary
Message-ID: <20200511063352.GR2183@umbus.fritz.box>
References: <20200411093150.4741-1-cfontana@suse.de>
 <20200414020303.GC48061@umbus.fritz.box>
 <47c51117-133c-9b88-4dec-b56d883f5e8b@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N+qDRRsDvMgizTft"
Content-Disposition: inline
In-Reply-To: <47c51117-133c-9b88-4dec-b56d883f5e8b@suse.de>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:36:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Alex Bennee <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--N+qDRRsDvMgizTft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 10:16:52AM +0200, Claudio Fontana wrote:
> On 4/14/20 4:03 AM, David Gibson wrote:
> > On Sat, Apr 11, 2020 at 11:31:48AM +0200, Claudio Fontana wrote:
> >> v2 -> v3:
> >>
> >> * changed into a 2 patch series; in the second patch we remove the old
> >>   compatibility gunks that were meant for removal some time after 4.1.
> >>
> >> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
> >>   existing working trees forward and backward compatible across the ch=
ange.
> >>
> >> v1 -> v2:
> >>
> >> * fix error generated when running UNCHECKED_GOALS without prior confi=
gure,
> >>   for example during make docker-image-fedora. Without configure, DSOS=
UF is
> >>   empty, and the module pattern rule in rules.mak that uses this varia=
ble
> >>   can match too much; provide a default in the Makefile to avoid it.
> >>
> >> * only attempt to build the archive when there is a non-empty list of =
objects.
> >>   This could be done in general for the %.a: pattern in rules.mak, but=
 maybe
> >>   there are valid reasons to build an empty .a?
> >>
> >> * removed some intermediate variables that did not add much value
> >>   (LIBFDT_srcdir, LIBFDT_archive)
> >>
> >> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src s=
ubdir),
> >> and with docker-image-fedora, docker-test-debug@fedora that failed
> >> before.
> >=20
> > Seems reasonable to me.  It's a bit of a shame that we can't use the
> > dtc makefiles more simply for this.  But I don't quickly know how to
> > fix them upstream to allow that.
>=20
>=20
> Hi David,

Sorry it's taken so long to reply.

> I tried to look at dtc upstream makefiles, I don't see a perfect
> solution at the moment.
>=20
> I came up with this idea though (not fully tested..) that _could_
> work, ie special casing the libfdt target when it is the only goal
> in MAKECMDGOALS.
>=20
> Any thoughts?

Bit of a hack, but still better than what we have now.  If you post
that for dtc upstream <devicetree-compiler@vger.kernel.org>, I'd apply
it.

Another improvement would be to not include these files on a "make
clean" - it's kind of annoying how a make clean will regenerate all
these before removing them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N+qDRRsDvMgizTft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl648dAACgkQbDjKyiDZ
s5Kd6BAAqcC+gdLVJOPT3WhZRMdS4Qodla+TtcqIcrLOQvSBwhai6RHmL8C6pDd2
mjgSYf1ixxaQ6WtE2mEdJmxN3c0DopvWETmz/W+6Co3dkamhzHW1mIJp13IkhoFv
i4nVzYcIRSetJ2J+Noc5irL9MdsGgUfGxG2sx1rkhVv+Syab80aVINQXg6ZDmbJ+
mbzwPUrRsd/OXDcEmCmhETj88NAyPdwPjotWDrW8FyOZRTt5f99WZZiYBz+N912+
VD2W32K4Vy/qPxEGs27cjwDotwsotXGfedk/2OPHWBN1UTjbuTQJaW+lONMUZcKO
S19ZiTuHzZiU2seqdQa3q01LuufvDFN0IIp8rZtheh1vHz/S7H+w8518lGAMSmFH
nDdozYMh3ytVDzjmn6FcIWXsoBs4e10pVujJVhIKIbMFHHu825PedDuVPO77AVuX
bWDxuoutl8a0xFsm80CllkCMcRJF4IgOhSvZyauWMw9X3NB7J25gHWBHEMUXVbQ0
N+XMK7lp2/Hn7h8BezlmmMY+BLK5Eh/rY3Gu1CxQ3WgDxrJDcsWMntLWWYEq+o0d
lE3iOJlkCzni2bm7kIiGLzM9LhN0x/H0+jAzTNy7kx7ooJyEXVqDTNuPqgIxwjZV
IPnKeWb4OvHZPVa+NF/36zplXc+a8IGFc6IiMTF3DGM1cO00cF0=
=d2u8
-----END PGP SIGNATURE-----

--N+qDRRsDvMgizTft--

