Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45422075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcVo48sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45422075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNU8I-0004DG-Sf
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTsf-0000ll-VO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTsd-00010i-Lv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTZcTgnuHmoGLt6FRxwTE9t0eG/X23KaLgeJoGEHm5c=;
 b=XcVo48skowruXizX83xynFmavX/kFiAnvX/h4PQEaYBo1IUsRggmtwA4XB0nJfoKkWcoQh
 BTNHrMb25ZSx1yavOr6aZxiKqLwK2hLc9NNnPJCvnGQXMCeDkh+vmagJ/6oIvybzZLDDX5
 vhwlQH9QUp5XKGfdPOv9D+uM+nlgUnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-JUxPrfaJMWiNivn-FWvptw-1; Wed, 30 Sep 2020 00:38:09 -0400
X-MC-Unique: JUxPrfaJMWiNivn-FWvptw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2AA1074653;
 Wed, 30 Sep 2020 04:38:08 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC33F6198B;
 Wed, 30 Sep 2020 04:38:07 +0000 (UTC)
Subject: Re: Contributor wanting to get started with simple contributions
To: Rohit Shinde <rohit.shinde12194@gmail.com>
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
 <a50f47d2-f5c6-49c0-779f-dfcaf05df5f9@redhat.com>
 <CA+Ai=tCDHWBLNToQ2HqMVmJtXxKzP40AuDqfWc=YQV3mggcc4Q@mail.gmail.com>
 <CA+Ai=tAVxNRNN1EP8LorOsYBm01f0ekmKCnMfcNH_eSqk5pFzg@mail.gmail.com>
 <CA+Ai=tBtSqigWwB4HNeZ8CT4JMEMBU2eEd47BCs2-QCEeBEARw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <09b8a63d-06ab-4846-cbc0-69bd95ca8ead@redhat.com>
Date: Wed, 30 Sep 2020 00:38:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tBtSqigWwB4HNeZ8CT4JMEMBU2eEd47BCs2-QCEeBEARw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 12:38 PM, Rohit Shinde wrote:
> Hey John,
> 
> I wanted to follow up on this, in case you missed my previous email :)
> 
> Thanks,
> Rohit.
> 

Sorry Rohit, very buried in my work and haven't been doing a good job 
with my inbox.

Right now, I am working on converting the QAPI parser module to the 
strictly typed mypy subset:

https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09136.html

There are six parts in all, that is part one. I am posting a v4 right 
now as I write this.


Work that remains to be done after these six parts:

- Get ./python/qemu passing under mypy/pylint/flake8 again. I have old 
patches for this that were on-list prior to the 5.1 release.

- Move ./scripts/qapi to ./python/qemu/qapi/

- Move ./python/qemu to ./python/qemu/core/

- Create a "make check" style script that will run 
mypy/pylint/flake8/isort on all the code in ./python. (I have patches 
for this, too.)

- Start investigating python scripts in ./scripts and consider moving 
them to ./python/qemu/tools, fixing them up to pass 
mypy/flake8/pylint/isort (etc) as I go. There are no existing patches to 
do this yet.


Other work I am doing:

- Investigating the use of Pydantic to replace ./scripts/qapi/expr.py
- Investigating a YAML format for the QAPI parser
- Building a JSON-SCHEMA output format for the QAPI generator


> On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde 
> <rohit.shinde12194@gmail.com <mailto:rohit.shinde12194@gmail.com>> wrote:
> 
>     Hey John,
> 
>     Sorry to bother you! I just wanted to know if you had any thoughts
>     on the mail I sent.
> 
>     Is there anything I can pick up right now with regards to the Python
>     package? You mentioned that linting is something that needs to be
>     completed before we go ahead, so maybe I can start with that?
> 
>     Thanks,
>     Rohit.
> 


