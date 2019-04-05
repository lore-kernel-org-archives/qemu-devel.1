Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A35C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594F821738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRuf-0008J7-CZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:41:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRtt-0007tC-H4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRtm-0003uC-6l
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:41:06 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hCRt6-0002MD-NU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:40:56 -0400
Received: by mail-wm1-f49.google.com with SMTP id 4so7393840wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version;
	bh=jX3Bh4f3fom44LEfsPFMtmxQMmSRYIE0W2T9M1yTcoI=;
	b=gM3ajLh6jGblF5JF7fjiAMQjBvq5fmHQTE50W/uuxJC9yktNcumVtt/YqfXPZ7F9pr
	SQu7cWQlabh+XAXIr8Wnk2UtU/vbKSGpPgaBXfKx5RKnCJ6pOC5b2UXkopy/iGCIrtvg
	l2zLAaM3VafMbJYeOjW+bpYTJWoqGEImfxcBfkee8StloGiFnBcMu5VfQ0eQbi9VWhbI
	t8QD7hB+F0AdHtXdIVVjsW6yazu/XP7Wi8lZLuxIFpWzi2UmXVh2OiLNmLaBBwtXx+OE
	gqMaKBZlJvNBwnEkTxqn1+ksfDgdojaK1T58tiiUSrC0xSbXuNOwka9NsmNOtp/2cCrU
	DW0g==
X-Gm-Message-State: APjAAAXxVZiMwKdJxWvmLd5x+64O87Cb6nQFClg3u5uf+it8Kt9ybrF9
	gWaqOQxgFnPB1hEcddKdF/76hCge5JE=
X-Google-Smtp-Source: APXvYqwFBpN6FF3rYmVR0gdDJYhfLk7qwWelOY3e1R4bnwLWOEXgDTu2aKPMCfPhFzqbDuRyv6wvkQ==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr8680302wmc.100.1554482002134; 
	Fri, 05 Apr 2019 09:33:22 -0700 (PDT)
Received: from dritchie.redhat.com ([80.30.223.174])
	by smtp.gmail.com with ESMTPSA id b9sm4855276wmc.9.2019.04.05.09.33.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:33:21 -0700 (PDT)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
User-agent: mu4e 1.0; emacs 26.1
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
Date: Fri, 05 Apr 2019 18:33:18 +0200
Message-ID: <877ec8mmy9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] QEMU event loop optimizations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405163318.u-V7vtVJ2wejAxiNbSawVxs56nkA8w3coQwWNdGZJN0@z>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini writes:

> On 26/03/19 14:18, Stefan Hajnoczi wrote:
>> Hi Sergio,
>> Here are the forgotten event loop optimizations I mentioned:
>>=20
>>   https://github.com/stefanha/qemu/commits/event-loop-optimizations
>>=20
>> The goal was to eliminate or reorder syscalls so that useful work (like
>> executing BHs) occurs as soon as possible after an event is detected.
>>=20
>> I remember that these optimizations only shave off a handful of
>> microseconds, so they aren't a huge win.  They do become attractive on
>> fast SSDs with <10us read/write latency.
>>=20
>> These optimizations are aggressive and there is a possibility of
>> introducing regressions.
>>=20
>> If you have time to pick up this work, try benchmarking each commit
>> individually so performance changes are attributed individually.
>> There's no need to send them together in a single patch series, the
>> changes are quite independent.
>
> I reviewed the patches now:
>
> - qemu_bh_schedule_nested should not be necessary since we have=20
> ctx->notify_me to also avoid the event_notifier_set call.  However, it=20
> is possible to avoid the smp_mb at the beginning of aio_notify, since=20=
=20
> atomic_xchg already implies it.  Maybe add a "static void=20
> aio_notify__after_smp_mb"?

try_poll_mode() is called with ctx->notify_me !=3D 0, so we get at least
one event_notifier_set() call while working in polling mode.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyng04ACgkQ9GknjS8M
AjUZvg//TMdHOS1Jgl7VNfIUbkinWzxCi4BFfzIO8hbJO6qHUCvHUKr/bp3DZy3Z
wMEelRuHLDju+MMGAYYKCf2Tird1TlWQ7mPWfENfLWOZ3uslyX0KsKVTzV0ns81t
sqHkqxvFX9clINIeVFaCxRsDTITmjwKCMvYpO/bRMvUoOl6uL5jNJ6qC/POotANq
OmdwzF93SUbWK1AIDUEFIw+ORW2lZKYs6hIbXbEXbDTMACKI8NNAcqK8Z9Fk3YkM
bteGL4TFqgG2y2SdH2xOGxrprQLMy45zNTgz4hEQRpEcOSWbfYhuO7uv0JFexfBa
rBbOZQ+QT799l3J0mSr2ertdFH29nKXliSbd1TYmw8LhPASmnoOSavk2bAcvJ6L3
cmRuL80eDEeWwjSzxdIvWrEMkMU3uPHtiMThKmZ3Lo/5XBuTb7alOeZxZ5/NTSnH
FNGx3wJHbu1+Kgz6w+j69XZAQcRnCWdv6M6we3Q2bM9OARLVu1+rKCu7g6sTWBDW
B643B/myW+11kHY1iQeqsTh7RpUUJN3zr2Z2EtcrE6yEma5DMJBvavU55sE0Ysa9
bB2ulP2f52KsttkSd1h+vqFVu4lP9uOUxUTUYv19zP4QKpHa5Tuv3nfFfkjOcK/Y
7P55bxSoKSRCVb9StLsntYi3l9kYO3djNx3FUFb7F906YnO30C8=
=8OCT
-----END PGP SIGNATURE-----
--=-=-=--

