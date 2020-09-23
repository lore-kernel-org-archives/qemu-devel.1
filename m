Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E900420637
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReMoK4ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E900420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9nC-0005AQ-NU
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL9Oh-0005Po-53
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL9Oe-0008Hi-QO
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600885299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nv9DphQP/BG0LuHcdhl8wRmT00DjDxCCEc9e9Ei//+s=;
 b=ReMoK4adHNShLe7d+1sVVZFnsdBDZW1KR3u0mS58Efr+3+G2P/ErxlGz/wZU5r94/kV/HP
 ye61+ZONX1wL04aVeQMVx3s0XQoATLVEynQIq2Uzg8ZyrY8ZXYLH1sKTKt5dRoPxrvSTJ5
 +qL9FkdGgSdCmrgS9exz5rlBqfDRSPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-DAp6dmAsNQeEcwI25wZKXg-1; Wed, 23 Sep 2020 14:21:37 -0400
X-MC-Unique: DAp6dmAsNQeEcwI25wZKXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B09B800597;
 Wed, 23 Sep 2020 18:21:36 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6725576A;
 Wed, 23 Sep 2020 18:21:35 +0000 (UTC)
Subject: Re: [PATCH v2 18/38] qapi/events.py: Move comments into docstrings
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-19-jsnow@redhat.com>
 <20200923144819.GE3312949@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6a3663e-022c-d11e-38a5-78c32e1eba70@redhat.com>
Date: Wed, 23 Sep 2020 14:21:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923144819.GE3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 10:48 AM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:00:41PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/events.py | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index 00a9513c16..e859fd7a52 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -52,8 +52,10 @@ def gen_event_send_decl(name: str,
>>                    proto=build_event_send_proto(name, arg_type, boxed))
>>   
>>   
>> -# Declare and initialize an object 'qapi' using parameters from build_params()
>>   def gen_param_var(typ: QAPISchemaObjectType) -> str:
>> +    """
>> +    Declare and initialize a qapi object, using parameters from `build_params`.
> 
> The mention of "object 'qapi'" is gone, and this seems correct
> because there's no object called 'qapi' anywhere in this
> function.  So:
>  > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Comments/questions for follow up patches, because it's beyond the
> scope of this series:
> 
> - Was the doc string supposed to say "an object 'param'" instead
>    of "an object 'qapi'", as that's the name of the variable it
>    declares?
> - The "using parameters from build_params()" part was confusing to
>    me.  I thought it meant gen_param_var() would call build_params().
>    I took a while to notice it actually meant "using the C
>    function parameters that were previously declared using
>    build_params() at build_event_send_proto()".  I don't know
>    how we could make it clearer.
> 

Good questions for Markus.

(By the way, Markus: I do intend to remove the "missing-docstring" 
warning from the exceptions, and at such time we can have a party 
writing docstrings for everything.

I intend to devote an entire series to doing this during the release 
window.)

--js

>> +    """
>>       assert not typ.variants
>>       ret = mcgen('''
>>       %(c_name)s param = {
>> -- 
>> 2.26.2
>>
> 


