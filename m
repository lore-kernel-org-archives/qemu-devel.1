Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2571C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2E820732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYUFOrla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2E820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Bt3-00031l-KR
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j6BsC-0002UK-Cv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j6BsB-0007XN-8X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:26:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j6BsB-0007WC-0Q
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:26:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t23so8628262wmi.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=t2FKyYNYv29I1YO83V55AaYWaLSaPKvf7U2eKevp8TQ=;
 b=BYUFOrla2nCvf6fGDrJOX6mCwVKp0q9/pIM0WPHSagWVwpK622eDvGmTn9gYwI5Isw
 FS2zEWWWoiXwp2scT1RNz+DSG9LouOZ3GGlkYVv3ifmpl1mYOu68qfys5sM0w236Ay7y
 XMgNf67gRPzNdmWX7KnGd/S1im3HoNSzZkuiLg0e9sapRUIBoOY19wKgXe7i9G91JUG6
 nlP3qxbfxQ0v3uMgtvLV2GzV5ZnnAIQCuNOl9Qyt+OxrjS6sC1W5X8YiTEeBlTU/7WhK
 So2ApAnLtypMh3UcUVjDCxBSoSDaXlbJAgyIlLCWje7sdDwGdLRV5juvzpHBkMNlESA7
 zj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t2FKyYNYv29I1YO83V55AaYWaLSaPKvf7U2eKevp8TQ=;
 b=LJxiDZE15HAIB+Z7gSGpGWIOGwwMwa0G7utTKgvHmAqf6XyNkaAZ1tUjTrvw4/RdaT
 NCNjIWkfv+QZJxigT4/7+px2RiQ3o9hUl97Hvo1vvKRCwBC0tov9kcu/3G4QpOWj4Mlx
 9ZM943B5Wrn0POeI4QBkrwkx/vOOo/6XplUhz1kGZwiYO6TLMmy0urvnGS5uZUiMkwhf
 lLKm/XNbR2Vpwus2lgaNOK+4mv2G1PoK6ZolvfKJrmeUYhyzOlyd91UqXQPPMtUriTMl
 5GEsaLM+/9BL70hUKsr1+pItvx0ps9jLO7GMojOo6QfCPNSYeLlovB7dqk3ZIdOtfj+J
 Mbyw==
X-Gm-Message-State: APjAAAWt5pVK+G74b0a32RRKzI8qZ9/QcAxsWewTCHOqGklWu53TCZqE
 /AbVyJ0v2ab9uzTW02ZqZp4=
X-Google-Smtp-Source: APXvYqwTdcrgmbX/JJY3ZJe3nN7Mf9NA5ZstBE061YHYOx05/gEmhjFyyYW5mBivObSU5q6cPA/QmQ==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr22328057wmi.46.1582543560632; 
 Mon, 24 Feb 2020 03:26:00 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v8sm17921591wrw.2.2020.02.24.03.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 03:25:59 -0800 (PST)
Date: Mon, 24 Feb 2020 11:25:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [GSoC/Outreachy] Arduino complete setup visualization and
 emulation
Message-ID: <20200224112557.GA1896391@stefanha-x1.localdomain>
References: <CAAdtpL524K2QFSU9ZK2zbW_EJyiDPJ=efhwRWVzCpsJUP6HioA@mail.gmail.com>
 <20200211105119.GA422372@stefanha-x1.localdomain>
 <20200221105620.GD1484511@stefanha-x1.localdomain>
 <675f0951-7f47-ada3-e30d-4f8b2416253c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <675f0951-7f47-ada3-e30d-4f8b2416253c@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 12:14:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/21/20 11:56 AM, Stefan Hajnoczi wrote:
> > On Tue, Feb 11, 2020 at 10:51:19AM +0000, Stefan Hajnoczi wrote:
> > > On Mon, Feb 10, 2020 at 08:58:28PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> >=20
> > Ping?
> >=20
> > QEMU has been accepted as a mentoring organization.  Please post a final
> > version of this project idea on the wiki:
> >=20
> >    https://wiki.qemu.org/Google_Summer_of_Code_2020
>=20
> I apologize, quickly after we chat on IRC about this last week I did the
> modifications but forgot to reply to this thread.
>=20
> There is the project description with 1 FIXME and 2 TODO (add the
> references), we will update the wiki tomorrow:

Great!  Instructions on adding it to the wiki are here:
https://wiki.qemu.org/Google_Summer_of_Code_2020#How_to_add_a_project_idea

Stefan

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5TssUACgkQnKSrs4Gr
c8j/OggAoT6AAGISYWisOrRylYFahqP30zD4oK9mUAnRDJnL4r/Ow2g22qybUpon
i4gmBUBQLIzfeB/0X8rGxNflHzHUFvulF6Ea5XMerCPCRuMh7PO2wxJV0Lop7WYY
gbnGPHRlBJwb3vjOex7S1aButtvPhUP0BYHTnnvlazEEZa20MG7jE55z5bE//UoX
dNVpT/vv5lFQHBUozeaytlTHdLjdfDjxVVhFnj7/qyPdhpTjm3u0ucRh5KfMIdsg
T5SCW2d3LFTxpDSwIe95YAliW98Xib1FBWjrOX+32wFFw7c9/1/SKUpcf3dP/ogA
+wOansG8sFCqp00FwrDMQ5BlxiB6iw==
=TPkY
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

