Received: from eggs.gnu.org ([2001:4830:134:3::10]:53825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej102-0004y5-0l
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej100-0006V6-V5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:18 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:52100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ej100-0006TZ-Nk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:16 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r71so2951543wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:01:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <877erri9tr.fsf@dusky.pond.sub.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-43-marcandre.lureau@redhat.com>
	<CAJ+F1CLrSaCthi3HZhg1629oycPS=cPHkOBs1PcVBsvFy=9M1w@mail.gmail.com>
	<877erri9tr.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Feb 2018 12:01:14 +0100
Message-ID: <CAJ+F1CJYXr-w34E8jK_gJUYPKf88zL5znFOibtcSV8bQy0Kc3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 42/51] qapi: add a 'unit' pragma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Feb 5, 2018 at 7:13 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> Hi
>>
>> On Thu, Jan 11, 2018 at 10:32 PM, Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com> wrote:
>>> Add a pragma that allows to tag the following expressions in the
>>> schema with a unit name. By default, an expression has no unit name.
>>>
>>> See the docs/devel/qapi-code-gen.txt for more details.
>>>
>>
>> I inadvertently merged the following patch "qapi: add a -u/--unit
>> option to specify which unit to visit" with this one.
>>
>> Fixed in the github branch: https://github.com/elmarco/qemu/commits/qapi=
-if
>
> Looks like it's still messed up: the patch there adds the pragma to
> docs/devel/qapi-code-gen.txt, the test cases, but no code.  Make check
> fails.  The code appears to be in the next patch.  Please advise.
>

More rebase mistakes.. fixed in github.

How do you want to proceed? The -u/-i options from this series seems
unnecessary one we have the "modularize generated qapi code" you
proposed. But -i/-u can easily be removed too later on, depending on
what goes first.

If you can take the first patches of the series, and tell me based on
what I should rebase or what to expect, I can keep working on it. In
the meantime, I am a bit stuck.

--=20
Marc-Andr=C3=A9 Lureau
