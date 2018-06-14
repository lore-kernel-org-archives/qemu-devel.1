Received: from eggs.gnu.org ([2001:4830:134:3::10]:35351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPdc-0008F9-0j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPdb-0007iL-7M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:37:56 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTPdb-0007i1-2D
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:37:55 -0400
Received: by mail-oi0-x22f.google.com with SMTP id 188-v6so5168123oid.12
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 03:37:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABhKiVVkQkBECYauEZpjvdm=1L5V5zXhx=C=vZ_dZhF2AkSsnA@mail.gmail.com>
References: <CABhKiVVkQkBECYauEZpjvdm=1L5V5zXhx=C=vZ_dZhF2AkSsnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 11:37:33 +0100
Message-ID: <CAFEAcA9WKhQLpTkkjz2ETTrtbVVqAPdkf7_Y4uBhvKAQ9qvvxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Questions about qemu enabling TCI (tcg/tci.c)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yt zhang <zyt510998645@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On 13 June 2018 at 15:10, yt zhang <zyt510998645@gmail.com> wrote:
>  Dear technicians=EF=BC=8C
> Good day.
> I encountered some difficulties in learning about the TCI part of QEMU.
> When I use the following configuration command to enable TCI:
>
>          "configure --enable-tcg-interpreter"
>
> Run the command as:
>
>         "qemu-x86_64 hello-one" (hello-one is my own executable file).
>
> Then I counted the number of times TB was interpreted in the
> "tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)" function in the
> tcg/tci.c file.However, I found that running the above command several
> times on the same host computer [Intel(R) Pentium(R) CPU G3250 @ 3.20GHz]=
,
> the number of TB counts may sometimes be different (as shown below).

I think that's expected. We don't try to be purely deterministic
by default. You may find that suitable use of the -icount option
will give you more deterministic behaviour (though if your guest
program works with timers or signals or multiple threads it
will likely still not be deterministic.)

thanks
-- PMM
