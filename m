Received: from eggs.gnu.org ([2001:4830:134:3::10]:39330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNJJU-0001MM-0c
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNJJP-0006AI-1J
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:07:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eNJJO-00069t-Qm
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:07:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-21-marcandre.lureau@redhat.com>
	<87tvx1e2xz.fsf@dusky.pond.sub.org>
Date: Fri, 08 Dec 2017 15:07:28 +0100
In-Reply-To: <87tvx1e2xz.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 08 Dec 2017 14:58:48 +0100")
Message-ID: <87o9n9cnz3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 20/50] qapi-event: add 'if' condition to
 generated enum
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Add condition to QAPIEvent enum members based on the event 'if'.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi-event.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
>> index 38f4264817..60c6f7030d 100644
>> --- a/scripts/qapi-event.py
>> +++ b/scripts/qapi-event.py
>> @@ -168,7 +168,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>>          self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
>>          self.defn +=3D gen_event_send(name, arg_type, boxed)
>> -        self._event_names.append(QAPISchemaMember(name))
>> +        self._event_names.append(QAPISchemaMember(name, ifcond))
>>=20=20
>>=20=20
>>  (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_l=
ine()
>
> No test coverage?

Wait!  This patch has no effect, because the it merely puts the ifcond
argument into QAPISchemaMember.ifcond.  Only later patches put
QAPISchemaMember.ifcond to use.  Correct?

Aside: the ifcond_decorator could already be doing something with the
argument, but I'll be hanged if I remember how that magic works.
