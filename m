Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536D721BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D721BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaMp-0006mo-QH
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMaLG-00067X-Sx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMaLF-00070a-Kx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:15:34 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMaLF-00070R-Bk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:15:33 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTRIi-1iS2wb12h2-00TnIv; Mon, 21 Oct 2019 18:15:17 +0200
Subject: Re: [PATCH v4 2/3] tests/migration: fix a typo in comment
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
 <1d0aa8142a10edf735dac0a3330c46e98b06e8eb.1570208781.git.maozhongyi@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5d32f229-ddd3-41b7-9fd4-08b4c29dd0a1@vivier.eu>
Date: Mon, 21 Oct 2019 18:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1d0aa8142a10edf735dac0a3330c46e98b06e8eb.1570208781.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cW9CftwDVeR/16u0aa/Y7KS7zbP7nzr8kezqZa2isaYWO4K7nes
 Rs4O6aomT0fuJuUFWmjXCoEf1fcYYDoxywIGhfohnlnvmZzu0W6BKZ5C3TN0HCRocB2jQyR
 bDaQHASP0nsI/T+nPqlvv0wXvZYqg2jbN/iZFC1+d3VbkPtVonJ5bBMD2KNkwE4LZkM/age
 WkoETWaW+FTjL38RMMG4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9lqq/uj2Oyw=:vqPpHeq6vLi2CvXayeaD/8
 GEdHA+lN/QY1ietz8Nbxsv/zmGTprlwdva2J5TrvqJT78hqkdgIyWgQ/RWRFq9fmlgieojuP5
 RUzXWQ2kuzvyI3M4mYCbRZ27j+RlF6e6HTgW5kA9ipz6WYbkBNk/GXLvQcP+bagQkqjQhCS8Y
 sbJ29TYpQUg7g+Rtj5GM3a5mcumgt7aBAVBstQVFVmnk961+xP3Qp1YYu3It3sO+UyEXQjocN
 iQH7fhwTRF7oqMc2cNbqtdUgxkUu146BGnlTb6XvmFKvsKS4ynZdtNkyR2B77odP4FngDM7Eh
 FUCKVr7xZD0jdqacUEAG+jIe+ppDyDRZ9qvAAPOMI0jH4HRO3c7nR1i5LtAlm0HRJA//74c1w
 aa1AC19e9qx2OxKddd6VAn92Dwss1mv9o0zMq+k1b/gHvE94Whm2HUXoHdn4oZ1UpLwlxpogU
 zzZHhysv4x7TvFEg3SWRDfNI+3IrSeTKJbbdINUsix4DrwVxZQmJ9aM0EXXRnhgqYipPPeZ2X
 YcZwocF8AGImiQWtQOJvYweW3mfZkqR16za6utLUXuA6Rf1vuA1nZvbZz/VqGM0I2WnekXw0U
 1uw3tPJNwXeXnLkM5vVDmuCx448DEGmprRABTW49UyL1UjmH9j5hHFMips7KAsK0btCGS2ZtG
 maDRyGlx9sbYqUGo9FeCT+vKbT2kf1PRU/2YXMbilBDXfsMAhvDS1F3sQiW10IMZ/RiYDibli
 Rig3Tr18U4zAZUb8nsuvCpkj1jnfqlVl7Yift1LxAXumXTv3h+kHipenaGGrMvE3fX22bM9Oh
 1FKpb1k/Ok/atVMUm2lENsOPyUT8dgrWBjSbmJIEBdVHKqApa8ikPpJW0g6DJu2kNJ/y9n0TZ
 E1YPkNhQrVcP3V4XD6ySNh6oGay8RyUudCoU++J+c=
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/10/2019 à 19:32, Mao Zhongyi a écrit :
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/migration/stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index d8a6f64af0..f9626d50ee 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -180,7 +180,7 @@ static int stressone(unsigned long long ramsizeMB)
>  
>      /* We don't care about initial state, but we do want
>       * to fault it all into RAM, otherwise the first iter
> -     * of the loop below will be quite slow. We cna't use
> +     * of the loop below will be quite slow. We can't use
>       * 0x0 as the byte as gcc optimizes that away into a
>       * calloc instead :-) */
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

