Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C184C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A9020674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNJH-0005hD-Dy
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfNCo-0000ra-8m
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfNCj-0007DW-J0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hfNCj-0006yj-CG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7F4030872DD
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 11:31:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8315F600CD;
 Mon, 24 Jun 2019 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 037FD11386A0; Mon, 24 Jun 2019 13:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-17-armbru@redhat.com>
 <20190620085627.GR25448@redhat.com>
Date: Mon, 24 Jun 2019 13:31:51 +0200
In-Reply-To: <20190620085627.GR25448@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Thu, 20 Jun 2019 09:56:27 +0100")
Message-ID: <87a7e7rzh4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 11:31:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 16/17] MAINTAINERS: Add Windows dump to
 section "Dump"
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
Cc: kwolf@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 19, 2019 at 10:10:49PM +0200, Markus Armbruster wrote:
>> Commit 2da91b54fe9 "dump: add Windows dump format to
>> dump-guest-memory" neglected to update MAINTAINERS.  Do it now.
>>=20
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a3fdda015f..327ad80ae4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1850,9 +1850,10 @@ F: include/sysemu/device_tree.h
>>  Dump
>>  S: Supported
>>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> -F: dump/dump.c
>> +F: dump/
>
> Isn't this better squashed in the previous patch in fact.

If I do that, the commit does two things: move code and improve
MAINTAINERS coverage.  Okay in this case.  We can just as well finish
the improvement job then, i.e. squash the entire commit into the
previous one.

>>  F: hw/misc/vmcoreinfo.c
>>  F: include/hw/misc/vmcoreinfo.h
>> +F: include/qemu/win_dump_defs
>>  F: include/sysemu/dump-arch.h
>>  F: include/sysemu/dump.h
>>  F: qapi/dump.json
>
> Either way, the result is good so
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!

