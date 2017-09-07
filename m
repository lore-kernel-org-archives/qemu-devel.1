Received: from eggs.gnu.org ([2001:4830:134:3::10]:36117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpz6L-00014e-QP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpz6G-0006xf-Tk
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpz6G-0006wl-Np
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:52:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-33-marcandre.lureau@redhat.com>
	<87fuby60vd.fsf@dusky.pond.sub.org>
	<1708774659.10407632.1504798228426.JavaMail.zimbra@redhat.com>
Date: Thu, 07 Sep 2017 17:52:10 +0200
In-Reply-To: <1708774659.10407632.1504798228426.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 7 Sep 2017
	11:30:28 -0400 (EDT)")
Message-ID: <87shfy1p79.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 32/54] qapi: add 'if' to struct members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
[...]
>> > diff --git a/tests/qapi-schema/test-qapi.py
>> > b/tests/qapi-schema/test-qapi.py
>> > index 70054848f0..5d2f67a1d3 100644
>> > --- a/tests/qapi-schema/test-qapi.py
>> > +++ b/tests/qapi-schema/test-qapi.py
>> > @@ -31,7 +31,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>> >              print '    base %s' % base.name
>> >          for m in members:
>> >              print '    member %s: %s optional=3D%s' % \
>> > -                (m.name, m.type.name, m.optional)
>> > +                (m.name, m.type.name, m.optional) + \
>> > +                (' if=3D%s' % m.ifcond if m.ifcond else '')
>>=20
>> Let's keep it simple & stupid:
>>=20
>>                print '    member %s: %s optional=3D%s if=3D%s' % \
>>                    (m.name, m.type.name, m.optional, m.ifcond)
>>=20
>
> I would rather not modify every existing test please.
>
> The last version of the series uses the trailing , trick instead:
>
>      print '%s optional=3D%s' % (m.type.name, m.optional),
>      if m.ifcond:
>          print 'if=3D%s' % m.ifcond,
>      print
>
> I think this is easier to deal with, is that ok for you too?

Yes.

>> >          self._print_variants(variants)
>> >          self._print_if(ifcond)
>>=20
>> Need negative tests, but I guess they're next.
>>=20
