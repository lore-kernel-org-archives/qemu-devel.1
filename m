Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAEBC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1875020714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1875020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCJXn-0001no-7D
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 05:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kCJXA-0001DB-Ns; Sun, 30 Aug 2020 05:21:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:43296
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kCJX8-0008UO-GO; Sun, 30 Aug 2020 05:21:56 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kCJXS-0002bg-9Z; Sun, 30 Aug 2020 10:22:16 +0100
To: Nathan Chancellor <natechancellor@gmail.com>
References: <20200610134731.1514409-1-mst@redhat.com>
 <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
 <20200830021939-mutt-send-email-mst@kernel.org>
 <20200830064944.GA1073664@ubuntu-n2-xlarge-x86>
 <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
 <20200830074304.GA2406902@ubuntu-n2-xlarge-x86>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <7cdbeed4-c1aa-f00e-f6ab-a7684a0ce045@ilande.co.uk>
Date: Sun, 30 Aug 2020 10:21:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830074304.GA2406902@ubuntu-n2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.809,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/08/2020 08:43, Nathan Chancellor wrote:

> On Sun, Aug 30, 2020 at 08:24:15AM +0100, Mark Cave-Ayland wrote:
>> On 30/08/2020 07:49, Nathan Chancellor wrote:
>>
>>> Unfortunately, it does not. I applied it on top of latest
>>> git (ac8b279f13865d1a4f1958d3bf34240c1c3af90d) and I can still
>>> reproduce my failure. Is it possible that type of fix is needed
>>> in a RISC-V specific driver?
>>>
>>> Would you like me to comment on the Launchpad bug as well?
>>
>> Hi Nathan,
>>
>> I came up with a quick patch to enable some logging to catch memory accesses being
>> refused for a similar bug report at
>> https://bugs.launchpad.net/qemu/+bug/1886318/comments/13.
>>
>> Can you apply the same change to your tree and report any messages on stderr as you
>> do your board reboot test?
>>
>>
>> ATB,
>>
>> Mark.
> 
> Thanks Mark, that helped.
> 
> ...
> [    3.807738] reboot: Power down
> invalid size: riscv.sifive.test addr 0 size: 2
> sbi_trap_error: hart0: trap handler failed (error -2)
> sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
> sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
> sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
> sbi_trap_error: hart0: gp=0xffffffe000e765d0 tp=0xffffffe0081c0000
> sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
> sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
> sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
> sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
> sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
> sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
> sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
> sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
> sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
> sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
> sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
> sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
> sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
> sbi_trap_error: hart0: t6=0x0000000000000000
> 
> With this diff, I can successfully shut down the board. No idea if that
> is valid or not though.
> 
> Cheers,
> Nathan
> 
> ============================================================
> 
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index 0c78fb2c93..8c70dd69df 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
>      .write = sifive_test_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
> -        .min_access_size = 4,
> +        .min_access_size = 2,
>          .max_access_size = 4
>      }
>  };

Okay - so according to the definition above, before your patch the sifive_test device
has a min and max access size of 4, i.e. all writes less than 32-bits are invalid.
With your patch you reduce the min access size to 2 which allows 16-bit writes and so
allows your shutdown test to succeed.

I'm afraid I'm not familiar enough with RISCV or the sifive_test device specification
to know whether the QEMU definition is correct and the access should be refused, or
whether the guest is using the wrong size when writing to the sifive_test device
register.


ATB,

Mark.

