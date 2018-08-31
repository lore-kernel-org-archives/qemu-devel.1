Received: from eggs.gnu.org ([2001:4830:134:3::10]:60135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvchb-00064V-Gf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvchY-0001Tl-D4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvchY-0001Te-8b
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:14:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-5-marcandre.lureau@redhat.com>
	<87sh2vzyux.fsf@dusky.pond.sub.org>
	<CAJ+F1CJLFGgM8QcY1HpfnRjOYfPUW_7F4ZSZ7ksvPfnDoNO5dQ@mail.gmail.com>
Date: Fri, 31 Aug 2018 08:14:34 +0200
In-Reply-To: <CAJ+F1CJLFGgM8QcY1HpfnRjOYfPUW_7F4ZSZ7ksvPfnDoNO5dQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 30 Aug 2018
	18:18:27 +0200")
Message-ID: <87efefukol.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] char: update the mux hanlders in class
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Aug 30, 2018 at 4:58 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Instead of handling mux chardev in a special way in
>> > qemu_chr_fe_set_handlers(), we may use the chr_update_read_handler
>> > class callback instead.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> In your subject, s/hanlders/handlers/.
>
> oops, fixed
>
> does it get you r-b ?

I haven't looked at the patch, yet :)
