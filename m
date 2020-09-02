Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C597205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kFRire35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C597205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQno-0005UI-9x
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDQkn-0004v8-Qu
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:16:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:59931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDQkk-0002HU-Ji
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599045388;
 bh=zZV4nNtuEjFcKs+/Ane/v/RTp0dlCfX9362SLTtmw54=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kFRire35KuZFIJUwA39CKJoe/24ZQvbkigZEaE/BTUDSN+ZQW3al9W3/QqLeEh3vi
 giiK1HnRQ+c/Vrp7wgcoqbeLI6VTfTFrr6Ba+l8qpUB3nY1cLD6FNu6JGN2G0QD5oY
 /PUj0LmiBJdOT+pSKneTnUOWq/KWo6zVcDxvAuZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.63]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1kxQgv34Nl-00p0iJ; Wed, 02
 Sep 2020 13:16:28 +0200
Subject: Re: [PATCH 2/7] hw/hppa: Make number of TLB and BTLB entries
 configurable
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-3-deller@gmx.de>
 <e4627473-3272-59e7-a8b6-0f223e69b198@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <162b573e-75d1-048b-4413-124e463c0942@gmx.de>
Date: Wed, 2 Sep 2020 13:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e4627473-3272-59e7-a8b6-0f223e69b198@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rSk6VS3czVQLRgT5BrQOi4e8leGd8gROzE3j6TSliAZL3b2rTco
 mbgw45N31yXs6g3PAsj0Gg9iRHCeQab9SZWhgc+Hpiy6u0LpJOKfnMy1Neoq9KEeoa8jBrZ
 xKpT2SXkKR76PG6WG5ACAd+OAA1itMcDnW7H4dzowLCIMXUtGTmDpX0t57jL1ztvSJZnTX/
 GRMHctISX8eUX2M9rDyNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khHDBNk4EMs=:+40g64nNwfGaK/wEenqfUq
 XoZY/WwacsaUa0RKvMuhVOFyJmi8ItPQ6cdfTAQIfOHwLNjI6gquCLZUjLHozdKXYCRz+wodw
 fb/PAxmTo94DDPi89crhxCATq2CrY/58FtmSN/7cZrIetWjBPcq/y+wthvpmsxvkQRvdcobvo
 EsfjF5I0cQW1EtNyBAVAxXzV95dMDU7oYxPIdplU/Jw0Azm1TTUPKhK2BRgWBQPjjrD93l45+
 tpil+DFdtojn6rBBGjpIJAi1ocJYSQWrP2GCF1vgIRIKtcs99oUm5woGgYRflgmJa7lWboeko
 jPabDLpxas5YP2UM1p77dp0Z4aufFNhGXrc+jxd6t3lv/XTwPRow5xYTHbmQ6BdO0n+RK/f1z
 1xNWZkuYswp4jjtkB/oKusu5UVB984+loDCjMeHZKctHMIQK3cQIf8VyKE6FhWUONpkIm8OfO
 E+P+eAc41rgU/65WRNlkGZSCJ/qL8jCprHQa8ba649N0ji/xHiiIe5lBJoa7/KTVhm0Hd195R
 n4daB3YcwqsiWjqMVdHkmsDvBFQTZ/9Me5vtvQtRk8giiCf3y5CgX7/SPYUsBDzQcPaHEgEkX
 yQpBLm2AOpH+BX8Wvgb7J1Z9OWWrPtYPsyvt7Dpr658fhYnQZj0uaSeXCh4CRN06kdUPkXu2Q
 s4MC1tL3OZYOBCjc59WweijoG7fEeIr0oeUTQEIw7A6qxcnDAfzkPx8ENuj6Tr0/4S8OTbNqe
 CQYwHgqa9YwLUxSrGAMAVEgNV1j860xzr9j5fM/MpB+RlT5ZNYMYzn8vpJDkQGihV6mzaupMx
 hTLY6DDw2CRS76ZBJZ+JpajqjdKmWtW5V/1nrkvYQFgjszP3u+Vkk6fHGpKeSLxwEjcUFRHa/
 ikrdIOdHOhqIGexZG9E5bwEc/zg/31mLYO0xBXgID9yBiRJT4u79/jMiCN9TBg1xjfgVlFpxY
 BP/KG6X9tTje+b+6ax962Ldh0KqM4zKg5iAODthgV/zpzI3RiIWdJ53sB6cd8eidfj4TMfh7p
 eUJ2nHslhmqkY0D+T0gZbB6aQeDUgl496KGmUZze3RCPXttjN+EnAhV1vDEE7Nw0+Q3bHJOQb
 hDH2zEvADfXpeGJxV6Y1oKMHtLoFSF/nri+ttGxX8tre3qbKdAJaBqX9E3YLmbsId9C8vwVhd
 hephHvC10Bc5snx1o9NsV4QoOp514yz0liwpbPLQ0RIY7xuuugtTU2AaEg7r3VbTsa357G8AN
 h9+9WSh3Uk/gQmRXC
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 07:16:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01.09.20 23:36, Richard Henderson wrote:
> On 9/1/20 11:34 AM, Helge Deller wrote:
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 90aeefe2a4..e9d84d0f03 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -72,6 +72,14 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>>      fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
>>                      g_memdup(&val, sizeof(val)), sizeof(val));
>>
>> +    val =3D cpu_to_le64(HPPA_TLB_ENTRIES);
>
> I guess you don't have a cpu structure here against which you could appl=
y
> ARRAY_SIZE?

You mean to calculate the number of TLB entries based on the static size
of an array, e.g. ARRAY_SIZE(struct CPUHPPAState.tlb[256]) ?
I've replaced it intentionally by a constant, because in a follow-up
patch to improve the TLB-lookup speed, the array gets replaced by a GTree.
You can see a working version of the patch here:
https://github.com/hdeller/qemu-hppa/commit/644790132b91cdb835c8dd38198e6f=
6ed0b533a1

In this patch:
-   hppa_tlb_entry tlb[HPPA_TLB_ENTRIES];
+   GTree *tlb;
+   GList *tlb_list;
+   int tlb_entries;

>>      /* ??? The number of entries isn't specified by the architecture. =
 */
>> +    #define HPPA_TLB_ENTRIES        256
>> +    #define HPPA_BTLB_ENTRIES       0
>
> The indented defines are weird.

How/Why?

> What's a btlb entry?

Block-TLB entries. Most PA1.1-machines have 16 such BTLBs which can
address a range of 4k pages with a single entry.
In a follow-up qemu patch it makes sense to add those TLBs.

Helge

