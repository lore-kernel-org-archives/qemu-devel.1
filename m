Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA3FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A5824682
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTquE5mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5824682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFKV-0003sB-Ju
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iiFHE-0000PP-Ns
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iiFHD-0001Yk-DF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:12:56 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iiFHC-0001SW-Te
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:12:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so8872729wrr.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 02:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SDuSraUbXfMK73m0WsNxh0mAANi4/0sUr1G8JBsGIzs=;
 b=iTquE5mimPupMiyngTkHHsG0T3C+tixB6MPskd6ckk8LEvo3p9K0vDRfxy6OYZ1MQK
 hdL3qAMewzlpp5G36Jfb0Vn/uyDeur6kd4IxpwSw7DD7KX7OqzdyNhPP9Q307V8QN9n7
 HCQLtqeZmZpEVsfNpjlRC9q7zRQPspiUqSy5vJkQSGA0Fs1BEbBRiYBgiHjA28e14F7X
 Qt19xHdSmKEkI8qBLcc23SI4pSOv1m5HmHlr5gb+IWv541rYavXp8XuzziaUQGWwahuN
 fdLXXpljDbDcibPmAOH4iHv8Cu7svVxTBlyA9DneItpIOFeav2UTJ1NpIdSKqGdh5pDt
 C+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SDuSraUbXfMK73m0WsNxh0mAANi4/0sUr1G8JBsGIzs=;
 b=dxRXgnDCx2UQY6Uib8BpbZuIji1AVQoVlV+JAcJA4WQKAqNqYoVrGkeZCcJ05Jnyg5
 a4RIdN6v5NlBGqKOWKBuQ9doiiCx1ZEi/55uy27feVlxNKZrySWE5jbll/MbszVFAgeM
 6ipmkXVwZNtlKwecnUWA8zvYUAG2lZHiP/ff8kaOcDYQUaPAFjU6Qug+OaUQAn2wwnGV
 t8F61OjwS2x72Zl3xKfAXL5U/TFPRj9HtA/ZtdnrN4DsomSnh9mThi1333pjwO02TJkV
 HdGwcb7+MPnq6NGEb9e7GXP8JxEBqQfqHGkRe1s9u3VYMherYdhI1kg1YOf4z02Sm78y
 RYjw==
X-Gm-Message-State: APjAAAXjSSpZTRkHPiHXFdQGR16zY4HuANc+9MRJg9TrGzdoWGklqaxI
 EuVfgfnJOdDz78CWQNMGAhk=
X-Google-Smtp-Source: APXvYqwmw7mm308LGXuLlYOteHywnhm8Veps/v3iJZQHAUw9qDd3u3P0iF7DOL+4scoqL4sHaptc2Q==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr14049038wrv.197.1576836773581; 
 Fri, 20 Dec 2019 02:12:53 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 25sm8739825wmi.32.2019.12.20.02.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 02:12:52 -0800 (PST)
Date: Fri, 20 Dec 2019 10:12:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
Message-ID: <20191220101251.GD1635864@stefanha-x1.localdomain>
References: <20191219180205.25191-1-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20191219180205.25191-1-felipe@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 06:02:28PM +0000, Felipe Franciosi wrote:
> This improves the family of object_property_add_uintXX_ptr helpers by ena=
bling
> a default getter/setter only when desired. To prevent an API behavioural =
change
> (from clients that already used these helpers and did not want a setter),=
 we
> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter. P=
atch 1
> enhances the API and modify current users.
>=20
> While modifying the clients of the API, a couple of improvement opportuni=
ties
> were observed in ich9. These were added in separate patches (2 and 3).
>=20
> Patch 3 cleans up a lot of existing code by moving various objects to the
> enhanced API. Previously, those objects had their own getters/setters tha=
t only
> updated the values without further checks. Some of them actually lacked a=
 check
> for setting overflows, which could have resulted in undesired values bein=
g set.
> The new default setters include a check for that, not updating the values=
 in
> case of errors (and propagating them). If they did not provide an error
> pointer, then that behaviour was maintained.
>=20
> Felipe Franciosi (4):
>   qom/object: enable setter for uint types
>   ich9: fix getter type for sci_int property
>   ich9: Simplify ich9_lpc_initfn
>   qom/object: Use common get/set uint helpers
>=20
>  hw/acpi/ich9.c       |  99 ++------------------
>  hw/acpi/pcihp.c      |   7 +-
>  hw/acpi/piix4.c      |  12 +--
>  hw/isa/lpc_ich9.c    |  27 ++----
>  hw/misc/edu.c        |  13 +--
>  hw/pci-host/q35.c    |  14 +--
>  hw/ppc/spapr.c       |  18 +---
>  hw/ppc/spapr_drc.c   |   3 +-
>  include/qom/object.h |  44 +++++++--
>  memory.c             |  15 +--
>  qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
>  target/arm/cpu.c     |  22 +----
>  target/i386/sev.c    | 106 ++-------------------
>  ui/console.c         |   4 +-
>  14 files changed, 282 insertions(+), 318 deletions(-)
>=20
> --=20
> 2.20.1
>=20
> Changelog:
> v1->v2:
> - Update sci_int directly instead of using stack variable
> - Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
> - Erroring out directly (instead of using gotos) on default setters
> - Retaining lack of errp passing when it wasn't there
> v2->v3:
> - Rename flags _RD to _READ and _WR to _WRITE
> - Add a convenience _READWRITE flag
> - Drop the usage of UL in the bit flag definitions
> v3->v4:
> - Drop changes to hw/vfio/pci-quirks.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl38nqMACgkQnKSrs4Gr
c8hD7AgAhcPlQkegib+rnJw0CeRKD0EW/HOZ/qTGJpjVHBqZaqhTwOavQ4lxSX6h
33A7WlGGGSFNmFNCKt/r32o2Mou/RCYBOQAJ053NNK22EwIsgY/j2gmJq2H4MacC
to9lQu0bKNnNjhPx8bMttwQIiiaItEoJ05gcQPMAv4+2g8TQPDfhHL2Lj01LdweQ
jzry3q5H+KCZz7IQB+jep9U8kncuw2SLC+gfDBB1ZEz8yswaJ8gnoDkcIyYRjsIF
aBeniM+vc9q6MYfqWlzVpsD+KrtnV3D/C7Y+JT079jI1yrZoxfqZtNasTiirPy7u
9hsZYmVXBN9Cq0XBDN+vtwMNhg3CPQ==
=XPmb
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

