Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D5C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76245206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76245206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYlbw-0002Uc-L7
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 03:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYlbJ-0001xv-D0; Wed, 13 May 2020 03:14:45 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:32940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYlbH-0000YI-36; Wed, 13 May 2020 03:14:44 -0400
Received: from [88.198.139.25] (helo=[10.17.32.77])
 by mail.hetzner.company with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYlbD-00014t-1h; Wed, 13 May 2020 09:14:39 +0200
Subject: Re: [PATCH] qemu-nbd: Close inherited stderr
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <ac17fad1-baf1-75ad-843d-cab8d17f1b2e@hetzner.com>
From: Raphael Pour <raphael.pour@hetzner.com>
Autocrypt: addr=raphael.pour@hetzner.com; keydata=
 mDMEXmXjyxYJKwYBBAHaRw8BAQdAtiEYnlLIuIUjvvqOH//nEbhrxSa54ZyAl7Iel403QaW0
 J1JhcGhhZWwgUG91ciA8cmFwaGFlbC5wb3VyQGhldHpuZXIuY29tPoiWBBMWCAA+FiEEvj4O
 DnHb6pxm/uWJzbHrt4XF634FAl5l48sCGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQzbHrt4XF635TcwD+NEMqL1HZPHP/WRsYujCDtqt0p+7uxGcpvzv//AjqMZ0A+wUh
 0bOYYNdlXWNMMNLA88SsAT2mxAfD+F/paVmLpdoLuDgEXmXjyxIKKwYBBAGXVQEFAQEHQB0z
 JYP6jtTj989IJL1vguinsiIxia5fkW83OB1+Bb4QAwEIB4h+BBgWCAAmFiEEvj4ODnHb6pxm
 /uWJzbHrt4XF634FAl5l48sCGwwFCQlmAYAACgkQzbHrt4XF6372LgEAi3qfceU+R53Ehg/Y
 SSHV4wg+zfPwrD6ylEg/xKabYDcBALrD0E3YX458RPjLIOC8H0u0rcFIvBqNYx/kGaMEmbEG
Message-ID: <fa1525c8-879a-56cd-5585-e855c7c1abce@hetzner.com>
Date: Wed, 13 May 2020 09:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ac17fad1-baf1-75ad-843d-cab8d17f1b2e@hetzner.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lqvG1G9aj2jlFJ8CBJHN6nG4YsLXkMcmc"
X-Authenticated-Sender: raphael.pour@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=raphael.pour@hetzner.com; helo=mail.hetzner.company
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lqvG1G9aj2jlFJ8CBJHN6nG4YsLXkMcmc
Content-Type: multipart/mixed; boundary="a2C7scKlfoD8pjLd51v7Nkk3iZ86TYlEk"

--a2C7scKlfoD8pjLd51v7Nkk3iZ86TYlEk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/12/20 3:57 PM, Eric Blake wrote:
> Wouldn't it just be simpler to not dup in the first place?
>=20
> diff --git i/qemu-nbd.c w/qemu-nbd.c
> index 4aa005004ebd..6ba2544feb3a 100644
> --- i/qemu-nbd.c
> +++ w/qemu-nbd.c
> @@ -916,7 +916,9 @@ int main(int argc, char **argv)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (pid =3D=3D =
0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 close(stderr_fd[0]);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old=
_stderr =3D dup(STDERR_FILENO);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(fork_process) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 old_stderr =3D dup(STDERR_FILENO);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D qemu_daemon(1, 0);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Temporarily redirect stderr to the parent's pipe...=C2=A0 */

Yes, you're right. We tested your patch and it also fixes the unwanted
open stderr.

Could you consider this patch in one of the next releases?

Thanks!
Raphael

--=20
Hetzner Online GmbH
Am Datacenter-Park 1
08223 Falkenstein/Vogtland
raphael.pour@hetzner.com
www.hetzner.com

Registergericht Ansbach, HRB 6089
Gesch=C3=A4ftsf=C3=BChrer: Martin Hetzner, Stephan Konvickova, G=C3=BCnth=
er M=C3=BCller


--a2C7scKlfoD8pjLd51v7Nkk3iZ86TYlEk--

--lqvG1G9aj2jlFJ8CBJHN6nG4YsLXkMcmc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS+Pg4OcdvqnGb+5YnNseu3hcXrfgUCXrueWwAKCRDNseu3hcXr
fuKDAQDFeK87V/5G5tlSy8EWPvuKcTh20b7xhin32ALn4DqotgD8CJx5Y6XnuUJu
pVEpGl4PUZqmMbTyi6kaIqSC2IwY5Qk=
=081x
-----END PGP SIGNATURE-----

--lqvG1G9aj2jlFJ8CBJHN6nG4YsLXkMcmc--

