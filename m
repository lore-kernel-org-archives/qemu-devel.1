Received: from eggs.gnu.org ([2001:4830:134:3::10]:37083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnPzZ-0004Wi-RB
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnPzV-0007cr-V7
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnPzV-0007cl-OZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:58:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-2-marcandre.lureau@redhat.com>
	<8b2a2be0-cf5f-29e4-b204-1da6b20539b7@redhat.com>
	<87r2vtgt7r.fsf@dusky.pond.sub.org>
Date: Thu, 31 Aug 2017 15:58:35 +0200
In-Reply-To: <87r2vtgt7r.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 30 Aug 2017 14:01:28 +0200")
Message-ID: <87r2vrj0tw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 08/25/2017 05:59 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> A step towards completeness.
>>>=20
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  include/qapi/qmp/qdict.h | 4 +++-
>>>  target/i386/cpu.c        | 4 ++--
>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> Is it worth touching up scripts/coccinelle/qobject.cocci at the same tim=
e?
>
> Let's keep it up-to-date.  I can do it when I apply.

Squashing in the appended patch.  I verified it produces exactly the
change to target/i386/cpu.c Marc-Andr=C3=A9 did manually, and no others.


diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.=
cocci
index c518caf7b1..1120eb1a42 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -20,6 +20,9 @@ expression Obj, Key, E;
 |
 - qdict_put(Obj, Key, qstring_from_str(E));
 + qdict_put_str(Obj, Key, E);
+|
+- qdict_put(Obj, Key, qnull());
++ qdict_put_null(Obj, Key);
 )
=20
 // Use QList macros where they make sense
