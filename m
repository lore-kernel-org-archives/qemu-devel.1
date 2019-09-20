Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BED62080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED62080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKgm-0002eD-LT
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBKfK-0001OE-Eh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBKfH-0000hl-An
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iBKfG-0000hJ-Vj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 107ED18C4270
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:17:42 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A168B5D6A7;
 Fri, 20 Sep 2019 15:17:38 +0000 (UTC)
Subject: Re: [RFC 1/4] Add qapi for block error injection
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, kwolf@redhat.com
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190919194847.18518-2-tasleson@redhat.com>
 <042391ce-1a18-9eb1-5a78-ac40613affb0@redhat.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <a0aece52-376b-009a-011b-51797cc26372@redhat.com>
Date: Fri, 20 Sep 2019 10:17:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <042391ce-1a18-9eb1-5a78-ac40613affb0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 15:17:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 4:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Tony,

Hi Phil

>=20
> On 9/19/19 9:48 PM, Tony Asleson wrote:
...
>> +void media_error_delete(const char *device_id, uint64_t lba)
>=20
> Can you explain the goal of this function? I don't understand it from
> the hardware PoV. Or is it a simple code cleanup function?

It's just a way to do clean up.  I actually used it during development
as the Linux kernel can get very unresponsive when doing error retries ,
so I removed the error to allow things to proceed again.

> Once hw starts to break, it is unlikely it recovers magically to a
> previous sane state...
>=20
> In real world, block hardware starts to fail, controller notice
> inconsistency and set some bits, the controller driver react.
> Eventually the hw will still be used, with the failing block avoided.

This is probably the most common case that people are familiar with, a
sector that goes bad and persists.

In rotating magnetic media devices, you can have a media error if a
write was interrupted by a power failure.  The sector has part of the
new write and part of the old write, CRC check fails and ECC is unable
to correct.  This can be corrected by having the host re-write the sector=
.

You can also have an intermittent read error if you have a transient
media problem, eg. a small particulate is moving around on the disk
surface (ransient thermal asperity, instead of persistent).

Depending on disk type (SCSI/SATA) and firmware features, the disk may
auto-reassign the block when it discovers that it had to go through lots
of recovery to retrieve the data or it may require the initiator to
issue a reassign blocks command.  In both cases the lba replacement is
ready to use.

> What do you think? How is your current use case setup?

Eventually I think it would be good to model some or all of these other
error scenarios I've outlined above.

>=20
> Thanks,

Thank you!

-Tony

