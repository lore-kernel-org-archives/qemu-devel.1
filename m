Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC232083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC232083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrT6-00004t-HH
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgqYe-0004UI-CW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgqYb-0005JW-Jv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:04:52 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:34813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgqYa-00055u-BQ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:04:48 -0400
Received: by mail-wm1-f48.google.com with SMTP id w9so9311336wmd.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 06:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w5Vg3tkkDkjY6PttiNQHOlE9rWBYlL6Po6SAMi7cmCc=;
 b=gDYTwT2lW/RUI6/u4O7y/KSaxm3QtM0ku2ta/myE9vY+4loB/VYAxDEP37/OdfgmEJ
 +U5BaeUySf7mlY4uqmeZLifsn546gm+5fDKP0unMAmVOgYSjkZJByLLTgDCC9mEtUwR9
 L6hiz4J3uKMi0o+5eY+0ZDBhut0jM/jEp5uhRAbx0U3PRpF9DCQ1UQb8WsqSenENdid+
 Wr/HMdUJ/Q/u2UeAileche8woyQaKJXzEy3e0cvIoFiek6Bs1STKaV9sPHcCk34DyMO1
 eeiaw9a9HYsH2r04Cs2kge6tU2xHSp8AR/YgFLtMkVX7YFmarGUqeuPXD//oapNU9QRU
 1d5g==
X-Gm-Message-State: APjAAAUpSwnZ4/UAc5MlIH3hpeFe+rDwkOhfdAFcKJ0uoUBtI/GjRYpa
 xqvaSUpF9EhK/7yflyOws6s8eJV+yV0=
X-Google-Smtp-Source: APXvYqxrWc4WQ5p9X8QndTonadVAisUizKKLladAyzcPUGJuL3TMTNK87jU4ZMvmE6x/ASx23WVF0w==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr7343204wml.90.1561721236403; 
 Fri, 28 Jun 2019 04:27:16 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id g8sm3247803wme.20.2019.06.28.04.27.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 04:27:15 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190312085502.8203-1-david@gibson.dropbear.id.au>
 <20190312085502.8203-13-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b693da29-0d2a-e739-17fb-9fd78894fd9e@redhat.com>
Date: Fri, 28 Jun 2019 13:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190312085502.8203-13-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.48
Subject: Re: [Qemu-devel] [PULL 12/62] target/ppc/spapr: Enable mitigations
 by default for pseries-4.0 machine type
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 3/12/19 9:54 AM, David Gibson wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> 
> There are currently 3 mitigations the availability of which is controlled
> by the spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable these
> mitigations by default for the pseries-4.0 machine type.
> 
> By now machine firmware should have been upgraded to allow these
> settings.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Message-Id: <20190301044609.9626-3-sjitindarsingh@gmail.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 37fd7a1411..946bbcf9ee 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4307,9 +4307,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
> -    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
> @@ -4389,6 +4389,9 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled = false;
>      smc->dr_phb_enabled = false;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
>  }

While trying auto-bisection for LP#1834613 [*] I found this commit break
clean bisection.

./configure --enable-debug

$ qemu-system-ppc64 \
 -kernel vmlinuz-vanilla \
 -nographic -serial null
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ibs=workaround
Opcode 13 10 10 00 (4c400420) leaked temporaries

More verbose log:

$ qemu-system-ppc64 \
 -kernel vmlinuz-vanilla \
 -nographic -append "console=hvc0" \
 -d guest_errors,in_asm
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ibs=workaround


SLOF **********************************************************************
QEMU Starting
 Build Date = Jan 14 2019 18:00:39
 FW Version = git-a5b428e1c1eae703
 Press "s" to enter Open Firmware.
[...]
--------------
IN: __switch_to
0xc00000000001aac0:  60000000  nop
0xc00000000001aac4:  7f44d378  mr       r4, r26
0xc00000000001aac8:  7f23cb78  mr       r3, r25
0xc00000000001aacc:  4bff3235  bl       0xdd00

