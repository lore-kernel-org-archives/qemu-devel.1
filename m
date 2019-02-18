Received: from eggs.gnu.org ([209.51.188.92]:43363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvnh4-0005hZ-4i
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvnh3-00083G-6P
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:31:06 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:38639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gvnh2-00081V-Pw
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:31:05 -0500
Received: by mail-it1-x144.google.com with SMTP id l66so196839itg.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 10:31:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <87ftsl2clg.fsf@dusky.pond.sub.org>
Date: Mon, 18 Feb 2019 13:31:01 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On Feb 18, 2019, at 13:08, Markus Armbruster <armbru@redhat.com> wrote:

> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>=20
>> On Feb 18, 2019, at 08:43, Thomas Huth <thuth@redhat.com> wrote:
>>=20
>>> On 18/02/2019 07.07, Stephen Checkoway wrote:
>>>> Hi all,
>>>>=20
>>>> I've been working on some improvements to the pflash_cfi02 block =
device (interleaved flash devices similar to pflash_cfi01, multi-sector =
erase, nonuniform sector sizes, and some bug fixes and I'm planning on =
implementing sector erase suspend/resume commands in the near future).
>=20
> Any chance you could do multiple region support, too?

Can you point me at the data sheet for a flash chip with multiple region =
support? For my purposes, I only need the features I mentioned, but if =
it's a simple change, I'll consider it.

>>> QTestState *qts;
>>> qts =3D qtest_initf(" qemu-system-arm -M musicpal,accel=3Dqtest "
>>>               "-drive if=3Dpflash,file=3D%s,format=3Draw", =
filename);
>>=20
>> If I do that, will it be possible for the test to override the =
properties set by pflash_cfi02_register? It looks like I should be able =
to use -global to set properties that aren't set explicitly.
>=20
> Yes.
>=20
> Won't work for properties set by pflash_cfi02_register(), though.  To
> test the full range of values there, you'd have to make them
> configurable somehow.  We currently don't have a good way to do that.
> Please see
>=20
>    Subject: Re: Configuring pflash devices for OVMF firmware
>    Message-ID: <87mun8gd2x.fsf@dusky.pond.sub.org>
>    =
https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01734.html

I see. That's too bad.

--=20
Stephen Checkoway
