Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFABCA9ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 05:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FB9222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 05:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FB9222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLKhq-0004pt-8g
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 01:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iLKh7-0004Mz-Ru
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 01:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iLKh6-0003UV-LI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 01:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iLKh6-0003U5-Fx; Fri, 18 Oct 2019 01:20:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F07C069084;
 Fri, 18 Oct 2019 05:20:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 877F8600C4;
 Fri, 18 Oct 2019 05:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07F4C1138619; Fri, 18 Oct 2019 07:20:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
References: <20191017142123.1236-1-thuth@redhat.com>
 <20191017163402.43437191.cohuck@redhat.com>
 <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
 <20191017172954.4e9712de.cohuck@redhat.com>
Date: Fri, 18 Oct 2019 07:20:52 +0200
In-Reply-To: <20191017172954.4e9712de.cohuck@redhat.com> (Cornelia Huck's
 message of "Thu, 17 Oct 2019 17:29:54 +0200")
Message-ID: <87eezaljd7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 05:20:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cornelia Huck <cohuck@redhat.com> writes:

> On Thu, 17 Oct 2019 16:40:56 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 17/10/2019 16.34, Cornelia Huck wrote:
>> > On Thu, 17 Oct 2019 16:21:23 +0200
>> > Thomas Huth <thuth@redhat.com> wrote:
>> >   
>> >> There is no USB on s390x, so running qemu-system-s390x with
>> >> "-machine ...,usb=on" is certainly wrong. Emit a warning to make
>> >> the users aware of their misconfiguration.
>> >>
>> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> >> ---
>> >>  After a year or two, we could finally turn this into a hard error,
>> >>  but I think we should give the users some time to fix their command
>> >>  lines first, so I'm initially only emitting a warning here.
>> >>
>> >>  hw/s390x/s390-virtio-ccw.c | 4 ++++
>> >>  1 file changed, 4 insertions(+)
>> >>
>> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> >> index d3edeef0ad..af8c4c0daf 100644
>> >> --- a/hw/s390x/s390-virtio-ccw.c
>> >> +++ b/hw/s390x/s390-virtio-ccw.c
>> >> @@ -243,6 +243,10 @@ static void ccw_init(MachineState *machine)
>> >>      VirtualCssBus *css_bus;
>> >>      DeviceState *dev;
>> >>  
>> >> +    if (machine->usb) {
>> >> +        warn_report("This machine does not support USB");  
>> > 
>> > I'm wondering if this is the only machine type not supporting usb...
>> > if not, how are others handling it?  
>> 
>> I think most machines are silently ignoring it, like we did on s390x
>> until now, too.
>
> I'm wondering how many options we have that do nothing when configured
> :)

Plenty.

-machine usb=on (and its sugared form -usb) are just one of many options
that deposit configuration for the board to pick up.  Some boards do,
some don't.  Some boards pick up and reject some configuration they
can't use.  Some don't.  It's a big family of hack jobs.

For -drive (and its sugared forms), we have generic code to turn "not
picked up" into an error: drive_check_orphaned().
a66c9dc734 "blockdev: Orphaned drive search", 2014-10-03
720b8dc052 "blockdev: Make orphaned -drive fatal", 2017-02-21

[...]

