Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED93C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA8D21655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkG1gm8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA8D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxLy-0006QS-65
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imxLM-00060Z-B3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imxLL-0001eS-7R
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:04:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imxLL-0001dx-0l
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:04:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so38620273wrl.13
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BATLscc48mfHUpWif2MffqTYB0WOvlMP8x34gDnT0f4=;
 b=XkG1gm8wF9lRdaqt2O5JEkYUggUSsSkbq2f19Dfk/wYIZsxgDMuVe3mOwY0fZjFI5Z
 4huKU/4fwyGvh8esYRerCssaopOO0R00KwjnOdFumFYBgJfk2kqofhKFp4SAUeGFxKyf
 xyIIa4Vmfov9GUfXFVfaUL1X9c3wqmqWQXkojBkPdv7uFzi5YCeduQqwuQU6M9Ve8r5U
 JHgusUjEGNgXjq32hSh63R31gBzpFA1MLJpz5Fe+TicVVHfrO7c7yWdkyp7HZzsJnolb
 Gd1DhxotKIWUxYzP3o6vHo11oU2RoZ8l1uxc7f/E3IFMNxXyIXPrMLU4t+68kESvEiwe
 CTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BATLscc48mfHUpWif2MffqTYB0WOvlMP8x34gDnT0f4=;
 b=MY4aIQgrY5bXl/e4vkrbDkVzNrGoHnz9TUshlhGKEWLGPk/OE/xJAO0ugian6c0AzX
 cZ9LtpszeZXX/GAr41XsK0QXnlfHq2+nuYkURLBcKLaz+OUSeQ611dmW6vx9FfSwIbJR
 +FCjpbHGwAZn/Sz0BtQb290Ygvdv+5t+gB0/yhi5TyS3Y8bfgQu/839JqemhHbfl8JAp
 iqMUOU/ya3JO0VyRYlhzRBuZ9MK8WSP8vt1iWjMFUtNXMK4VSGWjutOqBuTreY0PWau0
 cZOY1+rGIQgQFYhA7U5gz9udBZtWNwrb/mAi9O1uYNjaAIG6YrVcbTib+fsHslBu3xss
 yo5g==
X-Gm-Message-State: APjAAAWVcWBD0Gi4HarqSoeMS1Dm3nx1h+YaiLT75cRZUQIqMlWxaZGC
 BZM8QZOBgh/12PqWi/uOkNU=
X-Google-Smtp-Source: APXvYqwusked7iws9NCc6COOQgk2t3y/GJofo1F6t8PaQu9FGW9Chv0dSTVFJFCOU74DMAN8k2JTJA==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr80033857wrq.37.1577959477994; 
 Thu, 02 Jan 2020 02:04:37 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g18sm7974324wmh.48.2020.01.02.02.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 02:04:37 -0800 (PST)
Date: Thu, 2 Jan 2020 10:04:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200102100435.GE121208@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
 <20191219133650.GE1624084@stefanha-x1.localdomain>
 <D60846D3-5434-4EF8-B25F-7C70F4FA5367@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <D60846D3-5434-4EF8-B25F-7C70F4FA5367@oracle.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 09:15:40AM -0800, John G Johnson wrote:
> > On Dec 19, 2019, at 5:36 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Wed, Dec 18, 2019 at 01:00:55AM +0100, Paolo Bonzini wrote:
> >> On 17/12/19 23:57, Felipe Franciosi wrote:
> We don=E2=80=99t pin guest memory; we pass the QEMU file descriptors used=
 to create
> guest memory to the emulation program, and it mmap()s them itself. (ala
> vhost-user).

Please ignore my reply.  I just saw pinning was discussed in another
sub-thread.  Felipe posted this URL for tracking the issue:
https://github.com/nutanix/muser/issues/28

Stefan

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4NwDMACgkQnKSrs4Gr
c8gH3AgApQpzTmHr9426jMnxTyasd+LSridNEX4kL6LO8gyBNmT9HS/a9IEusPO4
z+ULjNP91WwNlEW1449+XrUyvWCP0/Mtmtanzzng+xvEhfK0S7Mpi/vXLu+YGWc0
/EoQGttI81rtjwo5AfCEiX1mj+kPep8U8BQ9oXFRLm0a4MI1P4p07K0jNgsDhjv3
9RZhoHfMw1DJDEIbjPqhpNHLoSBvenm5Kqq72pCmwFVN7zsIbbWjGaag4DUxR7X1
LuzVArj7MjmDNgJN/k55PIawByd+ScNvRxMaKUs1Zh/an1xM5R70UaTpLx50m51D
kYiYlx82KWwnacWaiHHMo5mg0Re6nw==
=02Ib
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--

