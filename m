Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05FDC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4EA221EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5kI/aOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4EA221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNCU-0001T2-R1
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPNB6-00080d-3q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPNB4-0006Zf-Vx
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:20:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:43030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPNB0-0006NM-6J; Fri, 17 Apr 2020 05:20:46 -0400
Received: by mail-ej1-x633.google.com with SMTP id gr25so1057775ejb.10;
 Fri, 17 Apr 2020 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kG6hv1YDexRUfq1qfGt9ldyQuL+gsxnz/gSByTCB6EQ=;
 b=o5kI/aOy3Dpnu4pJBxC39W3w1EBJ2fco9qShtevM9faaf/OzN8+gfWJMIFc3XD/n6J
 Ks2DZKb2J6eKlctJyfqxXlFaD3FM/QrKPffxcfpE4byhPUk06vgINRDTtlcm7twdj1Zv
 pdXISdlT/51Ooh3P2WbuAktkes5RxKL81CYdz5QUO86RtBxODGGwq6KqxUE6JiZg5Sl7
 7qDSNOCPkXoKd8FgBv1cmcqAEEcQASOfGQ8bQJkn3F+yX3zzQDk17YSzTm9G3/y1vguV
 2Z3TROY9btes+FP3pvQsldwg4Hot2vyOtBrX2P0e9P+Ux3svIhdQGqRThOzPrH0hUQ1/
 6VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kG6hv1YDexRUfq1qfGt9ldyQuL+gsxnz/gSByTCB6EQ=;
 b=bMohy4ALwNTCnZGy3IfIzn5USOQvj0pYk7jkqwN3caIjsndj7sSPd636V5Y6ELGy6K
 NVAENGadtvrWgZ+GP6KuYYlI99R9OZBxZO1v9D9FE7Kp5mjf8sG8N8khxqonmMwDr6so
 M3718i1HiD0UEXDIPEDa2lu2LWETXC8xoqhB7MSBC6sgC5iWcFLWLXNP6vRaBoeb2FqK
 FiOo3PCDceqwZhsPNEfuqP5y6AtiAZLji/lN9rEM8E8Ub0tohINVaLixtttdB9f6mQtf
 AxS4wIY0oO3NCYwrdLhKbFZHPKHCRCmcaHTGRaAUKTioouXlI3R/FQ5ekJ6nrMJw0BKB
 ZHsQ==
X-Gm-Message-State: AGi0PuaU5ywpw56v5OZp4d6AlIRcKbVU0/VlzlPf1MYRGUqcFN9NRjMH
 Jsa+633RKFoDQz6cdHvnLLy0KShat5A=
X-Google-Smtp-Source: APiQypJwjrW/Oe0AMoPaswV8zsc+YyxgsaeemjHJEpICAF99iVHRv04DO8+kl0utGoZzgpCruwCckw==
X-Received: by 2002:a17:906:2bd1:: with SMTP id
 n17mr2059406ejg.176.1587115244653; 
 Fri, 17 Apr 2020 02:20:44 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b5sm2878054edk.72.2020.04.17.02.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 02:20:43 -0700 (PDT)
Subject: Re: 5.0.0-rc3 : Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
To: Dennis Clarke <dclarke@blastwave.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
References: <707f641b-1cf6-15a0-0602-5950e7b98886@blastwave.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <023af69c-d21b-55a7-cdb4-f61ff3cd50f9@amsat.org>
Date: Fri, 17 Apr 2020 11:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <707f641b-1cf6-15a0-0602-5950e7b98886@blastwave.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::633
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
Cc: qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dennis,

On 4/17/20 2:42 AM, Dennis Clarke via wrote:>
> Very strange messages from qemu 5.0.0-rc3 wherein I try to run :
>
> $ /usr/local/bin/qemu-system-ppc64 --version
> QEMU emulator version 4.2.93
> Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
> $
> $
> $ /usr/local/bin/qemu-system-ppc64 \
>  > -machine pseries-4.1 -cpu power9 -smp 4 -m 12G -accel tcg \
>  > -drive file=/home/ppc64/ppc64le.qcow2 \
>  > -device virtio-net-pci,netdev=usernet \
>  > -netdev user,id=usernet,hostfwd=tcp::10000-:22 \
>  > -serial stdio -display none -vga none
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=workaround[...]> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000002000000 ...
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
[...]

Thanks for this report. I purposed a patch to fix this, but don't expect
it to be fixed in the next 5.0 release because this is not a critical
security bug.

>  From this point onwards I see an endless stream of :
>
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
[...]
>
> No idea what that is .. but it doesn't look friendly.
>
> Also I did compile qemu with --enable-debug --disable-strip and the
> performance is truely horrific.  I can only assume that those options
> are the cause. Any thoughts from anyone would be wonderful.

--enable-debug enables --enable-debug-tcg which is not designed for
performance. You might want to try '--enable-debug --disable-debug-tcg'.

