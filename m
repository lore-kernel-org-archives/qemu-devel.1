Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A9C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426482222A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF0b9csn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426482222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYcJ-00085l-Aw
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYRk-0000mE-GW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYRi-0004vu-Jh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600266603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxBcxuMcW32hadB7AMSacaPfx7lo536GhfTsKEPnxQM=;
 b=WF0b9csnnq4zwgK1N1zRDz4QgEwfBPuwnzhv0nwU1OWQviEF0b4qI1ua1jkldaDX3Pd9Dz
 l2vqXA3qg52TK8ZSP6ZCQa4BLsOXLYDrDe9G8JtBc+1xjr0KzRRxiCe5k4VGjKiZvRt8yG
 vtpMGul+pMGdhNXolWCBirf95LHxXTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-JspdfpuTPGW1F4WaRpQsjw-1; Wed, 16 Sep 2020 10:30:01 -0400
X-MC-Unique: JspdfpuTPGW1F4WaRpQsjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2AC10A7AE7;
 Wed, 16 Sep 2020 14:30:00 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8112D709BB;
 Wed, 16 Sep 2020 14:29:59 +0000 (UTC)
Subject: Re: [PATCH 06/37] qapi: delint using flake8
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
 <87wo0tor80.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com>
Date: Wed, 16 Sep 2020 10:29:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87wo0tor80.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 8:12 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Petty style guide fixes and line length enforcement.  Not a big win, not
>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>> easy baseline to enforce hereafter.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/.flake8     |  2 ++
>>   scripts/qapi/commands.py |  3 ++-
>>   scripts/qapi/schema.py   |  8 +++++---
>>   scripts/qapi/visit.py    | 15 ++++++++++-----
>>   4 files changed, 19 insertions(+), 9 deletions(-)
>>   create mode 100644 scripts/qapi/.flake8
>>
>> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
>> new file mode 100644
>> index 0000000000..45d8146f3f
>> --- /dev/null
>> +++ b/scripts/qapi/.flake8
>> @@ -0,0 +1,2 @@
>> +[flake8]
>> +extend-ignore = E722  # Pylint handles this, but smarter.
> 
> I guess you mean pylint's W0702 a.k.a. bare-except.  What's wrong with
> flake8's E722 compared to pylint's W0702?
> 

Flake8 will warn on *any* bare except, but Pylint's is context-aware and 
will suppress the warning if you re-raise the exception.

I don't actually think this comes up in the qapi code base, but it does 
come up in the ./python/qemu code base.

(One of my goals is unifying the lint checking regime for both packages.)

>> \ No newline at end of file
> 
> So put one there :)
> 

Whupps, okay.

>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index e1df0e341f..2e4b4de0fa 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>   def gen_marshal_output(ret_type):
>>       return mcgen('''
>>   
>> -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
>> +                                          Error **errp)
> 
> The continued parameter list may become misalignd in generated C.  E.g.
> 
>      static void qmp_marshal_output_BlockInfoList(BlockInfoList *ret_in, QObject **ret_out,
>                                                Error **errp)
>      {
>      ...
>      }
> 
> Do we care?
> 

Yeah, I don't know. Do we?

It actually seemed more annoying to try and get flake8 to make an 
exception for these handful of examples.

Path of least resistance led me here, but I can try and appease both 
systems if you'd prefer.

> More of the same below.
> 
>>   {
>>       Visitor *v;
>>   
> [...]
> 


