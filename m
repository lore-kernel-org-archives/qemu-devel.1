Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB0C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E00222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E00222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPcX-0001td-PE
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDPbm-0001Al-Pw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDPbl-0007Cs-AF
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDPbl-0007CY-23
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:58:41 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E767C01605D
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:58:39 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i10so411128wrb.20
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 01:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=EvA5l+XTOz8/RuEyrxw/ntlMCxz7WCbSgf2f1bKTXbI=;
 b=YfSogwv9UOPk1NCaVY3lIgCLeU7yyJpUYHO9tovRga3v2c9S2qtJ4HqtrfuLgIPfuZ
 7BXW5CaPbjywHGKEtTIo8wQRPuAbkbUmu4R5pwr4XSzFsJnOlBZ5iZoeLvpM6cup4K/e
 9aSgNHECIg7Ukbdnn73NGjexVdZpw3lPCW3xGgZeWFdPyoE5P2eTNF5og7e3zz9kFBI9
 gdl8tzlWlnBkpzxhlL3SdasgagLPbbf4NS4+je8Oo0jWHr01ewCdGBdlYR/VY/YjaZJM
 eESujAxnJKCEEJnTeGrdxvzhZSD9YHWMF0wjFfQQuj2Joj6qZhe0bWB+U8KuDP4vRlG0
 RXow==
X-Gm-Message-State: APjAAAUtipQlnt+y02/ipwvCLO9IDDqG/AsHuOkCpbLf+NRRG9N5sAg9
 2DaHJJcFtTdvyhiDJGZ29ogpoai+zQXqQGzcD1gTV6jfRkNzvQ08d4rhZ11pjLmGkn4iZtqBx4l
 NuvJBv5fxJXPpEbM=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr1982978wrj.366.1569488318312; 
 Thu, 26 Sep 2019 01:58:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzs4ac9R/2flZPy2xnzFFvSU65JOwFaYfb7vTKzGoGLGNYWNbzHGcdCuw8kvSw70+PexCh6AQ==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr1982963wrj.366.1569488317995; 
 Thu, 26 Sep 2019 01:58:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id a14sm1908827wmm.44.2019.09.26.01.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 01:58:36 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
To: Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
 <d70d3812-fd84-b248-7965-cae15704e785@redhat.com> <87o8z737am.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <92575de9-da44-cac4-5b3d-6b07a7a8ea34@redhat.com>
Date: Thu, 26 Sep 2019 10:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87o8z737am.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xs2VwYdKVKnb7nurjqEof2Su9l6q21oE1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xs2VwYdKVKnb7nurjqEof2Su9l6q21oE1
Content-Type: multipart/mixed; boundary="SPDh8eKColRzEIIRfqlV7zIrkQOX5Kuzf";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org
Message-ID: <92575de9-da44-cac4-5b3d-6b07a7a8ea34@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
 <d70d3812-fd84-b248-7965-cae15704e785@redhat.com> <87o8z737am.fsf@redhat.com>
In-Reply-To: <87o8z737am.fsf@redhat.com>

--SPDh8eKColRzEIIRfqlV7zIrkQOX5Kuzf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26/09/19 08:23, Sergio Lopez wrote:
>=20
> There's still one problem. If the Guest doesn't have TSC_DEADLINE_TIME,=

> Linux hangs on APIC timer calibration. I'm looking for a way to work
> around this. Worst case scenario, we can check for that feature and add=

> both PIC and PIT if is missing.
>=20

Huh, that's a silly thing that Linux is doing!  If KVM is in use, the
LAPIC timer frequency is known to be 1 GHz.

arch/x86/kernel/kvm.c can just set

	lapic_timer_period =3D 1000000000 / HZ;

and that should disabled LAPIC calibration if TSC deadline is absent.

Paolo


--SPDh8eKColRzEIIRfqlV7zIrkQOX5Kuzf--

--xs2VwYdKVKnb7nurjqEof2Su9l6q21oE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2MfbsACgkQv/vSX3jH
roPPkAf+M4M4xIhSXRUCGoCldxLPjeNZIek0gwMJyFLyJ2vln4OheCw3nYGJnm47
MYH45FPudx02mPPrukiYuZlsnLJqNJpIPyiWKCUbYlysCEIZon90tkRbSkgraomS
7R2SJhikKL1Ad6kujFGObebFSR3aZmDPNX04Cg6Rk0CA5akpvSh+hOkI4uWu9CrW
E9nk0wUZLRl8trf0t3HxJ0eeTtKcMmoOdryDtGUYvYTBKCKwiPClNbx4Ai5ML4zy
B5Ja3/xRwrlWfOW8WeKu21nUY/eTSmPJOK2V1+yTq9ekJ3hPCzp4a3XxXPy5kD/h
MenB4Am7dnVVGxq6/IUkyeD6+RGR+Q==
=bWFM
-----END PGP SIGNATURE-----

--xs2VwYdKVKnb7nurjqEof2Su9l6q21oE1--

