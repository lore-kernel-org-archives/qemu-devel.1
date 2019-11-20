Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C352D2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C352D2230F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQmZ-0006NQ-W3
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iXQlI-0005R2-8u
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iXQlG-0006Od-RO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:15:16 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iXQlG-0006Ml-GT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:15:14 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MeCxd-1hxY6S1UGt-00bHhl; Wed, 20 Nov 2019 15:14:47 +0100
To: Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
 <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
 <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
 <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Message-ID: <daae6a71-a5ba-21f7-ee57-2493d298ac52@vivier.eu>
Date: Wed, 20 Nov 2019 15:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nBQ/3jMcShYSRR3e5cz2TlxAOyQXqP6Dyf7Yw0qCY9d6VoOsKfp
 WsBxJqqNh9Sg07DCMpw1JgHhtOTeORyONnjnV+byJXPehOqhBkPc8jpRkDaboOpq9shCOAn
 I3iBF7zf8O4AT6yolBj9+84wsPLX9QGx9hX6HCAltbQ1hN+o3PD34CrZuUfud/3ZCAMobUW
 bHCNe26TJDuvwzzEagjlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:am1GtjRNzDc=:PgyrwO4GB5Vwn9WozUQYzN
 uWQAZ2yPO/p+8U3OFzy5DQd+Vf1tJkAtPHQAgEAyUCRDdlFhLK8lvownPVXqD0VL47l4h3RE+
 ynVcEZ9MjuHmSf/viaQwFQi9pmShKeSttkUNUvkLRfIICasJA1jg3wh5Flh3oXH7k8UZSi55R
 OdxHS4YzfDRD5UcFwuxTqF8YG27vU/APj3D0TM7GYgbF7iaMHd4NwsNn0XSszIBoY6xLTebkL
 Wf0FQKqzsAEL4x1AKWqpdxsjCKuBxxrL1zczLuC2PwhzVJi60Biu9qIX9caWbuS/dwswvU+rp
 t9+0QEhHqy+H8TOosjlYyh40cZhwqSF9r02vKw2jRtq+tmDb4uDThFFIl5RIQYwz79hExFsWq
 L3D3/KplCa92i05dI6guYXv4Y/OVLoLUqnKBpC78vNfz9/1MVCXFMl5fCm0s1+NUXNJkHbhse
 Y64hZ0z3DYyk4t9M9LEWz0zL4A7OMCQSYDZuVtbWqmbifWIo2/EXcIE0zOpr0pPxLH7SIZhvW
 9W7405CyrGeiVHhUwyoR3HZL5779dWBauv9dv9wFL2Zp2ud3rhl+6qNyrEQEQH26MO8ZQwrzM
 GyrLTAeyBl8TFAn0UIsG4R3WamJXDct86Rgd87xotbxoqqqKI+q3KKgncw2Ca2pe8tAj8U3kZ
 zGEhHq28vb3+ulxv4ywHd8P4ggm7/0BRxhGWzY/MRnmP+p8/kB4C8s1IsjOCPLHGJlXbVVTE4
 u1SZ+d7X26smVgyEOoO40eBx5vW6e+EKZLY7cXhHF77udMp5LJsED+fmsiWSTOZ+Gu+wIMrHj
 ja16caqzmuJvMlozvlFqCIgglB5yfeHFmK0ffrl8YDFVe8IBlJ1yU8MW1J/yHUqvF9D8Lh0Fr
 e05tcrk6TWv3UX4SUlLtTySeP3iSpDBkssqUE7bJQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/11/2019 à 13:58, Taylor Simpson a écrit :
> Is there a precedent for this?  I'm OK with DEBUG_HEX, but I assumed reviewers wouldn't approve
> #ifdef FIXME
> #define DEBUG_HEX
> #endif


For instance, in target/mips/translate.c you have:

     42
     43 #define MIPS_DEBUG_DISAS 0
     44
...
   2603 #define LOG_DISAS(...)  \
   2604     do { \
   2605         if (MIPS_DEBUG_DISAS) { \
   2606             qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__);\
   2607         }  \
   2608     } while (0)
   2609
...

  10121     LOG_DISAS("mftr (reg %d u %d sel %d h %d)\n", rt, u, sel,
h);
...

For the linux-user part, I don't think you need the DEBUG_HEX traces.

Thanks,
Laurent
> 
> -----Original Message-----
> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Wednesday, November 20, 2019 3:02 AM
> To: Laurent Vivier <laurent@vivier.eu>; Taylor Simpson <tsimpson@quicinc.com>; Philippe Mathieu-Daudé <philmd@redhat.com>; riku.voipio@iki.fi; qemu-devel@nongnu.org
> Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches - linux-user changes + linux-user/hexagon + skeleton of target/hexagon - Files in target/hexagon/imported are from another project and therefore do not conform to qemu coding standards
> 
> 
> On 11/20/19 9:33 AM, Laurent Vivier wrote:
>> Le 20/11/2019 à 05:48, Taylor Simpson a écrit :
>>> For the general DEBUG_HEX messages, I think the trace infrastructure isn't quite what I'm looking for.
>>>
>>> Here's a sample of what it prints
>>> Start packet: pc = 0x4002f0
>>> Packet committed: pc = 0x4002f0
>>> Regs written
>>>         r18 = -69420 (0xfffef0d4)
>>>         r19 = -69412 (0xfffef0dc)
>>> Stores
>>>         memd[0xfffef0b0] = 0 (0x0000000000000000) Next PC = 0x4002f8
>>> Exec counters: pkt = 17, insn = 24, hvx = 0
> 
> For something like this, I'd keep DEBUG_HEX.
> 
>>>     if (qemu_loglevel_maks(CPU_LOG_EXEC)) {
> 
> CPU_LOG_EXEC already has a specific structure, listing the TranslationBlocks that are executed.  It shouldn't be hijacked for something else.
> 
> If you really want a runtime flag for this, we should add a new CPU_LOG_* flag.
> 
> 
> r~
> 


