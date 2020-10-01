Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A7C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A8720754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx8W3Bb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A8720754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3EX-0006Z2-Qf
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2ry-0003mq-8k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2rv-0008TI-K2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601575190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcUs7n1kr79baMabgMqNNMGAJC9s5UYqp60RcY2S9YI=;
 b=Yx8W3Bb3P5JTi4yk89ZcDXBU6Npa+pHysQF2IDngDkvy3wEGfZ9DGSFYiIEFWP8lVwA7Io
 CB8VGR+rM+RyjE56vMuEsEmvr2hpc8JmjdR+oTXtyrg5fmRCssjERTrNMap3WjpP54o6L3
 9hmKvyL76U1DGHGSXq9FLV21rpbiBtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-cAArgcBHOnih35JUDmiJlQ-1; Thu, 01 Oct 2020 13:59:48 -0400
X-MC-Unique: cAArgcBHOnih35JUDmiJlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63A91007464;
 Thu,  1 Oct 2020 17:59:46 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8125C1CF;
 Thu,  1 Oct 2020 17:59:45 +0000 (UTC)
Subject: Re: [PATCH v4 41/46] qapi/introspect.py: create a typed 'Node' data
 structure
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-42-jsnow@redhat.com>
 <20200930183918.GY3717385@habkost.net>
 <4282f45c-b5e2-6c60-8010-a9858098f395@redhat.com>
 <20200930195215.GA3717385@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <89ba99a2-91fb-592e-ceb5-126d2aa5b01b@redhat.com>
Date: Thu, 1 Oct 2020 13:59:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930195215.GA3717385@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 3:52 PM, Eduardo Habkost wrote:
> On Wed, Sep 30, 2020 at 02:58:04PM -0400, John Snow wrote:
>> On 9/30/20 2:39 PM, Eduardo Habkost wrote:
>>> On Wed, Sep 30, 2020 at 12:31:45AM -0400, John Snow wrote:
>>>> This replaces _make_tree with Node.__init__(), effectively. By creating
>>>> it as a generic container, we can more accurately describe the exact
>>>> nature of this particular Node.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    scripts/qapi/introspect.py | 77 +++++++++++++++++++-------------------
>>>>    1 file changed, 38 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>>>> index 43b6ba5df1f..86286e755ca 100644
>>>> --- a/scripts/qapi/introspect.py
>>>> +++ b/scripts/qapi/introspect.py
>>>> @@ -12,11 +12,12 @@
>>>>    from typing import (
>>>>        Dict,
>>>> +    Generic,
>>>> +    Iterable,
>>>>        List,
>>>>        Optional,
>>>>        Sequence,
>>>> -    Tuple,
>>>> -    Union,
>>>> +    TypeVar,
>>>>    )
>>>>    from .common import (
>>>> @@ -43,42 +44,42 @@
>>>>    # The correct type for TreeNode is actually:
>>>> -# Union[AnnotatedNode, List[TreeNode], Dict[str, TreeNode], str, bool]
>>>> +# Union[Node[TreeNode], List[TreeNode], Dict[str, TreeNode], str, bool]
>>>>    # but mypy does not support recursive types yet.
>>>>    TreeNode = object
>>>> +_NodeType = TypeVar('_NodeType', bound=TreeNode)
>>>>    _DObject = Dict[str, object]
>>>> -Extra = Dict[str, object]
>>>> -AnnotatedNode = Tuple[TreeNode, Extra]
>>>
>>> Do you have plans to make Node replace TreeNode completely?
>>>
>>> I'd understand this patch as a means to reach that goal, but I'm
>>> not sure the intermediate state of having both Node and TreeNode
>>> types (that can be confused with each other) is desirable.
>>>
>>
>> The problem is that _tree_to_qlit still accepts a broad array of types. The
>> "TreeNode" comment above explains that those types are:
>>
>> Node[TreeNode], List[TreeNode], Dict[str, TreeNode], str, bool
>>
>> Three are containers, two are leaf values.
>> of the containers, the Node container is special in that it houses
>> explicitly one of the four other types (but never itself.)
>>
>> Even if I somehow always enforced Node[T] heading into _tree_to_qlit, I
>> would still need to describe what 'T' is, which is another recursive type
>> that I cannot exactly describe with mypy's current descriptive power:
>>
>> INNER_TYPE = List[Node[INNER_TYPE]], Dict[str, Node[INNER_TYPE]], str, bool
>>
>> And that's not really a huge win, or indeed any different to the existing
>> TreeNode being an "object".
>>
>> So ... no, I felt like I was going to stop here, where we have
>> fundamentally:
>>
>> 1. Undecorated nodes (list, dict, str, bool) ("TreeNode")
>> 2. Decorated nodes (Node[T])                 ("Node")
>>
>> which leads to the question: Why bother swapping Tuple for Node at that
>> point?
>>
>> My answer is simply that having a strong type name allows us to distinguish
>> this from garden-variety Tuples that might sneak in for other reasons in
>> other data types.
> 
> Would:
>    AnnotatedNode = NewType('AnnotatedNode', Tuple[TreeNode, Extra])
> be enough, then?
> 

I don't think so, because the runtime check still checks for tuple. I 
like the consistency and simplicity of a named type.

>>
>> Maybe we want a different nomenclature though, like Node vs AnnotatedNode?
> 
> Yes, I believe having a more explicit name would be better.
> 

I give up on introspect.py; I'm dropping it from my series. I cannot 
possibly justify another single second spent here.

--js


