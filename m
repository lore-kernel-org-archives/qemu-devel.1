Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1driGP-0001Se-EB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1driGO-0001LS-Go
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:17:53 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1driGO-0001L8-CK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:17:52 -0400
Received: by mail-io0-x244.google.com with SMTP id j26so312630iod.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 03:17:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912033333.GA29091@pxdev.xzpeter.org>
References: <20170911132627.9505-1-cohuck@redhat.com>
	<20170912033333.GA29091@pxdev.xzpeter.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Sep 2017 12:17:51 +0200
Message-ID: <CAJ+F1CLYrsOXO74nV4zpKffJgMkSPmBi84ARs22EJGAe0xTC0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Peter

On Tue, Sep 12, 2017 at 5:33 AM, Peter Xu <peterx@redhat.com> wrote:
> On Mon, Sep 11, 2017 at 03:26:27PM +0200, Cornelia Huck wrote:
>> It does not really make sense to dump memory that is not there.
>>
>> Moreover, that fixes a segmentation fault when calling dump-guest-memory
>> with no filter for a machine with no memory defined.
>>
>> New behaviour is:
>>
>> (qemu) dump-guest-memory /dev/null
>> dump: no guest memory to dump
>> (qemu) dump-guest-memory /dev/null 0 4096
>> dump: no guest memory to dump
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> Another unmaintained file. Joy. cc:ing some more-or-less random folks.
>
> I thought Marc-Andr=C3=A9 had proposed to be the maintainer? But indeed I
> didn't see the line in maintainer file.
>
> Anyway, if anyone think I am ok to maintain this single file
> (considering that I haven't posted patches on it for 2 years, and I
> haven't been working on any kind of maintainer job), please let me
> know. I'm glad to start with it (or with Marc-Andr=C3=A9).
>

That would be great!
thanks



--=20
Marc-Andr=C3=A9 Lureau