----------------
IN: _switch
0xc00000000000dd00:  7c0802a6  mflr     r0
0xc00000000000dd04:  f8010010  std      r0, 0x10(r1)
0xc00000000000dd08:  f821fe31  stdu     r1, -0x1d0(r1)
0xc00000000000dd0c:  f9c100e0  std      r14, 0xe0(r1)
0xc00000000000dd10:  f9e100e8  std      r15, 0xe8(r1)
0xc00000000000dd14:  fa0100f0  std      r16, 0xf0(r1)
0xc00000000000dd18:  fa2100f8  std      r17, 0xf8(r1)
0xc00000000000dd1c:  fa410100  std      r18, 0x100(r1)
0xc00000000000dd20:  fa610108  std      r19, 0x108(r1)
0xc00000000000dd24:  fa810110  std      r20, 0x110(r1)
0xc00000000000dd28:  faa10118  std      r21, 0x118(r1)
0xc00000000000dd2c:  fac10120  std      r22, 0x120(r1)
0xc00000000000dd30:  fae10128  std      r23, 0x128(r1)
0xc00000000000dd34:  fb010130  std      r24, 0x130(r1)
0xc00000000000dd38:  fb210138  std      r25, 0x138(r1)
0xc00000000000dd3c:  fb410140  std      r26, 0x140(r1)
0xc00000000000dd40:  fb610148  std      r27, 0x148(r1)
0xc00000000000dd44:  fb810150  std      r28, 0x150(r1)
0xc00000000000dd48:  fba10158  std      r29, 0x158(r1)
0xc00000000000dd4c:  fbc10160  std      r30, 0x160(r1)
0xc00000000000dd50:  fbe10168  std      r31, 0x168(r1)
0xc00000000000dd54:  f8010170  std      r0, 0x170(r1)
0xc00000000000dd58:  7ee00026  mfcr     r23
0xc00000000000dd5c:  fae101a0  std      r23, 0x1a0(r1)
0xc00000000000dd60:  f8230000  std      r1, 0(r3)
0xc00000000000dd64:  4bffdb3d  bl       0xb8a0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8a0:  7d2802a6  mflr     r9
0xc00000000000b8a4:  48000005  bl       0xb8a8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8a8:  48000005  bl       0xb8ac

----------------
IN: ret_from_kernel_thread
0xc00000000000b8ac:  48000005  bl       0xb8b0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8b0:  48000005  bl       0xb8b4

----------------
IN: ret_from_kernel_thread
0xc00000000000b8b4:  48000005  bl       0xb8b8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8b8:  48000005  bl       0xb8bc

----------------
IN: ret_from_kernel_thread
0xc00000000000b8bc:  48000005  bl       0xb8c0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8c0:  48000005  bl       0xb8c4

----------------
IN: ret_from_kernel_thread
0xc00000000000b8c4:  48000005  bl       0xb8c8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8c8:  48000005  bl       0xb8cc

----------------
IN: ret_from_kernel_thread
0xc00000000000b8cc:  48000005  bl       0xb8d0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8d0:  48000005  bl       0xb8d4

----------------
IN: ret_from_kernel_thread
0xc00000000000b8d4:  48000005  bl       0xb8d8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8d8:  48000005  bl       0xb8dc

----------------
IN: ret_from_kernel_thread
0xc00000000000b8dc:  48000005  bl       0xb8e0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8e0:  48000005  bl       0xb8e4

----------------
IN: ret_from_kernel_thread
0xc00000000000b8e4:  48000005  bl       0xb8e8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8e8:  48000005  bl       0xb8ec

----------------
IN: ret_from_kernel_thread
0xc00000000000b8ec:  48000005  bl       0xb8f0

----------------
IN: ret_from_kernel_thread
0xc00000000000b8f0:  48000005  bl       0xb8f4

----------------
IN: ret_from_kernel_thread
0xc00000000000b8f4:  48000005  bl       0xb8f8

----------------
IN: ret_from_kernel_thread
0xc00000000000b8f8:  48000005  bl       0xb8fc

----------------
IN: ret_from_kernel_thread
0xc00000000000b8fc:  48000005  bl       0xb900

