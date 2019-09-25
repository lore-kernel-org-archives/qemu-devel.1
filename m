Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22E3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53337214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53337214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2sS-0008Gi-Rg
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD2qS-00073x-Oj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD2qR-00041c-IN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD2qR-00041H-A8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:40:19 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05688796EB
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:40:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id q9so820977wmj.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=4bXVG8rG63RRdivHFVgYwdhQLE7BFDAw2IIkR800VUc=;
 b=aLGBYkaLf+eE4R8byzpfo4XNwQUfWNBIOSKsl+ZKRQ7adx8g8qKQTQ9MNomSdCSPfK
 SJgeQC+B7fhRZBiV6GbfZngyMAXIGZ0iWifIHDOTGUlqD+bR2qvn1fQYFBpI5+1+xfI+
 6Z5EZns9RHn+h3UxDjSZOhK4AkZUHyWlqHH/9KNImz4ynEb1F6+IJwsoSKUl5AFWA0s+
 DnFRZsUDjmp2lCWYaZB8X8E3nQxBQ8F7aQ/2yazWoHyRAtTd7ZoULjczBF1nrItPee3L
 DBcNvYKJkrmc+AU+r5MHiARQNk4ZYUK2bD1gF46M+Ili0GPNvLqLHiQdrD9F+B9cwCPL
 n+Ow==
X-Gm-Message-State: APjAAAXuOuQ5NHg8D3sn7nMLx6p7nEpIZcSDFDyEcbvSHzb99qWBDbDB
 BOqUG8SLblT9Afy1oV/hjCOctT09CEMEi0sTq8UNacgeF+RrHTJKXpk3nCmYLELoaPk83F0TIN4
 yXUMEKkab0ezpCAA=
X-Received: by 2002:a5d:5592:: with SMTP id i18mr7787748wrv.316.1569400816771; 
 Wed, 25 Sep 2019 01:40:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6InE01KCSIgG6LkFA8WJSjztS/3DwfUBnCsq0RGxy1GJ8STDnpt0XVvElcURKW6gqBLkh1g==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr7787718wrv.316.1569400816576; 
 Wed, 25 Sep 2019 01:40:16 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id x16sm3664590wrl.32.2019.09.25.01.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 01:40:15 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87r245rkld.fsf@redhat.com>
 <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com>
Date: Wed, 25 Sep 2019 10:40:13 +0200
Message-ID: <87ftkksr9u.fsf@redhat.com>
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

> On 25/09/19 07:49, Sergio Lopez wrote:
>>>> +serving as a stepping stone
>>>> +for future projects aiming at improving boot times, reducing the
>>>> +attack surface and slimming down QEMU's footprint.
>>>
>>> "Microvm also establishes a baseline for benchmarking QEMU and operating
>>> systems, since it is optimized for both boot time and footprint".
>>=20
>> Well, I prefer my paragraph, but I'm good with either.
>
> You're right my version sort of missed the point.  What about
> s/benchmarking/benchmarking and optimizing/?
>
>>>> +The microvm machine type supports the following devices:
>>>> +
>>>> + - ISA bus
>>>> + - i8259 PIC
>>>> + - LAPIC (implicit if using KVM)
>>>> + - IOAPIC (defaults to kernel_irqchip_split =3D true)
>>>> + - i8254 PIT
>>>
>>> Do we need the PIT?  And perhaps the PIC even?
>>=20
>> We need the PIT for non-KVM accel (if present with KVM and
>> kernel_irqchip_split =3D off, it basically becomes a placeholder)
>
> Why?

Perhaps I'm missing something. Is some other device supposed to be
acting as a HW timer while running with TCG acceleration?

>> and the
>> PIC for both the PIT and the ISA serial port.
>
> Can't the ISA serial port work with the IOAPIC?

Hm... I'm not sure. I wanted to give it a try, but then noticed that
multiple places in the code (like hw/intc/apic.c:560) do expect to have
an ISA PIC present through the isa_pic global variable.

I guess we should be able to work around this, but I'm not sure if it's
really worth it. What do you think?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LJ+0ACgkQ9GknjS8M
AjXcGA/+IYeN5JXsg5RjjhgQaQBE10F9NW4wT0FJkcXyzGlUk88RucLVjRw7mRP2
G2wfE81DPRXoJDFPfXebHUOpgpfN/dT53VLi2K1xBUNOdQ3yT5oWr5W/c22eyCZ6
6In5k+9WMKhT1HzDElhhlLK8A5u/soQHSJmFpNLQLWWmXuVjQ9wkfBNG5WsyfaOW
NHGus2A6lv5bUkcAerVcQukHcBuTs/9+nsDC3pCfrizVv03UivK36wrhf6br5vxO
9G+u/v5eFyn3fCQu1m8RFdRdQQ36Sze4HuB+79AM/Jin0mpVqpnTzn+cPd6mgypg
YdEb5Qraj+baxsAC3/+si3byinX4yeJRWcLektI5pt3TrZaMu3MdAGhkIw+CZrf+
6i2JMZCwdKJgdapESQz/O/nv/vEdWzHf9CZ35DfmtVMKzWXIE3MmFgVaLBpIi7Kb
xNu6U0zJtZr7aMJL/m7ZC7RfN2BDXdAPsB4SCvoBtALCTc6Kcm8v3tKBDFHcAwCp
/QGisQtJ2mMtrGtaVXNymumqPdBWygHVJ7O5vTGpghmAq2/zcTS1mAnx1whZwE1P
ppyu+mGMsVNGEaW//UEQt84hUdCVdDGCC7luRPEh1R7KUBaIJjArhAcDv1hcx+K4
86j0lSFsaPDxE1Qlj9LKdqPftzRIORZaN0t4619iOX3KY72xWQ4=
=A1ya
-----END PGP SIGNATURE-----
--=-=-=--

