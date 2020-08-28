Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B5C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 04:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6772080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 04:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfOn1FFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6772080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBVnx-0006gQ-Ij
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 00:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBVnG-0006EC-NM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 00:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBVnD-0001l1-PH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 00:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598588109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2hnZGG9Ewd9zLHv32UUcBtZ5VkiXc8exnlvWQYlOR4=;
 b=IfOn1FFFqs040596l35W0tMHIYxp5Luso50tJeYAiTznJHhujLzmDxzx1iO8rtXKf6nzRd
 lJlMOYAUC/AyYgppWGhdTcvx7gbKh3WgBj6XW+YqEeDyfCAUqCVY7HTpeFr1cLftDbVeKq
 ltB3p16S1DEsMtOAtCWmLGLyC7NMhIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-eUDNUOhFNee0cYrfXe2LwA-1; Fri, 28 Aug 2020 00:15:02 -0400
X-MC-Unique: eUDNUOhFNee0cYrfXe2LwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FBCB802B6B;
 Fri, 28 Aug 2020 04:15:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9355E1001B2B;
 Fri, 28 Aug 2020 04:15:00 +0000 (UTC)
Subject: Re: Contributor wanting to get started with simple contributions
To: Rohit Shinde <rohit.shinde12194@gmail.com>
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
 <15d81509-81d4-d583-16c6-3407efd26f12@redhat.com>
 <CA+Ai=tBJ+Z9ETMLu4muhA40F6V7OAjWC7-SyB+k7GDsHvYj4WQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96db61bb-47bd-e57c-11c8-3412e8ca4a96@redhat.com>
Date: Fri, 28 Aug 2020 06:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tBJ+Z9ETMLu4muhA40F6V7OAjWC7-SyB+k7GDsHvYj4WQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 00:15:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 28/08/2020 02.49, Rohit Shinde wrote:
> Hey Thomas,
> 
> Thanks for the in-depth response! I appreciate it a lot!
> 
> 
> 
> On Wed, Aug 26, 2020 at 9:38 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 26/08/2020 17.00, Rohit Shinde wrote:
>     > Hey Thomas,
>     >
>     > I didn't really have any specific questions. I wanted to know if there
>     > was any part of qemu that I could contribute to. Qemu is
>     overwhelmingly
>     > vast and without some pointers, I felt very lost.
> 
>     Ok, that's true - QEMU is really a huge project. I'd really recommend to
>     pick some topics from https://wiki.qemu.org/Contribute/BiteSizedTasks
>     first to get a feeling for contributing patches to QEMU. Since you're
>     interested in emulation, maybe the topics from the "Device models"
>     section would also be a good fit?
> 
>     >     >     I plan to stay and become a long term contributor. Is
>     there any CS
>     >
>     >     What does "CS" stand for?
>     >
>     > Computer Science :) 
> 
>     Oh, well, thanks, ok, that was too easy. I guess there are just too many
>     abbreviations around ;-)
> 
>     >
>     >     >     theory that I would need to know other than what I mentioned
>     >     above?
> 
>     I'd recommend to browse the various KVM forum presentations on
>     http://www.linux-kvm.org/page/Category:Conferences to see if there is
>     something that catches your eye. You can find the recordings of most
>     presentations on
>     https://www.youtube.com/channel/UCRCSQmAOh7yzgheq-emy1xA , too.
> 
>     >     >     Is it possible to "learn on the go"?
>     >
>     >     You certainly have to "learn on the go", since it is likely quite
>     >     impossible to grasp a huge project like QEMU at once.
>     >
>     > I am interested in contributing to something like device emulation.
>     > There might be lots of devices which Qemu might want to emulate but
>     > which haven't yet been emulated.
>     Sure, but I think you first need a target you're interested in first.
>     E.g. do you want to focus on x86, ARM, PPC, m68k, ... ? Depending on
>     that, you can start looking around in the hw/ directory for "missing" or
>     "TODO" items.
> 
> I am pretty familiar with the x86 architecture since I have worked with
> processors right from 8086 to the Pentium line of processors. I have a
> nice familiarity with x86_64. I have a passing familiarity with ARM and
> SPARC architectures, but not much more. So I think I would like to focus
> on the x86 architecture. I'll poke around the hw/ directory. Please feel
> free to give me pointers in the meanwhile.
> 
> Since I am new to the community, I wanted to make sure if it is fine if
> I post general questions to the mailing list and copy you?

Sure, but I'm not the right guy for x86 ;-) It's often a good idea to
have a look at the MAINTAINERS file to find people who you could put on
CC: for specific topics.

 Thomas


