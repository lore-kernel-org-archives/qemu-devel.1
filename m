Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7612C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 06:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74853206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 06:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74853206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHjML-0008Iw-IX
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 02:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHjLd-0007np-UH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 02:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHjLc-000723-Ql
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 02:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHjLY-0006zu-KW; Tue, 08 Oct 2019 02:51:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78F0B3060860;
 Tue,  8 Oct 2019 06:51:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F9625C223;
 Tue,  8 Oct 2019 06:51:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C8EB1138648; Tue,  8 Oct 2019 08:51:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] IDE: deprecate ide-drive
References: <20191006203150.13054-1-jsnow@redhat.com>
 <20191006203150.13054-2-jsnow@redhat.com>
 <87pnj8holb.fsf@dusky.pond.sub.org>
 <4493785d-f1b8-3de5-ee79-7911949dfba4@redhat.com>
Date: Tue, 08 Oct 2019 08:51:40 +0200
In-Reply-To: <4493785d-f1b8-3de5-ee79-7911949dfba4@redhat.com> (John Snow's
 message of "Mon, 7 Oct 2019 15:23:23 -0400")
Message-ID: <87a7abafwj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 08 Oct 2019 06:51:47 +0000 (UTC)
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/19 5:49 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
>>> I'd like to refactor these some day, and getting rid of the super-object
>>> will make that easier.
>> 
>> Device "scsi-disk" is similar.  However, it's still used by the
>> scsi_bus_legacy_add_drive() magic.  Not sure that's fully deprecated,
>> yet.  If / once it is, we can deprecate "scsi-disk", too.  Anyway, not
>> your department.
>> 
>
> Yeah. I just want to get rid of this to allow myself to do bolder things
> later on.
>
> I have literally no time to do this and it's not really anything that
> would make anyone money, but...
>
> I want to add a few explicit devices:
>
> ata-hd
> ata-cd
> sata-hd
> sata-cd
>
> With some shared state structures that implement common feature subsets,
> like ata_registers, sata_registers, atapi_registers, etc.
>
> I'd also like to separate out frontend and backend state providing a bit
> of a cleaner division between device configuration (parameters on the
> hardware creation itself), emulated device state (ATA register sets and
> state machine), and QEMU backend state (block_backend pointers, aio
> state counters, locks, etc etc etc -- Things solely purposed for
> interacting with the block module.)
>
> I'd also like to make each device type plug into ATA or SATA bus slots
> explicitly -- no more magic IDE devices.
>
> It's like the 5-year itch I can't help but want to scratch. My name's on
> this code and it's UGLY UGLY UGLY!

True!  And that's after Kraxel made it *less* ugly.  Your 5-year itch is
actually a 10-year itch that evolved from an open sore.

> The biggest roadblock to me actually doing this is figuring out how it
> would be even vaguely possible to migrate from ide-hd or ide-cd to the
> newer models -- it might be pretty complex, but maybe I can figure
> something out somehow...

Yes, that's the problem that has blocked further improvement.  Doesn't
mean it's intractable, only that nobody has found the time to tackle it
seriously.

> Well, suggestions welcome.
>
>>> Either way, we don't need this.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
[...]
> I'll respin to hit the tests with a stiffer scrub-brush.

Thanks!

