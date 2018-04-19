Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9BOw-0002cm-KO
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9BOq-0000dK-Ku
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:23:10 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9BOq-0000cb-CJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:23:04 -0400
Received: by mail-wr0-x244.google.com with SMTP id w3-v6so15132686wrg.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 08:23:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
	<d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 17:23:02 +0200
Message-ID: <CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Apr 19, 2018 at 5:20 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>> All QObject types have the base QObject as their first field. This
>> allows the simplification of qobject_to().
>>
>> This explicitly guarantees that existing casts work correctly (even
>> though we'd prefer to get rid of such casts in any location except the
>> qobject.h macros)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> My R-b stands that this is correct from a coding point of view.  But if
> I read Markus' review correctly, we could omit this patch, fix the one
> broken client in tests/check-qdict.c to use qobject_to() (why didn't you
> fix that in v6)?, and then just apply patches 2-5 without this patch,
> with no change in behavior and where we are no longer dependent on using
> offset 0 (even though all current instances do).  So, I'll leave that to
> maintainer discretion.
>

I don't think we have a good reason to allow offset different than 0.
The fact that we have code that rely on that behaviour already is a
sign that this could easily happen again, because it's the common
pattern in C for inheritance, and static casting is allowed, for
better or worse.



--=20
Marc-Andr=C3=A9 Lureau
