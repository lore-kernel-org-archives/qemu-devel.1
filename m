Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D645C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB422065E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USJAP8y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB422065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8iS-0005hz-R4
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8hl-0005GI-5s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8hj-0002iK-Fx
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600882638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUkFzkPE4ozYNt8RoZm8JyKvhyVWsTNkwEz56fvODt8=;
 b=USJAP8y/Uqg68U0L/EmXTUX/3ExDlIcO6yWZrhsfcZjIz45Su84KZ/x5x7GQziYgmbTfso
 vMhJqDqnVU4fEC6Dv3TBfFtLV2ky9Bn1POiIFFhwr6y5JbNZVpKLnouflVPGPn0yJWssT7
 3C/2myGRsaWc1+KAhafrgBdhXy5N9lY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-g0s5mZu1MOiJqUJ_jpSCuQ-1; Wed, 23 Sep 2020 13:37:16 -0400
X-MC-Unique: g0s5mZu1MOiJqUJ_jpSCuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0A010BBEE8;
 Wed, 23 Sep 2020 17:37:07 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 844A9702E7;
 Wed, 23 Sep 2020 17:37:06 +0000 (UTC)
Subject: Re: [PATCH v2 10/38] qapi/common.py: delint with pylint
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-11-jsnow@redhat.com>
 <20200923160119.GJ191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <cc0047ca-cb29-67fa-759d-500d226e928c@redhat.com>
Date: Wed, 23 Sep 2020 13:37:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923160119.GJ191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 12:01 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:33PM -0400, John Snow wrote:
>> At this point, that just means using a consistent strategy for constant names.
>> constants get UPPER_CASE and names not used externally get a leading underscore.
>>
>> As a preference, while renaming constants to be UPPERCASE, move them to
>> the head of the file. Generally, it's nice to be able to audit the code
>> that runs on import in one central place.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/common.py | 18 ++++++++----------
>>   scripts/qapi/schema.py | 14 +++++++-------
>>   2 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index e0c5871b10..bddfb5a9e5 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -14,6 +14,11 @@
>>   import re
>>   
>>   
>> +EATSPACE = '\033EATSPACE.'
>> +POINTER_SUFFIX = ' *' + EATSPACE
>> +_C_NAME_TRANS = str.maketrans('.-', '__')
> 
> IMO _C_NAME_TRANS is solely the concern of the c_name() function, and
> should not be a global.  If you're concerned with speed (which I don't
> think you should) you could still do:
> 

It's true, but that's why it's marked internal here with the leading 
underscore -- it will not be exported. It was also *already* defined at 
the module level, I didn't hoist it.

I think what is written here is already the simplest thing that works.

>     def c_name(name, protect=True,
>                name_translation=str.maketrans('.-', '__')):
>        ...
>        name = name.translate(name_translation)
> 
> Keeping in mind that you're adding a mutable type to a function
> argument *on purpose*.  I'd really favor having that statement within
> the only function that uses it, though.
> 

That complicates the signature, so I think we shouldn't.

--js


