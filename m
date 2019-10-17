Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82437FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CE720869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CE720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3Je-00070l-AE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iL3Ht-0005r0-68
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iL3Hs-0004X5-5f
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iL3Hr-0004WZ-Pd
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:45:44 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93FE84E925
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:45:42 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id o8so956602wmc.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=gxLm2Wq78FkSxgC6/pRtf+KctOp43uz9i3yGV1/50H4=;
 b=L5SRgfgibzNGIYV/sir/9RupRsuqQ0UdPBVrJipMXwG7HhS040IV+6ZTwk99A8eIgr
 uY81hNj1CVfdCD7X+8nsGiQMt/RAR7aGVNpHqN0GFcTj0+pizTPvbEs6aort50OFhvO8
 r2Ary0OMbeQsle2PiQGR3MmXXteGKzht0vMaLieLd8wH7gdJn7pxmvvY/vw9yPXlxBdI
 0OqtO4WfrFFI2H5md4j3YDKpxd/ggr5WRLcBiS+POsAyM0JBoMCFJRhpPafyp9LQ8Z1a
 C8KSAArkOI3PLdd0YvE9unV0WmYY++QZbpSj0wMYv9/6zY8ZFg4ss+dd+LSKoUf+GR0T
 nWeA==
X-Gm-Message-State: APjAAAWrmbzY64mjdjZgE2IKqna7bYwTHr6vL42bHcnIHC1KAD6vla92
 9PXo1ZtO8P04smTZmjUfh7DeeuLMZYROxud2ImECa9FEFlx7D9jFUNpVXzvUY65X2qYudo8TPHs
 MgtzfmHikeQq753c=
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr2364286wmu.69.1571309141370; 
 Thu, 17 Oct 2019 03:45:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEBs2G4Kc7RFK5QQ3yZRQWCcCaE57xk/04ngRYLbnkRJ4XvUhQm0huDWYLCP+tBts3y4o/fg==
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr2364270wmu.69.1571309141138; 
 Thu, 17 Oct 2019 03:45:41 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id w17sm1867573wra.34.2019.10.17.03.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 03:45:39 -0700 (PDT)
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
 <d981516f-f23a-47f5-d825-a101fdaaf471@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
In-reply-to: <d981516f-f23a-47f5-d825-a101fdaaf471@redhat.com>
Date: Thu, 17 Oct 2019 12:45:36 +0200
Message-ID: <87ftjrhcq7.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Sergio,
>
> On 10/16/19 12:12 PM, Sergio Lopez wrote:
>> +Supported devices
>> +-----------------
>> +
>> +The microvm machine type supports the following devices:
>> +
>> +- ISA bus
>> +- i8259 PIC (optional)
>> +- i8254 PIT (optional)
>> +- MC146818 RTC (optional)
>> +- One ISA serial port (optional)
>> +- LAPIC
>> +- IOAPIC (with kernel-irqchip=3Dsplit by default)
>> +- kvmclock (if using KVM)
>> +- fw_cfg
>> +- Up to eight virtio-mmio devices (configured by the user)
>
> If we have VirtIO devices, why not use virtio-serial instead of the
> one on the ISA bus?

The serial port on the ISA bus is simpler, and thus is supported for
both SeaBIOS debugging and Linux's earlyprintk. This makes it *very*
convenient for debugging boot issues.

Also, as it's explained in the documentation, users that no longer need
it can disable the device and just rely on virtio-console.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2oRlAACgkQ9GknjS8M
AjX9mhAAmYfmZAbdZ9X3KQHWi0AdlFM3fhOnI+pK36Ctk/ydMfgA0MaCsee73Out
WRY+dzNg8FwzPdeOAIIJk5tSwCVXK5iIEkDMAW/8EErTF/LR8OOCKPB1dRAGXy0v
unocaNHeYOP8BVPbnwwGgyBVuVv7J21BbVf4wwQ/M/4tz6VJGahiTrGUhFWkaVZT
aaaWMnrdaccn4u0q1/uR0llJnY8CLGPEKANV2zRvqNKUz/ehyUYrLtRdlcHAsBZU
IRucEaHJk5OfPntoWNMjTEJRVj78Nfv3JUVSRScn3EBYR973gAdUXhFinCD1uEW3
PSYDjqu9qJjq14UOHlh/TSiCaixjWHwGIcnYe42hcSj3kdvungA01xDkFrGlz6bj
ST2xgGWmplu/B9cc55TdKM2vajjqCI4mY5Tnb9CJwtcri8hWLRQeSCB6Wl1BnpvL
yMpOb5rWBm0oF34iFaxCYCgZ9H8CdvJQLagChzQsvRHPjGyYBDlHhQDEXLqXuTk7
os3r1D7SygrvslcMM+nNSDeS+87tah28lXmvA4ClZ/Bm9tcdQ4dPcAW5qQ9MIAUf
sQZMGw+WQ/6lRO8fnNoMlWsJgvwfFKFRqsT9r8qt9XGvW5SSGl3ziLpMVdTWn18l
i7B//7p7PhtIeqZrc84udDw5SKz9bJAyUswDqv7SqFdjHKq2x/k=
=gXeR
-----END PGP SIGNATURE-----
--=-=-=--

