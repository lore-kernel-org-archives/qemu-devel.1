Received: from eggs.gnu.org ([2001:4830:134:3::10]:36366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dOQ6r-0001fm-QY
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dOQ6r-0007FE-0y
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:02:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dOQ6q-0007F6-SS
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:02:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id r62so6513708qkf.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 08:02:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tw36sr55.fsf@linaro.org>
References: <CAGKXQydF6Y6xpfHGb3neVC-x72o+FEnvHBis87A3JbWRAmoGYA@mail.gmail.com>
	<87tw36sr55.fsf@linaro.org>
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Fri, 23 Jun 2017 19:32:34 +0430
Message-ID: <CAGKXQydodgWiEUstZ4pvPD5g9E92nA5jxWWThCJCfNaoEuGiwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] TARGET_PAGE_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

thank you for answer
So. why do we have right shift in qemu by "TARGET_PAGE_BITS" ? for exampe
in below code, what does it mean?

static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
                                                       ram_addr_t length)
{
    unsigned long end, page;

    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
    page =3D start >> TARGET_PAGE_BITS;
...
}
thanks a lot

On Fri, Jun 23, 2017 at 7:11 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

>
> ali saeedi <ali.saeedi56@gmail.com> writes:
>
> > Hello
> > What does TARGET_PAGE_BITS mean in qemu code?
>
> It's the page size of the target. e.g.
>
>   TARGET_PAGE_BITS 12
>
>   1 << 12 =3D 4096 =3D 4k pages
>
>
> > thanks a lot
>
>
> --
> Alex Benn=C3=A9e
>
