Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85845C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3FE205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3FE205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7Ul-000438-IC
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7Sy-000259-F8; Thu, 14 May 2020 02:35:36 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:52738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7Sv-0002Pj-MW; Thu, 14 May 2020 02:35:36 -0400
Received: from [88.198.139.25] (helo=[10.17.32.77])
 by mail.hetzner.company with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7St-0001R7-3j; Thu, 14 May 2020 08:35:31 +0200
Subject: Re: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
To: Eric Blake <eblake@redhat.com>
References: <1jYr2L-0004mc-Jj@mail.hetzner.company>
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
Message-ID: <b4e26df1-4031-0259-b920-b06b61139e4c@hetzner.com>
Date: Thu, 14 May 2020 08:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1jYr2L-0004mc-Jj@mail.hetzner.company>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xC4aqO1IVcgdPFOs74vMZFPqW37lBCMb9"
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xC4aqO1IVcgdPFOs74vMZFPqW37lBCMb9
Content-Type: multipart/mixed; boundary="7Ng5loIc979K7O0zyf3NUc6QkwuEfWsAM"

--7Ng5loIc979K7O0zyf3NUc6QkwuEfWsAM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...] introduced with e6df58a5, stderr won't get closed if the fork
option is __not__ set.

On 5/14/20 8:31 AM, Raphael Pour wrote:
> introduced with e6df58a5, stderr won't get closed if the fork option is=

> set.

--=20
Hetzner Online GmbH
Am Datacenter-Park 1
08223 Falkenstein/Vogtland
raphael.pour@hetzner.com
www.hetzner.com

Registergericht Ansbach, HRB 6089
Gesch=C3=A4ftsf=C3=BChrer: Martin Hetzner, Stephan Konvickova, G=C3=BCnth=
er M=C3=BCller


--7Ng5loIc979K7O0zyf3NUc6QkwuEfWsAM--

--xC4aqO1IVcgdPFOs74vMZFPqW37lBCMb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS+Pg4OcdvqnGb+5YnNseu3hcXrfgUCXrzmrwAKCRDNseu3hcXr
fkgOAQDzNs9CXquMkTwqx65lkJoIafPZwDNoZcTwikuoyRiqcAEA10Ks+lUOOtO1
kIjtYBFNQ+p/3um0TLw4dGyUm6/WFAA=
=V3Oc
-----END PGP SIGNATURE-----

--xC4aqO1IVcgdPFOs74vMZFPqW37lBCMb9--