----------------
IN: ret_from_kernel_thread
0xc00000000000b900:  48000005  bl       0xb904

----------------
IN: ret_from_kernel_thread
0xc00000000000b904:  48000005  bl       0xb908

----------------
IN: ret_from_kernel_thread
0xc00000000000b908:  48000005  bl       0xb90c

----------------
IN: ret_from_kernel_thread
0xc00000000000b90c:  48000005  bl       0xb910

----------------
IN: ret_from_kernel_thread
0xc00000000000b910:  48000005  bl       0xb914

----------------
IN: ret_from_kernel_thread
0xc00000000000b914:  48000005  bl       0xb918

----------------
IN: ret_from_kernel_thread
0xc00000000000b918:  48000005  bl       0xb91c

----------------
IN: ret_from_kernel_thread
0xc00000000000b91c:  48000005  bl       0xb920

----------------
IN: ret_from_kernel_thread
0xc00000000000b920:  48000005  bl       0xb924

----------------
IN: ret_from_kernel_thread
0xc00000000000b924:  48000005  bl       0xb928

----------------
IN: ret_from_kernel_thread
0xc00000000000b928:  48000005  bl       0xb92c

----------------
IN: ret_from_kernel_thread
0xc00000000000b92c:  48000005  bl       0xb930

----------------
IN: ret_from_kernel_thread
0xc00000000000b930:  48000005  bl       0xb934

----------------
IN: ret_from_kernel_thread
0xc00000000000b934:  48000005  bl       0xb938

----------------
IN: ret_from_kernel_thread
0xc00000000000b938:  48000005  bl       0xb93c

----------------
IN: ret_from_kernel_thread
0xc00000000000b93c:  48000005  bl       0xb940

----------------
IN: ret_from_kernel_thread
0xc00000000000b940:  48000005  bl       0xb944

----------------
IN: ret_from_kernel_thread
0xc00000000000b944:  48000005  bl       0xb948

----------------
IN: ret_from_kernel_thread
0xc00000000000b948:  48000005  bl       0xb94c

----------------
IN: ret_from_kernel_thread
0xc00000000000b94c:  48000005  bl       0xb950

----------------
IN: ret_from_kernel_thread
0xc00000000000b950:  48000005  bl       0xb954

----------------
IN: ret_from_kernel_thread
0xc00000000000b954:  48000005  bl       0xb958

----------------
IN: ret_from_kernel_thread
0xc00000000000b958:  48000005  bl       0xb95c

----------------
IN: ret_from_kernel_thread
0xc00000000000b95c:  48000005  bl       0xb960

----------------
IN: ret_from_kernel_thread
0xc00000000000b960:  48000005  bl       0xb964

----------------
IN: ret_from_kernel_thread
0xc00000000000b964:  48000005  bl       0xb968

----------------
IN: ret_from_kernel_thread
0xc00000000000b968:  48000005  bl       0xb96c

----------------
IN: ret_from_kernel_thread
0xc00000000000b96c:  48000005  bl       0xb970

----------------
IN: ret_from_kernel_thread
0xc00000000000b970:  48000005  bl       0xb974

----------------
IN: ret_from_kernel_thread
0xc00000000000b974:  48000005  bl       0xb978

----------------
IN: ret_from_kernel_thread
0xc00000000000b978:  48000005  bl       0xb97c

----------------
IN: ret_from_kernel_thread
0xc00000000000b97c:  48000005  bl       0xb980

----------------
IN: ret_from_kernel_thread
0xc00000000000b980:  48000005  bl       0xb984

----------------
IN: ret_from_kernel_thread
0xc00000000000b984:  48000005  bl       0xb988

----------------
IN: ret_from_kernel_thread
0xc00000000000b988:  48000005  bl       0xb98c

----------------
IN: ret_from_kernel_thread
0xc00000000000b98c:  48000005  bl       0xb990

----------------
IN: ret_from_kernel_thread
0xc00000000000b990:  48000005  bl       0xb994

----------------
IN: ret_from_kernel_thread
0xc00000000000b994:  48000005  bl       0xb998

