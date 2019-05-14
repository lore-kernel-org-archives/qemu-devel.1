Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5E821707
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5E821707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQay7-0004wp-3U
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:11:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQau0-0001D5-IO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQano-00056a-Mt
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59273)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hQano-00052A-Ax; Tue, 14 May 2019 13:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED016883BA;
	Tue, 14 May 2019 17:01:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F06562723;
	Tue, 14 May 2019 17:01:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9E19311385E4; Tue, 14 May 2019 19:01:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
	<4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com>
Date: Tue, 14 May 2019 19:01:11 +0200
In-Reply-To: <4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com> (Eric Blake's
	message of "Tue, 14 May 2019 09:05:34 -0500")
Message-ID: <878sv9c6nc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 14 May 2019 17:01:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RESEND] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 5/14/19 8:15 AM, Yury Kotov wrote:
>> monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
>> returns mon_fdset->id which is int64_t. Downcast from int64_t to int leads to
>> a bug with removing fd from fdset which id >= 2^32.
>> So, fix return types for these function.
>
> fd's cannot exceed 2^32. We should instead be fixing anything that uses
> int64_t with an fd to be properly limited to 32 bits.  That is, I think
> the real problem is in qapi/misc.json:
>
>  { 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int'} }
> instead of 'fd':'int32'.

This is actually not related to the patch.  It doesn't touch
file-descriptors at all, only fdset IDs.

But let's discuss file descriptors briefly.

File descriptors are plain int.  There is no QAPI type corresponding to
plain int.

I guess plain int is 32 bits wide on all hosts we support.  Narrower int
(permitted by the standard) wouldn't fly with QEMU.  Wider int should,
and are theoretically possible.

I'm not sure we want to change the QAPI schema.

>                           For that matter, 'fdset-id' larger than 32
> bits is unlikely to be useful (there's no reason to have more fdsets
> than you can have possible fds to put in those sets).

Even if we had wider file descriptors: a billion fdsets should be enough
for anyone.

> NACK to this version, but a v2 that addresses the real problem is
> worthwhile.

What exactly is wrong with the patch?

It changes the return value of monitor_fdset_dup_fd_find_remove() and
monitor_fdset_dup_fd_find() from int to int64_t.  Both return an fdset
ID (a MonFdset member @id, of type int64_t) on success, -1 on error.
The change removes a truncation from int64_t to int in
monitor_fdset_dup_fd_find_remove(), and a widening from int to int64_t
in qemu_close().

I believe the patch is fine as is.  Another patch that changes fdset IDs
from int64_t to int32_t would also be fine, but it would Require
tracking down all the places to change.

[...]

