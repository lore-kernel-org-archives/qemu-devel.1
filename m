Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzMis-0002Qr-2L
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzMTW-00086J-Eo
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:43:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzMTV-000863-VS
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:43:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id a108-v6so21971385wrc.13
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 06:43:33 -0700 (PDT)
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-6-cota@braap.org>
	<87d0tld83i.fsf@linaro.org> <20180910123020.GA19941@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180910123020.GA19941@flamenco>
Date: Mon, 10 Sep 2018 14:43:31 +0100
Message-ID: <875zzdcvss.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Sep 10, 2018 at 10:17:53 +0100, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > Needed for MTTCG.
>> >
>> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>> > ---
>> >  target/i386/translate.c | 24 ++++++++++++++++--------
>> >  1 file changed, 16 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/target/i386/translate.c b/target/i386/translate.c
>> > index 1f9d1d9b24..9a6a72e205 100644
>> > --- a/target/i386/translate.c
>> > +++ b/target/i386/translate.c
>> > @@ -71,26 +71,34 @@
>> >
>> >  //#define MACRO_TEST   1
>> >
>> > +/* we need thread-local storage for mttcg */
>> > +#ifdef CONFIG_USER_ONLY
>> > +#define I386_THREAD
>> > +#else
>> > +#define I386_THREAD __thread
>> > +#endif
>> > +
>>
>> I'm confused - as we can have multi-threaded user space don't the same
>> requirements apply?
>
> In user-mode, code generation is serialized by mmap_lock.
> Making these per-thread would just waste TLS space.

Ahh this is still the case - ok.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