----------------
IN: ret_from_kernel_thread
0xc00000000000b998:  48000005  bl       0xb99c

----------------
IN: ret_from_kernel_thread
0xc00000000000b99c:  48000005  bl       0xb9a0

----------------
IN: ret_from_kernel_thread
0xc00000000000b9a0:  48000005  bl       0xb9a4

----------------
IN: ret_from_kernel_thread
0xc00000000000b9a4:  4800001c  b        0xb9c0

Opcode 13 10 10 00 (4c400420) leaked temporaries
----------------
IN: ret_from_kernel_thread
0xc00000000000b9c0:  7d2803a6  mtlr     r9
0xc00000000000b9c4:  39207fff  li       r9, 0x7fff
0xc00000000000b9c8:  7d2903a6  mtctr    r9
0xc00000000000b9cc:  4c400420  bdzfctr  lt

----------------
IN: __start
0xc000000000004700:  7db243a6  mtspr    0x112, r13
0xc000000000004704:  7db142a6  mfspr    r13, 0x111
0xc000000000004708:  f92d0080  std      r9, 0x80(r13)
0xc00000000000470c:  7d20e2a6  mfspr    r9, 0x380
0xc000000000004710:  7c421378  mr       r2, r2
[...]
----------------
IN: __start
0xc000000000008efc:  894d097b  lbz      r10, 0x97b(r13)
0xc000000000008f00:  39600001  li       r11, 1
0xc000000000008f04:  614a0001  ori      r10, r10, 1
0xc000000000008f08:  996d097a  stb      r11, 0x97a(r13)
0xc000000000008f0c:  994d097b  stb      r10, 0x97b(r13)
0xc000000000008f10:  38610070  addi     r3, r1, 0x70
0xc000000000008f14:  48019585  bl       0x22498

----------------
IN: program_check_exception
0xc000000000022498:  7c0802a6  mflr     r0
0xc00000000002249c:  fbc1fff0  std      r30, -0x10(r1)
0xc0000000000224a0:  fbe1fff8  std      r31, -8(r1)
0xc0000000000224a4:  7c7f1b78  mr       r31, r3
0xc0000000000224a8:  f8010010  std      r0, 0x10(r1)
0xc0000000000224ac:  f821ff91  stdu     r1, -0x70(r1)
0xc0000000000224b0:  e9230108  ld       r9, 0x108(r3)
0xc0000000000224b4:  793e0020  clrldi   r30, r9, 0x20
0xc0000000000224b8:  77ca0010  andis.   r10, r30, 0x10
0xc0000000000224bc:  418200a4  beq      0x22560

----------------
IN: program_check_exception
0xc000000000022560:  77ca0002  andis.   r10, r30, 2
0xc000000000022564:  418200f4  beq      0x22658

----------------
IN: program_check_exception
0xc000000000022658:  77ca0020  andis.   r10, r30, 0x20
0xc00000000002265c:  4182004c  beq      0x226a8

----------------
IN: program_check_exception
0xc0000000000226a8:  e93f0108  ld       r9, 0x108(r31)
0xc0000000000226ac:  71294000  andi.    r9, r9, 0x4000
0xc0000000000226b0:  41820074  beq      0x22724

----------------
IN: program_check_exception
0xc000000000022724:  77c90004  andis.   r9, r30, 4
0xc000000000022728:  e8df0100  ld       r6, 0x100(r31)
0xc00000000002272c:  38a00005  li       r5, 5
0xc000000000022730:  4082ff40  bne      0x22670

----------------
IN: program_check_exception
0xc000000000022734:  38a00001  li       r5, 1
0xc000000000022738:  4bffff38  b        0x22670

----------------
IN: program_check_exception
0xc000000000022670:  7fe4fb78  mr       r4, r31
0xc000000000022674:  38600004  li       r3, 4
0xc000000000022678:  4bfffed0  b        0x22548

----------------
IN: program_check_exception
0xc000000000022548:  38210070  addi     r1, r1, 0x70
0xc00000000002254c:  e8010010  ld       r0, 0x10(r1)
0xc000000000022550:  ebc1fff0  ld       r30, -0x10(r1)
0xc000000000022554:  ebe1fff8  ld       r31, -8(r1)
0xc000000000022558:  7c0803a6  mtlr     r0
0xc00000000002255c:  4bfffe4c  b        0x223a8

