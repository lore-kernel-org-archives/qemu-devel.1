Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E59222AAB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2NEaSti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E59222AAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaEw-0002dg-1x
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIaCl-0000xH-3e
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIaCj-0000CG-1W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600273361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGtlFQVIq3jnMfePomStNiA0xNws0k776rzhyJtsaK4=;
 b=c2NEaStiGK2uuo01tTWDM+L1W3FJ0+eFylRJZdDdUTI0ngkUAeytHuF7NagarnyTalABL9
 NpY7HOnjNWn24Wz9lvS2o2fkzV/zRBLmbIOestyiw3L0VK9uEA1pNSQDeOpxJfkKgwFy6d
 2UajmbenSINABwoQ+vZECdVFmpPJAVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-s6_qUZdqNO-zf9F70APcxg-1; Wed, 16 Sep 2020 12:22:40 -0400
X-MC-Unique: s6_qUZdqNO-zf9F70APcxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC852801AAB
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:22:38 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27B7519728;
 Wed, 16 Sep 2020 16:22:37 +0000 (UTC)
Subject: Re: Python docstrings and licensing/authorship
To: Christophe de Dinechin <cdupontd@redhat.com>
References: <361aad7f-c2a3-524e-bd5a-2fc1fa6fe38a@redhat.com>
 <5C5765B1-3E0F-4577-B7B3-8BFFCB2D936F@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d6b98fa9-ee29-a9d3-c3e7-30ae84b8e4cd@redhat.com>
Date: Wed, 16 Sep 2020 12:22:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5C5765B1-3E0F-4577-B7B3-8BFFCB2D936F@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 12:05 PM, Christophe de Dinechin wrote:
> 
> 
>> On 16 Sep 2020, at 17:47, John Snow <jsnow@redhat.com> wrote:
>>
>> For some of the Python cleanup work I am doing, I am moving preamble comments into docstrings. These docstrings are visible in interactive editors and may be visible when using Sphinx to generate documentation manuals for Python code.
>>
>> My instinct is to remove the licensing and authorship information from the preamble and leave the docstring only with information functionally relevant to the module, while leaving licensing and authorship information in a comment (above? below?).
>>
>> The end effect would be that using e.g. `help(qapi.parser)` in the interactive Python shell would not show licensing or copyright for the module, but it would still be visible in the source file, as always.
>>
>> Is this in bad taste? Do we have strong feelings about authorship and licensing being visible in help output and generated documentation?
> 
> What about putting that in a separate pseudo-entity, so that help(copyright) would show it?
> 

help is a Python builtin that shows metadata about an object. If an 
object has a docstring, it is capable of displaying that as part of the 
help output. I'm not sure what type you are suggesting `copyright` to be.

So, you could do something like:

__copyright__ == """
Copyright (C) 2020 John Snow, for Red Hat Inc.
"""

And you could then theoretically do:

 >>> import qapi
 >>> qapi.__copyright__

which will show you that information. However, I don't think there's any 
standard for module-level metadata like this, so the odds of this 
information being seen or used is low.

Python has some standards for package-level metadata, but I don't think 
there are any standards for module-level metadata *except* the __doc__ 
attribute -- which is where the module-level docstring goes when we 
write one.

The real question I have is if anyone thinks it would be "rude" to 
separate out any of the comment preambles (currently not visible at 
runtime or docs in any way, shape or form!) into two pieces:

1. Functional stuff relating to the usage of the module, visible in 
help(module_name), visible in generated docs, visible in IDE popups, etc.

2. Authorship/copyright and licensing info, not visible in the above places.

>>
>> --js
>>
>>
> 


