Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C0z-0000ve-Uv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C0z-0003Qt-5S
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:02:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9C0y-0003Pf-U3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:02:29 -0400
Received: by mail-wr0-x243.google.com with SMTP id h3-v6so15471197wrh.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:02:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86162f1a-842b-f7aa-7781-f4260309925f@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<86162f1a-842b-f7aa-7781-f4260309925f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 18:02:26 +0200
Message-ID: <CAJ+F1C+ffbXOU7+xr_mhcXxt2=zu76URC4kFLM-7EskKrhj0XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Simplify qobject refcount
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

Hi

On Thu, Apr 19, 2018 at 5:45 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> This series aims to get rid of the distinction between QObject, that
>> must use qobject_incref/qobject_decref and its various derived types
>> that have to use QINCREF/QDECREF. Instead, replace it with
>> qobject_ref/qobject_unref for all types.
>
> Related question: should we do the same thing for qdict_put() vs.
> qdict_put_obj()?  That is, now that we have an easy way to always use
> QOBJECT(), it makes more sense to just have:
>
> QObject *o;
> QDict *d;
> qdict_put(dict, key1, o);
> qdict_put(dict, key2, d);
>
> rather than having to distinguish based on the type of the third argument=
.
>
> Similar for QList additions.

Good idea, that would be a lovely follow-up indeed.



--=20
Marc-Andr=C3=A9 Lureau
