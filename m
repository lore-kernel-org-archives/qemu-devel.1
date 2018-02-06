Received: from eggs.gnu.org ([2001:4830:134:3::10]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ej2c9-0004qx-1F
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1ej2c7-0007BV-V2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:44:45 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:44022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1ej2c7-0007At-JQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:44:43 -0500
Received: by mail-wr0-x232.google.com with SMTP id b52so1764932wrd.10
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 04:44:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87eflye96g.fsf@dusky.pond.sub.org>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
	<1516369485-5374-11-git-send-email-zhangckid@gmail.com>
	<87zi4qf4yi.fsf@dusky.pond.sub.org>
	<CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
	<87po5ifuh7.fsf@dusky.pond.sub.org>
	<CAK3tnvL1zxNO2JpyjhDTqQYtr7eniyLRGYciWfdhLO+ov+tGwA@mail.gmail.com>
	<87eflye96g.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 6 Feb 2018 20:44:41 +0800
Message-ID: <CAK3tnvJ8FmZhJpoyPvj30mbQYMhrJ46dm2dL-gpHD=48cM0jhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V4 10/16] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 6, 2018 at 5:53 PM, Markus Armbruster <armbru@redhat.com> wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Tue, Feb 6, 2018 at 3:27 PM, Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > On Sat, Feb 3, 2018 at 3:49 PM, Markus Armbruster <armbru@redhat.com>
> wrote:
> >> >> Standard question when I see a new event: is there a way to poll for
> the
> >> >> event's information?  If not, why don't we need one?
> >> >>
> >> >>
> >> > Your means is we'd better print the information to a log file or
> something
> >> > like that for all qemu events?
> >> > CC  Eric Blake <eblake@redhat.com>
> >> > any idea about this?
> >>
> >> Events carrying state change information management applications want to
> >> track are generally paired with a query- command.  While the management
> >> application is connected, it can track by passively listening for state
> >> change events.  After (re)connect, it has to actively query the current
> >> state.
> >>
> >> Questions?
> >>
> >
> >
> > If I understand correctly, maybe we need a qemu events general history
> > mechanism
> > to solve this problem,
> > because lots of qemu events can't resend the current state. Yes, when the
> > "management application"(like libvirt)
> > lose the connection to qemu,  management application can't get the
> > information after reconnect.
>
> Events can't resend the current state, but query commands can.
>
> Designing of an "events general history mechanism" could well be
> non-trivial.  Its implementation might not be simple, either.  Query
> commands, on the other hand, are well understood and easy to implement.
>

OK, I got it.
I will add a new query command for COLO state in next version.
Thanks your comments.

Zhang Chen
