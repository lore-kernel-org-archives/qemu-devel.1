Received: from eggs.gnu.org ([2001:4830:134:3::10]:36895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eygKU-0004UO-0W
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eygKQ-0002JH-Hl
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:11:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eygKQ-0002J2-DF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:11:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id n11so5517283qti.4
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
	<407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 17:11:05 +0100
Message-ID: <CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Blake, Eric" <eblake@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

Hi

On Wed, Mar 21, 2018 at 5:00 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/03/2018 16:55, Marc-Andr=C3=A9 Lureau wrote:
>> That would work with an anonymous union though:
>>
>> struct QObject {
>>     union {
>>         QType type;
>>         QType base;
>>     };
>>     size_t refcnt;
>> };
>>
>> If it's acceptable, I think I'll take this approach.
>
> You don't need QEMU_GENERIC at all then, don't you?

Ah ah, that's what I thought too, but the type of QObject * &x->base
isn't QObject * :)

I don't think we can fool it there (without loosing some type safety)
