Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA9C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD28206F7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD28206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMc2J-0006cA-RH
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jMc1h-0006Br-Ly
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jMc1g-00031m-J3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:35:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jMc1g-00030k-Ad
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:35:44 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1My3Ad-1j5Msj2KAp-00zXrn for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020
 20:35:42 +0200
Subject: Re: [PATCH-for-5.0] target/m68k/helper: Fix m68k_fpu_gdb_get_reg()
 use of GByteArray
To: qemu-devel@nongnu.org
References: <20200409172509.4078-1-philmd@redhat.com>
 <20200409182215.GA40299@xz-x1>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3096f665-13eb-b8e3-3fe3-fe832638f09e@vivier.eu>
Date: Thu, 9 Apr 2020 20:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409182215.GA40299@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AqyFkdnseVdkRBm2nA4DpkqDo8gJ2mIAcehrD/Ikcnh21IS3v9o
 YTFcP6gfpK4dUxr/ngA7MgOs8HmrAnomMlS3Q0QK/ZluoQY+FO5NWJ5Z0UGcjGWDxIIKBR1
 UYCRdniGMKXSrSoJvzgWLEtlSPrGmzWBAMZ6s4qYa7IwW5afVBRIW/0ZOIuTDyDBvHmw4cq
 nCSpmcs760Em5GJUNCKsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fgu/scRVX5c=:w6Jc3gTARybqkuNDG5LQhb
 9B2gtyKyk3NXb14rd2KsFv9cVvOoiQNy2+JNWAWPYmku+h9u0XCWf4q3i0iYtgz/6O7dJd5xd
 oOLJSDS8jdFxGduTJpTbxYHZcJb1Z6Qw83qUFu8TNJvSNn5oa4xQsWvnOLng+fhvtDPksdSah
 3JhATYndouMtJh8HzuVdW1/0Vc6hV1/tHR+hhdL9D1nYhezg2xHJYJPHiJM0KpJHePTZc4tOq
 JpjVPPXNSYK0znDgOnxVgEwj4r5BtpKdR5XqCbjPEHLRuslJ3srtb/ElZFkYyEj2TgWukHuey
 qjS1mIqbfxInERCOiQ6b4xI41uHfSAjL0+BgA72n4jsxbw1JRFnhMqswRcpTPinraHtF3ggvp
 vCUDFs5h++XpEeDZQZV6vjpKd8S2Pno+iISIR6KnoKMmr958XsFVlE1X0kp+/YAyKdm3LwV8/
 /Io2m0X/H9rFaxGnR26xlNZBo2YMF3E2Ag6A2D/2rEdnJ3inBBM5INorLCyWiKHUWJQjRz7vr
 NljX0M1aKuwagxacGnQRFrZyVM5U7YiuY84SV+qFcqF3UIrI+h+qvcB+eqOk0gmNAOz670LgX
 6CND8J+1wtkGbpWmlKUpJZ9mqL5hXuFmUcYt73+AgXJgKkTTvTSO36wg7XcoLE8pSeH1deK8t
 al7ovssVoO+MyXkqWlMMs3pT9TV/49AhjdD1jfPDZL2AaiECcQQw6tLj+IfjAOumNlEdPtjo7
 oAiKj953XRULQP+Fh8KScm9CiOBjyeK9WUIsLokkCt0Vmt497FxRfolOCl6t1nztBftQunJmO
 JjggG0HzNCkj203Hh2yBWJd/8pUCYeJeUwfnI5/DZWiNYOaSLjsUMW/1aaLgnh17nHZ0ddG
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

Le 09/04/2020 à 20:22, Peter Xu a écrit :
> On Thu, Apr 09, 2020 at 07:25:08PM +0200, Philippe Mathieu-Daudé wrote:
>> Since a010bdbe719 the gdbstub API takes a GByteArray*.
>> Unfortunately we forgot to update the gdb_get_reg*()
>> calls.  Do it now.
>>
>> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> 
> Should this be instead 462474d760 ("target/m68k: use gdb_get_reg
> helpers", 2020-03-17)?

No, this one is correct because it uses an "uint8_t *", then a010bdbe719
changed this to a GByteArray and didn't remove the "+ len".

Thanks,
Laurent

> 
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
>> ---
>> Based-on: <20200409164954.36902-1-peterx@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> (One benigh extra line; same thing could happen to me when amending
>  like this with "---")
> 
>> ---
>>  target/m68k/helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>> index 014657c637..cad4083895 100644
>> --- a/target/m68k/helper.c
>> +++ b/target/m68k/helper.c
>> @@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
>>  {
>>      if (n < 8) {
>>          int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
>> -        len += gdb_get_reg16(mem_buf + len, 0);
>> -        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
>> +        len += gdb_get_reg16(mem_buf, 0);
>> +        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
>>          return len;
>>      }
>>      switch (n) {
>> -- 
>> 2.21.1
>>
> 


