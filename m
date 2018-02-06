Received: from eggs.gnu.org ([2001:4830:134:3::10]:38468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej04C-0000z8-Q1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej047-00031q-2f
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:01:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej046-00031c-TA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:01:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
	<1516369485-5374-11-git-send-email-zhangckid@gmail.com>
	<87zi4qf4yi.fsf@dusky.pond.sub.org>
	<CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
	<87po5ifuh7.fsf@dusky.pond.sub.org>
	<CAK3tnvL1zxNO2JpyjhDTqQYtr7eniyLRGYciWfdhLO+ov+tGwA@mail.gmail.com>
Date: Tue, 06 Feb 2018 10:53:11 +0100
In-Reply-To: <CAK3tnvL1zxNO2JpyjhDTqQYtr7eniyLRGYciWfdhLO+ov+tGwA@mail.gmail.com>
	(Zhang Chen's message of "Tue, 6 Feb 2018 16:01:07 +0800")
Message-ID: <87eflye96g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Zhang Chen <zhangckid@gmail.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Zhang Chen <zhangckid@gmail.com> writes:

> On Tue, Feb 6, 2018 at 3:27 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > On Sat, Feb 3, 2018 at 3:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> >> Standard question when I see a new event: is there a way to poll for the
>> >> event's information?  If not, why don't we need one?
>> >>
>> >>
>> > Your means is we'd better print the information to a log file or something
>> > like that for all qemu events?
>> > CC  Eric Blake <eblake@redhat.com>
>> > any idea about this?
>>
>> Events carrying state change information management applications want to
>> track are generally paired with a query- command.  While the management
>> application is connected, it can track by passively listening for state
>> change events.  After (re)connect, it has to actively query the current
>> state.
>>
>> Questions?
>>
>
>
> If I understand correctly, maybe we need a qemu events general history
> mechanism
> to solve this problem,
> because lots of qemu events can't resend the current state. Yes, when the
> "management application"(like libvirt)
> lose the connection to qemu,  management application can't get the
> information after reconnect.

Events can't resend the current state, but query commands can.

Designing of an "events general history mechanism" could well be
non-trivial.  Its implementation might not be simple, either.  Query
commands, on the other hand, are well understood and easy to implement.
