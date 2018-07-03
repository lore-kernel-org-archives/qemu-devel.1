Received: from eggs.gnu.org ([2001:4830:134:3::10]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faGnx-00041i-0H
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faGnt-0005IR-QO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:36:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faGnt-0005Hy-MT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:36:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<CAJ+F1CK2AXagKO5-Qsb3nc4xBfc_Scr+pOyM+Vn8EynZYFsqAg@mail.gmail.com>
Date: Tue, 03 Jul 2018 10:36:48 +0200
In-Reply-To: <CAJ+F1CK2AXagKO5-Qsb3nc4xBfc_Scr+pOyM+Vn8EynZYFsqAg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 3 Jul 2018
	09:05:46 +0200")
Message-ID: <877emc4swv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/32] qmp: Fixes and cleanups around OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Jul 2, 2018 at 6:21 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> We're trying to get the out-of-band execution feature ready.  This
>> series fixes a number of issues, and marks a design flaw FIXME.  More
>> work is needed.
>
> They are several related worthy cleanups in the qapi-async series.
>
> They will now conflict with your changes though.

Puh!

I haven't looked closely at the qapi-async series; the qapi-if series
took priority.

> Please take a look roughly from 4/38 to 17/38, and let me know if you
> want me to rebase it for 3.0.

Extracting its preliminary cleanups into a separate series that could be
merged more quickly makes could make sense.  I'll try to have a look.
