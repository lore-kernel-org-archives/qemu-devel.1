Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BE0208B6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNpVV6EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BE0208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9ir-00017q-AS
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL9f6-0005aa-Uo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL9f4-0001k5-Fn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600886317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3YZf1N2hTwQqMPXb/r8Ufmbr49JcHElIvN8R0w/+LY=;
 b=MNpVV6ECuhCeoak/eeJHic5Z73eo6zf7T9vO6YBWcWMp/1H+BiiHr2z2v/WmoznzhoS0XP
 qz1WEkNSefRyUtHPx1Kc5EVS4g0IZNScfRslTORIEScECG9utQXkHL3rVruHZedbOPXolF
 GcEf2kxzLv8WlloU8LVrut6Cz5Yhz/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-9quG1IOoOaC4Ob5SvHFxdw-1; Wed, 23 Sep 2020 14:38:33 -0400
X-MC-Unique: 9quG1IOoOaC4Ob5SvHFxdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8926D1007464;
 Wed, 23 Sep 2020 18:38:32 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1123260BEC;
 Wed, 23 Sep 2020 18:38:30 +0000 (UTC)
Subject: Re: [PATCH v2 29/38] qapi/gen.py: delint with pylint
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-30-jsnow@redhat.com>
 <20200923154456.GQ3312949@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <28c8b2b8-1138-9ec8-2a4f-ccd250f59436@redhat.com>
Date: Wed, 23 Sep 2020 14:38:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923154456.GQ3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 11:44 AM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:00:52PM -0400, John Snow wrote:
>> 'fp' and 'fd' are self-evident in context, add them to the list of OK
>> names.
>>
>> _top and _bottom also need to stay class methods because some users
>> override the method and need to use `self`. Tell pylint to shush.
> 
> Do you mean "stay instance methods"?
> 

Yep. Fixed, thank you.

> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 

Thanks!

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/gen.py   | 2 ++
>>   scripts/qapi/pylintrc | 5 +++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index cf340e66d4..ed498397ad 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -50,9 +50,11 @@ def get_content(self) -> str:
>>           return self._top() + self._preamble + self._body + self._bottom()
>>   
>>       def _top(self) -> str:
>> +        # pylint: disable=no-self-use
>>           return ''
>>   
>>       def _bottom(self) -> str:
>> +        # pylint: disable=no-self-use
>>           return ''
>>   
>>       def write(self, output_dir: str) -> None:
>> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
>> index 7438806096..de132d03cf 100644
>> --- a/scripts/qapi/pylintrc
>> +++ b/scripts/qapi/pylintrc
>> @@ -5,7 +5,6 @@
>>   ignore-patterns=doc.py,
>>                   error.py,
>>                   expr.py,
>> -                gen.py,
>>                   parser.py,
>>                   schema.py,
>>                   types.py,
>> @@ -46,7 +45,9 @@ good-names=i,
>>              k,
>>              ex,
>>              Run,
>> -           _
>> +           _,
>> +           fp,  # fp = open(...)
>> +           fd,  # fd = os.open(...)
>>   
>>   [VARIABLES]
>>   
>> -- 
>> 2.26.2
>>
> 


