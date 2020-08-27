Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8037C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF68520786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gndTFX27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF68520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9gO-000870-0F
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kB9fq-0007en-8p
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:38:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kB9fn-00029Q-6y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598503081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoZ5eCPxOpi4H0Yt+NNUEiziYWya+ri+No+HNY84FmU=;
 b=gndTFX275Dazrsgw6Svyu863A3qzv1z65RQyQ9eF3TKMQxuxuuNKgZakmaW3pgzJE5DB5y
 fd8rklmyjq4qxaUC99zgAbzCUvVXTEjnWY0oLTa7D4ePfGJeVtBnUO89lRnfsIHwAtQpCc
 Bg5i0CjgHGU2UQHiRLwNhHy4qH9PGrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Iapd6WfwPcGMij10nSCIAg-1; Thu, 27 Aug 2020 00:37:55 -0400
X-MC-Unique: Iapd6WfwPcGMij10nSCIAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC3CD189E627;
 Thu, 27 Aug 2020 04:37:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2E210027AB;
 Thu, 27 Aug 2020 04:37:53 +0000 (UTC)
Subject: Re: Contributor wanting to get started with simple contributions
To: Rohit Shinde <rohit.shinde12194@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15d81509-81d4-d583-16c6-3407efd26f12@redhat.com>
Date: Thu, 27 Aug 2020 06:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/2020 17.00, Rohit Shinde wrote:
> Hey Thomas,
> 
> I didn't really have any specific questions. I wanted to know if there
> was any part of qemu that I could contribute to. Qemu is overwhelmingly
> vast and without some pointers, I felt very lost.

Ok, that's true - QEMU is really a huge project. I'd really recommend to
pick some topics from https://wiki.qemu.org/Contribute/BiteSizedTasks
first to get a feeling for contributing patches to QEMU. Since you're
interested in emulation, maybe the topics from the "Device models"
section would also be a good fit?

>     >     I plan to stay and become a long term contributor. Is there any CS
> 
>     What does "CS" stand for?
> 
> Computer Science :) 

Oh, well, thanks, ok, that was too easy. I guess there are just too many
abbreviations around ;-)

> 
>     >     theory that I would need to know other than what I mentioned
>     above?

I'd recommend to browse the various KVM forum presentations on
http://www.linux-kvm.org/page/Category:Conferences to see if there is
something that catches your eye. You can find the recordings of most
presentations on
https://www.youtube.com/channel/UCRCSQmAOh7yzgheq-emy1xA , too.

>     >     Is it possible to "learn on the go"?
> 
>     You certainly have to "learn on the go", since it is likely quite
>     impossible to grasp a huge project like QEMU at once.
> 
> I am interested in contributing to something like device emulation.
> There might be lots of devices which Qemu might want to emulate but
> which haven't yet been emulated.
Sure, but I think you first need a target you're interested in first.
E.g. do you want to focus on x86, ARM, PPC, m68k, ... ? Depending on
that, you can start looking around in the hw/ directory for "missing" or
"TODO" items.

 Thomas


