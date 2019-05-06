Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81AC04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2358420830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2358420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNbc3-0002uy-DC
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:16:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNbax-0002SV-Ve
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNbaw-0004rK-T3
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hNbaw-0004qW-L1; Mon, 06 May 2019 07:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96D40300180F;
	Mon,  6 May 2019 11:15:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 344DB1A921;
	Mon,  6 May 2019 11:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 92D301132B35; Mon,  6 May 2019 13:15:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
	<20190416212003.GB2272@habkost.net>
	<87ftqh1ae5.fsf@dusky.pond.sub.org>
	<20190417171059.GC25134@habkost.net>
	<3fc39df9-9c4e-219c-e7dc-c93754fd1315@linux.intel.com>
Date: Mon, 06 May 2019 13:15:39 +0200
In-Reply-To: <3fc39df9-9c4e-219c-e7dc-c93754fd1315@linux.intel.com> (Like Xu's
	message of "Tue, 23 Apr 2019 15:59:31 +0800")
Message-ID: <87d0kvsujo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 06 May 2019 11:15:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, like.xu@intel.com,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like Xu <like.xu@linux.intel.com> writes:

> On 2019/4/18 1:10, Eduardo Habkost wrote:
>> On Wed, Apr 17, 2019 at 07:14:10AM +0200, Markus Armbruster wrote:
>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>
>>>> On Mon, Apr 15, 2019 at 03:59:45PM +0800, Like Xu wrote:
>>>>> To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
>>>>> this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
>>>>> mode) and adds type assertion to qdev_get_machine() in system-emulation mode.
>>>>>
>>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>>>>
>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>
>>>> I'm queueing the series on machine-next, thanks!
>>>
>>> Hold your horses, please.
>>>
>>> I dislike the name qdev_get_machine_uncheck().  I could live with
>>> qdev_get_machine_unchecked().
>>>
>>> However, I doubt this is the right approach.
>>>
>>> The issue at hand is undisciplined creation of QOM object /machine.
>>>
>>> This patch adds an asseertion "undisciplined creation of /machine didn't
>>> create crap", but only in some places.
>>>
>>> I think we should never create /machine as (surprising!) side effect of
>>> qdev_get_machine().  Create it explicitly instead, and have
>>> qdev_get_machine() use object_resolve_path("/machine", NULL) to get it.
>>> Look ma, no side effects.
>>
>> OK, I'm dropping this one while we discuss it.
>>
>> I really miss a good explanation why qdev_get_machine_unchecked()
>> needs to exist.  When exactly do we want /machine to exist but
>> not be TYPE_MACHINE?  Why?
>
> AFAICT, there is no such "/machine" that is not of type TYPE_MACHINE.
>
> The original qdev_get_machine() would always return a "/container"
> object in user-only mode and there is none TYPE_MACHINE object.
>
> In system emulation mode, it returns the same "/container" object at
> the beginning, until we initialize and add a TYPE_MACHINE object to
> the "/container" as a child and it would return
> OBJECT(current_machine)
> for later usages.

I don't think so.

If you ever call qdev_get_machine() before creating "/machine", you not
only get a bogus "container" object, you *also* set "/machine" to that
object.  When main() later attempts to create the real "/machine", it
fails with "attempt to add duplicate property 'machine' to object (type
'container')", and aborts.  See commit 1a3ec8c1564 and e2fb3fbbf9c.

> The starting point is to avoid using the legacy qdev_get_machine()
> in system emulation mode when we haven't added the "/machine" object.
> As a result, we introduced type checking assertions to avoid premature
> invocations.
>
> In this proposal, the qdev_get_machine_unchecked() is only used
> in user-only mode, part of which shares with system emulation mode
> (such as device_set_realized, cpu_common_realizefn). The new
> qdev_get_machine() is only used in system emulation mode and type
> checking assertion does reduce the irrational use of this function (if
> any in the future).
>
> We all agree to use this qdev_get_machine() as little as possible
> and this patch could make future clean up work easier.

I don't think qdev_get_machine() per se is the problem.  Its side effect
is.  Quoting myself:

    I think we should never create /machine as (surprising!) side effect of
    qdev_get_machine().  Create it explicitly instead, and have
    qdev_get_machine() use object_resolve_path("/machine", NULL) to get it.

>> Once the expectations and use cases are explained, we can choose
>> a better name for qdev_get_machine_unchecked() and document it
>> properly.
>>

