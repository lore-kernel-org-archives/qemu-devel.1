Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1AC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABF02084C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaskzTZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABF02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNhO8-0005uo-2N
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 15:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNhNT-0005VN-Dg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNhNQ-00036l-Vq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:02:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601492575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Lx5n93EJG6DO0amlXI0CJkmd9GvfZUar2WyDmuPxh4=;
 b=BaskzTZaA5eCPIxoee+wMCHH4+IAx3i7E2rCuFym2a4p1zu+9o0Qv/LGBHjRC2g93iPmHK
 iF2FU4z4BQvMnq7bmHofgpwtHu9tUpalLuCdPvAmuYDpu14ho3KqwqfP3CUPjAXzQTbVLm
 1XHWxjuTn+P6/cD5whcOdJzI1oCQBvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-7645-dH5Ps-qGMOOhWJNxA-1; Wed, 30 Sep 2020 15:02:52 -0400
X-MC-Unique: 7645-dH5Ps-qGMOOhWJNxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A20186DD3C;
 Wed, 30 Sep 2020 19:02:51 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7F11001281;
 Wed, 30 Sep 2020 19:02:49 +0000 (UTC)
Subject: Re: [PATCH v4 39/46] qapi/introspect.py: Unify return type of
 _make_tree()
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-40-jsnow@redhat.com>
 <20200930182408.GV3717385@habkost.net>
 <20fa2354-e65b-0849-78e1-687a248b329b@redhat.com>
 <20200930185756.GZ3717385@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <74df6745-0628-7845-3d93-4d9f0c0d5ab2@redhat.com>
Date: Wed, 30 Sep 2020 15:02:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930185756.GZ3717385@habkost.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 2:57 PM, Eduardo Habkost wrote:
> On Wed, Sep 30, 2020 at 02:32:49PM -0400, John Snow wrote:
>> On 9/30/20 2:24 PM, Eduardo Habkost wrote:
>>> On Wed, Sep 30, 2020 at 12:31:43AM -0400, John Snow wrote:
>>>> Returning a *something* or a Tuple of *something* is hard to accurately
>>>> type. Let's just always return a tuple for structural consistency.
>>>>
>>>> Instances of the 'TreeNode' type can be replaced with the slightly more
>>>> specific 'AnnotatedNode' type.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>
>>> So, the only place where this seems to make a difference is
>>> _tree_to_qlit().
>>>
>>> We just need to prove that
>>>     _tree_to_qlit(o, ...)
>>> will have exactly the same result as
>>>     _tree_to_qlit((o, None), ...).
>>>
>>> For reference, this is the beginning of _tree_to_qlit():
>>>
>>> | def _tree_to_qlit(obj: TreeNode,
>>> |                   level: int = 0,
>>> |                   suppress_first_indent: bool = False) -> str:
>>> |
>>> |     def indent(level: int) -> str:
>>> |         return level * 4 * ' '
>>> |
>>> |     if isinstance(obj, tuple):
>>> |         ifobj, extra = obj
>>>
>>> `obj` is the return value of _make_tree()
>>>
>>> `ifobj` is the original `obj` argument to _make_tree().
>>>
>>> |         ifcond = extra.get('if')
>>>
>>> ifcond will be None.
>>>
>>> |         comment = extra.get('comment')
>>>
>>> comment will be None
>>>
>>> |         ret = ''
>>> |         if comment:
>>> |             ret += indent(level) + '/* %s */\n' % comment
>>>
>>> nop
>>>
>>> |         if ifcond:
>>> |             ret += gen_if(ifcond)
>>>
>>> nop
>>>
>>> |         ret += _tree_to_qlit(ifobj, level)
>>>
>>> ret will be '', so this is equivalent to:
>>>
>>>     ret = _tree_to_qlit(ifobj, level)
>>>
>>> which is almost good.
>>>
>>> The only difference seems to that suppress_first_indent=True will
>>> be ignored.  We should pass suppress_first_indent as argument in
>>> the recursive call above, just in case.
>>>
>>
>> This is a really good spot, and I indeed hadn't considered it at all when I
>> did this.
>>
>> (I simply made the change and observed it worked just fine!)
>>
>>> The existing code will behave weirdly if there are comments or
>>> conditions and suppress_first_indent=True, but I suggest we try
>>> to address this issue later.
>>>
>>> |         if ifcond:
>>> |             ret += '\n' + gen_endif(ifcond)
>>>
>>> nop
>>>
>>> |         return ret
>>>
>>
>> Hm, yes, it's a hypothetical case, but perhaps we can use an assertion to
>> help guard against it if development creates that case later by accident.
>>
>> That ought to be good enough for now to not waste time accommodating a
>> (presently) fictional circumstance?
>>
>> Thanks for the good sleuthing here.
> 
> With the current code, both
>    ret += _tree_to_qlit(ifobj, level)
> and
>    ret += _tree_to_qlit(ifobj, level, suppress_first_indent)
> will behave exactly the same.
> 
> The former will behave weirdly if we wrap a dictionary value using
> _tree_node().  We don't do that today.
> 
> The latter will behave weirdly if there's a comment or ifcond
> attached in a dictionary value.  We don't do that today.
> 
> I believe the latter is less likely to be triggered by accident.
> 
> But I'd be happy with either:
> 
>    # _make_tree() shouldn't be use to wrap nodes that
>    # may be printed using suppress_first_indent=True
>    # (in other words, dictionary values shouldn't be wrapped using _make_tree())
>    assert(not suppress_first_indent)
>    ret += _tree_to_qlit(ifobj, level)
> 
> or
> 
>    # we can't add ifcond or comments to nodes that may be
>    # printed using suppress_first_indent=True
>    # (in other words, dictionary values can't have ifcond or comments)
>    assert(not suppress_first_indent or (not comment and not ifcond))
>    ret += _tree_to_qlit(ifobj, level, suppress_first_indent)
> 
> 
> If we have time to spare later, we could do this:
> 
>    def _value_to_qlit(obj: Union[None, str, Dict[str, object], List[object], bool],
>                       level: int = 0,
>                       suppress_first_indent: bool = False) -> str:
>        ...
>        if obj is None:
>            ...
>        elif isinstance(obj, str):
>            ...
>        elif isinstance(obj, list):
>            ...
>        ...
>    
>    def _tree_to_qlit(obj: TreeNode, level: int = 0) -> str:
>        if isinstance(obj, AnnotatedNode):
>           ...
>        else:
>           return _value_to_qlit(obj, level)
> 
> This way, it will be impossible to set suppress_first_indent=True
> on an annotated node.
> 

Maybe it's the right thing to separate out container types from leaf 
types and make this mutually recursive.

I debating doing that earlier, but the patches were already so strangled 
and messy I was afraid of plunging deeper into refactors.

Maybe I'll go take a nap and do it when I wake up. :)

--js


