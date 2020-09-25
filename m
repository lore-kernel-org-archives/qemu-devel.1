Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A597C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB13B21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J49+MyEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB13B21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmu4-0005YN-JE
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLmhl-0001Ms-46
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLmhj-0005d9-Bo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:20:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601036398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEH6VI9EZI0WB7IP/xooniTqfZZCAukTQa6Rslmvrs4=;
 b=J49+MyEcnXsK4+wIper3ZRLsnHhcE7Yz4LRkZnmtE7f0WQ8PbtpBS/tjcAOCS7ptCvEqAr
 vEdIzzNXyeENoBUZYRAFHbn0tC1KFadYyWRpYhf2s1PmIfkS3ECbQio62JLzWZ52bzCZ7h
 cSg8Cd3JYDflMKGiU6qh/0Eoungwn2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-dorw4QlwMU-4oqHqlWWmLQ-1; Fri, 25 Sep 2020 08:19:56 -0400
X-MC-Unique: dorw4QlwMU-4oqHqlWWmLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8820C802EA3;
 Fri, 25 Sep 2020 12:19:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5827060C07;
 Fri, 25 Sep 2020 12:19:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5FC4113865F; Fri, 25 Sep 2020 14:19:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 18/38] qapi/events.py: Move comments into docstrings
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-19-jsnow@redhat.com>
 <20200923144819.GE3312949@habkost.net>
Date: Fri, 25 Sep 2020 14:19:52 +0200
In-Reply-To: <20200923144819.GE3312949@habkost.net> (Eduardo Habkost's message
 of "Wed, 23 Sep 2020 10:48:19 -0400")
Message-ID: <87k0wit5ef.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Sep 22, 2020 at 05:00:41PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  scripts/qapi/events.py | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index 00a9513c16..e859fd7a52 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -52,8 +52,10 @@ def gen_event_send_decl(name: str,
>>                   proto=build_event_send_proto(name, arg_type, boxed))
>>  
>>  
>> -# Declare and initialize an object 'qapi' using parameters from build_params()
>>  def gen_param_var(typ: QAPISchemaObjectType) -> str:
>> +    """
>> +    Declare and initialize a qapi object, using parameters from `build_params`.
>
> The mention of "object 'qapi'" is gone, and this seems correct
> because there's no object called 'qapi' anywhere in this
> function.  So:
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Comments/questions for follow up patches, because it's beyond the
> scope of this series:
>
> - Was the doc string supposed to say "an object 'param'" instead
>   of "an object 'qapi'", as that's the name of the variable it
>   declares?

Checking history... yes.  The variable was renamed from @qapi to @param
during review.

> - The "using parameters from build_params()" part was confusing to
>   me.  I thought it meant gen_param_var() would call build_params().
>   I took a while to notice it actually meant "using the C
>   function parameters that were previously declared using
>   build_params() at build_event_send_proto()".  I don't know
>   how we could make it clearer.

What about:

    Generate a QAPI struct variable holding the event parameters,
    initialized with the function's arguments.

>> +    """
>>      assert not typ.variants
>>      ret = mcgen('''
>>      %(c_name)s param = {
>> -- 
>> 2.26.2
>> 


