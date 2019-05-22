Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A68C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501D52081C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501D52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUAD-0003x2-Jr
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:32:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTU41-0007U7-Ig
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTU3z-0003vU-IG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hTU3r-0002lK-8P; Wed, 22 May 2019 12:25:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2D88300180C;
	Wed, 22 May 2019 16:25:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C69E5DE68;
	Wed, 22 May 2019 16:25:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1D1F01138648; Wed, 22 May 2019 18:25:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<CAGxU2F6r0hKy_Egwf=xfMkFH-3bxL8Yjz3z6GTT0QTrkYoHCDQ@mail.gmail.com>
Date: Wed, 22 May 2019 18:25:17 +0200
In-Reply-To: <CAGxU2F6r0hKy_Egwf=xfMkFH-3bxL8Yjz3z6GTT0QTrkYoHCDQ@mail.gmail.com>
	(Stefano Garzarella's message of "Wed, 22 May 2019 10:57:39 +0200")
Message-ID: <87woiijw2a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 22 May 2019 16:25:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Wed, May 8, 2019 at 1:44 PM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Stefano Garzarella <sgarzare@redhat.com> writes:
>>
>> > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
[...]
>> >> Let me review support in drivers:
>> >>
>> >> * file (file-win32.c)
>> >> * iscsi
>> >> * nfs
>> >> * qed
>> >> * ssh
>> >>
>> >>   - Reject all but PREALLOC_MODE_OFF
>> >>
>> >> * copy-on-read
>> >> * luks (crypto.c)
>> >> * raw
>> >>
>> >>   - Pass through only
>> >>
>> >> * file host_cdrom host_device (file-posix.c)
>> >>
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
>> >>     files
>> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
>> >>   - Reject PREALLOC_MODE_METADATA
>> >>
>> >> * gluster
>> >>
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
>> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
>> >>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
>> >>   - Reject PREALLOC_MODE_METADATA
>> >>
>> >> * qcow2
>> >>
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
>> >>     file
>> >>
>> >> * rbd with this patch
>> >>
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
>> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
>> >>
>> >> * sheepdog
>> >>
>> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
>> >>   - Doesn't support shrinking
>> >>
>> >> * vdi
>> >>
>> >>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
>> >>   - Doesn't support shrinking
>> >>
>> >> * blkdebug
>> >> * blklogwrites
>> >> * blkverify
>> >> * bochs
>> >> * cloop
>> >> * dmg
>> >> * ftp
>> >> * ftps
>> >> * http
>> >> * https
>> >> * luks
>> >> * nbd
>> >> * null-aio
>> >> * null-co
>> >> * nvme
>> >> * parallels
>> >> * qcow
>> >> * quorum
>> >> * replication
>> >> * throttle
>> >> * vhdx
>> >> * vmdk
>> >> * vpc
>> >> * vvfat
>> >> * vxhs
>> >>
>> >>   - These appear not to use PreallocMode: they don't implement
>> >>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
>> >>     implement it without a prealloc parameter.
>> >>
>> >> Looks good to me.
>> >>
>> >
>> > Thanks for the analysis!
[...]
>> > If you agree, I can check and update the documentation of all drivers following
>> > your analysis.
>>
>> Yes, please!
>
>
> Hi Markus,
> I'm finally updating the documentation of preallocation modes
> supported by block drivers and protocols in qapi/block-core.json.
> As sheepdog and vdi I'm adding the supported values for each driver or
> protocol that supports 'preallocation' parameter during the creation,
> I'm also updating the '.help' in the QemuOptsList.
>
> My doubt is: where is better to put the documentation about
> preallocation modes supported during the resize? (e.g. some drivers
> support only PREALLOC_MODE_OFF when shrinking)

As far as I can tell, no driver supports anything but PREALLOC_MODE_OFF
when shrinking.  Suggest to ignore the shrinking case for now when
documenting.

I'm not sure I fully answered your question.  Don't hesitate to ask for
more advice.

