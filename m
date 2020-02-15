Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C13C352A3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 20:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F482073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 20:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CD3n6cWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F482073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j33et-00088H-Uz
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 15:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1j33au-0006nT-Tm
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1j33at-0004vh-VU
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:59:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:35227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1j33at-0004uJ-JT
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581796746;
 bh=qxZgqHcPKBo88I+b/S2UGFrQQHer6PERsExPC+yj04s=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CD3n6cWMxsuCMjAzLiEVd3PyJr5QbQp7/MZpPJQ8M2zMmz23eAz6vSMuV5Obht0ab
 rG1f6hV1oVXZixjLgR44iGE9s7J8d5vE6ryLCfPMQikNDbx4JB+59h2aEwl9GtwSJq
 70V7pPAgaHSrJ3LgGgay7qo5/awPzox9Kwt7M/Ng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.227]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1imU982D0W-00IhNM; Sat, 15
 Feb 2020 20:59:06 +0100
Subject: Re: [PATCH 1/4] hw/hppa/dino: Add comments with register name
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
References: <20200213234148.8434-1-f4bug@amsat.org>
 <20200213234148.8434-2-f4bug@amsat.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <ddc10c9d-43b3-bdec-01f9-9db4a5e77c92@gmx.de>
Date: Sat, 15 Feb 2020 20:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213234148.8434-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vjxLrsWbBdgTiP60SKRvZXzsMPdQEWWf+YYxOX+/bLMThlvOReS
 KZw0ZBfhksuiSSXB5H5Ge9r9guJkfucqlo9hTKs70w9eOih/NgkRdcquzCor2kIpatzsAuY
 50+DBxKc7sujlwQQUVU1485N3yZbYOsc+qZ+bIGEKZsTxl8KF1KYgkbRgUNBIdb3z9qbkPi
 CgyB3aKzQTXaE9SvZecbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/PM1rQMMJU=:4i+e0K9SQDj+OiMgN4yTj/
 R04mOG//l9tGedGsXWy7+gF/IG864Yquwwbi/BaElfX5eUAFp4Z3i0I3tbqg4JGtBO/MQG6vd
 imYlzSUOsnX3jliKNMTV2dx3Ko9VllGJsGlUMt+fhFIM+QmgMstsieT5TAVZ5twhdVIY0I5FF
 bwvqourtJOc6LzW5YKxMPIcio0Z1ORB1P+kNFbDDA/52Hmmam+Ix6WVupZ0O0Zzw8Q6NEkIiQ
 mENYaqGkkDuvcjduvbNjOi9ZAqz3Qyf+zh8lnf4NpvTIv9MLNF5ueKkFKTHf8hPYji6iDY4Gd
 ihxnN5Obnxqp1GPIc39qb28ZtAwStTtbwOZLZUFsTQG9BqqBObLtHMTxhMozxulCa8Cz/bt8g
 HSS/mAVNRAgLff9MjQIb+r33Z/Z/tg9yxou4r2oCftqeDJDhXvyaO01ammrLtszMqSCMoEtCz
 65VuEmECCluAuBElTwBd5kjPiSBqy4Tnul0h0V79pbwMhozHAFMvw6RsYwy2APgMc+NVa57rW
 QUp5+EJ3HN74CXsMVH4GguyfIdH3NgrTJdeqBMPQb/VENl3qWgQkuA1DMG1FiqDZVTpRM/psQ
 jhZsUCCDBidzfOSgqvjpDwo7eCNLdWi0fkNhqI+RppAQdjKN9abyuCnWSHkehubz4HPFK4bBs
 vSTYVLw9rXCnKtf00YJUnfxLq7DGg2ec/F4+u/Ftwm20F5dKqHfAsctL2kTPWo8QRQbARc1rI
 CZCnnBPvVpB/e2njAT8XKjWVBHUmlLexSPy2dSfKJ0bqHqm6lrg7UpA0a1ay+G5oWtiu/+042
 1xwHxa+WAjG0T9VwEDothWf3rK3VVxvH9t/IEVIU79PncFFiiUL1CWwU7SOdoqnjVL3CWVZLK
 RyTJJIpEht/2KqbyUyrAe5TxGK/14kiwmm+pqXNqZo5VKctkwCFflPjJvDJ7YeKkrv/1HL83L
 NHT9rN8Vk7TWgQbH6i6E5jjho+aNDPkAKQ1W7t71ykvtQRWlDRPBlUYNoUcpO9lkEtV62xVT6
 hFQ7jNmnEKiz4Au+EtJ3Lz4xUkGLy4YuEoW9weELmI8VfO/iPWbVbhBjNFFlObUy0/AkyW1kg
 byjM722/FtnRYoSWUJveuXzaTdXobZt8PjKsgHgOQLK6MUgoMlraQhdjjzqdHv7JZiGZnXO3V
 Tk0VX+dezJ+6EEl5do+NeWaFyVje+wc+nmjzlk01G6NiZmmIQm818txhKXgloObJcimeRnqWE
 oJeSgXV0w/PjANrBG
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.02.20 00:41, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a comment with the name of each register in the 0x800-0x833 range.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Helge Deller <deller@gmx.de>

> ---
>  hw/hppa/dino.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 9797a7f0d9..c237ad3b1b 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -85,18 +85,18 @@
>
>  #define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
>  static const uint32_t reg800_keep_bits[DINO800_REGS] =3D {
> -            MAKE_64BIT_MASK(0, 1),
> -            MAKE_64BIT_MASK(0, 7),
> -            MAKE_64BIT_MASK(0, 7),
> -            MAKE_64BIT_MASK(0, 8),
> -            MAKE_64BIT_MASK(0, 7),
> -            MAKE_64BIT_MASK(0, 9),
> -            MAKE_64BIT_MASK(0, 32),
> -            MAKE_64BIT_MASK(0, 8),
> -            MAKE_64BIT_MASK(0, 30),
> -            MAKE_64BIT_MASK(0, 25),
> -            MAKE_64BIT_MASK(0, 22),
> -            MAKE_64BIT_MASK(0, 9),
> +    MAKE_64BIT_MASK(0, 1),  /* GMASK */
> +    MAKE_64BIT_MASK(0, 7),  /* PAMR */
> +    MAKE_64BIT_MASK(0, 7),  /* PAPR */
> +    MAKE_64BIT_MASK(0, 8),  /* DAMODE */
> +    MAKE_64BIT_MASK(0, 7),  /* PCICMD */
> +    MAKE_64BIT_MASK(0, 9),  /* PCISTS */
> +    MAKE_64BIT_MASK(0, 32), /* Undefined */
> +    MAKE_64BIT_MASK(0, 8),  /* MLTIM */
> +    MAKE_64BIT_MASK(0, 30), /* BRDG_FEAT */
> +    MAKE_64BIT_MASK(0, 25), /* PCIROR */
> +    MAKE_64BIT_MASK(0, 22), /* PCIWOR */
> +    MAKE_64BIT_MASK(0, 9),  /* TLTIM */
>  };
>
>  typedef struct DinoState {
>


