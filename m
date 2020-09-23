Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCEC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B63206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA5gyTbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B63206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5oo-0002sJ-LJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL5nA-0001Z4-0N
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL5n6-0004ol-NV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600871439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVsa8ykOw39x39jrfw0FOEnmI2UQa5us7k5IRIIUBCw=;
 b=GA5gyTbRrNY3J64lVL/CmaNUw0ZV97L5YOy8EBOK++dT1ytiofHbyQZrwrPdDtmLg+v/W0
 SOLUhFc7K7tagoXff06SBTaVjZQ/1hOCXJzlNvJygqBNX53PSS/zx9nT8TsQTAhVfvRx61
 gNSnkKXf5rWE79r6pwdZQfN4gCLleFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-zijU-_l7PCSq7kzZbbL_9A-1; Wed, 23 Sep 2020 10:30:36 -0400
X-MC-Unique: zijU-_l7PCSq7kzZbbL_9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B347164088;
 Wed, 23 Sep 2020 14:30:35 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B895719744;
 Wed, 23 Sep 2020 14:30:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
 <8711f367-c055-4f61-0043-3880fff95315@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3cc1d1b9-e87b-6418-188e-57f5c400e285@redhat.com>
Date: Wed, 23 Sep 2020 10:30:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8711f367-c055-4f61-0043-3880fff95315@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 3:49 AM, Philippe Mathieu-Daudé wrote:
> On 9/23/20 1:05 AM, John Snow wrote:
>> I'm proposing that I split the actual Python library off from the other
>> miscellaneous python scripts we have and declare it maintained. Add
>> myself as a maintainer of this folder, along with Cleber.
>>
>> v2: change python/* to python/, thanks Alex.
> 
> ^ Can you drop that line from the description when applying please?
> 

Yup, forgot to put below the dashed line, oops.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Acked-by: Cleber Rosa <crosa@redhat.com>
>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>   MAINTAINERS | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3d17cad19a..c0222ee645 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2355,11 +2355,18 @@ S: Maintained
>>   F: include/sysemu/cryptodev*.h
>>   F: backends/cryptodev*.c
>>   
>> +Python library
>> +M: John Snow <jsnow@redhat.com>
>> +M: Cleber Rosa <crosa@redhat.com>
>> +R: Eduardo Habkost <ehabkost@redhat.com>
>> +S: Maintained
>> +F: python/
>> +T: git https://gitlab.com/jsnow/qemu.git python
>> +
>>   Python scripts
>>   M: Eduardo Habkost <ehabkost@redhat.com>
>>   M: Cleber Rosa <crosa@redhat.com>
>>   S: Odd fixes
>> -F: python/qemu/*py
>>   F: scripts/*.py
>>   F: tests/*.py
>>   
>>
> 


