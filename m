Received: from eggs.gnu.org ([2001:4830:134:3::10]:44314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3iuq-00019Z-Di
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3iup-0004qK-GU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:57:32 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f3iup-0004pn-8M
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:57:31 -0400
Received: by mail-wm0-x234.google.com with SMTP id r82so43186282wme.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 06:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <73aa8f1a-31dd-f7d1-2210-1082edc277d9@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<73aa8f1a-31dd-f7d1-2210-1082edc277d9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Apr 2018 15:57:29 +0200
Message-ID: <CAJ+F1CJkDM86RGfATxGzALhC=Ct6eOOa3tfpqHhvgwPi5eMMDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/38] RFC: monitor: add asynchronous
 command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Wed, Apr 4, 2018 at 3:45 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/26/2018 10:08 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> One of initial design goals of QMP was to have "asynchronous command
>> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
>> goal was not fully achieved, and some broken bits left were removed
>> progressively until commit 65207c59d that removed async command
>> support.
>>
>
>> v3:
>> - complete rework, dropping the asynchronous commands visibility from
>>   the protocol side entirely (until there is a real need for it)
>> - rebased, with a few preliminary cleanup patches
>
> Are any of the preliminary cleanup patches appropriate for 2.12 as bug
> fixes?

Nothing urgent, just a few cleanups (I'll need to rebase).

Btw, the conditional series ( [Qemu-devel] [PATCH v3 00/49] qapi: add
#if pre-processor conditions to generated code ) is of higher priority
I think.

Thanks

--=20
Marc-Andr=C3=A9 Lureau
