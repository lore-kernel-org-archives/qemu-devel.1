Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIDft-00052S-Sc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIDfp-0003eN-T6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:33:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIDfp-0003dU-Ma
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:33:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-20-marcandre.lureau@redhat.com>
	<87y3tabikl.fsf@dusky.pond.sub.org>
	<CAJ+F1CKUTua8M17pLpDpCBcvaRHtHC-ONqZX-P6_7-WWmaoH3A@mail.gmail.com>
	<CAJ+F1CLY9P+VPU845wKGAX+-UwAM4eMt6x+WKgmpW9FmkmGi=A@mail.gmail.com>
Date: Tue, 06 Jun 2017 14:33:22 +0200
In-Reply-To: <CAJ+F1CLY9P+VPU845wKGAX+-UwAM4eMt6x+WKgmpW9FmkmGi=A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 02 Jun 2017
	14:05:01 +0000")
Message-ID: <8760g9thwt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/45] qdev: add unsigned properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Fri, Jun 2, 2017 at 6:00 PM Marc-Andr=C3=A9 Lureau <marcandre.lureau@g=
mail.com>
> wrote:
>
>> On Fri, Jun 2, 2017 at 5:55 PM Markus Armbruster <armbru@redhat.com>
>> wrote:
>>
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>
>>> > Add and use unsigned type for various properties.
>>> >
>>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> The commit message is a bit misleading.  We don't "add unsigned
>>> properties", we clean up the property code to avoid type casts between
>>> signed and unsigned.
>>>
>>
>> That in itself is imho a good reason for the cleanup :)

I could accept that with a commit message that says so :)

> There might be other reason, as if a value is stored as negative QNum/i64
> after cast, and later retrieve with get_uint(), it will fail.

I see.

>>> I'm not sure that's worth the churn by itself.  But perhaps it helps
>>> later in this series.  If yes, can you give me a hint?
>>>
>>
>> Churn is quite minimal though.
