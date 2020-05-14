Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5899CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D38020575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38020575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6Vq-0005PZ-Cd
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ6Uz-0004aw-RP; Thu, 14 May 2020 01:33:37 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:60234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ6Ux-0006EF-GI; Thu, 14 May 2020 01:33:36 -0400
Received: from [88.198.139.25] (helo=[10.17.32.77])
 by mail.hetzner.company with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ6Uo-0004zW-NL; Thu, 14 May 2020 07:33:26 +0200
Subject: Re: [PATCH] qemu-nbd: Close inherited stderr
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <ac17fad1-baf1-75ad-843d-cab8d17f1b2e@hetzner.com>
 <fa1525c8-879a-56cd-5585-e855c7c1abce@hetzner.com>
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
Message-ID: <e12ccc8e-ddf1-4a88-4f3d-03a6f1b99d91@hetzner.com>
Date: Thu, 14 May 2020 07:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fa1525c8-879a-56cd-5585-e855c7c1abce@hetzner.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qn3jFuIkXfucGR2Ip1witxTtv8Jd07zdU"
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
--qn3jFuIkXfucGR2Ip1witxTtv8Jd07zdU
Content-Type: multipart/mixed; boundary="R0NhbZdzaSFcRw4jD93mNIstSG0SSTOmk"

--R0NhbZdzaSFcRw4jD93mNIstSG0SSTOmk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 5/13/20 3:02 PM, Eric Blake wrote:
> Yes, now that we know about it, the bug will be fixed in 5.1; we can
> also cc: qemu-stable to get it backported to the next 5.0.x release
> (downstream developers are also more likely to backport it to their
> ports as well if it lands on qemu-stable).=C2=A0 Would you like to try =
your
> hand at a v2 patch, or shall I just turn my proposal into a formal patc=
h
> and mention you as the reporter?=C2=A0 Time-wise, it may be faster for =
me to
> just take over the patch than to spend the time coaching you through to=

> the point of your first successful submission, but project-wise, it is
> always better to welcome in new contributors and share the wealth,
> rather than making maintainers become the bottleneck.
>=20

I'll give v2 a try and cc qemu-stable.
Thanks for the opportunity.

--=20
Hetzner Online GmbH
Am Datacenter-Park 1
08223 Falkenstein/Vogtland
raphael.pour@hetzner.com
www.hetzner.com

Registergericht Ansbach, HRB 6089
Gesch=C3=A4ftsf=C3=BChrer: Martin Hetzner, Stephan Konvickova, G=C3=BCnth=
er M=C3=BCller


--R0NhbZdzaSFcRw4jD93mNIstSG0SSTOmk--

--qn3jFuIkXfucGR2Ip1witxTtv8Jd07zdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS+Pg4OcdvqnGb+5YnNseu3hcXrfgUCXrzYIwAKCRDNseu3hcXr
frjPAPoCLXYC4SCkknQnykgBxWz5Z4Y16uEFApJF3lpTBw2fbgD/aOzT2M3p0xy2
uEwRx3A2cgbGNVibcjfBpmJS89MuXwo=
=9Td6
-----END PGP SIGNATURE-----

--qn3jFuIkXfucGR2Ip1witxTtv8Jd07zdU--

