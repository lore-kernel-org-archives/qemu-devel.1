Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF38AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BE020658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRq7zmfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BE020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAPy-0001Aw-ND
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEAPH-0000eV-Bv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEAPF-0002EH-9E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:29:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEAPF-0001xn-0j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584444548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBoKto1yqadjDiDiDu3t09uWv+wnMFe33nVllPHtZHI=;
 b=YRq7zmfrkIVtfIX1NMBoTE8s18MkLQ/Xxu1ns8onFVbDu5D6p73ck5R2JzwnRb4P7qexx4
 f+JaxO/l1n0b7tftsdRZWuTi743lZEO9ANhvDZcZp/1JvVm8Euf7ykHXwSlupmDAEwJCwg
 QSBfFBsPuhRb2YW0mO+MyzLxUNPQCO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-TFfK5d1APC-FwW3T5OAbSg-1; Tue, 17 Mar 2020 07:29:06 -0400
X-MC-Unique: TFfK5d1APC-FwW3T5OAbSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917DE800D4E;
 Tue, 17 Mar 2020 11:29:05 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9EC5C1BB;
 Tue, 17 Mar 2020 11:29:05 +0000 (UTC)
Subject: Re: [PATCH v3 12/34] qapi: Add feature flags to remaining definitions
To: Markus Armbruster <armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-13-armbru@redhat.com>
 <a6b5dcd4-6ac7-adef-d3c0-20a6a9748bd3@redhat.com>
 <87a74fv8hk.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <43385d38-0269-dedb-1d20-3952712f3891@redhat.com>
Date: Tue, 17 Mar 2020 06:29:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a74fv8hk.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 12:46 AM, Markus Armbruster wrote:

>>> +++ b/tests/qapi-schema/doc-good.json
>>> @@ -53,10 +53,14 @@
>>>    # @Enum:
>>>    # @one: The _one_ {and only}
>>>    #
>>> +# Features:
>>> +# @enum-feat: Also _one_ {and only}
>     +#
>      # @two is undocumented
>      ##
>      { 'enum': 'Enum', 'data':
>        [ { 'name': 'one', 'if': 'defined(IFONE)' }, 'two' ],
>     +  'features': [ 'enum-feat' ],
>        'if': 'defined(IFCOND)' }
> 
>>
>> All our existing public features are a single word (matching naming
>> conventions elsewhere in QAPI).  Are we sure we want to allow feature
>> names that include whitespace?  Of course, the fact that our testsuite
>> covers it (even if we don't use it publically) means that we are sure
>> that our generator can handle it, regardless of whether we decide that
>> a separate patch should restrict feature names.  But I don't see it
>> holding up this patch.
> 
> We definitely do not want to exempt feature names from the QAPI naming
> rules.
> 
> The code enforces this.  If I change '-' to ' ' in 'features': [
> 'enum-feat' ], I get
> 
>      doc-good.json:61: 'features' member 'enum feat' has an invalid name

Good. I was getting confused between the doc comment (which generally 
should have spaces, rather than being one word) and the feature name 
itself.  Sorry for the distraction.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


