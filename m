Received: from eggs.gnu.org ([209.51.188.92]:36034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grkee-0005Jn-Q0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grked-0003z5-NI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:27:52 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grkec-0003qV-AZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:27:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAMxuvawnNqvUYf2Z-+8zX63wRNFp+F_A7Uo==pY_9n1HDXumqQ@mail.gmail.com>
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
	<CAMxuvayhuXEWTvJqNyKFjuae3u47MnjN4NPQ_J+vVWLK9pM5Rg@mail.gmail.com>
	<CAMxuvawnNqvUYf2Z-+8zX63wRNFp+F_A7Uo==pY_9n1HDXumqQ@mail.gmail.com>
Date: Thu, 07 Feb 2019 15:27:43 +0100
Message-ID: <w51ftszhdwg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu 07 Feb 2019 03:24:40 PM CET, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Feb 7, 2019 at 3:23 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> On Thu, Feb 7, 2019 at 2:23 PM Alberto Garcia <berto@igalia.com> wrote:
>> >
>> > After g_source_attach() the GMainContext holds a reference to the
>> > GSource, so the caller does not need to keep it.
>> >
>> > pty_chr_state() and qio_task_thread_worker() are not doing this, so
>> > the GSource is being leaked in both cases (pty_chr_open_src_cancel()
>> > is the exception here because it does remove the extra reference
>> > correctly).
>> >
>> > Signed-off-by: Alberto Garcia <berto@igalia.com>
>>
>> You could mention this is a fix for regression from
>> a17536c594bfed94d05667b419f747b692f5fc7f
>
> and 938eb9e9c83d34d90cac6ec5c5388e7998840e4e

Ok, feel free to add this to the commit message if I don't need to
resend the series.

Berto
