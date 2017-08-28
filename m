Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmHeb-00064Z-I4
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmHeW-0001oS-O2
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmHeW-0001nK-IO
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:52:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-2-marcandre.lureau@redhat.com>
	<8760dc4231.fsf@dusky.pond.sub.org>
	<20170825125718.GG15315@localhost.localdomain>
	<CAJ+F1CKJ19t__dbOf_ULYiEGc=xjdPhkwC2rZj-udXa=vTNa_g@mail.gmail.com>
Date: Mon, 28 Aug 2017 12:52:16 +0200
In-Reply-To: <CAJ+F1CKJ19t__dbOf_ULYiEGc=xjdPhkwC2rZj-udXa=vTNa_g@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	14:12:21 +0000")
Message-ID: <87y3q43qxr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/54] qapi: fix type_seen key error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Fri, Aug 25, 2017 at 2:57 PM Eduardo Habkost <ehabkost@redhat.com> wro=
te:
>
>> On Fri, Aug 25, 2017 at 08:02:26AM +0200, Markus Armbruster wrote:
>> > Conflicts with Eduardo's "[PATCH v2] qapi: Fix error handling code on
>> > alternate conflict".
>> > Message-Id: <20170717180926.14924-1-ehabkost@redhat.com>
>> >
>> > Marc-Andr=C3=A9, could you have a look?  You can rebase your fix on to=
p of
>> > Eduardo's, or merge the two into one commit.
>>
>> Both patches seem to be fixing the same bug.
>>
>
> Yes, it is solved differently. But take Eduardo's patch, it has more
> extensive tests .

Okay.

Too bad I didn't remember Eduardo's patch when I got yours.
