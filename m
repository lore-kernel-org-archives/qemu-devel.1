Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DBCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0927020658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeCN-0006qe-8a
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ize71-0002Lh-Gr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ize6y-0008QK-NH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:10:19 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57641)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ize6y-0008HB-EH; Thu, 06 Feb 2020 05:10:16 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGhds-1ilsTi3iVO-00DrSU; Thu, 06 Feb 2020 11:10:09 +0100
Subject: Re: [PATCH] qemu-img: Place the '-i aio' option in alphabetical order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200205163008.204493-1-jusual@redhat.com>
 <d97e763f-b987-06b7-a7e3-d243b6790f31@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3928f965-13a5-801d-826d-fa286991868e@vivier.eu>
Date: Thu, 6 Feb 2020 11:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d97e763f-b987-06b7-a7e3-d243b6790f31@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gGwJdq3vIQnfv+yEL2j8zwgoDZ2CWDCjxQulhWsXg98vp1tWorY
 nkZVjHUUrtsEVMMmfd+0SFWUAQN1+vhrbZ8BQbHMDArM0TxSxCMW14+ro3Ke9IP6u152xJU
 oQuQ4ZPMZHNk72WUymlMgO1Ut4e3vjyc7pS8uagPiTBUuvCQWgCDHKr60dbhSFXIfUYxCs/
 sRQ17dhNzBeD1G/9T3qhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G8F09bRYvC4=:pPBye3pLm8oM4+R5vj/pKK
 snXB67R0jrNb9Th+ncj1EzXbm36R7A7prIGVVDNuwkpsw80Y8hHtaIfDoWIKfh/rIwU34TxFz
 49SIX/zHHPEPWoHGWEa6KIcoalVT2v9D4wENTvWKc13w30m+dbEj1FRSLR6+sk3nGlNI+QRit
 0NVjL/Srs3v4+HKYlSb6WkMpzrDqC6af1qMmBB9+niWX4TP686dJ/4tC3k80JsJrRyB5es/v7
 f7pY5Qvj7VNL6ltoNlVsIfvfzvSAYJYqb69syfK0W5CpDtvMxQjXEI8pNa+W3LPWi5b5G+JOY
 X4MuCcdO4O+/tMq6TGn8IWglqjgEwhotHw5e9cMlONgejp5pW7J318OyvRRafY9t931jBUQBu
 W5HCowK+K+GfaGlYyQrvDvZQ0NkIPPHfzDNJvrASpaPwv31ho9mLUDAZkHR+WcLiyWURJbPCq
 PmPl4eUQ6HZzYFKkOVWcd5p+5U/thhIzyxpMUJzv7qBYI8A7jkFQH+WmN+H4VWYwpxHL/fI/d
 TI5ClsrHp96rXvKKb5ZykCrDatVd1uEhN8tZ0N7+Hd1ZHwNWxir998EahcaQrxUSRpxCCXNf0
 p9i9/Ndn0lH7d1yenWL9cX3j3cp1MMYuo7g59VKShJP8mY4A+3zBR6+wneU9i2TW7I3om2bgD
 txu6u1tomcecn7njDVI/XlN3xrYxzuj1hWY2MX9bBRbO/xNA/Nup1svdWQozijzFEdkVwkkTp
 5mQJRkog+HvmCzRiBGaS6DLDzwV3kaiL4nfYPVhhpjSNQlGC99Ca6oBDF2OtJN9bjjt4QXMBi
 OA95kWu0kplzd/coW7zNMA052X3RzCm0Dmfek6+qUKTKpeZz7Ak9m8Gm5RPCdayy5m40rZ5
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 05/02/2020 à 18:17, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial@
> 
> On 2/5/20 5:30 PM, Julia Suvorova wrote:
>> The '-i AIO' option was accidentally placed after '-n' and '-t'. Move it
>> after '--flush-interval'.
>>
>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>> ---
>>   docs/interop/qemu-img.rst | 8 ++++----
>>   qemu-img-cmds.hx          | 4 ++--
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
>> index fa27e5c7b4..42e4451db4 100644
>> --- a/docs/interop/qemu-img.rst
>> +++ b/docs/interop/qemu-img.rst
>> @@ -247,7 +247,7 @@ Command description:
>>     Amends the image format specific *OPTIONS* for the image file
>>     *FILENAME*. Not all file formats support this operation.
>>   -.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
>> [--flush-interval=FLUSH_INTERVAL] [-n] [-i AIO] [--no-drain] [-o
>> OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t
>> CACHE] [-w] [-U] FILENAME
>> +.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
>> [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o
>> OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t
>> CACHE] [-w] [-U] FILENAME
>>       Run a simple sequential I/O benchmark on the specified image. If
>> ``-w`` is
>>     specified, a write test is performed, otherwise a read test is
>> performed.
>> @@ -264,13 +264,13 @@ Command description:
>>     ``--no-drain`` is specified, a flush is issued without draining
>> the request
>>     queue first.
>>   +  if ``-i`` is specified, *AIO* option can be used to specify
>> different
>> +  AIO backends: ``threads``, ``native`` or ``io_uring``.
>> +
>>     If ``-n`` is specified, the native AIO backend is used if
>> possible. On
>>     Linux, this option only works if ``-t none`` or ``-t directsync`` is
>>     specified as well.
>>   -  if ``-i`` is specified, *AIO* option can be used to specify
>> different
>> -  AIO backends: ``threads``, ``native`` or ``io_uring``.
>> -
>>     For write tests, by default a buffer filled with zeros is written.
>> This can be
>>     overridden with a pattern byte specified by *PATTERN*.
>>   diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
>> index 3fd836ca90..d7fbc6b1f4 100644
>> --- a/qemu-img-cmds.hx
>> +++ b/qemu-img-cmds.hx
>> @@ -16,9 +16,9 @@ SRST
>>   ERST
>>     DEF("bench", img_bench,
>> -    "bench [-c count] [-d depth] [-f fmt]
>> [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset]
>> [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache]
>> [-i aio] [-w] [-U] filename")
>> +    "bench [-c count] [-d depth] [-f fmt]
>> [--flush-interval=flush_interval] [-i aio] [-n] [--no-drain] [-o
>> offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t
>> cache] [-w] [-U] filename")
>>   SRST
>> -.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
>> [--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET]
>> [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE]
>> [-i AIO] [-w] [-U] FILENAME
>> +.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
>> [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o
>> OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t
>> CACHE] [-w] [-U] FILENAME
>>   ERST
>>   DEF("check", img_check,
>>       "check [--object objectdef] [--image-opts] [-q] [-f fmt]
>> [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

