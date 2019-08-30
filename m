Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DCC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4B21721
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 10:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3drg-0006dc-L2
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 06:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1i3dpd-0005yt-7C
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1i3dpI-0008IC-B3
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 06:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1i3dpB-0007fB-3E; Fri, 30 Aug 2019 06:08:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0EDDC010923;
 Fri, 30 Aug 2019 10:08:04 +0000 (UTC)
Received: from ptitpuce (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A255D9CA;
 Fri, 30 Aug 2019 10:07:51 +0000 (UTC)
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk> <87d0h6zfrt.fsf@dusky.pond.sub.org>
 <m1lfvbex92.fsf@redhat.com> <eba518d8-0104-fb41-8ed5-d59ebdb211c9@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: John Snow <jsnow@redhat.com>
In-reply-to: <eba518d8-0104-fb41-8ed5-d59ebdb211c9@redhat.com>
Date: Fri, 30 Aug 2019 12:07:49 +0200
Message-ID: <m1k1avdkzu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 30 Aug 2019 10:08:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Christophe de Dinechin <dinechin@redhat.com>, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow writes:

> On 8/29/19 12:45 PM, Christophe de Dinechin wrote:
>>
[...]

>> Sorry for catching up late, this mail thread happened during my PTO.
>>
>> I remember bringing up at the time [1] that the correct solution needs
>> to take into account usage models that vary from
>>
>> - a workstation case, where displaying an error box is easy and
>>   convenient,
>>
>> - to local headless VMs where system-level notification would do the job
>>   better, allowing us to leverage things like system-wide email notifications
>>
>> - to large-scale collections of VMs managed by some layered product,
>>   where the correct reporting would be through something like Insights,
>>   i.e. you don't scan individual logs, you want something like "913 VMs
>>   are using deprecated X"
>>
>> To me, that implies that we need to have a clear division of roles, with
>> a standard way to
>>
>> a) produce the errors,
>> b) propagate them,
>
> I started replying to this thread to the other mail you sent; I think
> this is going to be fairly involved. I wouldn't mind being proven wrong
> though.

Yes, I think it does look involved, but mostly for historical reasons.
In other words, what is complicated is preserving the historical
behaviors so as to not break existing consumers.

>
>> c) consume them (at least up to libvirt)
>>
>> Notice that this work has already been done for "real" errors,
>> i.e. there is a real QAPI notion of "errors". AFAICT, warn_report does
>> not connect to it, though, it goes through error_vprintf which is really
>> just basic logging.
>>
>> So would it make sense to:
>>
>> 1. Add a deprecation_report() alongside warn_report()?
>>
>
> Where's that get routed to? just an error_vprintf style situation?

Yes, but see below.

>
>> 2. Connect warn_report() and all the error_vprintf output to QAPI,
>>    e.g. using John's suggestion of adding the messages using some
>>    "warning" or "deprecated" tag?
>>
>
> How do you correlate them?

Without having looked at the code much, I think I would

1. extend the existing QAPI error to support warnings, deprecations and
   info messages. The first problem I see is that there is no error, so
   we may sometimes need to create one when there was none before. And
   of course make sure that this does not ultimately show as an error,
   but as a success with additional annotations.

2. replace the current "link + if" switching for error_vprintf with some
   actual notification mechanism, with one option routine to
   monitor_vprintf, one to stderr, one to log file, and then an
   additional path that would post a newly minted qapi warning.

>
>> 3. Teach libvirt how to consume that new tag and pass it along?
>>
>
> I think it's not libvirt's job to pass it along, exactly -- libvirt made
> the decision for which features to engage in QEMU, not the end user.

First, by "pass along", I meant to possible layered products or
management software. We don't necessarily need a new virErrorLevel,
deprecation could be a warning with some special domain,
e.g. VIR_FROM_DEPRECATION.

There may be a need to add some API here. Looking at the code, it's not
obvious to me that libvirt has any notion of error priority. In other
words, if you raise an error then a warning, you get the warning as the
last error, right?


Second, why not report the use of deprecated features? I don't fully buy
the rationale that libvirt engages the features, because it does not do
it on its own, it does it because the user made some specific request.
This point of view also seems to require that libvirt or the user should
know ahead of time it's about to engage a deprecated feature. To me, the
problem is precisely that neither libvirt nor the user knows, which is
why we are discussing how to best make it known.

>
> If the user upgrades QEMU but not libvirt, it's not really anything they
> have control over and they shouldn't be pestered with such things.
>
> However, if libvirt accidentally released a version that engages
> deprecated behavior (and were unaware of it), it'd be nice to get user
> reports, surely?
>
> Logging messages for libvirt might be the best that can be done there in
> that case.

I personally would treat that like any warning.

>
>
> In contrast, power user tools like QMP libraries, qmp-shell and others
> allow more direct and meaningful access to QMP, so those should report
> deprecation messages to the user.

Agreed.

>
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.html
>>

--
Thanks,
Christophe de Dinechin (IRC c3d)

