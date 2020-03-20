Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D461A20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D461A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDqL-0003J7-2y
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFDpc-0002hr-GV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFDpb-0003px-B3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:20:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jFDpY-0003mP-M0; Fri, 20 Mar 2020 05:20:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ml6i2-1jgc262i8S-00lWv0; Fri, 20 Mar 2020 10:20:22 +0100
Subject: Re: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent
 Clang warning
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
 <7412CDE03601674DA8197E2EBD8937E83B6A4539@dggemm531-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70484354-84a0-facf-d4dc-df167752110b@vivier.eu>
Date: Fri, 20 Mar 2020 10:20:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6A4539@dggemm531-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+88HfOJCKE0y+O1pM8VC/jZ/e82RR4pyKXH+v01Ua5KsUoZqrk0
 Pvx7iyUDyga1gquSauiJM5uopME5+mNDAKc9PPNNu+1V6UJ5C+2JB/jniZrObmDxv3W6Y4g
 njSWY4o/245KgrdRq8tvw5plR95mLJ24L0709opiOJnuqO48/sK3UjpgKZ7iy9lC389phX0
 x9f38C3DZ1vIDh+lixL4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RpLhXBF0ebo=:0su2W1Xb5Nn84/+AxcOULS
 aLMmTZ9RUP/Dfw3OFoSeZvPg/Xns4oGvAxjnBJYey6fhw3Fzo66kDWikmxtaE5In8LmvPKNzy
 ge6o2qh7ShAL67EyFCVKf4VzQykLZeJU1nOGLW9CaPHvfj9WitO6r4JZrkP1lpOafFP/2hdtF
 nM9p5yWzpZ9yfsBxqeQ9bo0hjBQlG3fK6FYVhh96iTFOUx8e5i58Sc3Ao6AYcimq0Ff9g8mNv
 Y6tP0B096VH6lMKC1YjYBN2I5HK7g6NQ6Gik3FP7fMyIcxwBjozuBvlVFRhhihYDPqfks1fBK
 QVUxcxWFfLXOI6FmyWx2+FIuShzMgS+aslPsWnq/Ubl/RUOh5hP8w4CaYR3uxIAr4aHXjKlnZ
 UKzW6yDGgsmiWcHWyxfGnycc3arzUkNQUTdkjrz3nEwuiCsVMh6SMNdvU5Jqkt17PGLJKyzLe
 j1YgXQ3d9teGqVG/YCQDRI23LclKNzT8wP8fjiZ9JnpqIwAO4tvbcvBTumUoOkmNl5rwrnGHe
 oljgWSNTJkvThhJHlTw9jNVL26T3eDcXzD6h3hkPIXBg+bPao0RR2kppZvueaH+19/tsWQB5K
 BVpVqntzowxK0QU1e1iH5MyjPw24fVfGjFe+iBC2s9R226i3gpTCQAdKmbMPn0C5m8uzmBgXm
 HfwRWkIWagxaBikLSSlRWGVtmS7BfK9LWQCG+OvvYWmsqGxz0XGSzgHZ/pLHeOymLi0ruLOQu
 S8l9a4+0SpHK1XBv1E/1kOanswKu+YrUzLTATY9/JFbRwHZj7WB8zwnRf3kioYtohjWnRSA0u
 aKXLB/hQ2UAqMIzjNtwVB6SeBNl4CqsPQHvw4Z/MrmpHonWmRoDbOLnbiK5SVLj/H02qNFB
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/03/2020 à 03:25, Chenqun (kuhn) a écrit :
> Gentle ping.
> 
> Any other suggestions about this?

I will not take that via the trivial queue as it is not trivial for me.

Could it go via block queue?

Thanks,
Laurent

> Thanks.
> 
>> -----Original Message-----
>> From: Chenqun (kuhn)
>> Sent: Wednesday, March 11, 2020 11:29 AM
>> To: qemu-devel@nongnu.org; qemu-trivial@nongnu.org
>> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Chenqun (kuhn)
>> <kuhn.chenqun@huawei.com>; Euler Robot <euler.robot@huawei.com>;
>> Kevin Wolf <kwolf@redhat.com>; Ronnie Sahlberg
>> <ronniesahlberg@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter
>> Lieven <pl@kamp.de>; Max Reitz <mreitz@redhat.com>; Laurent Vivier
>> <laurent@vivier.eu>
>> Subject: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent Clang
>> warning
>>
>> Clang static code analyzer show warning:
>>  block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>>        flags &= ~BDRV_O_RDWR;
>>        ^        ~~~~~~~~~~~~
>>
>> In iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which is the same in
>> both of flags and bs->open_flags.
>> We can use the flags instead bs->open_flags to prevent Clang warning.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Lieven <pl@kamp.de>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>>
>> v1->v2:
>> Keep the 'flags' then use it(Base on Kevin's comments).
>>
>> v2->v3:
>> Modify subject and commit messages(Base on Kevin's and Laurent's
>> comments).
>> ---
>> block/iscsi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/iscsi.c b/block/iscsi.c index 682abd8e09..50bae51700 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict
>> *options, int flags,
>>         iscsilun->cluster_size = iscsilun->bl.opt_unmap_gran *
>>             iscsilun->block_size;
>>         if (iscsilun->lbprz) {
>> -            ret = iscsi_allocmap_init(iscsilun, bs->open_flags);
>> +            ret = iscsi_allocmap_init(iscsilun, flags);
>>         }
>>     }
>>
>> --
>> 2.23.0
>>
> 


