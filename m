Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CEBC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F7120684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4W1G1/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F7120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itTnS-0007pg-HQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itTmp-0007Qi-Iu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itTmo-0005tx-E8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:55:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itTmo-0005tX-5y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:55:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id a5so13792322wmb.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 01:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/HSfbxiixYQbwBYBczbWwsRX8M1dnLEkYnnj0rNLS1s=;
 b=M4W1G1/c8KJeYpzJ9Y5FsoOhHEdMASJPc2V8WM3XhvOV/nZH31/4CsWAYEaqvpCx6N
 oishPTTyBXuOtb4GDjj0llCxeHnzONJG7TESECmDDLFCRZ+H1Hv7vQz+4ggTd/hRD2xi
 BCFUsVENk+rut/qYA5gbc3bWOkawxFAUuMgE+S2a82xNzFDF1iVbQwrFD49e0rf2KCsF
 NoH9mPbgYKvrSU6XQ7O+xIRYR9nLtJUwx7J3CjQq4MC0C8eVAGUBKY2CGTtVKuV9Z1xs
 xG4x/IXx7RhVbb62dA/xORdHG20vyuybQwr1Drip/ubkWEgkan/F0ibKbhpdHyJNYsJ6
 z9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/HSfbxiixYQbwBYBczbWwsRX8M1dnLEkYnnj0rNLS1s=;
 b=KKTHRy2nFxQ59uQOrwwApFdP+1C3aNIngKcR1e8NHM4vjC18EpsRaHci+9/vyJcS3s
 lgReKHP21RB47ElkNK9hslJFcYR4JSUBLuNiSufpYf6R+9jfjdDAD1lHvKI1OgIvTgyx
 91UVQk0ExU4+pElmACdi9JEaOxaq8zApfobYdUOxMFczqsNvluj6ZCO3oTQ+fg+9oyoW
 EO6HYvVtMOUCXcoTJH+a+vtztejH3nQUj2Poed7qJs/+ZckxCKqK6mXHepeeVM69K/vg
 uOJTMmQC36zcQ2LabMDq6BFiexRJlitU59yUQ5DAEJ3fnQ/U0a5czhUQAl68edtjxNLL
 EQZg==
X-Gm-Message-State: APjAAAXwlVnnaZSsemtnqV9kxm9tzNX6yNB/UpCSnX/DtNEpWjzuSU1O
 fVxcEQAV7CNJSYLo7b0+UBo=
X-Google-Smtp-Source: APXvYqyv53SCwr4slzdedS5x6bMhq/miz3kqq4J7DK2mDC6NjMBnt5eM4xSef7dz07EHykNWHKXNfw==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr18876975wmg.83.1579514156983; 
 Mon, 20 Jan 2020 01:55:56 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h8sm49272560wrx.63.2020.01.20.01.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 01:55:55 -0800 (PST)
Date: Mon, 20 Jan 2020 09:55:54 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200120095554.GA345995@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20200102144722.GL121208@stefanha-x1.localdomain>
 <20200116110314.GA24159@paraplu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20200116110314.GA24159@paraplu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 12:03:14PM +0100, Kashyap Chamarthy wrote:
> On Thu, Jan 02, 2020 at 02:47:22PM +0000, Stefan Hajnoczi wrote:
> > On Sat, Dec 21, 2019 at 10:02:23AM +0100, Markus Armbruster wrote:
> > > Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> [...]
>=20
> > > > 2. scripts/qmp/ contains command-line tools for QMP communication.
> > > > They could use some polish and then be shipped.
> > >=20
> > > MAINTAINERS blames them on me, but they're effectively unmaintained.
> > > Prerequisite for shipping: having a maintainer who actually gives a
> > > damn.
> > ...
> > > * scripts/qmp/qmp-shell
> > >=20
> > >   Half-hearted attempt at a human-friendly wrapper around the JSON
> > >   syntax.  I have no use for this myself.
> >=20
> > I think this one is used by people.  John Snow comes to mind.
>=20
> FWIW I too frequently use 'qmp-shell'.  And some of the examples in this
> document[1] are demonstrated with it.
>=20
> I'm reasonably happy with it (particularly the persistent history
> captured in ~/.qmp-shell_history), and it has some "known issues" that
> can trip up a new user.  The one that immediately jumps to mind:
> asynchronous events won't be printed without a prompt from the user --
> e.g. after a `blockdev-commit`, you won't see BLOCK_JOB_{READY,
> COMPLETED} events printed unless you manually hit enter from the
> 'qmp-shell'.
>=20
> (Not complaining; I have a long-standing TODO to make time to
> investigate this.)
>=20
> [1] https://qemu.readthedocs.io/en/latest/interop/live-block-operations.h=
tml

John and I discussed async events in the past.  qmp-shell currently uses
the input() built-in function.  If we modify it with a
select(2)/poll(2)-style function that monitors both stdin and the QMP
socket then it could print QMP events as soon as they are received.

There might be a nicer way of doing it, but pseudo-code for the idea is:

  def input_with_events(prompt):
      while True:
          print(prompt, end=3D'', flush=3DTrue)
          readable_files =3D select([sys.stdin, qmp_socket])
          if qmp_socket in readable_files:
              print_qmp_events()

      # stdin is ready, read a line
      return input()

Stefan

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4leSoACgkQnKSrs4Gr
c8iNwgf8DYv0AWLCCFYMllOi0aqOYdCUxx1OYofxvop1SAWWBnM2dz/u3QUfUYQF
0ZVuZAqo/L7luoA7D7SCOTiXcPunLxopN/y50qw0h9hl28lNR/CPwHTZi2UmGW7R
DBB5NXsthjTzBFCsBfGKUAlchLL0K0M8vTxYWx8b2L/MOMI/RiZrA29+I0YM37qy
nXA909eAPfRKUBhQPArs5tAh/S3rPK68mtHpNYx/fPRwpDqQOqPPOIh1kQqRYPLW
mISKfMOEbOwVlsnOlejLn15RFFZbUhmAtn/5uCwvjpBgu9e/VHboA8Pt+cq/nzf/
6RY7w59wgZZSrrikcaApeoKVp6wynw==
=wARp
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

