Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCZd-0000LR-Jn
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCZZ-0006to-02
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:05:13 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVCZY-0006t4-Pb
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:05:08 -0400
Received: by mail-wr0-x244.google.com with SMTP id x4-v6so19678782wro.11
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 02:05:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619062158.xreqany3tlnpmzn6@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-4-marcandre.lureau@redhat.com>
	<20180619062158.xreqany3tlnpmzn6@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Jun 2018 11:05:03 +0200
Message-ID: <CAJ+F1CJ7jvg=oR0BxF-96tYZy=AnnHYQ0ZnhN0jHNfS7TDZozg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/26] dmabuf: add y0_top,
 pass it to spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jun 19, 2018 at 8:21 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Jun 18, 2018 at 06:17:06PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Some scanouts during boot are top-down without this.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/ui/console.h | 1 +
>>  ui/spice-display.c   | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index 981b519dde..fb969caf70 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -186,6 +186,7 @@ struct QemuDmaBuf {
>>      uint32_t  stride;
>>      uint32_t  fourcc;
>>      uint32_t  texture;
>> +    bool      y0_top;
>>  };
>>
>>  typedef struct DisplayChangeListenerOps {
>
> Looks incomplete, who sets y0_top?
>
> Also: send the bugfixes (patches 1-6 ?) separate, so they can be merged
> already while the input + gpu details are hashed out?

That makes sending / managing seperate series more complicated. You
need to reference some other series for reviewers, patchew etc,

It's easier if the first / reviewed patches of the series are picked.
But that may involve separate maintainers, I'll ping some of them.

thanks

--=20
Marc-Andr=C3=A9 Lureau
