Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA1C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E5A206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A55Wyxeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E5A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3Bw-0000oW-4q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jv3B9-0000Ns-AG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:27:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jv3B6-0003jB-LV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594664867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hEolbz1LXH+PVXiybKee2xDLexesOqOXWRDUDF7HXrU=;
 b=A55Wyxeof5uOY+7bUA8k1hCMfFbnunVVB67jQhLLZdHTIrCV2XM25Z+kMCjreMXdm/Hyn4
 BTia4CXVND6QehQh8zH6trM5pXsjXA0DtPAtvSFD0LZZ6xfklwRcJ5GFpyMoU0wB8QW6B3
 88WqljgqjuKFgJnW9gipchL8p4fzIxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-5o9rZi6TO2G31cypo1vs6w-1; Mon, 13 Jul 2020 14:27:43 -0400
X-MC-Unique: 5o9rZi6TO2G31cypo1vs6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BD1C106B258;
 Mon, 13 Jul 2020 18:27:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3BB57621D;
 Mon, 13 Jul 2020 18:27:37 +0000 (UTC)
Subject: Re: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option
 to handle -Wpsabi
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-11-alex.bennee@linaro.org>
 <9c736c87-34c7-375c-61b8-954aa70deab5@linaro.org> <87wo37z7vv.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6afbd8ef-9aa5-961d-975f-d26136989e26@redhat.com>
Date: Mon, 13 Jul 2020 20:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87wo37z7vv.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/2020 18.39, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 7/9/20 7:13 AM, Alex Bennée wrote:
>>> Not all compilers support the -Wpsabi (clang-9 in my case).
>>>
>>> Fixes: bac8d222a
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/plugin/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
>>> index 0cb8e35ae407..dcfbd99b15b8 100644
>>> --- a/tests/plugin/Makefile
>>> +++ b/tests/plugin/Makefile
>>> @@ -18,7 +18,7 @@ NAMES += hwprofile
>>>  
>>>  SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>>  
>>> -QEMU_CFLAGS += -fPIC -Wpsabi
>>> +QEMU_CFLAGS += -fPIC -Wno-unknown-warning-option -Wpsabi
>>
>> Surely -Wno-unknown-warning-option is in the same boat?  E.g. I don't see any
>> version of gcc that supports it.
> 
> GCC doesn't seem to complain about it though.

Both, GCC and Clang do not complain about unknown -Wno-somthing options
as long as there are no other warnings. They only complain for options
that do not have a "no-" after the "-W".

 Thomas


