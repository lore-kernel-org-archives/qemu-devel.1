Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C472DC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A1A20578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A1A20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmc5-0006Ko-Ma
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHmb5-0005Vn-8v
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHmb4-0001nG-82
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:52:19 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHmb3-0001kA-6y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:52:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQ5nK-1ivhKq34Do-00M16Z; Fri, 27 Mar 2020 11:51:44 +0100
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
To: Richard Henderson <richard.henderson@linaro.org>,
 Roger Pau Monne <roger.pau@citrix.com>, qemu-devel@nongnu.org
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ec0e5b6-9ee5-f26e-8f2c-1c1812d6fc07@vivier.eu>
Date: Fri, 27 Mar 2020 11:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hrEg4IIKz6MHIrPQiDTy/8C4OuEWEKtOFdh+dr4WjYYTln/IYks
 0qFfWsa2l7Mf6w+6s+7iD8nwdtmdNPznuV7+iEB4rY1XNUdorFV64OrP4ONpZGiy7PTRe0p
 sStSctR8FKglva/ecqKSsG4Hgv+7QIwb5bjV2zW1CcYDhIj+zW264XKpoDxYDaGcxomhn1P
 29zTD/Uv2H/bjzHuksxZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tce6fi1UBvQ=:j4rYZ2sHHVX3ioayoUCCrm
 K1lf6nTTSYzqNgyzDEhJPIh5KiDWvFdmmo3IoEr7/5ytkH2Bm156p3XM42nsQ978e3Etw7NMX
 AMFzlLvMwRtHeeYh2SXDXx6WBtrBnZjX37yTP3v872nFxm6CozlKAJKU1RcalK4pdWnDYzoRX
 KO4HiZLlJNDW7hWAbgeovJN4wTQgwEfK118WSEMG7fzuLcSZfeh6H01tk5Pezk7MiPivlZYtR
 nr5oDFcDQ2VXz/diZcUP6q2ioSRd7f0BzJ0/jFB8P1gdVpn6cH9KXwBJzoAr1MbsaPTEvInci
 65vweLgjFOi7LEAalXhqo1S0VIAHlQXxbv81/AgOG1QinG+CR+LBm4e93RsYxg2N05gL2LXmV
 epAr9IX+xDec6gSp4b066HqZ2qwJOniGC5FUL3MDqpToqlouIpFcs9N0bI/ujDztS9k/THLiq
 vFaksBgI4WdhhQtARo7wAkZVXtW/03+bJVLf8IYnbAgzc7CceCkerQLVo30y/jbMIJslYc8LY
 WRX1P+bpptjV46lgglQEZJJGNadqmnP+4qKYD+Vq5rBWizElcpM6WI12cWPEIQiZYRSwcw4TQ
 nvE67Fc0XlPTSViGcaPWDSJq2X9s6kL/6QWt4BtJ5J3Zcv9st9NgjIKUBYjL3XNsZhJYXNM4u
 8TVWaDCPysmkDNgw+Oz9pHMmfalKnqh6k4B2z9ryR8HYxQgw0RQu0YnMCZmM2EP+BJeJ3uFO1
 EM86t9rGyaiA4YKI6Y/JjJ5y3wP3UtxJT6nakFIZQPt5mNsn7g1xRXy0ppUs2MTFgux3+zCvH
 snWEbozbEOxYME/ut5zPlzGTYz8T9hsQzTX1kdiHK6M0kV8YE58Y2U00KIZ7e19y1qW3ERw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/03/2020 à 17:56, Richard Henderson a écrit :
> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
>> lld 10.0.0 introduced a new linker option --image-base equivalent to
>> the GNU -Ttext-segment one, hence use it when available.
>>
>> This fixes the build of QEMU on systems using lld 10 or greater.
>>
>> Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>> ---
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> ---
> 
> The Plan is still to drop this whole section of code.
> 
> However, it's still blocked on getting the x86_64 vsyscall patches upstream.

Richard,

will you propose another fix to fix build with LLVM lld 10?

Thanks,
Laurent

