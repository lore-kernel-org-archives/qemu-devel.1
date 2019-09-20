Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9839C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A73207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A73207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMC7-0006ci-Ls
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBLyr-000214-IW
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBLyo-0008Em-Qz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iBLyo-0008ER-I3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7565A116BB20
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 16:41:57 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA50960606;
 Fri, 20 Sep 2019 16:41:56 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: Kevin Wolf <kwolf@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
Date: Fri, 20 Sep 2019 11:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920083630.GA5458@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 20 Sep 2019 16:41:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: tasleson@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 3:36 AM, Kevin Wolf wrote:
> I/O error inserted by blkdebug can be one-off or permanent, but since it
> also supports using a small state machine, I think you should already be
> able to configure your errors that are corrected by a rewrite, too, even
> if there is no explicit support for this yet (I guess we could add it if
> it turned out to be much easier to use).

One thing I thought about is the feasibility of having a callback for
these errors across qapi.  For example you could register a sector for a
read/write/both and when that operation occurs you would block IO, send
the sector number and associated data across qapi for test code to do
something with it and respond allowing the operation to continue
successfully or by returning an error determined by the external test
code to be propagated to guest.

This would allow the logic to be outside of QEMU.  So for example in the
re-write case the test code could remove the error when it gets the
write, instead of having that logic embedded in QEMU itself.

Thoughts?

> The one thing I see in your series that we can't currently provide this
> way is the exact sector number where the error happened. If you read
> from sector 32 to 64 and there is an error configured for sector 50, you
> just see that the whole request is failing.

Also depending on the device type the data behavior can be different
too.  For SCSI devices I believe the specification states that the data
leading up to the sector in error is transferred to the initiator.  For
ATA I believe this is not true.  My code doesn't model this correctly.
I generated the error before any data was transferred.

I'm thinking changes in blkdebug will need to be done to handle this too?

> I also wonder why you had to write low-level error handling code instead
> of calling the existing error functions. If the existing functions don't
> give the right result in error cases, shouldn't they be fixed anyway?

I would think so too.  I'm using error constants that already exist, but
apparently are not being used anywhere else.


> And then, as John already hinted, adding code for debugging scenarios to
> hot paths that are important for high-performance VMs that don't use any
> debugging is less than optimal.

I agree, the POC code was experimental, but I should have done more
effort in minimizing the run-time costs.

Additionally I think it would be good if QEMU could standardize the
device wwn format to be consistent throughout all block device types,
eg. uint64_t, but maybe not possible.  I also think it would be good to
allow the wwn passed on the command line correlate with what the guest
sees for /sys/block/<device>/device/wwid.

However, I'm assuming that QEMU has the same stance as the linux kernel
with no visible user space breakage?

> 
> So bringing everything together, what would you think of this plan:
> 
> 1. Extend blkdebug with whatever ways you need to trigger I/O errors
>    (only if the existing modes aren't sufficient at least for the start;
>    we can still always extend it later)
> 
> 2. Add a new BlockDriver callback that can return detailed information
>    about an error (such as the exact sector number), and wire it up
>    through BlockBackend (some blk_* function). Implement it in blkdebug.
> 
> 3. In the guest devices, only call the function to get detailed error
>    information in the existing error path. You can then update some
>    device state according to the details if the block driver returned
>    anything (probably only blkdebug will return something).
> 
> This way, we have no changes at all in the hot I/O path if you didn't
> configure your VM with a blkdebug filter. And we avoid duplication of
> code both in the error handler in devices and in the error injection
> mechanisms.

This all sounds good to me.  Although I'm not 100% sure of all the
specific details you are describing at the moment as I'm not that
familiar with the code base.

Thanks!

-Tony




