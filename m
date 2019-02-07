Received: from eggs.gnu.org ([209.51.188.92]:42017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grj57-0002CF-A7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grj56-000678-I4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:47:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grj56-00065c-C3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:47:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F5D013CF4
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 12:47:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-4-armbru@redhat.com>
	<CAMxuvaxkDUt=kBxJ+nBQGGx1z18T5F7pt3TQ97KOcvGg_ag+7w@mail.gmail.com>
Date: Thu, 07 Feb 2019 13:46:57 +0100
In-Reply-To: <CAMxuvaxkDUt=kBxJ+nBQGGx1z18T5F7pt3TQ97KOcvGg_ag+7w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 7 Feb 2019
	12:15:53 +0100")
Message-ID: <87tvhfepfi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/17] qapi: Clean up modular built-in
 code generation a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> We neglect to call .visit_module() for the special module we use for
>> built-ins.  Harmless, but clean it up anyway.  The
>> tests/qapi-schema/*.out now show the built-in module as 'module None'.
>>
>> Subclasses of QAPISchemaModularCVisitor need to ._add_module() this
>> special module to enable code generation for built-ins.  When this
>> hasn't been done, QAPISchemaModularCVisitor.visit_module() does
>> nothing for the special module.  That looks like built-ins could
>> accidentally be generated into the wrong module when a subclass
>> neglects to call ._add_module().  Can't happen, because built-ins are
>> all visited before any other module.  But that's non-obvious.  Switch
>> off code generation explicitly.
>>
>> Split QAPISchemaModularCVisitor._add_module() into ._add_user_module()
>> and ._add_system_module(), for clarity.
>
> That's in next patch.

You caught me fiddling with the patch split after having written the
commit messages.  Will fix.

>> Rename QAPISchemaModularCVisitor._begin_module() to
>> ._begin_user_module().
>>
>> New QAPISchemaModularCVisitor._is_builtin_module(), for clarity.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
