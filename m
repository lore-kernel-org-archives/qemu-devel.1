Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E86C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5065B2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvO+l6Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5065B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ZH-0001O4-Hg
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO0UG-0005CT-Vt
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO0UE-0001Xb-G1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601566031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OihSq0gt8DpQAhx66TRZDWtQNBr4a2Glg7Mbd5qOFA0=;
 b=fvO+l6QzvyzptVTSJ3qSYSl5sQC0RvNgoDbO7KXx1cwoCNUW87UxqAjeLp6y7OuWJMrNY7
 fCk/OWOEoc1du6fY9PyEcS+C+jDTiorH9rwjI4ju0FFxKu1Gd/HM+hk6GGgZOMY61n9pVJ
 6PZYFYhTyHFmkZCYCSAIb8Vg4n/jXow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-AQeB2n04N_uq3MShYVlwZQ-1; Thu, 01 Oct 2020 11:27:05 -0400
X-MC-Unique: AQeB2n04N_uq3MShYVlwZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 886D610059A9;
 Thu,  1 Oct 2020 15:27:03 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7724A5D9D3;
 Thu,  1 Oct 2020 15:27:02 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
 <87wo0k34qp.fsf@dusky.pond.sub.org>
 <ce23c70a-2e0e-0ca1-5260-812d713f04a8@redhat.com>
 <20200923153707.GP3312949@habkost.net>
 <f0e34f41-ba30-770e-068f-dc6ccc92ed33@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8ce21cbd-2b7a-dbb7-46e3-026621ad0568@redhat.com>
Date: Thu, 1 Oct 2020 11:27:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f0e34f41-ba30-770e-068f-dc6ccc92ed33@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org, crosa@redhat.com, alex.bennee@linaro.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 12:49 PM, Philippe Mathieu-Daudé wrote:
> On 9/23/20 5:37 PM, Eduardo Habkost wrote:
>> On Wed, Sep 23, 2020 at 11:17:01AM -0400, John Snow wrote:
>>> On 9/23/20 11:14 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> I'm proposing that I split the actual Python library off from the other
>>>>> miscellaneous python scripts we have and declare it maintained. Add
>>>>> myself as a maintainer of this folder, along with Cleber.
>>>>>
>>>>> v2: change python/* to python/, thanks Alex.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Acked-by: Cleber Rosa <crosa@redhat.com>
>>>>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> ---
>>>>>    MAINTAINERS | 9 ++++++++-
>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 3d17cad19a..c0222ee645 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -2355,11 +2355,18 @@ S: Maintained
>>>>>    F: include/sysemu/cryptodev*.h
>>>>>    F: backends/cryptodev*.c
>>>>> +Python library
>>>>> +M: John Snow <jsnow@redhat.com>
>>>>> +M: Cleber Rosa <crosa@redhat.com>
>>>>> +R: Eduardo Habkost <ehabkost@redhat.com>
>>>>> +S: Maintained
>>>>> +F: python/
>>>>> +T: git https://gitlab.com/jsnow/qemu.git python
>>>>> +
>>>>>    Python scripts
>>>>>    M: Eduardo Habkost <ehabkost@redhat.com>
>>>>>    M: Cleber Rosa <crosa@redhat.com>
>>>>>    S: Odd fixes
>>>>> -F: python/qemu/*py
>>>>>    F: scripts/*.py
>>>>>    F: tests/*.py
>>>>
>>>> Separate sections just so you can have the appropriate S:, or is there a
>>>> deeper logic behind the split?
>>>>
>>>
>>> Yes, different intended levels of support. I don't currently have the
>>> bandwidth to promise support for the miscellaneous Python scripts in
>>> ./scripts, but I do promise to support to a higher level the code in
>>> ./python.
>>>
>>> Over time, I intend to migrate things into ./python, but there are some
>>> series that need to happen first before I start doing that.
>>
>> Also, the actual owners for most scripts in ./scripts are already
>> listed elsewhere.  I believe we shouldn't really have M: lines
>> for the scripts/*.py section, just R:.
> 
> Agreed. Maybe worth a comment in the section although.
> 

*in* the section? There is no precedent for that. Is this really so 
important?

I'll give you a commit message blurb.

--js


