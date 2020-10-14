Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86641C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598BB2222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeNem4KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598BB2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSl4D-0006NY-6Z
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSl3W-0005wp-U3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSl3U-0007h8-VP
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iQUXCLIeeivDB5OM/KwSr1w/C9+M7AE/5ZlJeLIVzU=;
 b=YeNem4KXDaGXaSqUHC6Z8xlTL3CdPlxqSjWz56GEon9W0kaw8BdrhcR4yY4KAmhSqcSDij
 d666v6XeH5dsJQzosUIebkaJ295VGpDX+oA/DSiWHD6Jr7zBll2Y5Pg5LH2rIwoqTIs7cC
 z00fYSmkUsfhLqbNYpsQkrWEskAuocI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-MZYGuOdVMYSHxrFIBXU1ug-1; Wed, 14 Oct 2020 13:59:12 -0400
X-MC-Unique: MZYGuOdVMYSHxrFIBXU1ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 920F2101EBEC;
 Wed, 14 Oct 2020 17:59:11 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E619455763;
 Wed, 14 Oct 2020 17:59:10 +0000 (UTC)
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
 <09b8a63d-06ab-4846-cbc0-69bd95ca8ead@redhat.com>
 <CA+Ai=tCvVsUNuNZo-gMmsMaQtn+H6CqGstMGhuDgm8rNsf7V5A@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d5901da0-e1b7-af23-36db-80f4a0ac0e28@redhat.com>
Date: Wed, 14 Oct 2020 13:59:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tCvVsUNuNZo-gMmsMaQtn+H6CqGstMGhuDgm8rNsf7V5A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: crosa@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 2:46 PM, Rohit Shinde wrote:
> Hey John,
> 
> Sorry for the late reply! I was in the midst of a job change and 
> couldn't get time to get to this.
> 
> The work sounds interesting! I have a couple of questions regarding this:
> 
>  1. How do I actually build this part? I am familiar with building and
>     using QEMU. Does the qapi parser get built along with the main code?

It's python, so it doesn't get built. It's in ./scripts/qapi/. It is 
invoked by the build machinery to turn the files in ./qapi into C files 
that get built into QEMU.

Try "make check-qapi-schema" to see this stuff run and get tested.

>  2. If not, how do I start using this part and contributing to it?

Depends on what you want to actually try to do, what interests you, what 
your goals are, etc. Some of the various Python-related tasks that I am 
working on right now are laid out below.

> 
> 
> Thanks,
> Rohit.
> 
> On Tue, Sep 29, 2020 at 9:38 PM John Snow <jsnow@redhat.com 
> <mailto:jsnow@redhat.com>> wrote:
> 
>     On 9/2/20 12:38 PM, Rohit Shinde wrote:
>      > Hey John,
>      >
>      > I wanted to follow up on this, in case you missed my previous
>     email :)
>      >
>      > Thanks,
>      > Rohit.
>      >
> 
>     Sorry Rohit, very buried in my work and haven't been doing a good job
>     with my inbox.
> 
>     Right now, I am working on converting the QAPI parser module to the
>     strictly typed mypy subset:
> 
>     https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09136.html
> 
>     There are six parts in all, that is part one. I am posting a v4 right
>     now as I write this.
> 

Part one is now merged; parts 2-6 remain.

> 
>     Work that remains to be done after these six parts:
> 
>     - Get ./python/qemu passing under mypy/pylint/flake8 again. I have old
>     patches for this that were on-list prior to the 5.1 release.
> 

This part is done, or mostly done.

>     - Move ./scripts/qapi to ./python/qemu/qapi/
> 

Still pending parts 2-6 of the QAPI cleanup.

>     - Move ./python/qemu to ./python/qemu/core/
> 

Patches on list to do this.

>     - Create a "make check" style script that will run
>     mypy/pylint/flake8/isort on all the code in ./python. (I have patches
>     for this, too.)
> 

Need to resurface old patches to do this. I have a draft that was sent 
to the list prior to 5.1, but haven't touched it since.

>     - Start investigating python scripts in ./scripts and consider moving
>     them to ./python/qemu/tools, fixing them up to pass
>     mypy/flake8/pylint/isort (etc) as I go. There are no existing
>     patches to
>     do this yet.
> 

I started porting ./scripts/qmp very recently. It is based off of my 
python maintainer's branch.

> 
>     Other work I am doing:
> 
>     - Investigating the use of Pydantic to replace ./scripts/qapi/expr.py
>     - Investigating a YAML format for the QAPI parser
>     - Building a JSON-SCHEMA output format for the QAPI generator
> 

Various half-finished drafts exist only on my computer for these.

I also have some very rough prototype work to create an asynchronous QMP 
client in python.

> 
>      > On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde
>      > <rohit.shinde12194@gmail.com <mailto:rohit.shinde12194@gmail.com>
>     <mailto:rohit.shinde12194@gmail.com
>     <mailto:rohit.shinde12194@gmail.com>>> wrote:
>      >
>      >     Hey John,
>      >
>      >     Sorry to bother you! I just wanted to know if you had any
>     thoughts
>      >     on the mail I sent.
>      >
>      >     Is there anything I can pick up right now with regards to the
>     Python
>      >     package? You mentioned that linting is something that needs to be
>      >     completed before we go ahead, so maybe I can start with that?
>      >
>      >     Thanks,
>      >     Rohit.
>      >
> 


