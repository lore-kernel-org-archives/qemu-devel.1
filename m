Received: from eggs.gnu.org ([2001:4830:134:3::10]:50199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebpll-0008Dy-D4
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebplj-0007pg-VB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:36:53 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ebplj-0007op-Mo
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:36:51 -0500
Received: by mail-wm0-x22c.google.com with SMTP id t74so16143473wme.3
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 07:36:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bacb3016-0470-a70d-881a-06a2b2555386@redhat.com>
References: <20180117114430.19110-1-marcandre.lureau@redhat.com>
	<a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
	<bacb3016-0470-a70d-881a-06a2b2555386@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2018 16:36:49 +0100
Message-ID: <CAJ+F1CJZAsujv0X2D3-hzrsnzivA8TEa8MiWZbJ_HcWRVy-EXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix python 2 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Hi

On Wed, Jan 17, 2018 at 3:59 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/17/2018 08:18 AM, Laszlo Ersek wrote:
>> On 01/17/18 12:44, Marc-Andr=C3=A9 Lureau wrote:
>>> Python GDB support may use Python 2 or 3.
>>>
>>> Inferior.read_memory() may return a buffer with Python 2 or a
>>> memoryview with Python 3 (see also
>>> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>>>
>>> The elf.add_vmcoreinfo_note() method expect a byte string, but Python 2
>>> buffer doesn't provide the tobyes() method. Wrap the read_memory()
>>> result to a memoryview, available in Python 2.7. (if the return object
>>> is already a memoryview, this adds a useless identity view on top)
>>
>> OOP is awesome.
>>
>>>
>>> Fixes a regression introduced with commit
>>> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").
>>
>> Do you want to CC stable? Commit d23bfa91b778 is part of v2.11.0.
>
> Configure says we still support python 2.6; does this still work there?

 memoryview is not available with python 2.6.

Is the configure version check a configure-time check, or are we
suppose to support that version for gdb scripts as well?

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>



--=20
Marc-Andr=C3=A9 Lureau
