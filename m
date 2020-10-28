Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932CC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2B7247B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWBaS++n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2B7247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn2L-0005JK-4X
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXmzw-0003pt-Du
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXmzt-0004Q7-Vk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oj/aVpU3hJ/jYV5Lahq3ffcVrrVbEq7LwrjB4I3XB80=;
 b=KWBaS++n/k4Ufw0/6Z1x4XwGM86DVbuIhQrJAqZzfc43qAQbrjZkoVZmHGuOajy3NyQxho
 Kkj9P9m/rip4R9oqRQVdEr75hIVERyiUDZECW0BkVC0jzMQ7qPvja4cN1OL3TPAW20w6aG
 vLTO1GW/tVr0CfM3AcenChAjLj/bQcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Fss2iCBrPbObAX4puLPK7Q-1; Wed, 28 Oct 2020 11:04:13 -0400
X-MC-Unique: Fss2iCBrPbObAX4puLPK7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0F98C5741;
 Wed, 28 Oct 2020 15:04:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-124.ams2.redhat.com [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C85F6EF46;
 Wed, 28 Oct 2020 15:04:07 +0000 (UTC)
Subject: Re: [PATCH 9/9] hw/timer/renesas_tmr: silence the compiler warnings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-10-kuhn.chenqun@huawei.com>
 <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61ec3c46-f01e-c4ea-de28-a55507192ff3@redhat.com>
Date: Wed, 28 Oct 2020 16:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9992abee-6af6-5fae-15f6-3039fca84e80@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Magnus Damm <magnus.damm@gmail.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/10/2020 10.59, Philippe Mathieu-Daudé wrote:
> On 10/28/20 5:18 AM, Chen Qun wrote:
>> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
>> ../hw/timer/renesas_tmr.c: In function ‘tmr_read’:
>> ../hw/timer/renesas_tmr.c:221:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   221 |         } else if (ch == 0) {i
>>       |                   ^
>> ../hw/timer/renesas_tmr.c:224:5: note: here
>>   224 |     case A_TCORB:
>>       |     ^~~~
>>
>> Add the corresponding "fall through" comment to fix it.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> ---
>>  hw/timer/renesas_tmr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
>> index 446f2eacdd..e03a8155b2 100644
>> --- a/hw/timer/renesas_tmr.c
>> +++ b/hw/timer/renesas_tmr.c
>> @@ -221,6 +221,7 @@ static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>>          } else if (ch == 0) {
>>              return concat_reg(tmr->tcora);
>>          }
>> +        /* fall through */
>>      case A_TCORB:
>>          if (size == 1) {
>>              return tmr->tcorb[ch];
>>
> 
> You fixed A_TCORA but not A_TCORB...

A_TCORB cannot fall through, since it always does a "return" in both
branches of the if-statement.

However, it also looks really odd that A_TCORA falls through to A_TCORB here
and return that register value instead. Is this really intended? Yoshinori,
could you please double-check whether this is a bug here, or intended?

 Thanks,
  Thomas


