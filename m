Received: from eggs.gnu.org ([2001:4830:134:3::10]:49847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej2PR-0006dC-TP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej2PM-0006tJ-4o
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej2PL-0006rd-Uk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:31:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-43-marcandre.lureau@redhat.com>
	<CAJ+F1CLrSaCthi3HZhg1629oycPS=cPHkOBs1PcVBsvFy=9M1w@mail.gmail.com>
	<877erri9tr.fsf@dusky.pond.sub.org>
	<CAJ+F1CJYXr-w34E8jK_gJUYPKf88zL5znFOibtcSV8bQy0Kc3Q@mail.gmail.com>
Date: Tue, 06 Feb 2018 13:31:29 +0100
In-Reply-To: <CAJ+F1CJYXr-w34E8jK_gJUYPKf88zL5znFOibtcSV8bQy0Kc3Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 6 Feb 2018
	12:01:14 +0100")
Message-ID: <87eflyb8pq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Cleber Rosa <crosa@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Mon, Feb 5, 2018 at 7:13 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> Hi
>>>
>>> On Thu, Jan 11, 2018 at 10:32 PM, Marc-Andr=C3=A9 Lureau
>>> <marcandre.lureau@redhat.com> wrote:
>>>> Add a pragma that allows to tag the following expressions in the
>>>> schema with a unit name. By default, an expression has no unit name.
>>>>
>>>> See the docs/devel/qapi-code-gen.txt for more details.
>>>>
>>>
>>> I inadvertently merged the following patch "qapi: add a -u/--unit
>>> option to specify which unit to visit" with this one.
>>>
>>> Fixed in the github branch: https://github.com/elmarco/qemu/commits/qap=
i-if
>>
>> Looks like it's still messed up: the patch there adds the pragma to
>> docs/devel/qapi-code-gen.txt, the test cases, but no code.  Make check
>> fails.  The code appears to be in the next patch.  Please advise.
>>
>
> More rebase mistakes.. fixed in github.
>
> How do you want to proceed? The -u/-i options from this series seems
> unnecessary one we have the "modularize generated qapi code" you
> proposed. But -i/-u can easily be removed too later on, depending on
> what goes first.

Modularization first would be less churn.  But it's not quite complete,
yet.

> If you can take the first patches of the series, and tell me based on
> what I should rebase or what to expect, I can keep working on it. In
> the meantime, I am a bit stuck.

This series' clash with my modularization patches should not interfere
much with reviewing it.  Let me try and see how far I get.
