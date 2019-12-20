Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2E8C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3395F20716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3395F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiD9r-0002Pt-7A
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 02:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iiD8z-0001sJ-Gu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iiD8y-0003EW-7Q
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:56:17 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iiD8x-000377-Sw; Fri, 20 Dec 2019 02:56:16 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MirfI-1i3d423Z8m-00ewxL; Fri, 20 Dec 2019 08:55:55 +0100
Subject: Re: [PATCH] util/module: fix a memory leak
To: Markus Armbruster <armbru@redhat.com>, pannengyuan@huawei.com
References: <1576805650-16380-1-git-send-email-pannengyuan@huawei.com>
 <87lfr7jvlh.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c286a30f-38f1-e90b-e07e-4c9f7a8723d8@vivier.eu>
Date: Fri, 20 Dec 2019 08:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <87lfr7jvlh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2y2Z35trQfBXGW85A2fi0mFEDEYquAaH1FyCpW8QxJvqjpgmkL1
 IhX9GtyD1lfWdqMpsgL1gWg4FmMAQVDPUmehnd4NS8N012dDDk8WDzW6dIp/uQchK8yd83c
 1OpKUXAHMYr155PhksO589Z05PTtQ0/i59W0ABlpolTp792/0/4XJ7/ehUgcC5CfGjds114
 IPB2ssJNcAs4QjMUhItAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSDDitx+r8I=:Qgs+Gs1nK8NlSYCf8FnKhh
 /bV8TweYmNNuh+uPZ2/kHmn6lwu/bZNpQBCla4VEFx//R+H32yM6B+4xFtYvGUHmd2E+T0VpC
 3D43h3uXhP6MXd9A0xkDJvmhxZ6PRK/mRqvKSYxGZQkIvOKFdsr8KeLfQp1SxL9SdACcnFgAW
 WJ0xlzzcEtALU9YAmey2ipRPTvZt6YhZLiFf7FgwvCxIQMYYfntmZ4ErkicvQXKaxK+Dtucgg
 sglRPAJnoYBkXGGy3vX3jCcz3cjUJdbwG3tk6jqJvp9gPHYkIzwuLJfUjn+xRBafhBePvKH4k
 +yUEREcTqSkvZcaWkUvRlzrnFU3MvW5dsfFjhmquRsdBkRwAmV/3cN6wXeDNp+gOSHF6Lf3os
 xY6T9Cpc9SAfRMo7SIvhnzWOJvd+GNlvw5FRqVU2YCxzSxEoRGQEMCr8k0OQivPJ7YIWpI+hh
 bytGgC9skDGXApIbJ2m8pKKTsP7S0yPe/UWunH+C6noEoBe3oRHEfPMDzHrpTpm2vIHbYYjWx
 bH6Ska6NTvCz9nUakFlHpFYs/dVzf1paxsIoq0QESsd1ENVMqaClNk3ZWo6+PknRaKHQG/bGj
 7qHsLghtagUCBVasi9NI1X69IvpwyNyxRUk3TrK80BFyCY1wSBVIu20GwcHs5lzxR3eVQEZ5q
 c2N5SssIH7+allbnS8FQBK7AFquoyOcHw07DkUGpfHwq0Bw9i7oBf/vQ0HbMQlEnz3pHeCW2t
 8XPextsgkCZUMvEwDTzogYHwlqTd4OvanAqZaQmuMtiIHy2pNPW7konwL4eO5gbOrhPHnEmJD
 RHIFR6QX5zfu7JtP0Ly2IcKVCzjv01z61ZVohkb3xEEUq3NiDb+OqabCIfQw0WmU1uzDiaj5T
 rbZZ9/n/Aw7LdNxvQBhQ==
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/12/2019 à 08:37, Markus Armbruster a écrit :
> Cc: qemu-trivial
> 
> <pannengyuan@huawei.com> writes:
> 
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> spotted by ASAN
>>
>> Fixes: 81d8ccb1bea4fb9eaaf4c8e30bd4021180a9a39f
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>  util/module.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/util/module.c b/util/module.c
>> index e9fe3e5..8c5315a 100644
>> --- a/util/module.c
>> +++ b/util/module.c
>> @@ -214,6 +214,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
>>  
>>      if (!success) {
>>          g_hash_table_remove(loaded_modules, module_name);
>> +        g_free(module_name);
>>      }
>>  
>>      for (i = 0; i < n_dirs; i++) {
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Reviewing this made me wonder: @loaded_modules is global state, but
> there appears to be no synchronization.  What's the safety argument?
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

