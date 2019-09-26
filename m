Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1369C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C0820872
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C0820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQvr-0003KU-IC
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iDQpJ-0004Js-Qg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iDQpI-0007k5-Ro
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iDQpI-0007jf-I2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:16:44 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A817988302
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:16:43 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s19so835719wmj.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 03:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=IBdWUvcQutLfTdj7XIJktgM69ZCC8tBDBOih2754DOc=;
 b=fm3N3dz2KZHPHy+Lye2Qkvd/dvjhW/tK1/j70eN0dYFTQw/AvyryoG3FiLS1pKIwju
 359syIK6DPwwnB794CWC5la+xtNt0M7bqV854xoA4kwo8wWaF0qwWv6nIDbCeD3HwUM2
 C9lcTEzq+oVJuf1skpTw3zSBeFvzCEDPLzWf6PbalKi9s1VBOJ9UKXPRtdPEivQ9/CV1
 xPTiWGNpOARMW1/OJ7w3aiyhE8BtmrIWI3qX2jMxXh9oPPe2YP5Rb3EpjJjRhHN7vwLW
 6ziQ+sFeK+N4yl3ELDae4th6+aqumG6Y37Is/awCFq9udOT8++HTLpgPf+xvdjRux93V
 mSDQ==
X-Gm-Message-State: APjAAAXitEcGKQ9V9/S7r57k5p1aLguI96zdFg2zCQTfQLpfQBMbQRSL
 T4u7Vb/MH7Zorj5P15/YqbCy+cYgaOTNLLFUvwvR7sbIRlNpRga4ExX+iNwncFurJEvXSPwB/bP
 8EB84NuwDj/cUTyo=
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr2276654wmj.57.1569493002412; 
 Thu, 26 Sep 2019 03:16:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNjQRHTszNojB7edoXk7xS7U86MXEMu/qGpIBGlRYk66f8dZYwpXS9eK2cj0djm21gul4Pgw==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr2276640wmj.57.1569493002233; 
 Thu, 26 Sep 2019 03:16:42 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id r7sm624946wrx.87.2019.09.26.03.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 03:16:41 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
 <d70d3812-fd84-b248-7965-cae15704e785@redhat.com> <87o8z737am.fsf@redhat.com>
 <92575de9-da44-cac4-5b3d-6b07a7a8ea34@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <92575de9-da44-cac4-5b3d-6b07a7a8ea34@redhat.com>
Date: Thu, 26 Sep 2019 12:16:39 +0200
Message-ID: <87k19v2whk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/09/19 08:23, Sergio Lopez wrote:
>>=20
>> There's still one problem. If the Guest doesn't have TSC_DEADLINE_TIME,
>> Linux hangs on APIC timer calibration. I'm looking for a way to work
>> around this. Worst case scenario, we can check for that feature and add
>> both PIC and PIT if is missing.
>>=20
>
> Huh, that's a silly thing that Linux is doing!  If KVM is in use, the
> LAPIC timer frequency is known to be 1 GHz.
>
> arch/x86/kernel/kvm.c can just set
>
> 	lapic_timer_period =3D 1000000000 / HZ;
>
> and that should disabled LAPIC calibration if TSC deadline is absent.

Given that they can only be omitted when an specific set of conditions
is met, I think I'm going to make them optional but enabled by default.

I'll also point to this in the documentation.

Thanks,
Sergio

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2MkAcACgkQ9GknjS8M
AjU+og/+Nbc2ZkpftrB6CqGZXaz1bwXwBrDuNX0AanuB7LdNVpiCKGCR913yKL44
qY9NnJ8A1J5QM6fai5BcMoDVn3Xm2AVf8OL/mg0xOdoGXDGK2ybpoiyv8AGrd3cc
lPQjWMVZ9XMBCzHoGeI+ogLkx24AXjfc9+82jGMbXSIgYXH0/KPtOa+P3U0P6GV0
0nnTouITT0OpWvp0C3Mi+oS5CJbcTRbinLbwP5mozXjMDdmiKpCrkBFN7TOBcceW
rwB0IQ9bjbK2xNBUjUVnzWAcgmczzQF1Q42JUTGEn3bD6X9AxhLUsVd4aWjCfmDj
93WlmcJwKKB+ADj7/9alsxJALRlwhGfutS2Lp4QfTZFMkWW5SZngQgES86a1gC/P
Qx8dy0h/4XBXb9f2BKW18TUVKyHKIfOVNeLeJBBYKUPY9ABBIzXBtnx7exnbMnOd
6yPViV4aJ8PDJtE5dXQLdU0A3qTSb6SXXiJOQmR7uVeF5iO25xOf7C+hple3Trhr
HGnwqZWni55h8S4aom8P3NZF7AmqsmU4AqlSvE/ZAkwfGKg8jKw8jt0jaXUP5Srn
9HjwvifpEp6zkSBzE2PbeD5lZp9uF+0Ug+mEpk/R4IxycDAcZ7Y9pQswCaMgojd0
EYWz1qEDZ2WbBSM06+FzmwsKPxWv1ug+Z1usbQKTrmYG1xWt2i8=
=7lIN
-----END PGP SIGNATURE-----
--=-=-=--

