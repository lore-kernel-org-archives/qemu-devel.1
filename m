Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F887C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1405F2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1405F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqF1-0007cO-6Q
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iXqEG-00078u-Cd
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iXqEF-0001pf-7E
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:26:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iXqEE-0001oh-UZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:26:51 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7JvQ-1iUYRC0v9A-007kzP; Thu, 21 Nov 2019 18:26:42 +0100
Subject: Re: [PATCH v2] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20191120145555.GA15154@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bc8c7e0d-861d-87c3-d63d-4bcf82d4cdb2@vivier.eu>
Date: Thu, 21 Nov 2019 18:26:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120145555.GA15154@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ToHpZiAFW3LJ/r/QBQfNhwBttXs3eURPX3KQgMX5EUkNmSgSx/z
 Qe2gCGjkJnD++GyTPxvbDC8vkKK+MG5q2hcj4Ibco/tmiGL80iIYQSHexxe+izOAhZVbJHb
 Qvqsr8fIx1sCcVEqhm/Ny5vQbmH20sz9xeVWqkL95iPjuUv8ovEopL0Hv7SRUaRxyFSWxBe
 xQd9lu3FdYThkXY4u+Lkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NS2xSLnNudU=:EGqEb6+wEHTjvfQzwaPOfV
 dBF9bjqT2jKbDX90oceQL6EmOI3yCSbDeZx5EuoEdxKv3VVZSAjgZyDZOWSmvoeDbFuUqYpEb
 VvajjzOrSF/dI3NtgGWNg2ygUn5lvZ5F3jrsHhOPGv2ytmQdVKJ51UgDmN7q6KH6lt0OCmNbf
 gE42EqxBmIH+AxwMpOrcxdiU+JQnX4nAWuXFPcn+UaYDZvzn7ZuEvhKeqPpNaelCaHw+9/n1G
 P7JqgTdRSi8x/YjttbcHNVloHy3+YQt6jZoUCMS3ybI2jSRz87y5G903iZus3gymS3Kp3MZjw
 MaP+mC3iDYznWLoGDnaEwvBZ2RyIDH9dEj27Nom5gu1XcrVDbqbsW0r2lS/5B97QLRkueMJsk
 5UlgrTnRLkuCFtPDm/JUMr6zninVESLCohhAhRwm0M1sE3vPwlWF4TUhHlGevJPY3g2vsY6NV
 Tm3ApnO6wYk0u0mpNsYTrKjdtFGLK64sJ2R9nIk3LlT3CNGegvfUl7jHbeTQ+8DuyObplVBgw
 XGuspGJexdLP1p4u5gb8+Eq7TXOQgVNAuMQdVbQK1s8I7sgz0XEw1xtX0VV97zLzLPCNoemiX
 76WIKHMNLEbiHtlQIdrAXvy17oQwNQc2nX7+a7wGnVri25sPYx0zSSJMe9lB9RzwtE0AWQBK/
 6xgoLRnRUxXyYuWQQzZXqSnRV45f66RsCd4TIwNHeiJXYIVgCmhIos22YsVbxe+9YRa4F3qad
 U5mHMq/dx5LGOm2JENo1VVT0S/NhpdqxzDODFAQjwLwLDee09QCtBqXOZj8imugsHFiyGER8G
 4h2LWtCHDCB/cNddS7RDzoB+nAHKhsVOUBmRkus1aTgrNVjdnfZbsAcgBknLKTvgYYGJeLT9m
 0b9xENvQ7AiHEITsE5z5p5utFGBrAoIKxAgsjmhWg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/11/2019 à 15:55, Helge Deller a écrit :
> Add the textual representations of some missing target signals.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3d4d684450..de43238fa4 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
>      case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
>      case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
>      case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
> +    case TARGET_SIGIO: signal_name = "SIGIO"; break;
> +    case TARGET_SIGBUS: signal_name = "SIGBUS"; break;
> +    case TARGET_SIGPWR: signal_name = "SIGPWR"; break;
> +    case TARGET_SIGURG: signal_name = "SIGURG"; break;
> +    case TARGET_SIGSYS: signal_name = "SIGSYS"; break;
> +    case TARGET_SIGTRAP: signal_name = "SIGTRAP"; break;
> +    case TARGET_SIGXCPU: signal_name = "SIGXCPU"; break;
> +    case TARGET_SIGPROF: signal_name = "SIGPROF"; break;
> +    case TARGET_SIGTSTP: signal_name = "SIGTSTP"; break;
> +    case TARGET_SIGXFSZ: signal_name = "SIGXFSZ"; break;
> +    case TARGET_SIGWINCH: signal_name = "SIGWINCH"; break;
> +    case TARGET_SIGVTALRM: signal_name = "SIGVTALRM"; break;
> +    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;
>      }
>      if (signal_name == NULL) {
>          print_raw_param("%ld", arg, last);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

