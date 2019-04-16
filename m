Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D081C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1892073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XiSUmGaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1892073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGLrQ-0006d0-4p
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 07:02:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGLq1-0005y1-N3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGLq0-000552-HD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:17 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:45780)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGLpz-000520-LA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:16 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9CD3B2E099E;
	Tue, 16 Apr 2019 14:01:10 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	Ji3nnfpZLr-1AMS7dAL; Tue, 16 Apr 2019 14:01:10 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555412470; bh=OVpxFfqNnruVlAdPfPsh0tRVSUYz9KF+XqEZFjKdrN0=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=XiSUmGaJucl+a5rtZRt2wkbSuw3kWJlR7Pob8QQ95vSDmPvoNmTA7IuOQTyZe6F7n
	QjZ8meEfGWPjhij4xWApOpa6PZxE8cJ2+xGZWqKuHSKjwpyzbB8yvFeveqSIpQTCdU
	WFoYaE4KM0slEcUoFt+vo8iRG9YPZWRKOB8Dx0/U=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net ([::1])
	by mxbackcorp1j.mail.yandex.net with LMTP id bcHS7tkA
	for <yury-kotov@yandex-team.ru>; Tue, 16 Apr 2019 14:01:05 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Tue, 16 Apr 2019 14:01:05 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>,
	=?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
In-Reply-To: <20190415113045.GI2852@work-vm>
References: <20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 16 Apr 2019 14:01:10 +0300
Message-Id: <612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416110110.VAjHS_bI_ytT-9st_iiMnIAC24uV2WQkN6Am165fMNA@z>

15.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> =C2=A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David Alan Gilbert=
 wrote:
>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> =C2=A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wrote:
>> =C2=A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=C3=A9" <berrange@red=
hat.com>:
>> =C2=A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Kotov wro=
te:
>> =C2=A0> > > >> =C2=A015.04.2019, 13:11, "Daniel P. Berrang=C3=A9" <ber=
range@redhat.com>:
>> =C2=A0> > > >> =C2=A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury =
Kotov wrote:
>> =C2=A0> > > >> =C2=A0>> =C2=A0Hi,
>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0> > > >> =C2=A0>> =C2=A0Just to clarify. I see two possible solu=
tions:
>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0> > > >> =C2=A0>> =C2=A01) Since the migration code doesn't rece=
ive fd, it isn't responsible for
>> =C2=A0> > > >> =C2=A0>> =C2=A0closing it. So, it may be better to use =
migrate_fd_param for both
>> =C2=A0> > > >> =C2=A0>> =C2=A0incoming/outgoing and add dupping for mi=
grate_fd_param. Thus, clients must
>> =C2=A0> > > >> =C2=A0>> =C2=A0close the fd themselves. But existing cl=
ients will have a leak.
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0> We can't break existing clients in this way as =
they are correctly
>> =C2=A0> > > >> =C2=A0> using the monitor with its current semantics.
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0>> =C2=A02) If we don't duplicate fd, then at lea=
st we should remove fd from
>> =C2=A0> > > >> =C2=A0>> =C2=A0the corresponding list. Therefore, the s=
olution is to fix qemu_close to find
>> =C2=A0> > > >> =C2=A0>> =C2=A0the list and remove fd from it. But qemu=
_close is currently consistent with
>> =C2=A0> > > >> =C2=A0>> =C2=A0qemu_open (which opens/dups fd), so addi=
ng additional logic might not be
>> =C2=A0> > > >> =C2=A0>> =C2=A0a very good idea.
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0> qemu_close is not appropriate place to deal wit=
h something speciifc
>> =C2=A0> > > >> =C2=A0> to the montor.
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0>> =C2=A0I don't see any other solution, but I mi=
ght miss something.
>> =C2=A0> > > >> =C2=A0>> =C2=A0What do you think?
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0> All callers of monitor_get_fd() will close() th=
e FD they get back.
>> =C2=A0> > > >> =C2=A0> Thus monitor_get_fd() should remove it from the=
 list when it returns
>> =C2=A0> > > >> =C2=A0> it, and we should add API docs to monitor_get_f=
d() to explain this.
>> =C2=A0> > > >> =C2=A0>
>> =C2=A0> > > >> =C2=A0Ok, it sounds reasonable. But monitor_get_fd is o=
nly about outgoing migration.
>> =C2=A0> > > >> =C2=A0But what about the incoming migration? It doesn't=
 use monitor_get_fd but just
>> =C2=A0> > > >> =C2=A0converts input string to int and use it as fd.
>> =C2=A0> > > >
>> =C2=A0> > > > The incoming migration expects the FD to be passed into =
QEMU by the mgmt
>> =C2=A0> > > > app when it is exec'ing the QEMU binary. It doesn't inte=
ract with the
>> =C2=A0> > > > monitor at all AFAIR.
>> =C2=A0> > > >
>> =C2=A0> > >
>> =C2=A0> > > Oh, sorry. This use case is not obvious. We used add-fd to=
 pass fd for
>> =C2=A0> > > migrate-incoming and such way has described problems.
>> =C2=A0> >
>> =C2=A0> > That's a bug in your usage of QEMU IMHO, as the incoming cod=
e is not
>> =C2=A0> > designed to use add-fd.
>> =C2=A0>
>> =C2=A0> Hmm, that's true - although:
>> =C2=A0> a) It's very non-obvious
>> =C2=A0> b) Unfortunate, since it would go well with -incoming defer
>>
>> =C2=A0Yeah I think this is a screw up on QMEU's part when introducing =
'defer'.
>>
>> =C2=A0We should have mandated use of 'add-fd' when using 'defer', sinc=
e FD
>> =C2=A0inheritance-over-execve() should only be used for command line a=
rgs,
>> =C2=A0not monitor commands.
>>
>> =C2=A0Not sure how to best fix this is QEMU though without breaking ba=
ck
>> =C2=A0compat for apps using 'defer' already.
>
> We could add mon-fd: transports that has the same behaviour as now for
> outgoing, and for incoming uses the add-fd stash.
>

Oh, I'm sorry again. I think my suggestion about monitor_fd_param wasn't
relevant to this issue. If migrate-incoming + "fd:" + add-fd is an invali=
d use
case, should we disallow this?
I may add a check to fd_start_incoming_migration if fd is in mon fds list=
.
But I'm afraid there are users like me who are already using this wrong u=
se case.
Because currently nothing in QEMU's docs disallow this.

So which solution is better in your opinion?
1) Disallow fd's from mon fds list in fd_start_incoming_migration
2) Allow these fds, but dup them or close them correctly

And how to migrate-incoming defer through fd correctly?
1) Add "mon-fd:" protocol to work with fds passed by "add-fd/remove-fd" c=
ommands
as suggested by Dave
2) My suggestion about monitor_fd_param and make "fd:" for
migrate/migrate-incoming consistent. So user will be able to use
getfd + migrate-incoming
3) Both of them or something else

Regards,
Yury Kotov

