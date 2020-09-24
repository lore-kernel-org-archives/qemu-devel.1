Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555442220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1tr62Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555442220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX3t-00012u-AB
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLX2g-0008A8-SU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLX2e-0007fa-Vw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:36:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600976192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFTuP+sfBTvJkmgJ2lJKaKE4RExWcMG2EtFJlw580AU=;
 b=T1tr62Yug+nCTOhOiakY5kV02yvco/vY77culzVysnyxIs4/ySlH0DnWHVe6CE0aTXXm6U
 /WYNU86vadUk1Mx2aEWYOiRvP4qGXHMmq5nHrPEpLyTdrE2KM6bSlFxcztVPpdAq30a9ES
 BWWFJymH6CmNeHIvGdPSyPoxO/NRWGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-MTYu1zCqP2adG0-cqeRCig-1; Thu, 24 Sep 2020 15:36:26 -0400
X-MC-Unique: MTYu1zCqP2adG0-cqeRCig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F09D57051;
 Thu, 24 Sep 2020 19:36:25 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37C3B1002C01;
 Thu, 24 Sep 2020 19:36:24 +0000 (UTC)
Subject: Re: [PATCH v2 36/38] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-37-jsnow@redhat.com>
 <20200924191047.GH191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <3f37ab45-fd5b-ad8b-f033-d7887d1d6d93@redhat.com>
Date: Thu, 24 Sep 2020 15:36:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924191047.GH191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/24/20 3:10 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:59PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/visit.py | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 4edaee33e3..180c140180 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -22,7 +22,10 @@
>>       indent,
>>   )
>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>> -from .schema import QAPISchemaObjectType
>> +from .schema import (
>> +    QAPISchemaEnumType,
>> +    QAPISchemaObjectType,
>> +)
>>   
>>   
>>   def gen_visit_decl(name, scalar=False):
>> @@ -84,15 +87,17 @@ def gen_visit_object_members(name, base, members, variants):
>>           ret += gen_endif(memb.ifcond)
>>   
>>       if variants:
>> +        tag_member = variants.tag_member
>> +        assert isinstance(tag_member.type, QAPISchemaEnumType)
>> +
> 
> I'd be interested in knowing why this wasn't left to be handled by the
> type checking only.  Anyway,
> 

QAPISchemaVariants is a container type that is used to house a number of 
QAPISchemaVariant types; but it (can) also take a tag_member to identify 
one of the fields in the variants that can be used to differentiate them.

Now, we assert that tag_member must be a QAPISchemaObjectTypeMember. 
QAPISchemaVariant is also a QAPISchemaObjectTypeMember.

a QAPISchemaObjectTypeMember is a QAPISchemaMember. a QAPISchemaMember 
describes one 'member' of either an enum, a features list, or an object 
member.

Now, the QAPISchemaObjectTypeMember (and not the QAPISchemaMember!) 
serves as a container for a QAPISchemaType -- this is a wrapper type, 
effectively. That contained type can be *anything*, because object 
members can be *anything*.

Oops, but if we zoom back out, we are only able to constrain tag_member 
to being a QAPISchemaObjectTypeMember, we have no expressive power over 
its contained type.

That's why you need the assertion here; because of a loss of specificity 
when we declare tag_member.


"Wow, John, it sounds like you should use a Generic type to be able to 
describe the inner type of a QAPISchemaObjectTypeMember?"

Uh, yup, you're right! I should. But it's complicated, because 
QAPISchemaMember does not have a contained type. Further, the contained 
type of a Member may or may not be known at construction time right now.

It's fixable, and probably involves adding something like a "string 
constant" dummy type to allow QAPISchemaMember to have a contained type.

"Hey, all of that sounds very messy. What if we just added in a few 
assertions for right now while we get the preliminary types in, and then 
we can make adjustments based on what makes the code prettier?"

Sounds like a plan, hypothetical quote person.

> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 


