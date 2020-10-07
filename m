Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE204C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B5E216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1+TJpTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B5E216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBYm-0007tw-2L
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBXT-0006uP-Bj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBXR-0005xq-GU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602085172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpGQSgL/tMTYnrcwO4ktwPOEPyrBu7GiAhbsq3PwJhU=;
 b=E1+TJpTNEyQ0fb68gOoGIYD/VV4qdLn/7IZ8nEgRfkv+r3TACNEKSgZEuPZmNopf1WBEOr
 DMN4zEmdrXTc3Wigt86uTO+vscEW1TIE6TF7TLwsQNUzZW2vE5cq6uWLzvA5m1wWfqO7A5
 R9mSxbTAB1Kpo/hOiNOVKRtIG+sAoLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-ZNsEmRZvPRuu_ew-1Ek37Q-1; Wed, 07 Oct 2020 11:39:30 -0400
X-MC-Unique: ZNsEmRZvPRuu_ew-1Ek37Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCAB81F000
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 15:39:29 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0895A1001281;
 Wed,  7 Oct 2020 15:39:28 +0000 (UTC)
Subject: Re: [PATCH v5 19/36] qapi/events.py: add type hint annotations
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-20-jsnow@redhat.com>
 <87zh4ye0fh.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb656a3c-a92e-f934-5294-a4230842e322@redhat.com>
Date: Wed, 7 Oct 2020 11:39:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh4ye0fh.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:32 AM, Markus Armbruster wrote:
> Ignorant question: what's the difference between -> None (like here) and
> nothing (like __init__() above?

This came up in Cleber's review, too.

Mypy supports a gradual typing paradigm; it is designed to facilitate 
what we are doing here: the gradual adding of types until we are able to 
enforce static typing everywhere.

To that end, mypy uses a simple heuristic to determine if a function is 
"typed" or "untyped": did you use any type annotations for it?

Meanwhile, __init__ never returns anything. You do not need to annotate 
its return type. mypy knows what the return type is and must be. In the 
case of __init__ with no parameters, it is both untyped and strictly typed!

Annotating the return type for no-parameter init methods convinces mypy 
that this is a strictly typed method. It doesn't do this automatically, 
because doing so might enable more checks than you were ready for simply 
because mypy was able to accurately surmise the typing of just __init__.

So it's just a little flip switch to enable strict typing, really.

--js

https://mypy.readthedocs.io/en/stable/class_basics.html#annotating-init-methods


