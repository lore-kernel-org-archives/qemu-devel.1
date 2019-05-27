Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE2C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B7221721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B7221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVArM-0000tK-6w
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:19:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVAqI-0000S3-Oi
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVAqH-0003zK-QK
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVAqH-0003yd-Js
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:18:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E567A3086213;
	Mon, 27 May 2019 08:18:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52684608BA;
	Mon, 27 May 2019 08:18:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D883D1138648; Mon, 27 May 2019 10:18:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	<87tvdlhakq.fsf@dusky.pond.sub.org>
	<CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
Date: Mon, 27 May 2019 10:18:42 +0200
In-Reply-To: <CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Sat, 25 May 2019
	14:12:12 +0200")
Message-ID: <87blzo1fa5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 27 May 2019 08:18:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, May 23, 2019 at 9:52 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>> I'm not sure how asynchronous commands could support reconnect and
>> resume.
>
> The same way as current commands, including job commands.

Consider the following scenario: a management application such as
libvirt starts a long-running task with the intent to monitor it until
it finishes.  Half-way through, the management application needs to
disconnect and reconnect for some reason (systemctl restart, or crash &
recover, or whatever).

If the long-running task is a job, the management application can resume
after reconnect: the job's ID is as valid as it was before, and the
commands to query and control the job work as before.

What if it's and asynchronous command?

>> >> I'm ignoring "etc" unless you expand it into something specific.
>> >>
>> >> I'm also not taking the "weird" bait :)
>> >> > The following series implements an async command solution instead. =
By
>> >> > introducing a session context and a command return handler, it can:
>> >> > - defer the return, allowing the mainloop to reenter
>> >> > - return only to the caller (instead of broadcast events for reply)
>> >> > - optionnally allow cancellation when the client is gone
>> >> > - track on-going qapi command(s) per client/session
>> >> >
>> >> > and without introduction of new QMP APIs or client visible change.
>> >>
>> >> What do async commands provide that jobs lack?
>> >>
>> >> Why do we want both?
>> >
>> > They are different things, last we discussed it: jobs are geared
>> > toward block device operations,
>>
>> Historical accident.  We've discussed using them for non-blocky stuff,
>> such as migration.  Of course, discussions are cheap, code is what
>> counts.
>
> Using job API means providing new (& more complex) APIs to client.
>
> The screendump fix here doesn't need new API, it needs new internal
> dispatch of QMP commands: the purpose of this series.
>
> Whenever we can solve things on qemu side, I would rather not
> deprecate current API.

Making a synchronous command asynchronous definitely changes API.

You could still argue the change is easier to handle for QMP clients
than a replacement by a job.

[...]

