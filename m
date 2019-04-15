Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25317C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D8B20645
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Pz4n0OS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D8B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0cG-000285-3X
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:21:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hG0aj-0001DO-PU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hG0ai-0002Kt-IT
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:20:05 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41282)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hG0ah-0002Kk-Tc
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:20:04 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 07ED52E0E0F;
	Mon, 15 Apr 2019 15:20:02 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	CKCc2lKdRr-K1e0VS7P; Mon, 15 Apr 2019 15:20:02 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555330802; bh=qhP/hBpTHlEBggSN6G00TnETAiTnh7GONlMssGowVPQ=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=Pz4n0OS1VcBgy83Dkx5xUI+VQNLQFqx7fGieKbV7/8/Hewr2HN9AXkcmDTLuE9SJM
	ANZamTa40GJpS/FEWUF4Y90fcg5rG8c0TUL6Y/LpiO3Z+Gcr/mrPwXEj88UetlKqYo
	YhCEp/jNS79FTIcaEOcH8GYTooeW63kVj6CvLfwU=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net ([::1])
	by mxbackcorp1g.mail.yandex.net with LMTP id CPLBOKi5
	for <yury-kotov@yandex-team.ru>; Mon, 15 Apr 2019 15:19:56 +0300
Received: by myt5-68ad52a76c91.qloud-c.yandex.net with HTTP;
	Mon, 15 Apr 2019 15:19:56 +0300
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
Date: Mon, 15 Apr 2019 15:20:01 +0300
Message-Id: <329231555330796@myt5-68ad52a76c91.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
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
Message-ID: <20190415122001.wEl1Iy9ua-4phIjHydEhgz3WAdJJGDZ7vLVqIUgpfL8@z>

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

May be it's better to use monitor_fd_param for both incoming/outgoing?
So, "migrate" will know fd:<int> semantics and "migrate-incoming" will
know fd:<fd_name> semantics. And also modify monitor_get_fd to
remove fd from list before return.
This is a backwards compatible change.

Regards,
Yury

