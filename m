Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB7EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ADE205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l+oqivWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ADE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ1iw-0003Bf-Q3
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 20:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZ1iP-0002ln-L9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:27:09 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:47480)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZ1iI-0001q0-KX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=aexkb
 2I2hH1HTu3sDoOGxH+NkooalP2YflHVJyYZxLE=; b=l+oqivWbod+gDQk+ZIizM
 Jm9DsqvoQi3MBKJFP+OD954gyXJRqDZtirqXqnluxDqOOILNJv0KQbRNUTjzhJTh
 RSni34LfgNZMVLAjnDaz6XGkCCn3NTdI3NTUfpsK2AEXOPdGstqFQc6a9bhKRAWx
 nknlCPmytToDLue59eK/q8=
Received: from [192.168.0.123] (unknown [114.240.93.195])
 by smtp3 (Coremail) with SMTP id G9xpCgD3zdAwkLxeV+OQBA--.40S2;
 Thu, 14 May 2020 08:26:25 +0800 (CST)
Subject: Re: [PATCH v3 2/3] tests/util-sockets: add abstract unix socket cases
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200510061422.24841-1-zxq_yx_007@163.com>
 <20200510061422.24841-3-zxq_yx_007@163.com>
 <20200513154931.GI1253949@redhat.com>
From: xiaoqiang zhao <zxq_yx_007@163.com>
Message-ID: <0b5b8953-a9b8-71e6-0f40-6ec2c464b211@163.com>
Date: Thu, 14 May 2020 08:26:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513154931.GI1253949@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: G9xpCgD3zdAwkLxeV+OQBA--.40S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFWkKr4DKrWxAw47Xr4xZwb_yoW8JrWDpr
 y5GF4FkF48JFZ7WrnIg3WUZFyrCF1xWr4j9r97u3WYvF4Duryayr10qryUKr1kJrWrXw4S
 vFsYgrn09w4YyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNrcfUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEAAkxlUMRC6WEQAAsG
Received-SPF: pass client-ip=123.126.97.3; envelope-from=zxq_yx_007@163.com;
 helo=mail-m973.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 20:26:49
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/5/13 下午11:49, Daniel P. Berrangé 写道:
> On Sun, May 10, 2020 at 02:14:21PM +0800, xiaoqiang zhao wrote:
>> add cases to test tight and non-tight for abstract address type
>>
>> Signed-off-by: xiaoqiang zhao<zxq_yx_007@163.com>
>> ---
>>   tests/test-util-sockets.c | 83 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
>> index 5fd947c7bf..8042fb9276 100644
>> --- a/tests/test-util-sockets.c
>> +++ b/tests/test-util-sockets.c
>> @@ -227,6 +227,84 @@ static void test_socket_fd_pass_num_nocli(void)
>>       g_free(addr.u.fd.str);
>>   }
>>   
>> +static gpointer unix_server_thread_func(gpointer user_data)
>> +{
>> +    SocketAddress addr;
>> +    Error *err = NULL;
>> +    int fd = -1;
>> +    int connfd = -1;
>> +    struct sockaddr_un un;
>> +    socklen_t len = sizeof(un);
>> +    char name[] = "/tmp/unix-test.sock";
> Fixed filenames are bad, as even though this is the abstract
> namespace and thus safe from on-disk clashes, the abstract
> namespace is still OS global. We should append both the PID
> and a sequence of random bytes to get something which doesnt
> clash if two copies of the unit test run concurrently.
>
agree.


