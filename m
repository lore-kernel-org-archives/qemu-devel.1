Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F5EC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F5E24683
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBsRgTI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F5E24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isv0m-0000pl-4T
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 15:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isv08-0000GJ-8I
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isv04-0003vA-V2
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:47:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isuzA-0003Xc-DL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579380383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+37JeFDbJ64sqSVnLR8ALutEO/UPK6+rkNow+LTlYKg=;
 b=TBsRgTI9luAvcwURbA7ClPPR8lKcAXxpPQvBDHGZLZLr1Z+EkqQvJ+2DC+6xDWj+jtl3/s
 iBv2dpFcMZhyKJfAKv8l3zAGthi4sm7GWRc7ztoOIAFXo7H1wgIArKdJMuk5qAbEJ/xKAE
 KNXi1nmVbbDZDgMiaKn3kI04gXcEgmE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-2z-J1ORuOsyBCWAwF5pRMQ-1; Sat, 18 Jan 2020 15:46:19 -0500
Received: by mail-wr1-f71.google.com with SMTP id r2so12078376wrp.7
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 12:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2t+6vXd7oNsiyEE3xHDZ4NPo+88hOH5f7tlV3bHTZfc=;
 b=RvYGEzL/oUKJ3UqHF7/JXU1SM+k7ip1M0E0eig9ue9k41BLL4q0wc9Gxyzn1fl04ZP
 d1UvgsYWpr1PF00TWxOMChLQ8YsBbLdm8v5/9j6x5SFRfEadU2AiFRiPb7gO4C6k8n4n
 coroejIPFp9F64CWawWJS2saknTDCjj2JjNItkwBPkzYfGt1wYlZntg50RPlirnYR+gC
 3NaL805N9+Ylz+Vuyv4k9tOEKtJqaBBQe1MqvSwDSG/PO1dyRg1zlwY/V+/GcWotlytT
 rM7pLrrHy/E9/tKptTTuq/giuV06F3bjJj/x1EoRXowm+lsHlQdRXydQhrJprvpZnLJT
 ncoA==
X-Gm-Message-State: APjAAAUU5cPZxu54LGPlKJgeLBWABpypUodg5eSsd1KzT8VBMW6vWznW
 b1t5k1UkPAvbVRTbfRdBVfBNqC84QHixzlSmO5Y2fTdo2R0K9Gzbuwgsm6tSlWFpPlfScBqbuwQ
 IRueLLJ7AxplKkK4=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr11020793wmh.22.1579380378740; 
 Sat, 18 Jan 2020 12:46:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiLA7c4f6Z1i7rdL58u0+OLwTHoRgv0sLLcjBArV8vGAe0c0Yz3x70Bm2zpsFol3McHu4kVQ==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr11020776wmh.22.1579380378550; 
 Sat, 18 Jan 2020 12:46:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id r15sm127470wmh.21.2020.01.18.12.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 12:46:17 -0800 (PST)
Subject: Re: [Qemu-devel] What should a virtual board emulate?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com>
Date: Sat, 18 Jan 2020 21:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
Content-Language: en-US
X-MC-Unique: 2z-J1ORuOsyBCWAwF5pRMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/01/20 22:16, Philippe Mathieu-Daud=C3=A9 wrote:
> 1/ the Radeon chip is soldered on the motherboard,
>=20
> 2/ the default BIOS expects the Radeon chip to be
> =C2=A0=C2=A0 unconditionally present,
>=20
> I insist this patch is incorrect for the particular case of the
> Fuloong2e board. I plan to revert it when I post the test.
>=20
> BTW I'm not using --nodefault, I'm running default ./configure:
>=20
> qemu-system-mips64el -M fulong2e -bios pmon_2e.bin \
> -display none -vga none -serial stdio

But if you're not specifying -nodefaults, why are you specifying a
configuration that your BIOS does not support?  You should just remove
-vga none and leave in -display none.

Paolo


