Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0856CC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56FF2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56FF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFbt-0003kO-Tf
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:24:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVFb1-0003TR-Av
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVFaz-0004jY-GG
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVFaz-0004j5-C9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5023C3084023;
	Mon, 27 May 2019 13:23:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FA35D704;
	Mon, 27 May 2019 13:23:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 188DB1138648; Mon, 27 May 2019 15:23:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	<87tvdlhakq.fsf@dusky.pond.sub.org>
	<CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
	<87blzo1fa5.fsf@dusky.pond.sub.org>
	<20190527090731.uohmamahlg53bu77@sirius.home.kraxel.org>
Date: Mon, 27 May 2019 15:23:12 +0200
In-Reply-To: <20190527090731.uohmamahlg53bu77@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Mon, 27 May 2019 11:07:31 +0200")
Message-ID: <87pno46ngf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 27 May 2019 13:23:20 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, May 27, 2019 at 10:18:42AM +0200, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>=20
>> > Hi
>> >
>> > On Thu, May 23, 2019 at 9:52 AM Markus Armbruster <armbru@redhat.com> =
wrote:
>> >> I'm not sure how asynchronous commands could support reconnect and
>> >> resume.
>> >
>> > The same way as current commands, including job commands.
>>=20
>> Consider the following scenario: a management application such as
>> libvirt starts a long-running task with the intent to monitor it until
>> it finishes.  Half-way through, the management application needs to
>> disconnect and reconnect for some reason (systemctl restart, or crash &
>> recover, or whatever).
>>=20
>> If the long-running task is a job, the management application can resume
>> after reconnect: the job's ID is as valid as it was before, and the
>> commands to query and control the job work as before.
>>=20
>> What if it's and asynchronous command?
>
> This is not meant for some long-running job which you have to manage.
>
> Allowing commands being asynchronous makes sense for things which (a)
> typically don't take long, and (b) don't need any management.
>
> So, if the connection goes down the job is simply canceled, and after
> reconnecting the management can simply send the same command again.

Is this worth its own infrastructure?

Would you hazard a guess on how many commands can take long enough to
demand a conversion to asynchronous, yet not need any management?

>> > Whenever we can solve things on qemu side, I would rather not
>> > deprecate current API.
>>=20
>> Making a synchronous command asynchronous definitely changes API.
>
> Inside qemu yes, sure.  But for the QMP client nothing changes.

Command replies can arrive out of order, can't they?

