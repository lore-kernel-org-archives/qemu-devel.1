Received: from eggs.gnu.org ([2001:4830:134:3::10]:52562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXnoL-00006o-V5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXnoL-00045Y-1Q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXnoK-00044Z-Qd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:10:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
	<CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
Date: Wed, 19 Jul 2017 14:10:31 +0200
In-Reply-To: <CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 19 Jul 2017
	12:06:52 +0200")
Message-ID: <87h8y8iq4o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Jul 19, 2017 at 9:09 AM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> QMP command
>>
>>     { "execute": "change",
>>       "arguments": { "device": "vnc", "target": "password", "arg": PWD }=
 }
>>
>> behaves just like
>>
>>     { "execute": "change-vnc-password",
>>       "arguments": { "password", "arg": PWD } }
>>
>> Their documentation differs, however.  According to
>> change-vnc-password's documentation, "an empty password [...] will set
>> the password to the empty string", while change's documentation claims
>> "no future logins will be allowed".  The former is actually correct.
>> Replace the incorrect claim by a reference to change-vnc-password.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> The password would have to be NULL to disallow further login, is that
> what your other series will allow to do?

I guess it could be applied to change-vnc-password that way.
