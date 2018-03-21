Received: from eggs.gnu.org ([2001:4830:134:3::10]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyea6-0002HN-DG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyea2-0007iX-7L
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eyea2-0007i9-27
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:06 -0400
Received: by mail-qk0-f194.google.com with SMTP id g184so5567385qkd.10
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:19:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9efff62f-1762-12ff-02c2-6d117163a1c9@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<9efff62f-1762-12ff-02c2-6d117163a1c9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:19:05 +0100
Message-ID: <CAMxuvazUcPpfLZCy3nGX6kVbNepy4VDq7wsM7Ygz5DPGpRp6=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] RFC: simplify qobject refcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>

Hi

On Wed, Mar 21, 2018 at 3:09 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/21/2018 08:40 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi,
>>
>> This series aims to get rid of the distinction between QObject, that
>> must use qobject_incref/qobject_decref and its various derived types
>> that have to use QINCREF/QDECREF. Instead, replace it with
>> qobject_ref/qobject_unref for all types.
>
>
> I _like_ the fact that you don't have to use a different thing for the ba=
se
> class compared to the derived classes.  I'm not sure I like that the name
> got longer in the QINCREF -> qobject_ref direction, but it got shorter in
> the qobject_incref =3D> qobject_ref direction, so maybe bikeshedding on t=
he
> final name is still possible?

sure :) Tbh, I'd rather keep the qobject prefix for clarity, but we
could also go for qref/qunref ?

>
>>
>> Marc-Andr=C3=A9 Lureau (3):
>>    compiler: extend QEMU_GENERIC to handle more arguments
>>    qobject: assume base of a qobject is at offset 0
>>    qobject: replace qobject_incref/QINCREF qobject_decref/QDECREF
>
>
> But I definitely think this is 2.13 material.  It is easy to do (mechanic=
al
> conversion in 3/3) but a conflict magnet, so it would need to land early
> after the freeze is lifted.

Fortunately, it's a straightforward sed replacement.

thanks