----------------
IN: _exception
0xc0000000000223a8:  38e00000  li       r7, 0
0xc0000000000223ac:  4bffffd4  b        0x22380

----------------
IN: _exception_pkey
0xc000000000022380:  e9240108  ld       r9, 0x108(r4)
0xc000000000022384:  71294000  andi.    r9, r9, 0x4000
0xc000000000022388:  40820014  bne      0x2239c

----------------
IN: _exception_pkey
0xc00000000002238c:  7c651b78  mr       r5, r3
0xc000000000022390:  3c62ffd4  addis    r3, r2, -0x2c
0xc000000000022394:  3863467e  addi     r3, r3, 0x467e
0xc000000000022398:  4bfffc6c  b        0x22004

----------------
IN: die
0xc000000000022004:  7c0802a6  mflr     r0
0xc000000000022008:  48732b19  bl       0x754b20

----------------
IN: die
0xc00000000002200c:  f821ffc1  stdu     r1, -0x40(r1)
0xc000000000022010:  7c7c1b78  mr       r28, r3
0xc000000000022014:  7c9f2378  mr       r31, r4
0xc000000000022018:  7cbe2b78  mr       r30, r5
0xc00000000002201c:  e9240140  ld       r9, 0x140(r4)
0xc000000000022020:  792906e4  rldicr   r9, r9, 0, 0x3b
0xc000000000022024:  2fa90100  cmpdi    cr7, r9, 0x100
0xc000000000022028:  409e0058  bne      cr7, 0x22080

----------------
IN: die
0xc000000000022080:  3d220003  addis    r9, r2, 3
0xc000000000022084:  e9291d38  ld       r9, 0x1d38(r9)
0xc000000000022088:  2fa90000  cmpdi    cr7, r9, 0
0xc00000000002208c:  419effa0  beq      cr7, 0x2202c

----------------
IN: die
0xc00000000002202c:  7fe3fb78  mr       r3, r31
0xc000000000022030:  4bfff74d  bl       0x2177c

----------------
IN: oops_begin
0xc00000000002177c:  7c0802a6  mflr     r0
0xc000000000021780:  fbe1fff8  std      r31, -8(r1)
0xc000000000021784:  f8010010  std      r0, 0x10(r1)
0xc000000000021788:  f821ffd1  stdu     r1, -0x30(r1)
0xc00000000002178c:  480a42bd  bl       0xc5a48
[...]
----------------
IN: console_flush_on_panic
0xc000000000121d98:  38210020  addi     r1, r1, 0x20
0xc000000000121d9c:  39200000  li       r9, 0
0xc000000000121da0:  3d42000c  addis    r10, r2, 0xc
0xc000000000121da4:  e8010010  ld       r0, 0x10(r1)
0xc000000000121da8:  912a282c  stw      r9, 0x282c(r10)
0xc000000000121dac:  7c0803a6  mtlr     r0
0xc000000000121db0:  4bffe5d0  b        0x120380

----------------
IN: panic_flush_kmsg_end
0xc000000000022348:  60000000  nop
0xc00000000002234c:  38210020  addi     r1, r1, 0x20
0xc000000000022350:  e8010010  ld       r0, 0x10(r1)
0xc000000000022354:  7c0803a6  mtlr     r0
0xc000000000022358:  4e800020  blr

----------------
IN: pseries_panic
0xc000000000096e9c:  60000000  nop
0xc000000000096ea0:  e8610020  ld       r3, 0x20(r1)
0xc000000000096ea4:  4bf97025  bl       0x2dec8

----------------
IN: rtas_os_term
0xc00000000002dec8:  7c0802a6  mflr     r0
0xc00000000002decc:  48726c59  bl       0x754b24
[...]
Guest crashed

Am I supposed to use different command line options to run this image?

Thanks,

Phil.

[*] https://bugs.launchpad.net/bugs/1834613


