Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B03C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB082064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB082064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycQQ-0001MJ-I9
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hycEF-0005Dn-1u
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hycED-0002NS-N4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hycED-0002Md-BV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D27C2A09CF;
 Fri, 16 Aug 2019 13:25:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98E817EBA6;
 Fri, 16 Aug 2019 13:24:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1570610E6CCA; Fri, 16 Aug 2019 15:24:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
 <CAFEAcA9L1yA==UV__H_bkC+HBKNB1vMtAXidQsbNwDGSt6Yokw@mail.gmail.com>
 <7d6c5482-183e-5373-03ac-18aac5055572@redhat.com>
 <80ed7df8-2dfc-4bb0-b3e4-3e58df9d0957@redhat.com>
Date: Fri, 16 Aug 2019 15:24:45 +0200
In-Reply-To: <80ed7df8-2dfc-4bb0-b3e4-3e58df9d0957@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 16 Aug 2019 14:39:06
 +0200")
Message-ID: <87v9uxmeea.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 16 Aug 2019 13:25:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/29] Header cleanup patches for 2019-08-13
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/16/19 1:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/16/19 12:59 PM, Peter Maydell wrote:
>>> On Tue, 13 Aug 2019 at 16:54, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>>
>>>> The following changes since commit 864ab314f1d924129d06ac7b571f105a2b7=
6a4b2:
>>>>
>>>>   Update version for v4.1.0-rc4 release (2019-08-06 17:05:21 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://repo.or.cz/qemu/armbru.git tags/pull-include-2019-08-13
>>>>
>>>> for you to fetch changes up to 8d111fd683b678d3826e192bc07ffcc349a118b=
5:
>>>>
>>>>   sysemu: Split sysemu/runstate.h off sysemu/sysemu.h (2019-08-13 13:1=
6:20 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Header cleanup patches for 2019-08-13
>>>>
>>>> ----------------------------------------------------------------
>>>> These patches are rather bothersome to rebase, so I'd like to get them
>>>> into 4.2 early.
>>>>
>>>
>>> Fails to build on OSX I'm afraid:
>>> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1166:5: error: implicit
>>> declaration of function 'qemu_system_shutdown_request' is invalid in
>>> C99 [-Werror,-Wimplicit-function-declaration]
>>>     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
>>>     ^
>>=20
>> Ah I reported this one while reviewing v2:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01150.html
>>=20
>> Then didn't take the time to test OSX on v4 :(
>>=20
>> BTW Travis should find this.
>
> Actually I did try v4 on Travis and it succeeded:
> https://travis-ci.org/philmd/qemu/builds/570743079
>
> But Travis seems to have updated smth on their OSX images (or brew is
> down?), now I get:
>
>   ERROR: glib-2.40 gthread-2.0 is required to compile QEMU
>
> Anyway, the culprit is:
>
> commit 8d111fd683b678d3826e192bc07ffcc349a118b5 (tag:
> pull-include-2019-08-13)
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Mon Aug 12 07:23:59 2019 +0200
>
>     sysemu: Split sysemu/runstate.h off sysemu/sysemu.h
>
>     sysemu/sysemu.h is a rather unfocused dumping ground for stuff related
>     to the system-emulator.  Evidence:
>
>     * It's included widely: in my "build everything" tree, changing
>       sysemu/sysemu.h still triggers a recompile of some 1100 out of 6600
>       objects (not counting tests and objects that don't depend on
>       qemu/osdep.h, down from 5400 due to the previous two commits).
>
>     * It pulls in more than a dozen additional headers.
>
> ui/cocoa.m now needs to include "sysemu/runstate.h".

v2 sent.  Thanks!

