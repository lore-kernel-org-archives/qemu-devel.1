Received: from eggs.gnu.org ([209.51.188.92]:53332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTRS-0008Qh-Ti
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTRR-0002de-W0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDTRR-0002dO-Mo
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D05062D7EF
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 12:32:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
Date: Mon, 08 Apr 2019 14:31:59 +0200
In-Reply-To: <CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 8 Apr 2019
	11:20:52 +0200")
Message-ID: <87bm1gr83k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> char_pty_open() prints a "char device redirected to PTY_NAME (label
>> LABEL)" message to the current monitor or else to stderr.  No other
>> ChardevClass::open() prints anything on success.  Drop the message.
>>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  chardev/char-pty.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>
> I guess that was printed for convenience.
>
> Allocated pty can be read from "info chardev", so I suppose we can
> make qemu more silent. Fine with me:
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

If we should decide the message is still useful enough to be worth
keeping, I could direct it to stdout instead of dropping it.
