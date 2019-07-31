Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6B0206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WqRcYF0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6B0206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsk98-00020C-Ib
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hsk8i-0001ZL-Sl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hsk8h-00017J-Ga
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:39:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53593 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hsk8g-00015m-Fb; Wed, 31 Jul 2019 04:39:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45z6KW07mNz9sMr; Wed, 31 Jul 2019 18:39:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564562351;
 bh=yaz6AHd28OiPBZovYbxmRxDST0fRnDH8y1p+nF7nfzA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WqRcYF0IL3zDyafRanNIzdX3re2d/H27U0UDObdDzRVdOpyOUVQG/XMadj+gKUpSG
 uiOnK7q40wmjbKkOh6tIlKAN7UQgHC9VRUkGyUw37Lxu+qpaUymNq/gUtUxyXFtf2T
 9UDZ9MwNmORQpAtUHICVLwKHe10Xokxu1S6WIZrM=
Date: Wed, 31 Jul 2019 16:51:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Message-ID: <20190731065120.GH2032@umbus.fritz.box>
References: <20190731043653.shdi5sizjp4t65op@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <20190731043653.shdi5sizjp4t65op@oak.ozlabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Implement better workaround in
 spapr-vty device
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 02:36:54PM +1000, Paul Mackerras wrote:
> Linux guest kernels have code which scans the string of characters
> returned from the H_GET_TERM_CHAR hypercall and removes any \0
> character which comes immediately after a \r character.  This is to
> work around a bug which was present in some ancient versions of
> PowerVM.  In order to avoid the corruption of the console byte stream
> that this introduced, commit 6c3bc244d3cb ("spapr: Implement bug in
> spapr-vty device to be compatible with PowerVM") added a workaround
> which adds a \0 character after every \r character.  Unfortunately,
> this corrupts the console byte stream for those operating systems,
> such as AIX, which don't remove the null bytes.
>=20
> We can avoid triggering the Linux kernel workaround if we avoid
> returning a buffer which contains a \0 after a \r.  We can do that by
> breaking out of the loop in vty_getchars() if we are about to insert a
> \0 and the previous character in the buffer is a \r.  That means we
> return the characters up to the \r for the current H_GET_TERM_CHAR,
> and the characters starting with the \0 for the next one.
>=20
> With this workaround, we don't insert any spurious characters and we
> avoid triggering the Linux kernel workaround, so the guest will
> receive an uncorrupted stream whether or not they have the workaround.
>=20
> Fixes: 6c3bc244d3cb ("spapr: Implement bug in spapr-vty device to be comp=
atible with PowerVM")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/char/spapr_vty.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 617303dbaf..65a7c2ffbd 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -57,25 +57,19 @@ static int vty_getchars(SpaprVioDevice *sdev, uint8_t=
 *buf, int max)
>      int n =3D 0;
> =20
>      while ((n < max) && (dev->out !=3D dev->in)) {
> -        buf[n++] =3D dev->buf[dev->out++ % VTERM_BUFSIZE];
> -
> -        /* PowerVM's vty implementation has a bug where it inserts a
> -         * \0 after every \r going to the guest.  Existing guests have
> -         * a workaround for this which removes every \0 immediately
> -         * following a \r, so here we make ourselves bug-for-bug
> -         * compatible, so that the guest won't drop a real \0-after-\r
> -         * that happens to occur in a binary stream. */
> -        if (buf[n - 1] =3D=3D '\r') {
> -            if (n < max) {
> -                buf[n++] =3D '\0';
> -            } else {
> -                /* No room for the extra \0, roll back and try again
> -                 * next time */
> -                dev->out--;
> -                n--;
> -                break;
> -            }
> +        /*
> +         * Long ago, PowerVM's vty implementation had a bug where it
> +         * inserted a \0 after every \r going to the guest.  Existing
> +         * guests have a workaround for this which removes every \0
> +         * immediately following a \r.  To avoid triggering this
> +         * workaround, we stop before inserting a \0 if the preceding
> +         * character in the output buffer is a \r.
> +         */
> +        if (n > 0 && (buf[n - 1] =3D=3D '\r') &&
> +                (dev->buf[dev->out % VTERM_BUFSIZE] =3D=3D '\0')) {
> +            break;
>          }
> +        buf[n++] =3D dev->buf[dev->out++ % VTERM_BUFSIZE];
>      }
> =20
>      qemu_chr_fe_accept_input(&dev->chardev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1BOmUACgkQbDjKyiDZ
s5Jtlg/+JUBOQciG/JNIvUuFVoNgE/1U4l4PVvdbPG/m8oleds/HHLmvWtDO0KIX
6C0/7phc4rwbK5Qd5Mln2sdoEHtocT3SfFB9YiGiCH/GsxtRjoxnqeIxpMDhiDLk
Ovam0mcGXFDotiF0UhOCmoFha6hVczPe0NtSyMign+elSCGvBkyDzWKQYxMHgOsb
g2zp+uf/pqWRbGK6YZ6/lfUPc3GMHCJ6NLJSpTKHPwRvsP5r6w9SXwkdrnFB3MsV
99Jbw7PDisq9e1szZdfw/k10JZYBUWL6ZJik/aeSsGcw6HFXKvk++5vWqErfe6Xn
UNne9H+i0gwred9jwh6R+ej9hshoOTnNFKTR219zG3C6RhKUSOrVSixCvJFsPj5P
sHg+hDe8RwaH1Mm0gKMwe0Dtab2dBT3FkrSIfrO1u5b4tMcEPQzsuU4Eyx/wDSxh
vzxOPLEZMa4JQIxdo1aWjD3L2si3T7Ln/Xw7j1EZ72IZfoaLM2RJ6DKZCFeGtC1C
LTiQUU7rvkT9QY499FBRWMEVzNDrMICN18jcy7GyanxqMmdo2C81tAS2oz/YgST/
mVisxZLPaOo+q56LrvnDxpWSDjmfXgTYARAFfzbILlSNS+sfz+5Vx4gS7WNZpmLu
9wnotiXYuIbooB7k2k93xRA6Q5dICvE2xcvspewGs6ylRpjxNns=
=HQ3O
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--

