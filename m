Received: from eggs.gnu.org ([2001:4830:134:3::10]:44476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEy6C-0005zu-Pv
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEy6C-0003GR-0O
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:46:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87oa0q1t21.fsf@dusky.pond.sub.org> <20161207025457.GB30227@lemon>
	<20161207094832.GA4773@noname.str.redhat.com>
	<20161207100339.GB2286@lemon>
Date: Thu, 08 Dec 2016 13:46:47 +0100
In-Reply-To: <20161207100339.GB2286@lemon> (Fam Zheng's message of "Wed, 7 Dec
	2016 18:03:39 +0800")
Message-ID: <87shpybnbc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block]  Meeting notes on -blockdev,
 dynamic backend reconfiguration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Fam Zheng <famz@redhat.com> writes:

> On Wed, 12/07 10:48, Kevin Wolf wrote:
>> > If so I think there is no race to worry about, mirror-filter should go
>> > away only after a QMP command.
>> 
>> Currently, a mirror job goes away whenever it is done. This is not
>> directly tied to a QMP command.
>
> Ah right, block-job-complete is only "start to complete" and the job goes away
> at some later point. I thought this is "the" QMP command but it is not.
>
>> 
>> Of course, in the new job API we want an explicit job-delete, so in
>> that case it wouldn't happen, but we need to keep the old case for
>> compatibility.
>
> Another possibility is to add a placeholder node in the right location first
> then fill in the actual throttling node once created. QMP owns the placeholder
> node so it won't suddenly vanish when mirror job goes away.

I'm not sure I understand this idea.  Could you explain it in a bit more
detail, perhaps even with a bit of ASCII art?
