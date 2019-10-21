Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC94CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E262F205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E262F205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaXu-00064b-Tq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMaV9-00042R-3i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMaV7-0000jk-Ux
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:25:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMaV5-0000iw-Ds; Mon, 21 Oct 2019 12:25:43 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M89P1-1iRFT80NiF-005G7H; Mon, 21 Oct 2019 18:25:37 +0200
Subject: Re: [PATCH] MAINTAINERS: Replace tab indent by spaces in the Status
 description
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191012071307.14314-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d4d3adeb-948a-fe20-996f-1f642f9e986d@vivier.eu>
Date: Mon, 21 Oct 2019 18:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191012071307.14314-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vWkTooxcQIUEne/u/SA1GKtIXaNBSztNf41rKMlgPENgcS5ZtW9
 j53PnYcQ/TfAy1TC4EAMYlVOd/XH5JyO1y04JuaAKha95pQAeQC5+IG0JvLY8LHIqD/86qz
 S3y2G7wbWx+a6B2lu/P9PY/I1ycdYZ2RskNZgWe394E4PsGUcUVp8H9vYcPUAwFrLApdoCX
 /rlw65JONsYNSEZehshhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ySvg9qTV+4g=:SjvhdtKfWdR0LGDdfM/97l
 WqH4x3uj+3vDbM4UAs4kt7nMuSH4I4B6M5LtIPNpWjPXIUEcDOlYt1U31WU9KofFZ6X+Ki6mH
 BorC1ZawOy+kDeDjxpA6GumDPbw8SszDStNAcuyDk5PO/2o8GGl3NkHodpHo6+0CKYHsyRW7t
 Omdl+N86v5Levra3WVwYLVInBEYzf2qviTR6YyTw8U1NkNHBSDvFUvg8BCfsPtajgPgukFHb/
 OS/f2tHB/E/+zRhJYQ/Zj5XrB6INUb52+A8wo3+JKBUwQyoXktBSXJvt2LQhKLn3cQiVmSEQa
 xhglN+c9nycG6G6/1SnC/bnEJCo6EX7X9cWneNT3P7hLigEwtQ4gP4m0W69EVS1cW8RystV3s
 UkxC/zAsd/Mpu8d7TcAaRvZwmeYTfwHbKAM3LURoHIl3Pa+mmfS++IJlcQ03U3vaNR/7Js6XI
 TCucr9nzEIDBz9H4PGCeCx3W8Q1eR9rs6S5rOW4xbhjfpJQQHeXNTI4tH0oRg9cNCJHN4N8Af
 UgmJA9mVGd9u9PCcsmQLLNsHKKISK5vGDCl6i9wIg9kaIvQhm3aD/Y2VLHofw+bxFEydrG0xB
 62AY/LiCIGB1m6Bo2VWA3CSRA0gVJYosaDsQh2CdYhGvFJTql7weeY7QRBFTFkfulsS0e9/F9
 1zvHYu3HE98o8EJ3Y0RmiuC1ZI5tJYoGQMEHSCD+nsr9OilO4bdE6pUjx3OYZoECqvFTiQy/n
 eK5M+Ap9dspFLbhkx9g4vOiu+6LyFZuWybrlNM5u4A3dJXDQRY+L4QaDEAOhCWH6MWGSIHCPq
 lpyceXDvE82eJvqCQpTlO1kqsQSIaWYHCf3f+BIDuZlV5MlhM65uR/N+cleZCWYEDFiede3vC
 2QVxUIR3IWpuvtTjBWtFnLK2yagaZN+LjA3Mgsims=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/10/2019 à 09:13, Philippe Mathieu-Daudé a écrit :
> The Status description has a mix of tabs and spaces and displays
> unaligned. Unify using spaces.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca814850e..b9093e4dac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24,15 +24,15 @@ Descriptions of section entries:
>  	Q: Patchwork web based patch tracking system site
>  	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.
>  	S: Status, one of the following:
> -	   Supported:	Someone is actually paid to look after this.
> -	   Maintained:	Someone actually looks after it.
> -	   Odd Fixes:	It has a maintainer but they don't have time to do
> -			much other than throw the odd patch in. See below.
> -	   Orphan:	No current maintainer [but maybe you could take the
> -			role as you write your new code].
> -	   Obsolete:	Old code. Something tagged obsolete generally means
> -			it has been replaced by a better system and you
> -			should be using that.
> +          Supported:   Someone is actually paid to look after this.
> +          Maintained:  Someone actually looks after it.
> +          Odd Fixes:   It has a maintainer but they don't have time to do
> +                       much other than throw the odd patch in. See below.
> +          Orphan:      No current maintainer [but maybe you could take the
> +                       role as you write your new code].
> +          Obsolete:    Old code. Something tagged obsolete generally means
> +                       it has been replaced by a better system and you
> +                       should be using that.
>  	F: Files and directories with wildcard patterns.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
> 

Why don't you remove all the tabs (line 14 to line 55)?

And "vi" can help you:

:set expandtab
:retab

Thanks,
Laurent

