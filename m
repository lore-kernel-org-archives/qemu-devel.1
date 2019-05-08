Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11040C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D746E21019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFVa-0006Tq-2E
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:52:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOFSb-0004CM-CW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOFSa-0007w7-81
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOFSa-0007vr-0y; Wed, 08 May 2019 01:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49F5ADC8EF;
	Wed,  8 May 2019 05:49:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D98600D4;
	Wed,  8 May 2019 05:49:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 356331132B35; Wed,  8 May 2019 07:49:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <1549471435-21887-1-git-send-email-thuth@redhat.com>
	<5a21d28a-fcb5-305c-d44f-158e69411b28@redhat.com>
	<de25b04f-eb0a-a59c-3a6a-535e2ad67c49@redhat.com>
Date: Wed, 08 May 2019 07:49:37 +0200
In-Reply-To: <de25b04f-eb0a-a59c-3a6a-535e2ad67c49@redhat.com> (Thomas Huth's
	message of "Mon, 6 May 2019 07:52:24 +0200")
Message-ID: <874l658phq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 08 May 2019 05:49:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/i2c/smbus_ich9: Fix the confusing
 contributions-after-2012 statement
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Marcel in the hope of getting a pong.

Thomas Huth <thuth@redhat.com> writes:

> On 29/03/2019 09.42, Thomas Huth wrote:
>> On 06/02/2019 17.43, Thomas Huth wrote:
>>> The license information in this file is rather confusing. The text
>>> declares LGPL first, but then says that contributions after Jan 2012
>>> are licensed under the GPL instead. How should the average user who
>>> just downloaded the release tarball know which part is now GPL and
>>> which is LGPL? Also, as far as I can see, the file has been added to
>>> QEMU *after* January in 2012, so the whole file should be GPL by
>>> default instead.
>>>
>>> Furthermore, looking at the text of the LGPL (see COPYING.LIB in the
>>> top directory), the license clearly states in section "3." that one
>>> should rather replace the license information in such a case instead.
>>> Thus let's clean up the confusing statements and use the proper GPL
>>> text only.
>>>
>>> While we're at it, also remove the comment about acpi.c, since that
>>> file does not exist under this name in the QEMU tree anymore.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/i2c/smbus_ich9.c | 21 ++++++++-------------
>>>  1 file changed, 8 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
>>> index 2a8b49e..484aef5 100644
>>> --- a/hw/i2c/smbus_ich9.c
>>> +++ b/hw/i2c/smbus_ich9.c
>>> @@ -6,23 +6,18 @@
>>>   *               VA Linux Systems Japan K.K.
>>>   * Copyright (C) 2012 Jason Baron <jbaron@redhat.com>
>>>   *
>>> - * This is based on acpi.c, but heavily rewritten.
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>>   *
>>> - * This library is free software; you can redistribute it and/or
>>> - * modify it under the terms of the GNU Lesser General Public
>>> - * License version 2 as published by the Free Software Foundation.
>>> - *
>>> - * This library is distributed in the hope that it will be useful,
>>> + * This program is distributed in the hope that it will be useful,
>>>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> - * Lesser General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU Lesser General Public
>>> - * License along with this library; if not, see <http://www.gnu.org/licenses/>
>>> - *
>>> - * Contributions after 2012-01-13 are licensed under the terms of the
>>> - * GNU GPL, version 2 or (at your option) any later version.
>>> + * General Public License for more details.
>>>   *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, see <http://www.gnu.org/licenses/>
>>>   */
>>>  #include "qemu/osdep.h"
>>>  #include "hw/hw.h"
>>>
>> 
>> Ping?
>
> Ping^2
>
>  Thomas

