Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C5C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8456220675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8456220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGqN-00018J-MD
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBGpd-0008ON-GW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBGpc-00054e-96
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:44:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37193)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBGpc-00054Q-0Q; Mon, 09 Mar 2020 07:44:24 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLhwM-1itjyk1Sim-00HfzE; Mon, 09 Mar 2020 12:44:18 +0100
Subject: Re: [PATCH 0/3] hw/net,virtfs-proxy-helper: Reduce .data footprint
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305010446.17029-1-philmd@redhat.com>
 <92a0e3c4-2d50-49a6-f794-c5df57e1b3fc@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3613c1f0-eda8-0385-4e38-a90c69777a57@vivier.eu>
Date: Mon, 9 Mar 2020 12:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <92a0e3c4-2d50-49a6-f794-c5df57e1b3fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LS6KDhhXc/vQ7XHTjveDL1AOYOmdaJbiLJvO23CwysCdn2TdRJx
 w+JKpTjzV/wsrcfUcP/LCRmfOfG2Kppsc17XIXGVJxZcFyvjGPcmUAlRRFx06+O32Qwcuq9
 C2g00UXpj7y5W/tZrHeyiVTDpyGOD+5lsp4+GMXWrJCLLY2G90PnUS9h3WSwGFQzmgWxynU
 KKS6nh3jb1XKLuXdWqIjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84EivtRHnHI=:RVe5C8cmuoo5Y5QW2WjJLP
 eJqwKoNm/lM4s7Yfc7GfHns7xHNO6knekftLz6xVV9IdJyyN+GucB6o62lbMF+Je9GVQGj91+
 IRCZnRk4byFsTRkYczBW9nW8oW0iY352UwoGziOiqdVATAKY5RZCkOH9vKITHu0BkovpmYLRT
 ZHh+gAu2X3xbozLwbY34Jk8Krw1Q4HWfYibi9jLbsW/Mt+AUiiaFDbdBiFv22nSC6cLYQtBe1
 PfxLAGT3SUkP6U0785x6cYrSbVgdjG+sEEKY/02rih3Q7tvFPnRN2eRUOn2Q1Vx1o5yuvc8bo
 jmEyzGFEHQQnHQVqlV4CM21tv2s1OET8Hn468/48yx4/7KnZPu5Lu03aOA+EJpWe6v5TpTCpw
 FIgZR/ADVzr1wfog0LqlVuMPQ00EKRqKJUxXIlISz/etMnbskQcQeE180JFL3dlOln35h+jMz
 eW7G84AzTz/pbmNE1YwqbSQyzX6CQDTicl7aLB7TIB5jOaJlAns0iXXPN1WYRW7/rEbYosz5w
 iqSNmOxrqcnGN60W81h9dEb6EUUPpzWQCWDhKD/xeAEUa2gbIMZEeyvBz5vF/zU3LXCtQSF75
 4QyHhbuo8ESHuff59itGUJuuSYRM6ESFF3yRV7tbDtEWWLZ+vswGQEHOvNs/p6NdtQ8HWpkLK
 Y+Tt46JBPjK/XpubQN0JRDLa3bx/kAEJITsD8ugB9/CVbdKb0ZaNDJIoc/79DLTxarUaimcEq
 HYpWbqCrmMtes8ZHsHmgVeVWTjy6m1pEgtnxnTrRnDzNWRd8+u6CdkLFV91Zk7I9fz2hv3l2W
 E4YrSaOTN9Gaq8NGmwaqpaYC0zAY9RSPfynzLpmNldDxLaSoTZghxW77DskTiTkbMjxeH6A
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/03/2020 à 10:25, Paolo Bonzini a écrit :
> On 05/03/20 02:04, Philippe Mathieu-Daudé wrote:
>> More memory footprint reduction, similar to:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00984.html
>>
>> The elf-dissector tool [1] [2] helped to notice the big array.
>>
>> [1] https://phabricator.kde.org/source/elf-dissector/
>> [2] https://www.volkerkrause.eu/2019/06/22/elf-dissector-aarch64-support.html
>>
>> Philippe Mathieu-Daudé (3):
>>   hw/net/e1000: Add readops/writeops typedefs
>>   hw/net/e1000: Move macreg[] arrays to .rodata to save 1MiB of .data
>>   virtfs-proxy-helper: Make the helper_opts[] array const
>>
>>  fsdev/virtfs-proxy-helper.c | 2 +-
>>  hw/net/e1000.c              | 6 ++++--
>>  hw/net/e1000e_core.c        | 6 ++++--
>>  3 files changed, 9 insertions(+), 5 deletions(-)
>>
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> These can certainly go through qemu-trivial.

Applied to my trivial-patches branch.

Thanks,
Laurent

