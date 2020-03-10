Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4944CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF1920727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF1920727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgem-0002nL-9b
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBgP5-0002n3-Oq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBgP4-0003Z0-En
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:02:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBgP1-0003Qg-S0; Tue, 10 Mar 2020 11:02:40 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MyK1E-1jYizR1dwy-00ydJN; Tue, 10 Mar 2020 16:02:05 +0100
Subject: Re: [PATCH v3 02/12] block/iscsi:Remove redundant statement in
 iscsi_open()
To: Kevin Wolf <kwolf@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-4-kuhn.chenqun@huawei.com>
 <20200310142614.GF6926@linux.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a1ed92ff-4842-c437-4e22-a94c46760cc0@vivier.eu>
Date: Tue, 10 Mar 2020 16:02:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310142614.GF6926@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v8j2ig5QH8TsKZObjeVkeSJ+nkwqXBuvWMOHB+3jGzLXsQWnxd7
 +y8hhrABcNlsW45PmTte1rPMjFFuJQtxXOIYrob2VxpErw5f9rouP8nwOGJY+pAUFS3tRhn
 9UIDKa1CozA+VhOX1naAUxFONUboB2DG+hExTdo2FbX2fN1XzlMW6D73peTYvhWJmX/0dXz
 9Qf5l69FvMixahUjHo8Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BfgVxwcLdPs=:2NgBEW9SgghtpiG0KMWCAe
 3OVrqXt4Pziv0LuKktel4gur+fIUf/7tb1N0w0U2NIdObQ7lHhDd5p7PJFkw0n8cQ1TJR2zf5
 CGfvh4Ayb8KxGQOUQvLlB44u0WhhYgWW7xI029Sj+nwAzPDIsvsDL99qVye9y7zNKW0MzugJb
 NIELM+zvzNjdJyn4hJXbrmaB4xYXiE0HyWLWHBXV+VS3WbEuBbMNrV6NIxgE5dtQNR9c+z6kv
 S34+Beof7UN4GPXAsFKBCoHIRnYi/fdYK6uXBCQ55RwbaZ4+aHsZgbjj67KVKwNxK4e6RbLVu
 5FT9j44he+G93iMzYDNICH9Z3QpzJRQY9jZXV0Cn0sW1XA0AaQ1oRPIYAXfK9WFLseMpP2GXy
 M+ZIY34YcQ49aJ9sbiQ6dKHe1ACPJHleh1+IIsD946ndqKuVmQTaYUsNOE/vZzUw05NDREdWH
 1RSrixU+WAbPckUFtKKYTiFyq147+jDJKJiziHTVWwaHuo+SvQoWCMm3QqF75xv30ZLaOhRdU
 TexAYjY30iFdmKJzCjqvfIUzY7vDkxXTq2a5MIfk3wK7EvSEWoSZnjJ1zNO+Tc6le60br7Drv
 v2VAH+sMq03F6Iq1YBAoaEDF1YzZ5vjhEz5ryZ0NFdSoilYiXvW6M0qDHzQczztcpJQjdy0mK
 7RZIjx+F+DLO0SnfOnelZUk04JsxNqtiUvlE+2U/qBDGaOUvHwaNMig5yyWlA5eogH7XMA8T+
 pSvlCSqo/KRycVR/vpCrXUueKcqQM8quALenOobTd9WDkNKvQxxyA7gZBD3VHkWg0EvCGoo8G
 gPukj9BEIrehVeqoxNYkrXADtp4bmNjjdlyxfwvlJ+UHZHh1VdYUWrlzRStX8+lWuUQhZRP
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 15:26, Kevin Wolf a écrit :
> Am 02.03.2020 um 14:07 hat Chen Qun geschrieben:
>> Clang static code analyzer show warning:
>>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>>         flags &= ~BDRV_O_RDWR;
>>         ^        ~~~~~~~~~~~~
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Lieven <pl@kamp.de>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>>
>> v1->v2:
>>  Keep the 'flags' then use it(Base on Kevin's comments).
> 
> I think this patch wants a different subject line now.


It needs also a better explanation in the commit message and should not
go through trivial as the change is not obvious.

Thanks,
Laurent

> 
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 682abd8e09..50bae51700 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
>>          iscsilun->cluster_size = iscsilun->bl.opt_unmap_gran *
>>              iscsilun->block_size;
>>          if (iscsilun->lbprz) {
>> -            ret = iscsi_allocmap_init(iscsilun, bs->open_flags);
>> +            ret = iscsi_allocmap_init(iscsilun, flags);
>>          }
>>      }
> 
> The code looks good.
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 
> 


