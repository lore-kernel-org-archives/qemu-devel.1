Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D05C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4236020739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaTSG+c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4236020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQGO-0002Yy-RP
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQEV-0001k3-OM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQES-0005Kn-Dp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602141655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKx+y68MYKxYyHAUO9CjNvJad15NOVNgKltVUv2ojOE=;
 b=KaTSG+c5mNFZswhfFKQ7c5RQlsGYrfap5V0JTTwlizEVSboghAdb9eCXhURJBQNQ+8FCb1
 ARGDZbVTnZ0jIN7avzMn86yUt9Wo3a6hwoERolPDiJlOj7kw+yiHOFuB1bWZz64Mrm9qyl
 jGmQl5xOZuEp/Mo1L6XwDOcI9fWNVsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-QSa73SRfPs2MnskYmzGxMw-1; Thu, 08 Oct 2020 03:20:52 -0400
X-MC-Unique: QSa73SRfPs2MnskYmzGxMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7063280BCC8
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 07:20:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F03B5C1C2;
 Thu,  8 Oct 2020 07:20:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFB5911329C1; Thu,  8 Oct 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 16/36] qapi/common.py: Convert comments into
 docstrings, and elaborate
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-17-jsnow@redhat.com>
 <87zh4ygzzb.fsf@dusky.pond.sub.org>
 <762ffec5-088f-8f25-b298-99e50abe7909@redhat.com>
Date: Thu, 08 Oct 2020 09:20:49 +0200
In-Reply-To: <762ffec5-088f-8f25-b298-99e50abe7909@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 11:23:07 -0400")
Message-ID: <874kn5420e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 5:14 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> As docstrings, they'll show up in documentation and IDE help.
>>>
>>> The docstring style being targeted is the Sphinx documentation
>>> style. Sphinx uses an extension of ReST with "domains". We use the
>>> (implicit) Python domain, which supports a number of custom "info
>>> fields". Those info fields are documented here:
>>> https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#info-field-lists
>>>
>>> Primarily, we use `:param X: descr`, `:return[s]: descr`, and `:raise[s]
>>> Z: when`. Everything else is the Sphinx dialect of ReST.
>>>
>>> (No, nothing checks or enforces this style that I am aware of. Sphinx
>>> either chokes or succeeds, but does not enforce a standard of what is
>>> otherwise inside the docstring. Pycharm does highlight when your param
>>> fields are not aligned with the actual fields present. It does not
>>> highlight missing return or exception statements. There is no existing
>>> style guide I am aware of that covers a standard for a minimally
>>> acceptable docstring. I am debating writing one.)
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   scripts/qapi/common.py | 53 +++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 39 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>> index 74a2c001ed9..0ef38ea5fe0 100644
>>> --- a/scripts/qapi/common.py
>>> +++ b/scripts/qapi/common.py
>>> @@ -15,15 +15,24 @@
>>>   from typing import Optional, Sequence
>>>     
>>> +#: Sentinel value that causes all space to its right to be removed.
>> What's the purpose of : after # ?
>> 
>
> Documents this name in Sphinx. We had a small discussion about it, I
> think; "Does using this special form or the docstring make the comment 
> visible in any IDE?" (No.)
>
> There's no Python-AST way to document these, but there is a Sphinx way
> to document them, so I did that.
>
> (Doing it like this allows `EATSPACE` to be used as a cross-reference.)

Thanks.

Consider pointing this out when you write the comment & doc string part
of our Python style guide.

>> I'm not sure this is a "sentinel value".  Wikipedia:
>>      In computer programming, a sentinel value (also referred to as a
>>      flag value, trip value, rogue value, signal value, or dummy data)[1]
>>      is a special value in the context of an algorithm which uses its
>>      presence as a condition of termination, typically in a loop or
>>      recursive algorithm.
>>      https://en.wikipedia.org/wiki/Sentinel_value
>> 
>
> I really should try to learn English as a second language so I know
> what any of the words I use mean, I guess. I had slipped to a less
> strict usage where it meant more like "placeholder".
>
>> Perhaps
>>     # Magic string value that gets removed along with all space to
>> the
>>     # right.
>> 
>
> This can be written on one line if we gently disregard the 72 column
> limit. (Maybe you already did when you wrote it and my client wrapped 
> it. Who knows!)

Drop the period and it fits ;-P

You could also drop "value" without loss.

[...]


