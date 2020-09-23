Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6E920C56
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QazjD7sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6E920C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEYE-0005kZ-Lp
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLEXH-00059S-Uw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLEXF-000423-DB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAK+4Sk36Ktfh+jIItpAppGyZd2Ti2nDvgZIMh8Jd6E=;
 b=QazjD7smrKHt3F7CiPaoVeolqCn9Ym3y1DUkLhH2oyA823omHWw8gVehSIYR3PnQ9ZjHDq
 STYI9zkcV28Jzxgvu+0gJRuKAp/LJquXNSAeYNCZRw4k0RxykIV/cZtvRqLin/eRaUffsX
 eHfI374p+80iJBjat0cR0S4RgPwNnqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-MxPxM-0dOOmG_4pyS3iIGg-1; Wed, 23 Sep 2020 19:50:47 -0400
X-MC-Unique: MxPxM-0dOOmG_4pyS3iIGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D3D1007464;
 Wed, 23 Sep 2020 23:50:46 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97DC055778;
 Wed, 23 Sep 2020 23:50:45 +0000 (UTC)
Subject: Re: [PATCH v2 21/38] qapi/commands.py: enable checking with mypy
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-22-jsnow@redhat.com>
 <20200923222118.GU191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <2dfefea6-68ac-61e7-ff4f-e1f05f9c6c1a@redhat.com>
Date: Wed, 23 Sep 2020 19:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923222118.GU191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 6:21 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:44PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/mypy.ini | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>> index b668776d94..9da1dccef4 100644
>> --- a/scripts/qapi/mypy.ini
>> +++ b/scripts/qapi/mypy.ini
>> @@ -4,11 +4,6 @@ strict_optional = False
>>   disallow_untyped_calls = False
>>   python_version = 3.6
>>   
>> -[mypy-qapi.commands]
>> -disallow_untyped_defs = False
>> -disallow_incomplete_defs = False
>> -check_untyped_defs = False
>> -
>>   [mypy-qapi.doc]
>>   disallow_subclassing_any = False
>>   disallow_untyped_defs = False
>> -- 
>> 2.26.2
>>
> 
> IMO, this increase of strictness for "commands" would make more sense
> to be squashed together with the previous changes on "commands.py".
> Not only here, but for the other patches for the other modules too.
> 
> Anyway,
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 

Admittedly, the only reason I *didn't* is because these patches have 
been reordered a *lot* and in some cases, it helped me to have distinct 
"This patch is last and enables the checks!" commits.

(I am hedging my bets that more re-ordering is in my future.)

I will squash the "Enable such-and-such" commits with whatever fixed the 
last error for final inclusion, but I might keep them separate for now 
just for my own convenience.

Sorry for the volume.

--js


