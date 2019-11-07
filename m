Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD72C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7DA2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7DA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSg8T-0006Iq-WB
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iSg6L-00046s-Dk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iSg6K-0001iW-5M
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iSg6J-0001iA-TR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:37:20 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E842C04BD48
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 11:37:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id y14so910513wmi.4
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 03:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uz8YLhbDJw58qn6rfxKRJYLEsiNpzO0oItRitYqlaIc=;
 b=m+vD5+PBTC71fCckx1GMdZ/2BsKqvb4rtW3Zff4b5Ls8g7WZzgiuYdpKA5MbI7DY8O
 8bs+XeyAvZw32lvRsVKjbVR7WEKJXZae5+6s5Oo/j+Ps0k8teiOfJJYklSjr2nySey8x
 b+RBukGbf6PHKK1QsFocnH+TM6SVZNBF91j6y/Dcc9BTnIErduWYk66uYo1v3Obqvtc1
 kz1rs1LnecZwCuQWHjWyPRKC6gH+BIZpfbG5buGlYWTZfVknWwjn+4w36/WDSf3T9wMV
 VR7TylAo8+grotUEfsuIohproc7Fwg20KZMYeNQfW3D2ZiRb8dpoGkXHA/6RLveuABhC
 37Tw==
X-Gm-Message-State: APjAAAUO1zMBtbt9gErY/3Ao1zZKQBl4k6D45h66UnvnR5/4iCDRyFQf
 RCEm1ov3rWOY4ZR5fdsxB4PWh50LBbLfO7yn1n1ekWrIUIgofvC1oLOHYIaptJYjyB6m+XJUXqY
 yElsFGkhkLs5zjhY=
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr2545792wmb.40.1573126636032; 
 Thu, 07 Nov 2019 03:37:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyJPN/JjEcfvGhNLcpsBg1/uzv0Vpp9ztZB8EtsQdh4uJqn51IiumLd3F04fWajyIiXHMziw==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr2545770wmb.40.1573126635696; 
 Thu, 07 Nov 2019 03:37:15 -0800 (PST)
Received: from [10.201.49.199] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id h205sm1891358wmf.35.2019.11.07.03.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 03:37:15 -0800 (PST)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
Date: Thu, 7 Nov 2019 12:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/19 11:25, Ard Biesheuvel wrote:
>> This looks problematic on QEMU. Entropy is a valuable resource, and
>> whatever resource SMM drivers depend on, should not be possible for e.=
g.
>> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
>> Therefore, it's not *only* the case that SMM drivers must not consume
>> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e=
.
>> outside of SMM/SMRAM), but also that SMM drivers must not depend on th=
e
>> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
>>
> The typical model is to seed a DRBG [deterministic pseudorandom
> sequence generator] using a sufficient amount of high quality entropy.
> Once you have done that, it is rather hard to exhaust a DRBG - it is a
> mathematical construction that is designed to last for a long time (<=3D
> 2^48 invocations [not bytes] according to the NIST spec), after which
> it does not degrade although it may have generated so much output that
> its internal state may be inferred if you have captured enough of it
> (which is a rather theoretical issue IMHO)
>=20
> The problem is that using the output of a DRBG as a seed is
> non-trivial - the spec describes ways to do this, but wiring
> virtio-rng to a DRBG in the host and using its output to seed a DRBG
> in the guest is slighly problematic.
>=20
> So it seems to me that the correct way to model this is to make the
> host's true entropy source a shared resource like any other.
>=20

Yes, I would make SMM use a cryptographic pseudo-random number generator=20
and seed it from virtio-rng from DXE, way before the OS starts and can=20
"attack" it.

Once you've gotten a seed, you can create a CSPRNG with a stream cipher=20
such as ChaCha20, which is literally 30 lines of code.

Paolo

#define ROTL(a,b) (((a) << (b)) | ((a) >> (32 - (b))))
#define QR(a, b, c, d) (			\
	a +=3D b,  d ^=3D a,  d =3D ROTL(d,16),	\
	c +=3D d,  b ^=3D c,  b =3D ROTL(b,12),	\
	a +=3D b,  d ^=3D a,  d =3D ROTL(d, 8),	\
	c +=3D d,  b ^=3D c,  b =3D ROTL(b, 7))
#define ROUNDS 20

// initial state:
// in[0] =3D 0x65787061
// in[1] =3D 0x6e642033
// in[2] =3D 0x322d6279
// in[3] =3D 0x7465206b
// in[4]..in[11] =3D key (seed)
// in[12]..in[13] =3D 0
// in[14]..in[15] =3D nonce, can probably use RDTSC?
static uint32_t in[16];

uint32_t chacha_rng(void)
{
	int i;
	static uint32_t x[16], p;
	if (p < 16)
		return in[p++] + x[p++];

	if (++in[12] =3D=3D 0)
		++in[13];

	for (i =3D 0; i < 16; ++i)
		x[i] =3D in[i];

	// 10 loops =C3=97 2 rounds/loop =3D 20 rounds
	for (i =3D 0; i < ROUNDS; i +=3D 2) {
		// Odd round
		QR(x[0], x[4], x[ 8], x[12]); // column 0
		QR(x[1], x[5], x[ 9], x[13]); // column 1
		QR(x[2], x[6], x[10], x[14]); // column 2
		QR(x[3], x[7], x[11], x[15]); // column 3
		// Even round
		QR(x[0], x[5], x[10], x[15]); // diagonal 1 (main diagonal)
		QR(x[1], x[6], x[11], x[12]); // diagonal 2
		QR(x[2], x[7], x[ 8], x[13]); // diagonal 3
		QR(x[3], x[4], x[ 9], x[14]); // diagonal 4
	}
	p =3D 1;
	return in[0] + x[0];
}

