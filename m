Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5332EC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1779220752
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MCqTB01l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779220752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOoC-0005BP-9x
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jYOms-0002Uj-I6
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:53:10 -0400
Received: from m12-15.163.com ([220.181.12.15]:54388)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jYOmo-0003hn-Ea
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=0Plmu
 mm+zQXK5AMhdQ7eYLBwbMpoEI5NJg1tCPeU1u4=; b=MCqTB01le/7sy+DhxBo7r
 /+LdnsjxPjEbP5rye6p4noDmLW3R/IivzNPdtUOIN08TggiIuL6TQtW6PMKzviRk
 KofPLAiJfkYi4mrtvR0FiriIbgFvrfwejrjPz9q7cxUyQowIvQhwoZVX2niLct9B
 Ik0rO+hdbf6IhPmzde/LbU=
Received: from [10.11.32.40] (unknown [39.155.168.46])
 by smtp11 (Coremail) with SMTP id D8CowABXdkakR7peQKiqCA--.7543S2;
 Tue, 12 May 2020 14:52:20 +0800 (CST)
Subject: Re: [PATCH v3 1/3] qemu-sockets: add abstract UNIX domain socket
 support
To: Eric Blake <eblake@redhat.com>, berrange@redhat.com,
 marcandre.lureau@redhat.com, kwolf@redhat.com, armbru@redhat.com
References: <20200510061422.24841-1-zxq_yx_007@163.com>
 <20200510061422.24841-2-zxq_yx_007@163.com>
 <0ead3ac4-efa3-b773-f5c3-7aa055e2af18@redhat.com>
From: "xiaoqiang.zhao" <zxq_yx_007@163.com>
Message-ID: <d9600083-303f-2e55-a0f0-86548774d55b@163.com>
Date: Tue, 12 May 2020 14:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0ead3ac4-efa3-b773-f5c3-7aa055e2af18@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: D8CowABXdkakR7peQKiqCA--.7543S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF18WrW3KF47Wr1xZrWrXwb_yoW8XF4Up3
 s8KayUK3Z5A3y8Wrs8ua15Jryrtan0q3Wjq3s5J3s0ka9093WSkFW2ka4FqF18Gr1fW3y7
 AFZ09rWSvF1qy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jheOJUUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqAQixlc7PH4i-AAAs4
Received-SPF: pass client-ip=220.181.12.15; envelope-from=zxq_yx_007@163.com;
 helo=m12-15.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:52:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/5/12 上午2:01, Eric Blake 写道:
> On 5/10/20 1:14 AM, xiaoqiang zhao wrote:
>> unix_listen/connect_saddr now support abstract address types
>>
>> two aditional BOOL switches are introduced:
>> tight: whether to set @addrlen to the minimal string length,
>>         or the maximum sun_path length. default is TRUE
>> abstract: whether we use abstract address. default is FALSE
>>
>> cli example:
>> -monitor unix:/tmp/unix.socket,abstract,tight=off
>> OR
>> -chardev socket,path=/tmp/unix.socket,id=unix1,abstract,tight=on
>>
>> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
>> ---
>
>> +++ b/qapi/sockets.json
>> @@ -73,12 +73,19 @@
>>   # Captures a socket address in the local ("Unix socket") namespace.
>>   #
>>   # @path: filesystem path to use
>> +# @tight: pass a socket address length that does not include the whole
>> +#         struct sockaddr_un record but (besides other components) only
>> +#         the relevant part of the filename or abstract string.
>> +#         default value is 'true'
>
> Perhaps:
>
> pass a socket address length confined to the minimum length of the 
> abstract string, rather than the full sockaddr_un record length (only 
> matters for abstract sockets, default true)
>
Sounds better
>> +# @abstract: whether this is a abstract address, default is 'false'
>
> Both new fields should have a '(since 5.1)' tag, to make it obvious 
> that they did not exist in earlier releases with the rest of the struct.
>
> s/a abstract/an abstract/
>
Will fix in the next version,  thanks Eric.


