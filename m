Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B66C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5025A24673
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqbRLr6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5025A24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uE3-0007Uc-Gv
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j6uDQ-00070S-RK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j6uDP-0007YY-Id
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:46:56 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j6uDM-0007N5-3e; Wed, 26 Feb 2020 05:46:53 -0500
Received: by mail-yw1-xc41.google.com with SMTP id 10so2645464ywv.5;
 Wed, 26 Feb 2020 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UTx3NFxBdZPxuYKPf1+G0Vsmt35MgswZqfjQW72k32Q=;
 b=jqbRLr6bUGle8yDlIvcSdNGcY2JdDbHj8UANXQHFeR8A2VUe38ty68TIDgx2a7Ljxh
 6U3ZQNAWdLbCYKindckFAfd/S4bojf1bh4kZNrXHDUVF2tNYELB6o4dtQyXihTsvxIRi
 lI4jTUDGpRgTcc3fW16wi+EEYvDXXELwqCScG1oeHYT1UqDxPCr6suW3jl9Q4y9Uq+HO
 P1kI6hQFsDw1FKDOV8RNvd09RRaVBR5nHDWFztl0G1GiBqT+wT5/y04A1uzmAesca3RY
 q9BB9HmXrqGxhLbf3FPGg1oldrygwhPkmkkIiC1Z23TkqYtYtnpcW1+w0T2QjGrd7G9p
 XY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=UTx3NFxBdZPxuYKPf1+G0Vsmt35MgswZqfjQW72k32Q=;
 b=blAebvXW6f428j9zf9/H4ihqK1jX5UoZRWnDTgYwZau1cf/26YWsSqhiZlAvfTha+S
 K+RdnHNYMVKKApyP+/Uq0cEO1I0B8TiBWBrdQVZ5vHoLw4Dah8HI4x1TkEAhYEafd+DM
 VLDiIM5nq84Xmkpn7A+KwMXRPwXvQkTP/FSiaLLXTpZJumMxN6HF+GM/9mLJ6VJ2ffEc
 eilvtXInRkrNM2gubm49OmKpmuPiqRoMsYDX/GkzHhu8GPPtIEN5mi7TqWs+A6Fe0LCT
 MG4/fAMgAIAs8/XTsDz5/plXm/VkKohYaI5d1IRhz+D494ma2+kUx7rWkJSh7sg1wzaO
 +jEA==
X-Gm-Message-State: APjAAAXlcm/Ogm1X9qwZQzvMfKbOfQgeyP6oWwfXGXMGetsl5TWYUsRH
 oD3EvZxADhBaL8C3y6CLe9g=
X-Google-Smtp-Source: APXvYqyL6Y8m8Q3I5j4wW1aj5gPhLTEFYViUlM7XhCS6TR12ZQ7mrtonZzDCOPg6Vel6Y2BwS+E7Iw==
X-Received: by 2002:a81:8785:: with SMTP id x127mr2724412ywf.455.1582714010724; 
 Wed, 26 Feb 2020 02:46:50 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id q16sm722502ywa.110.2020.02.26.02.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 02:46:50 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
Date: Wed, 26 Feb 2020 05:46:47 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Paul Clarke <pc@us.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 25, 2020, at 7:09 AM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> On Mon, 24 Feb 2020, Programmingkid wrote:
>> Intel Core i5-2500S CPU @ 2.70GHz.
> [...]
>> Ok, I did test on the G4, here are my results:
>>=20
>> Git commit: c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f
>> Mac OS 10.4.3 VM
>> -cpu G4
>> -USB audio device
>>=20
>> Hardfloat=3Dfalse
>> Audio sounds bad when playing midi file.
>> Extraction rate: 1.5x
>> Converting rate: 0.7x
>> Total time: 7:24
>>=20
>> Hardfloat=3Dtrue
>> Midi audio sounded perfect for about 30 seconds, then it went silent!
>> Extraction rate: 1.4x (slower with hard float)
>> Converting rate: 0.7x (same as without hardfloat)
>> Total time: 7:16 (faster time with hardfloat)
>=20
> How is that extraction rate is slower but total time is less than =
without hardfloat? There must be other factors here than just FP ops. =
Maybe a better test is to not play the audio just save it to a file so =
other issues with USB is not influencing the test.

I does seem odd to me also.=20

>> When I played sound this second time I hard the same broken audio I =
usually hear with the USB audio device with hardfloat set to false. When =
playing the same midi file with hardfloat set to true, the audio played =
perfectly! It only played for 30 seconds before it went silent.
>=20
> So probably there are at least two problems: FPU emulation is not fast =
enough to decode audio to fill buffer then there's also something with =
usb-audio that jams it after a while? I don't think all of this is FPU =
related.

I think a timeout takes place and that is why audio stops playing. It is =
probably an USB OHCI issue. The other USB controller seems to work =
better.=20

>=20
>> I can give you the full testing suite if you like. I run it on Mac OS =
10.4 but it should compile with gcc on Linux. I will send it to you in a =
separate email because it is big.
>=20
> Thanks, I'll have a look and see if I can make sense of it but not =
sure when will I find time.

Please let me know if you have any questions with it.

>=20
>> I have another idea on how to improve QEMU's performance. What if you =
enabled more CPUs for the PowerPC target? Mac OS 9, Mac OS X, and Linux =
support multiple CPUs. It might actually be easier to do this than to
>=20
> Have you tried if it works? I think MTTCG is enabled for PPC64 but not =
sure about 32 bit PPC. The mac99 machine seems to init multiple CPUs but =
not sure if they'll use MTTCG. But you could test it to see if it makes =
any difference.

I had completely forgot about MTTCG. I think Howard once did some =
performance testing with it and came back with favorable results. Maybe =
this is another avenue we should look at.

>=20
>> improve the FPU. I imagine the performance increase with multiple =
emulated CPUs would be much more noticeable.
>=20
> The Amiga like OSes I'm interested in don't use multiple cores so I'm =
mainly interested in improving single core performance. Also I'm not =
sure if (part of) your problem is slow FPU preventing fast enough audio =
decoding then having multiple CPUs with slow FPU would help as this may =
use a single thread anyway.

Good point. MTTCG might be the option that really helps with speed =
improvements.=

