Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F028BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A6222522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRBRlTqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A6222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrmh-0007PT-S1
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itrlm-0006wl-50
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itrll-0002HL-0g
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:32:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itrlk-0002Ga-Pr
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:32:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id 20so2590020wmj.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mULkrHcO6/FMi++ZNozTSx2X87z7oZ/v4d3br/oHd88=;
 b=HRBRlTqObZlZh0xGFSVbGd0X6AM9W+eWuazwGTuu9gp9MU/KThYEAg5xC0hEFQn3le
 YxcI1tbULKEbHCcUFNdX7unh0RTypItI/y2e+yw2R2GcUFvsbUmprrG8tkjlqHTK5K83
 L0HtaORJn9/SB5F9apWrFF7Xc+RLMnXUEpwZ4mZGM5yxRjCJSoXmpEpZwK98Nbi92l93
 Hj0MhtfuE1CmxhJ74wlqZ3a7J016IyJ1JowMztggIpbOkxpELtvLqUyu8FG+yvG6LuLV
 lk/9Pt1Pyddy3t6BM37ir/pCpbDQY1X86FKaOsuX9UgF3gspTtmGOZXn7s1A7UWIW0nq
 IYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mULkrHcO6/FMi++ZNozTSx2X87z7oZ/v4d3br/oHd88=;
 b=grx9/YZtZUXg3GQNWrH+youMawoAxFpjbeo2IRtjlKHA4muPFMPAhyWb5oZusmIxOZ
 MVQru9XC0k+TyIm5/8BhtwImIHCHWzjOUeThj4V/mAU5LOmjJ3gde6pnFGSH8XHkkLuQ
 VMgJTHlA8+J8X6LIK0fw5jOkLwIObKM95BVPjXQky3ftv5ZiOFQW6NSqPO8SgPhH54+Y
 aJymAbTGcrNUwVY4I4GR8KZO2sxSBpagluqymVd8quedKA4xzg3/cg/4jJv1p2J5N5JH
 6AqE6lFfFjpevqj6QWwPAMmIN3GMjNBhERQe+B4D0LT19u8INzruTR1OdXo6fmNX8XYf
 S1Tw==
X-Gm-Message-State: APjAAAU+MFYDlrrBygRTp5DjSpt0rrj2FB9FlHwzNaiQ1KbEft8Blk/t
 1lKBcKGpgUe2kJdGe8GC/NM9JnQQOfbKoA==
X-Google-Smtp-Source: APXvYqwsCD3Uvi0kkkHsaPxGuS96ROwStMWXd4abHu6NqxvKx0AuTSlzCR660CntWw5sD8igH4UdfA==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr4056479wml.49.1579606347090; 
 Tue, 21 Jan 2020 03:32:27 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i5sm3564340wml.31.2020.01.21.03.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 03:32:25 -0800 (PST)
Date: Tue, 21 Jan 2020 11:32:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200121113224.GD630615@stefanha-x1.localdomain>
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <871rrtmkko.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 06:42:47AM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
> >> Christophe de Dinechin <dinechin@redhat.com> writes:
> >> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wro=
te:
> >> * qemuMonitorJSONSetIOThread() uses it to control iothread's properties
> >>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
> >>   documented (in qemu-options.hx), their use with qom-set is not.
> >
> > I'm happy to use a different interface.
> >
> > Writing a boilerplate "iothread-set-poll-params" QMP command in C would
> > be a step backwards.
>=20
> No argument.
>=20
> > Maybe the QAPI code generator could map something like this:
> >
> >   { 'command': 'iothread-set-poll-params',
> >     'data': {
> >         'id': 'str',
> > 	'*max-ns': 'uint64',
> > 	'*grow': 'uint64',
> > 	'*shrink': 'uint64'
> >     },
> >     'map-to-qom-set': 'IOThread'
> >   }
> >
> > And turn it into QOM accessors on the IOThread object.
>=20
> I think a generic "set this configuration to that value" command is just
> fine.  qom-set fails on several counts, though:
>=20
> * Tolerable: qom-set is not actually generic, it applies only to QOM.
>=20
> * qom-set lets you set tons of stuff that is not meant to be changed at
>   run time.  If it breaks your guest, you get to keep the pieces.
>=20
> * There is virtually no documentation on what can be set to what values,
>   and their semantics.
>=20
> In its current state, QOM is a user interface superfund site.

Thoughts about a solution:

Static QOM properties should be declared via QAPI instead of
imperatively via QOM APIs.  That way they are introspectable and type
information is present in the schema.

The QAPI code generator could emit a function that is callable from
=2Eclass_init().  This eliminates the need to manually call
object_class_property_add().

Stefan

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4m4UgACgkQnKSrs4Gr
c8hmowf9FnVHGtaGgZWMg3l+9GF9UAdyAUuF2/K+xrpcs9vK8Xed4Srw4EDZsC/g
HFFX5l0owUffXstBUHsJwFUMMBM27IH8y6dKcsuv4h5rurpCAoGQp3Ra6V0wWE27
C9PwNherPIdlDNabip66QNYjYjYsae8IbDK66+P7VDKiaXNB3uRnlbefkP3i57YE
o7KjjOODMnaFH8X6tudDmvsCd/tFAEfRvOVv+OB9cebwg7O1Ir99wWcrTZiKH2I+
BDSe4muDTvS9X1s7rFvusfTMfS7xrOVANxZvk4TcrXO2jdkFEIxsPny1PjvWpw1X
1G2JqnZHjXXlRgF9+oW6AJp5XQHyDQ==
=EF39
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--

