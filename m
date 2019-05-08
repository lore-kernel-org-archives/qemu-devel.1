Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163BC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC6B21734
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajCWKa4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC6B21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONr1-0005EF-7u
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:47:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hONpp-0004lt-QV
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hONpm-0003fy-Ql
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:46:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hONpk-0003dw-5S
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:46:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id v11so7444536wru.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=K5COiiCB4oFUPNBU3qgmWvs8WxRY0Zve6KLrkJnsSFI=;
	b=ajCWKa4/NVYYU2MY+lH1SyimELJiufewro8/DHcyVW0Vm0LEL6IR+FVQ2DvcjRitu5
	wc0imy5Imm8p+TUzcHJOoBqfH4X5663sVZeGwcda3ZOEVb0svc1u425n1HP+SBN/aOj+
	aZ7vUvvaT2VNf2BGpW3pjYskpwzEhLoYj/mAi8sL9HHLMK2CLXyxR8P6irYaoxfiBsRJ
	P1BE/XylWIQkJ79YxQqT361PpZVO3Tiz1bhb2g79xgBeJmcdUwXgIfJQe2OG7Z87Lk0T
	AWfleuBgG+xG6WMZXbr0/OvBFJamuWYY31pJyEtJJY5nb6TIlkDGR+Rwvyj4Dh1Ii9E4
	mwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=K5COiiCB4oFUPNBU3qgmWvs8WxRY0Zve6KLrkJnsSFI=;
	b=a0xOisGgXNhUReM5EexTyrDTK5trCYgY2P7p4EtVIrlxTbJFUzDt/X7Cg/aNgqIhXc
	vt4Oc2QW7+h629hVNDw0Ug5Qav/ntuSkFNuUm/omSTL9tuGf2RVDfRcRG5G5HAJwMN4h
	ULwS5ommYpuUCVhhHD8E3n7mjyW45rSpvzPWO7sLS/cJQ3N3X3QweJLidD3DpROtOSz7
	inU6l60OyEJqhwZS78Lieo8gn4/zLtIGpK1m6MNmb09A7rftdOoqmXsKEv/xXbSmkfZ2
	HcNTqOyx1MD4H2X8faFqzwTY3/c77UzQSUTXKA85z1BbgXECNvy4cf8LV/Y4iL2UfsbY
	DSqQ==
X-Gm-Message-State: APjAAAX4xaNiLhN6ZeY77SdEq9mEf60ckznJW9ZpkGavDd6jTAyaAryB
	e1AzO6ffEflp1VaI3+2nJ2WFLA==
X-Google-Smtp-Source: APXvYqzooKjpibC645OKa5MgUGHcJ/0lh3hKm3or70X0NsNVkvfDIVvL6SHHTrrvK7jhdIsknu7Uzg==
X-Received: by 2002:adf:a55b:: with SMTP id j27mr21017002wrb.55.1557326769370; 
	Wed, 08 May 2019 07:46:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j190sm4390488wmb.19.2019.05.08.07.46.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 07:46:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4BB711FF87;
	Wed,  8 May 2019 15:46:08 +0100 (BST)
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston>
	<87imulaude.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87imulaude.fsf@dusky.pond.sub.org>
Date: Wed, 08 May 2019 15:46:08 +0100
Message-ID: <87tve53sy7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>,
	Aurelien
	Jarno <aurelien@aurel32.net>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Thu, 2 May 2019 at 19:58, Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511=
e41df:
>>>>
>>>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-reque=
st' into staging (2019-05-02 12:04:51 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>>>
>>>> for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c=
0:
>>>>
>>>>   sockets: avoid string truncation warnings when copying UNIX path (20=
19-05-02 20:50:47 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Pull request trivial branch 2019-05-02
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> Markus's "Clean up includes" patch breaks 'make check' on
>>> big-endian hosts:
>>> cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all  i32=
_to_f16 i
>>> 64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_t=
o_f128 >
>>>  int-to-float.out 2>&1 || (cat  int-to-float.out && exit 1;)
>>>>> Testing i32_to_f16, rounding near_even
>>> ^M372 tests total.
>>> ^M372 tests performed.
>>> In 372 tests, no errors found in i32_to_f16, rounding near_even.
>>>>> Testing i32_to_f16, rounding minMag
>>> [...]
>>> ^MErrors found in i32_to_f128:
>>> 1006FFFF  =3D> +0000.000000000000401B006FFFF00000 .....
>>>         expected +401B.006FFFF000000000000000000000 .....
>>> ^M0001DDEB  =3D> +0000.000000000000400FDDEB00000000 .....
>>>         expected +400F.DDEB000000000000000000000000 .....
>>> ^MFFF6FFFC  =3D> +0000.000000000000C012200080000000 .....
>>>         expected -4012.2000800000000000000000000000 .....
>>> ^MFFFFFFF8  =3D> +0000.000000000000C002000000000000 .....
>>>         expected -4002.0000000000000000000000000000 .....
>>> [etc]
>>
>> Considering the header clean-ups moved bswap related stuff and the
>> patterns look incorrectly swapped something has gone fishy.
>>
>> If it's just stuff touching f128 then we have some magic in
>> softfloat-types:
>>
>>  typedef struct {
>>  #ifdef HOST_WORDS_BIGENDIAN
>>      uint64_t high, low;
>>  #else
>>      uint64_t low, high;
>>  #endif
>>  } float128;
>>
>> but I would have though HOST_WORDS_BIGENDIAN is in the config. I shall
>> have a poke once I get onto the s390 machine.
>
> Any luck?
>
> In my own poking, I stumbled over
>
>     #ifndef HOST_WORDS_BIGENDIAN
>     #define LITTLEENDIAN 1
>     /* otherwise do not define it */
>     #endif
>
> in platform.h.  Is LITTLEENDIAN unused, or am I confused?

I couldn't replicate the bug with access to my s390 account so I think
it might be existing build artefact related which is odd.

--
Alex Benn=C3=A9e

