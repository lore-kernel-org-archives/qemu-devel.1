Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7556920724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbyma8IX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7556920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sX9-0007ft-Lk
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1sTe-00029Q-3N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1sTc-0005ui-QA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:54:54 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j1sTc-0005tP-In
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:54:52 -0500
Received: by mail-wr1-x432.google.com with SMTP id z3so2472404wru.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pxIsCLzIiIZBTXvrA990N9OJJAZy+6fW75tsngcvtNA=;
 b=Xbyma8IXA1/npXnvNOE54w+8cEpd78HE9bGPAMaNvDZaRzT5Xu2r904QJ7mrCU047/
 g9jbZjlaNyhjZ1XrXVN+66cnblIIcm7lg48gw23o7miuw/JmMsVijAdI5JozkIGcPWru
 vaTYKlL+CMY4XjuC6PyQOLb7cZV3SIe2ClLhaD2t2qKXjgYpz2Os4hbxKTuhcEmHShwp
 IAyP1E5szIijmM01lWelsHAIrDhh++pAOldd1lRPBblxGO+JsneI0jI/v+QsDpeRuoaA
 t5OICXLZFCtoHNTLy9JWCcSZOpSKMIDhx2vtKzBfa/nuxdJW+s8+K4yXI/CMpB0CQobh
 qdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pxIsCLzIiIZBTXvrA990N9OJJAZy+6fW75tsngcvtNA=;
 b=IYPpQnkY/did4Q/HtrM0pOdXr+RAcq8lmCxqBtqvsPqw6faHcBsMucLIJJZLxbSxSm
 nWv7iXTY50R00YrjIe8CCtQI0oEPDMoRrS91sL687pbeCb9cFGxpKVPBTwWduDpkLCBe
 b769uEWSB7mAZyK/uSKgwWWhd2Ql0dtuaRzDkf+6DabUZGS3wXwFWTGoxrv54dJLIRGt
 6usZ/D4xNWkoT78ahM65x4XyFk9d/wCq7h7mO/zjIOTzciZ6D6eiWFnlTbiSSUqWNzgY
 Nq9NerxEcIws1sCViN7JQzxxx4edL/TMkbGdFQbCWQ0DZQJ6umxSMGfenubNonU2Um2F
 qVLQ==
X-Gm-Message-State: APjAAAUC5B428XbNreEttWthHnJXd0RP2ppl6dg+ovWgNCxYSasml3Oa
 3ukdEy7aHK8OGDt8vMkG0Co=
X-Google-Smtp-Source: APXvYqyXfS0vDMuvII0hJ+bOWiWGHXJFInCly1Kgw2SMGFR2OS+b6M9SSbV5bPqegeofleObOFIq3Q==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr15196713wrs.159.1581515691233; 
 Wed, 12 Feb 2020 05:54:51 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c9sm801379wme.41.2020.02.12.05.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 05:54:44 -0800 (PST)
Date: Wed, 12 Feb 2020 13:54:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
Message-ID: <20200212135442.GB432724@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
 <87ftfio0ke.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <87ftfio0ke.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 05:43:13PM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Tue, Feb 4, 2020 at 3:54 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
> >> =3D Ways to provide machine-friendly initial configuration =3D
> >>
> >> Two ways to provide machine-friendly initial configuration on par with
> >> QMP have been proposed:
> >>
> >> 1. Extend QMP
> >>
> >>    Machines use the CLI only to configure a QMP socket.  The remainder
> >>    of the CLI becomes human-only, with much relaxed compatibility rule=
s.
> >>
> >> 2. QAPIfy the CLI
> >>
> >>    Provide a machine-friendly CLI based on QAPI and JSON.  The current
> >>    CLI becomes human-only, with much relaxed compatibility rules.
> >
> > Do we keep the existing CLI around in both cases?  I'm concerned that
> > we're still following the HMP/QMP approach, which has left QEMU with
> > the legacy HMP monitor that we still haven't removed.
>=20
> The "HMP is legacy" idea is relatively recent.
>=20
> I think having separate interfaces for humans and machines makes sense,
> we just need to give both the attention and care they need and deserve.
>=20
> I think a human-friendly monitor is has its use, but it should ideally
> be done differently than we do HMP now.
>=20
> Likewise, human-friendly initial configuration should exist, but it
> should ideally be done differently than we do HMP now.
>=20
> > I'm in favor of simplifying QEMU at the expense of an incompatible CLI
> > change in QEMU 6.0.
>=20
> I'm convinced the current CLI needs cleanup badly, and that means
> incompatible change.  The question is how and when to change it.
>=20
> Here's how I'd like us to do it:
>=20
> 1. Create machine-friendly initial configuration interface separate from
>    the existing CLI
>=20
>    Doesn't mean it cannot be a CLI.
>=20
> 2. Develop it step by step to feature parity with existing CLI
>=20
>    If we identify misfeatures we don't want anymore, we should
>    immediately deprecate them in the existing CLI instead.
>=20
> 2. Transition machine users to this new interface
>=20
> 3. Declare the existing CLI to be like HMP: for humans, may change
>    incompatibly
>=20
> 4. Clean up existing CLI step by step to wrap around the
>    machine-friendly interface
>=20
>    Whatever we deprecated in step 2 goes to the bit bucket instead.
>=20
>    I'm open to replacing the existing CLI by a separate wrapper process
>    instead.
>=20
>    Capability to translate to the machine-friendly interface is
>    desirable, so human users can easily transition to the
>    machine-friendly interface when they run into a need to automate.
>=20
> The risk is of course that we fail at step 4 and remain stuck with the
> CLI mess we've made.

Yes, QEMU does not have a good track record of successfully converting
to new APIs and then removing old code.

My worry is that this effort will result in the addition of even more
code but we'll still be stuck with the old cruft (both in the user
visible interface and in the implementation).

But we won't get anywhere if we don't try :).  This sounds like a
significant project and I wonder if others would be willing to help if
you can break down the tasks for them.

Stefan

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EA6IACgkQnKSrs4Gr
c8iJ7wgAsyT+pb7U8B3s53JDuPIwO+drOVzODQFMpnQrWWzZBy9Fyne3fx4z1Cgh
r83+M2JPGMtC/mO0zH5x/08Q4ltXI0UWmdM2YVbP9AKPAegB8eeVGn2Zmi42DRo0
tr6I9MTRe5vS4B9W5feux5reSFRcc0v9II52UBj6CaNPxKe+UDmSNEF9q7VcIn5t
Kc+2AooRRV9hCMoYrMrNLDxBYbbUiJPTO0+VVetzz+gDI/DsmLQJ/fMyOw9BQnai
6/NFbK040uHppiXaR1ek94KbrNWLRHH0fSBysxM4u4S5dSqOvXDK2uYW4xg7ILu6
oTPNU5lFbgsOMyfiP1zrVWHQ6IO/+A==
=2Maj
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

