Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4357C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 22:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5D82073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 22:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgvWpasb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D82073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfsis-00013x-JN
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 18:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfsi7-0000TX-Ub
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 18:15:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfsi6-0004u3-1L
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 18:15:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id 131so4071297pfv.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BX7EAmZqnE9F58zM4h015O5rdd4Hqd5+OrSHBjkYDz8=;
 b=DgvWpasbalwteuMr1nB7yF/8VDgF5H0DZ8nr5jkVhmGjOXOdEGhRafk3sT7rLkoq9K
 Mo4WwvufSt8ThAzhx8TERKN+KWxT2Awd/oFjVnjK9I8ZO2GLx9y+2ZoN4ckLcgd60Or6
 dnGDnvLAonTGjl+roxpHxBHW1jAq+EdMkro7XPxQdPdolNzncIhx/usjl5SQ59QEqCQK
 BjLvhTRREodmfseWXt3miAJZsdG86c0McU+UDzY+Y2o/916d2aCzeIyxL4U1PdvxmMbW
 pBoY3PQCWklrdlG55xn5oHWeNxoaGTzbdSJ9dD1wrJX06ym2MjcgPypkj/JeI+pRtf/0
 IRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BX7EAmZqnE9F58zM4h015O5rdd4Hqd5+OrSHBjkYDz8=;
 b=NDdnfvBWScg0yyOhmE8YyHCISfBWVZEslq29aG9zBhPpJ47pbYznLa5Ajbc/UgVXcg
 nCq7zimjFjY5kICxPEG/W+g+FiHUshT8z/WclL4MsxQKJeSkfSQWGmPvS6nhmKotdpkZ
 POHLj6LTLdoo19x+yIBqFz4RK9yLWS1quCI0mZ15LxAKBfiw328yngqmnzhF8e0Iw8q8
 WR7V+1mlBEKjVWwRpKBa8S12T1qS3gCAbXS3MdWG8tzIHjd2jD4EGlLb6f9jpgt7Dr7D
 rTXS/qRZX7EMu5QpV0hxfSarr6rePM6krmGqgPIxR9tJF0nz0USlAZeF6XsAGZN2dm/5
 hp7g==
X-Gm-Message-State: AOAM53054CShOnxHt2COgRO+GiXQcNBdfi4DS00thlgTqcCmHYjVggAE
 wiww9Bt5sVyO9+orWJ05dAcwKg==
X-Google-Smtp-Source: ABdhPJynkfUadUpMr4B9KJWYVQ1C61S2aJvFllynOGvJPGowQTBfGfrK/ZzEnqD7xT55ID9qqqySCg==
X-Received: by 2002:aa7:9106:: with SMTP id 6mr21908652pfh.245.1591049707968; 
 Mon, 01 Jun 2020 15:15:07 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id hb3sm389191pjb.57.2020.06.01.15.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 15:15:07 -0700 (PDT)
Subject: Re: [PATCH] target/m68k: implement fmove.l #<data>,FPCR
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200531110231.620711-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <24e63485-dfce-96e7-7b68-90efeeec8fad@linaro.org>
Date: Mon, 1 Jun 2020 15:15:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200531110231.620711-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 4:02 AM, Laurent Vivier wrote:
> The immediate value mode was ignored and instruction execution
> ends to an invalid access mode.
> 
> This was found running 'R' that set FPSR to 0 at startup with
> a 'fmove.l #0,FPSR' in qemu-system-m68k emulation and triggers a
> kernel crash:
> 
> [   56.640000] *** ADDRESS ERROR ***   FORMAT=2
> [   56.640000] Current process id is 728
> [   56.640000] BAD KERNEL TRAP: 00000000
> [   56.640000] Modules linked in: sg evdev mac_hid ip_tables x_tables sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 crc32c_generic sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common sr_mod cdrom mac_esp macsonic esp_scsi
> [   56.640000] PC: [<00016a2c>] X_UNSUPP+0x2c/0x3c
> [   56.640000] SR: 2004  SP: 3eb5e68c  a2: c02e239a
> [   56.640000] d0: 00000040    d1: 00000002    d2: 8002adec    d3: 8002ad50
> [   56.640000] d4: 8002c768    d5: 0000000d    a0: ffffffc2    a1: ffffffc1
> [   56.640000] Process R (pid: 728, task=a3dfda5d)
> [   56.640000] Frame format=2 instr addr=00000000
> [   56.650000] Stack from 3a4d9f30:
> [   56.650000]         41000000 00000002 00000002 ffffffc2 ffffffc1 1fff0000 80000000 00000000
> [   56.650000]         3fbf0000 80000000 00000000 00000000 20000000 00000000 7fff0000 ffffffff
> [   56.650000]         ffffffff 00000000 00050008 00000000 8000067c c02c2000 efffee20 000002d8
> [   56.650000]         00002a28 3a4d9f98 00000002 00000014 fffffffe 8002c768 00000002 00000041
> [   56.650000]         00000002 c041fc58 c0743758 ffffffff 00000000 0008c075 00002b24 00000012
> [   56.650000]         000007d0 00000024 00000002 c05bef04 c05bef04 0000005e 00000077 c28aca70
> [   56.650000] Call Trace: [<00050008>] copy_overflow+0x10/0x28
> [   56.650000]  [<00002a28>] buserr+0x20/0x28
> [   56.650000]  [<0008c075>] bpf_check+0x57f/0x1cfa
> [   56.650000]  [<00002b24>] syscall+0x8/0xc
> [   56.650000]  [<0000c019>] dn_sched_init+0x75/0x88
> [   56.650000] Code: 1017 0200 00f0 0c00 0040 66ff 0000 05ac <f23c> 8800 0000 0000 f23c 9000 0000 0000 222e ff84 082e 0005 ff1c 6600 000a 0281
> [   56.650000] Disabling lock debugging due to kernel taint
> ...
> 
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

