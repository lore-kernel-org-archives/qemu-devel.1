Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400A2227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400A2227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYpM-0007xL-03
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYVM-0004MO-KG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYVL-0001PV-AL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:32:40 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54561)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYVI-00017z-Of; Wed, 18 Dec 2019 07:32:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHoAg-1iUvMj39k6-00Er3I; Wed, 18 Dec 2019 13:27:15 +0100
Subject: Re: [PATCH] qemu-doc: Remove the unused "Guest Agent" node
To: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, 
 qemu-devel@nongnu.org
References: <20191216132941.25729-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <44bc97df-b537-aa3b-6f00-a6321f20d269@vivier.eu>
Date: Wed, 18 Dec 2019 13:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216132941.25729-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uq/VyW+0ZQJCarIRuaURlbZ/IlSn6qiRNkIjo/uTdwehapIX3u/
 SMPD9fVdFHI12BaknUNK/AmaZi8cS8ieSmwIg+RvSNlGo48e6EYBUSDdGIBEazINmTFPx+m
 F1RLLa6AQy7jLtqUYPByAIUFR8J+pNlFR/E5Ch5azdgf1218fJGBEOhlNDVGMACerVyULtM
 FHVtj/C+XHfkMnN1XqEQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Ip9NGEkN7Q=:rocoePu0Umr8XyaORXp5PX
 G70M4XFkJ1MU+4CD5Fldq+dMpTMjz/nopAtgccr6kI1eRk5FUz21jk5QCmVlNnjXlu31+/rjC
 0tbLpyS57ZNF74N4IwFqX5Wn2tkgNgVt9qjniX0pEE6gMlepxRcqdphGouMnEJaeqHkaX0WJ8
 m+e2uYfCDz8HTMppVSmOhRLckwXPZ8NOuRtlhEBm2iwPF/ODkfHonVThT506vLMESpVV/AMDL
 8u8t9JQrA+MR/OoYK+kZBqlk/CbUBgAAkl5SIq49Ap/OYx/TAXBYugmswCLGCjMvmuO5HmH/g
 GmmSNUfW1v3stZT7npAlsLgRPfLfbV1VR3uOH6Hppim4X/ZQMlcYwSEFS+YzJOZEBIYmstiwR
 8LlbQX+FJhECkLeGLTVHKUWAVbuT8CpRovx7BI8cdgUrw73FacvMX9ZnrRAMx0PAAaFpohmLF
 3IT6U03gADCEONz8iiYNTuOB9NmD1oZalaI96Tc7AdxqxvWYJzvRB//U7lCShx8rzivEI5NJc
 VbEiewwxPUIATSDu1Xg4ynhtjxDBuWWwsfK6JDJgnsewdmwJ2DHpFWSQHk3g/UxViEG90wm26
 /RYelir6D5tdHwE86BQXWE7Gq8lR+8ZIerdltqOxD8yzsZqGxivWiSYUdsUzrXEWXQlhghHbS
 peAbPxWybYd75TWA0jlIW/ijP6+EqF1fOU4msMii6C+bxZXbttWJy2vOivazrscjGXWhWwwCx
 MowEqA3VYbKFfnAyLdeG/sJ6jQ8UHRVxPBJtp0P376SVgB9Jo12IANgHX9wYT6tRWCUtlbk3i
 97girPbOAtIJuWmIcAgW4bJdPvfmmnReohGXYv8LHgvnnotaXpURiTCSuAyKV/UiUAfQFItuP
 tOGn6JS0qc+Tb6Y1xZpA==
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/12/2019 à 14:29, Thomas Huth a écrit :
> The node has been removed from the texi file some months ago, so we
> should remove it from the menu section, too.
> 
> Fixes: 27a296fce982 ("qemu-ga: Convert invocation documentation to rST")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3ddf5c0a68..4b62b23264 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -38,7 +38,6 @@
>  * Introduction::
>  * QEMU PC System emulator::
>  * QEMU System emulator for non PC targets::
> -* QEMU Guest Agent::
>  * QEMU User space emulator::
>  * System requirements::
>  * Security::
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

