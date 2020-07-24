Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DDC20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DDC20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyy93-0003Wg-FY
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyy8J-0002UJ-S1
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:53:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyy8I-0005I2-1m
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:53:07 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MlwBh-1kgW0k0zuV-00ixlY; Fri, 24 Jul 2020 15:53:01 +0200
Subject: Re: [PATCH] linux-user: Use getcwd syscall directly
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmmu3qplvi.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9249265a-1538-1819-bfa7-e7f523bffcfd@vivier.eu>
Date: Fri, 24 Jul 2020 15:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mvmmu3qplvi.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h8ybjNGapAokfz+pV3SI5JsadHCYy5NCJSk1UXlxaEbKjTEENXj
 MCNfWVxBAIT1DPXz3w6VQYeQ3bD51bO1dpOb5mGRyHiGiq/jZHidJi0UpV4XjmiugoKqzQC
 EH980mDAShzbguXMJkwi2RUty3rRlgK2mF4MFTrH7Y3V5FL0Afpv8Z4ni/Uqd7fzt194cf1
 0BrSpufltdEgbdksY6oIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ChUTyBymvo=:L3GzEWeC2qZN7Cwe4NphFz
 7n8aN9mrOo+bNQHaPykKqKmW+bUjwWiEJuN+7aMBDNUD1SLZOT8M5nkHyk39BPvsfDf2SoZ8X
 DMFQAyfxvuxLQxKATZNVW9a1Gjux998pT2YbYefCnRRPLu7fNVzJjWEm+MiMzGWDFIYUYAOWr
 frgzyQJhxVa+h7Ttz7X//ufpKqpp45FjVLL5upiRucGD5UiBHstizN5eQIqd7X3LNCNak26dQ
 PLpWjBpAASyJ/BmNnAsfUmVVlgbSMzwCGgndIf981aF4EyygiofT9UeywJEiSOwfPWa88pwP+
 cD29yhmHFMIjAkgaWccEZ7bYdKe4nzeRLPi5z9n1oxr1tHIkfb2t/n2C1hHFLQgwKMNSr5JpM
 i1Ykt9DV7AWfIkDIRVLR8AaIy7O8vO1vPjQU9N64J3APqDq3OeNwUa3ByNob2R55hRZFkoFRU
 2by2Ny4tMI9exQzm0ZvZdAZGjnIhgvk9CfAEmc8Ja7dCfmF5CiAQjIASV5UOYkBsEGenEtFR+
 HHF3+Vk64USkKmNPn28hd3H7h2frp0qgsw2uNXGE18MSoKQeOUIOAmbmZp7UELq48Uvv8/TYl
 wzn35MJNVDVDCZfK2/cF1yXWiR2JjHyrEd+s8768AfiND/ARuxUJesyC7XOJTJBiJZ4ovo95D
 O9aS570OLqJKtBtW9e3VdumZzbQ9ShFb6nNY3FxsumqU8E9izLCQwUDXuwQQtBzmqsWie/C4y
 Zqr5YOkMN1eZTwiKncQgQgO+IoLeurpJ2mhfwlHVd9mk/B19q79KwMqQ8B32/yRW26BOwwolX
 9SxzSMSmyi3TnRas8bXCITxRC1Dy0xh6ptitKNriSWIM3yqEsYv5he/Sy1nz7npsfNb5qah
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 09:53:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/07/2020 à 12:27, Andreas Schwab a écrit :
> The glibc getcwd function returns different errors than the getcwd
> syscall, which triggers an assertion failure in the glibc getcwd function
> when running under the emulation.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b9144b18fc..e4e46867e8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -388,14 +388,7 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
>    { 0, 0, 0, 0 }
>  };
>  
> -static int sys_getcwd1(char *buf, size_t size)
> -{
> -  if (getcwd(buf, size) == NULL) {
> -      /* getcwd() sets errno */
> -      return (-1);
> -  }
> -  return strlen(buf)+1;
> -}
> +_syscall2(int, sys_getcwd1, char *, buf, size_t, size)
>  
>  #ifdef TARGET_NR_utimensat
>  #if defined(__NR_utimensat)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I'll add in the commit message the explanation you did on your previous
attempt:

"When the syscall returns ENAMETOOLONG,
the glibc wrapper uses a fallback implementation that potentially
handles an unlimited path length, and returns with ERANGE if the
provided buffer is too small.  The qemu emulation cannot distinguish the
two cases, and thus always returns ERANGE.  This is unexpected by the
glibc wrapper."

Thanks,
Laurent

