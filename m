Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A912067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYWUwS77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A912067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jun4k-0000Lr-BJ
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jun3m-0007pq-Gp
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 21:15:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jun3k-00017Q-87
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 21:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594602907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OwuAs1LrBoAoDnWfUuVO+H7TiVmAecs1UZTB0DeYY/M=;
 b=WYWUwS77QoJ7E+XF5+JUMOd/U12j+olzmwhoIwm80CNiLPFeRCYf+1v9ys51Gi/DEgiXkz
 smV71/OtaTzBknJ1vHPDZ4TAV4CxQbmfcy4njxoWC3S51QpUXVnN4BXU5JslcY1Z+tL6Xs
 13W8im39fnN8lyFqooUYwOfcrLYSZeM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-_nLX6DyHNv2VclNpIuT1Yg-1; Sun, 12 Jul 2020 21:13:55 -0400
X-MC-Unique: _nLX6DyHNv2VclNpIuT1Yg-1
Received: by mail-pg1-f200.google.com with SMTP id h5so9077806pgq.4
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 18:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=TfDYPWw0QOv2FFK2ytIN9cJtmpZNHTDz7Wdm7e0Ve9Q=;
 b=UP884y2a0qlz0yL65tbGwEFOXF6z4KJF2gkLJrQirR7bafmzDIcf3jKjE6IV434vBJ
 7ewCv/sKeDaAB1376hodHwo/OeYJ+48PvWio1DUJ7GE4xLWH6G/KvKGc9RFQtczCxnSf
 a6zz3LYKLeAHqo0LomkqVBLMcWTVqmLFI9DxSd5xyK7UZQWaWivK1ls9eohMOD55OEc4
 gjRiB6L0teJRF4vtkfnn3gZA5cgD6COkLV3PCUNeemOW0FUy4pfZIHQ8ZtLFI3h+pl95
 7SRfVe5CUpgRjhT99MCxkhYpv0bjVcJCOYH9dFvUEwhiZyNBMTBFrBb9uwUMImP43TVA
 PMvg==
X-Gm-Message-State: AOAM530dTQuz1oyqg78UnwaHVWdu+KJ5nCDG8risxxCjnXYDHpjjTa75
 gMiQw0T4fTNEmx+aV4u8MXmjEXkP9f+8Rb+aQUVWNLOWcZHSkobMdnLCB9LVSN1dk0f9/JIUffe
 gWD1rYXHC9FVNkMk=
X-Received: by 2002:a17:90a:3602:: with SMTP id
 s2mr16708763pjb.161.1594602834436; 
 Sun, 12 Jul 2020 18:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws8SSf3/RCZL8Nosj0Imh2GhlQhqYdh0a8bosYREUvQSxQKfiqmnWxvsXxqVcxW5Rq7wANig==
X-Received: by 2002:a17:90a:3602:: with SMTP id
 s2mr16708742pjb.161.1594602834141; 
 Sun, 12 Jul 2020 18:13:54 -0700 (PDT)
Received: from umbus.fritz.box ([2001:4479:e100:3700:6379:248f:ca6b:e855])
 by smtp.gmail.com with ESMTPSA id f72sm12506064pfa.66.2020.07.12.18.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2020 18:13:53 -0700 (PDT)
Date: Mon, 13 Jul 2020 11:13:44 +1000
From: David Gibson <dgibson@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
Message-ID: <20200713111344.23c1b313@umbus.fritz.box>
In-Reply-To: <87v9iz7cxl.fsf@dusky.pond.sub.org>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
 <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
 <87v9iz7cxl.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/Z.lsDZp.XPBnItT0zHgnSfg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 21:15:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Z.lsDZp.XPBnItT0zHgnSfg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Jul 2020 14:00:06 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 07/07/20 07:33, Markus Armbruster wrote: =20
> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>  =20
> >>> On 7/7/20 6:45 AM, Thomas Huth wrote: =20
> >>>> On 27/05/2020 10.47, Markus Armbruster wrote: =20
> >>>>> "info qom-tree" prints children in unstable order.  This is a pain
> >>>>> when diffing output for different versions to find change.  Print i=
t
> >>>>> sorted.
> >>>>>
> >>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>>>> ---
> >>>>>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
> >>>>>  1 file changed, 16 insertions(+), 8 deletions(-) =20
> >>>>
> >>>>  Hi Markus,
> >>>>
> >>>> this patch causes a slow down of the qtests which becomes quite mass=
ive
> >>>> when e.g. using the ppc64 and thourough testing. When I'm running
> >>>>
> >>>> QTEST_QEMU_BINARY=3D"ppc64-softmmu/qemu-system-ppc64" time \
> >>>> ./tests/qtest/device-introspect-test -m slow | tail -n 10
> >>>>
> >>>> the test runs for ca. 6m40s here before the patch got applied, and f=
or
> >>>> mor than 20 minutes after the patch got applied! =20
> >>=20
> >> That's surprising. =20
> >
> > It's a bit surprising indeed, but on the other hand using
> > g_queue_insert_sorted results in a quadratic loop. =20
>=20
> The surprising part is that n turns out to be large enough for n^2 to
> matter *that* much.

Is this another consequence of the ludicrous number of QOM objects we
create for LMB DRCs (one for every 256MiB of guest RAM)?  Avoiding that
is on my list.  Though avoiding a n^2 behaviour here is probably a good
idea anyway.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/Z.lsDZp.XPBnItT0zHgnSfg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8LtUgACgkQbDjKyiDZ
s5IXYw/8CHs4l3BUadX/K+v6QQxaX8xgVrIx7gDnelJTV9XvVIVAfe0DK1T21KzL
sXDpo8vvR1iKUR0YjoROY6691SRbuGC9cT1Cm7VxlOuFWM/fzLkjpOROfxmV7bdy
I2ztImBcTOVMuSQthWmAB3x20szhRBNRiSJFP6TvpLGsjtRaXQpTaMfxGGa4GmBJ
TKpB/0N1S81e8wMkCdqKAI7XDcQdA7liodkIK1Wwm+4HHoGWx3phTOcJhn3pxt9S
SIjKHXevnRQeCSnFTnG77KeY9CD9G3nta8Q+/ZTbgAt1+apOkza9+ZMFDzCthgLL
v4s9vU/IJ5/WRJEo+4cp5XlK5KOoWwa5rDKdwPjvCKw+mADXp+BGJtavLJvBDPTh
Luast13YeGxeD3i7C5jOkg/XkoPquu981mXVO/3rGzAsNLQW5ySsnlKEsP94QgkP
7kd+Qj+q+wgAnRhxH3RIFzUYCKPhE9DHcXfiuTnrC/oTNZ7sRUzc5AvBJ5Z71mWz
2dVHJRpI3Srk6sKJNYK8CzGmLmrNgh5c9zBz9gioIG/NnfPHk7OIWLDo4Pc9tqSQ
/hujaOkoFbcZkTRlwUbMa4rVIY9reAnQRY6l7d4hWVKKFSyN3yL3t5NvHxXdOCu/
FTkVMD3P05rzr9Z4hvJO9Us6Mwbbq12Nxrf+V4G4Qr4BjnYx6BM=
=VVJq
-----END PGP SIGNATURE-----

--Sig_/Z.lsDZp.XPBnItT0zHgnSfg--


