Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27171C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADDB20728
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DrjLLB+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADDB20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZn6V-0006jb-0i
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 23:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZn5h-0006Jc-Be
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:02:21 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:37330)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZn5b-0002A9-S0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=788y2
 imNs+iCPYuXCvUck7WTQ/qr0M/Sj0G09hdMcVo=; b=DrjLLB+kuCMpH74///vwW
 7qMC1TLX23H+Fs1X/j/c7SnmJGCa0w5gsiOD8YKKZKW1v7fkbcDcq4G8kx+NYPqQ
 cuI3UmlENN4F6q/a0p7FoGv0MwOHH++8qlY1mcgloNqcMnvXDIjCHsuIb30uj1tH
 6MlHBMW1pwzfUtEOlzFCio=
Received: from [192.168.0.123] (unknown [114.240.93.195])
 by smtp5 (Coremail) with SMTP id HdxpCgDXFkmMV79eMOe3AA--.31S2;
 Sat, 16 May 2020 11:01:42 +0800 (CST)
Subject: Re: [PATCH v4 3/3] qemu-options: updates for abstract unix sockets
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200515043235.32189-1-zxq_yx_007@163.com>
 <20200515043235.32189-4-zxq_yx_007@163.com>
 <df4fe148-90af-771d-641e-0579e2049cc3@redhat.com>
From: xiaoqiang zhao <zxq_yx_007@163.com>
Message-ID: <d2161f52-f23d-a70c-648c-2d3da9290247@163.com>
Date: Sat, 16 May 2020 11:01:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <df4fe148-90af-771d-641e-0579e2049cc3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: HdxpCgDXFkmMV79eMOe3AA--.31S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF4kJFy8KF4rZF4kXF4Dtwb_yoW8Jr47pr
 y5Kan0yrn7X3y8uF13Xay8JrWrGa1Fqa18K34UJwn0k398Za4Sga47Kw1vqw18ArWfAF4a
 y3WjvryYga1qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0ManUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiFhYmxl44Kn1IqwAAsy
Received-SPF: pass client-ip=123.126.97.5; envelope-from=zxq_yx_007@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 23:02:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 armbru@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/5/16 上午1:37, Eric Blake 写道:
> On 5/14/20 11:32 PM, xiaoqiang zhao wrote:
>> add options documents changes for -chardev
>>
>> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qemu-options.hx | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> I'd suggest listing 'abstract' before 'tight', since 'tight' only 
> matters for abstract.  I also have grammar suggestions:
>
>> -    ``unix options: path=path``
>> +    ``unix options: path=path[,tight=on|off][,abstract=on|off]``
>>           ``path`` specifies the local path of the unix socket. ``path``
>>           is required.
>> +    ``tight`` whether to set @addrlen to the minimal string length,
>> +        or the maximum sun_path length. defaults to true. ``tight`` is
>> +        optional.
>> +    ``abstract`` whether use abstract address. defaults to false.
>> +    ``abstract`` is optional.
>
> ``abstract`` specifies the use of the abstract socket namespace, 
> rather than the filesystem.  Optional, defaults to false.
> ``tight`` sets the socket length of abstract sockets to their minimum, 
> rather than the full sun_path length.  Optional, defaults to true.
>
Reasonable,  will change in v6


