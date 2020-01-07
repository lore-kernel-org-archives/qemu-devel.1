Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE0C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5192073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR6B8w9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5192073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqsp-00069S-JJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ioqcK-0004r8-4U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ioqcH-0004TG-T7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:17:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ioqcH-0004Sc-Ou
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578410276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTmGWCtRMEvR45OARh5uPFkTrPPwC6PUndYCAhlmKxU=;
 b=UR6B8w9f9htdsWuewHWT39Z9P1n0Vy0VVmKXJKdlD9jOXQfR134n+TL8RYvNPRYl73a5r0
 +TpM04rxyjVhXdKpulv4r/V2woB88MSaCP8MS42Ury7PvEc3cVoJQOau9BMGCE6HUQYRag
 bWD7dSODvAJys6qIlcpdkjpFb7FvW5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-WkmUJgb1OSCyUy7Ut_HnTQ-1; Tue, 07 Jan 2020 10:17:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0665D800D5B;
 Tue,  7 Jan 2020 15:17:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFD6C5D9E5;
 Tue,  7 Jan 2020 15:17:31 +0000 (UTC)
Date: Tue, 7 Jan 2020 16:17:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
Message-ID: <20200107161729.09d84dc4@redhat.com>
In-Reply-To: <4272cf03-cd8a-3a29-b3c2-65788a60b50a@gmx.de>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
 <8ef57947-dba6-9273-0b1e-7f0c052795da@gmx.de>
 <20200106172411.5a6f2efe@redhat.com>
 <a54bf2ab-a0ae-5374-300c-77d7bc926330@gmx.de>
 <20200107122127.4c8ac59d@redhat.com>
 <4272cf03-cd8a-3a29-b3c2-65788a60b50a@gmx.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: WkmUJgb1OSCyUy7Ut_HnTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Sven Schnelle <svens@stackframe.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 12:53:32 +0100
Helge Deller <deller@gmx.de> wrote:

Even though I disagree and it would waste ~256Mb 4Gb of RAM,
I think I should be able to replace #43 with
  "hppa: allow max ram size upto 4Gb"
as it still removes fix up at mapped address space level,
removes fix up of global ram_size variable and adds max size check,

which lets hppa board get out of the way of re-factoring
generic RAM allocation and making what board does with
provided RAM its own business.

> On 07.01.20 12:21, Igor Mammedov wrote:
> > On Mon, 6 Jan 2020 18:03:49 +0100  
> >> So, I'd suggest to drop your wrong patch #43.  
> > As you noted in your first reply, patch is correct.  
> 
> You probably got me wrong.
whichever way I read it
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667855.html
states user convenience as a reason.

> Your patch #43 is wrong, and your fixup patch to some degree reverts it back again.
>
> 
> In patch #43 you error out and stop, which real hardware wouldn't do.
> Real hardware simply ignores the memory which wouldn't be used.
> > All it's doing is validating user input versus RAM size
> > actually supported by the current code, telling user> current supported limit and enforcing it.  
> 
> Real hardware would not tell user.
>
> > I agree it's inconvenience for the users since they
> > won't be able to specify non-sense values and still
> > get board running, but that's clear user error and
> > should be corrected on user side and not by QEMU
> > magically masking wrong CLI values.  
> 
> I disagree.
> Everything worked as expected before, but with *your* change now people
> might need to modify their CLI.
> 4GB is a valid amount of memory which can be plugged into
> the virtual and physical machine.
> It's not magic, it's how the architecture works and you changed it.
>
> > Since it could be fixed on user side, I care less
> > about user convenience when it comes to correctness
> > and unified code.  
> 
> IMHO, you should care about that the emulation works the same
> way as physical machine. 

As for correctness wrt real hardware questions are:
 * is one able to stuff hardware with unsupported 4Gb or more DIMMs,
   will system even work?
 * what real hardware does with top 256Gb of 4Gb RAM if present?
   Is it addressable/accessible in some way by CPUs or devices?
 * how does real firmware discovers amount of installed RAM

[...]


