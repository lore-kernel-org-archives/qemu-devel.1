Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD479C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D5920873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D5920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBge0-0001rQ-AU
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBgRh-00082H-Ed
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBgRg-0000SD-5p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:05:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBgRW-0008QU-Ox; Tue, 10 Mar 2020 11:05:15 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N1wdd-1jMITT02af-012Hyk; Tue, 10 Mar 2020 16:04:34 +0100
Subject: Re: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
To: Peter Maydell <peter.maydell@linaro.org>,
 Chen Qun <kuhn.chenqun@huawei.com>
References: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
 <CAFEAcA_W2pRztEAmd1v+6O-1J9-CckVV8+G6kZ3igmR-ie6k+Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3e551fba-8bda-a2b4-d223-356493cac4db@vivier.eu>
Date: Tue, 10 Mar 2020 16:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_W2pRztEAmd1v+6O-1J9-CckVV8+G6kZ3igmR-ie6k+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JkLH/S6Rec/tr78Bh6CWTV1WIIdEuqwtEB7ZH8DNQ3uVKiAxW6G
 BnpPLGIIo50DsNmfTd6mwBFDC5ZZ708uz4IhWemEC58iKeeBTVvOQyJ4Vji3niwoEJmL8ea
 I/FmCbwpwuw9glQQ0hxwE4kcqIlVYUhvEYLJqn/SnOYWdnfbMhZIpgqwjIK18pB5IqVGym4
 6AIBEUhxnXA3Ke6TyjQfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SAtAZydQ0CQ=:AYTzFhbz+Jy1skKkrbbm3k
 w3Hn4whqLnwgWIOq+ls5kQ4bSRjaMlRiWyIXp/21WjHsY/EfSBTQPnCFO5ak1zJy3rpTGoUzg
 oYI+pJ+ZuVC7qGhhAHD2G6Pk4xEQdFXubrijcvKZeZ+ml7KzrFJcLh9EDJDjulXS+Y7TpmRD2
 QQLVDPmQlJsylkcBOlYIkxtAltmA4SsNVEZsdiqudHxfwBY8e6wWLXS9oX3UriFireSaR5mnt
 fnNlGn33ROx0VxVnu81IC6YORL1NpUpE6KOGZ7+wE3ifNZiSDQLSA/yxoFAih3Fs77sJKEaEF
 3ivOMu7VY3D77VGqbt0lyt6nWVPwNClEA6jZqUb25fHsCJAVA9LN6s4GkfDcOdknOCWU67hK2
 odvdWUdkDEZ35T76rgDbBYc9U9hzPOVnqXy1bnhvuAcUcm5p8UdSmKrGlCxQjqFo0kwYg0kXE
 taJ1cKgiCWFS2C/CDnHPYY7afm43LQu1kx61hRsWMN96VMgCanpsv6K4PrrBXvLZkZSHERe/6
 SI1ptTQy5DfuAuzfGw6JNuQd80v/7X3QFTPzVUujI+4B30qyrZ7+wAZrD//K8mEVg2dxw3KtU
 NSBr7wLgUGV22ApRnzOyYjviAkOeCeji74A6hgzRS1BZctIbrDIu0eVq2CBDS3/SMik+OOGnF
 MmhwY5MxiyNIQBIQChFW3SFvoDZkx2pyr/fVVKU4xLLzcldgrNSqHyHljXaw1LTlNZy3zpXrV
 bnMkJFyFJcu5ucFzR+sxa7chAMNQOu3KNNx0Yt5bCFJbY5YiHyCXa0IInv9FWK7mi858c3PLk
 9nmEByvKPYC1/ScUn5pTQop7MQcgitBRiEY0WNtmi06VUePjZpjihHySEVUg2sU2A7iLXQv
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 14:46, Peter Maydell a écrit :
> On Tue, 10 Mar 2020 at 13:10, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>>
>> Here are some redundant statements, we can clean them up.
>> Clang static code analyzer show warning:
>> hw/scsi/megasas.c:1175:32: warning: Value stored to 'max_ld_disks' during its initialization is never read
>>     uint32_t num_ld_disks = 0, max_ld_disks = s->fw_luns;
>>                                ^~~~~~~~~~~~   ~~~~~~~~~~
>> hw/scsi/megasas.c:1183:9: warning: Value stored to 'max_ld_disks' is never read
>>         max_ld_disks = 0;
>>         ^              ~
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Fam Zheng <fam@euphon.net>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: qemu-block@nongnu.org
>> ---
>>  hw/scsi/megasas.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
>> index af18c88b65..3f982e1d3b 100644
>> --- a/hw/scsi/megasas.c
>> +++ b/hw/scsi/megasas.c
>> @@ -1172,7 +1172,7 @@ static int megasas_dcmd_ld_list_query(MegasasState *s, MegasasCmd *cmd)
>>      uint16_t flags;
>>      struct mfi_ld_targetid_list info;
>>      size_t dcmd_size = sizeof(info), resid;
>> -    uint32_t num_ld_disks = 0, max_ld_disks = s->fw_luns;
>> +    uint32_t num_ld_disks = 0, max_ld_disks;
>>      BusChild *kid;
>>
>>      /* mbox0 contains flags */
>> @@ -1180,7 +1180,6 @@ static int megasas_dcmd_ld_list_query(MegasasState *s, MegasasCmd *cmd)
>>      trace_megasas_dcmd_ld_list_query(cmd->index, flags);
>>      if (flags != MR_LD_QUERY_TYPE_ALL &&
>>          flags != MR_LD_QUERY_TYPE_EXPOSED_TO_HOST) {
>> -        max_ld_disks = 0;
>>      }
> 
> This doesn't look right -- your change removes the only statement
> in the body of this "if". I think you need to examine what the
> function is trying to do with the test it is doing on these flags
> in order to identify what the right change is... Probably this
> means going back to the h/w spec to identify the correct behaviour
> overall.

Moreover this "if" is the only user of MR_LD_QUERY_TYPE_ALL and
MR_LD_QUERY_TYPE_EXPOSED_TO_HOST.

Thanks,
Laurent


