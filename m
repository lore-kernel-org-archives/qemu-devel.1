Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTkjS-0002bh-2c
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTkXw-0004Lz-Bn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTkXw-0004Lp-6h
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:29:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-3-marcandre.lureau@redhat.com>
	<87in0b84r6.fsf@dusky.pond.sub.org>
	<CAJ+F1CJQ0SGWnQvL7A8oYHCiuyv-2wS_78Aoeco2ZMLVpH9gLw@mail.gmail.com>
Date: Mon, 03 Dec 2018 10:29:39 +0100
In-Reply-To: <CAJ+F1CJQ0SGWnQvL7A8oYHCiuyv-2wS_78Aoeco2ZMLVpH9gLw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 3 Dec 2018
	12:04:00 +0400")
Message-ID: <8736rf6jr0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] monitor: accept chardev input from
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Dec 3, 2018 at 11:26 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Chardev backends may not handle safely IO events from concurrent
>> > threads.
>>
>> What exactly could go wrong?  Or is this a well-known fact that doesn't
>> need further elaboration?
>
> chardev are not thread-safe. Only the write path is, since commit
> 9005b2a7589540a3733b3abdcfbccfe7746cd1a1.

Add this to your commit message?  Your call.

>> "safely handle I/O events"
>>
>> >          Better to wake up the chardev from the monitor IO thread if
>> > it's being used as the chardev context.
>> >
>> > Unify code paths by using a BH in all cases.
>> >
>> > Drop the now redundant aio_notify() call.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
