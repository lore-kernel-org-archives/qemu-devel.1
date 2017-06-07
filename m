Received: from eggs.gnu.org ([2001:4830:134:3::10]:49691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIX1m-0004sb-Up
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIX1m-000562-1w
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:13:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIX1l-00055b-PD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:13:21 -0400
Received: by mail-wr0-x230.google.com with SMTP id v111so3220490wrc.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 02:13:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607074632.13162-3-marcandre.lureau@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 10:13:00 +0100
Message-ID: <CAFEAcA8FpdJEt2M5jHQjRE5OcHQ=XQoL=q3O=5ptBnc2UfN7Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 7 June 2017 at 08:46, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m> wrote:
> The coccinelle/round.cocci script doesn't catch hard coded values.
>
> I used the following script over qemu code base:
>
> (
> - ((e1) + 3) / (4)
> + DIV_ROUND_UP(e1,4)
> |
> - ((e1) + (3)) / (4)
> + DIV_ROUND_UP(e1,4)

Why do we need both of these? Is it just "coccinelle is weird" ? :-)

> |
> - ((e1) + 7) / (8)
> + DIV_ROUND_UP(e1,8)
> |
> - ((e1) + (7)) / (8)
> + DIV_ROUND_UP(e1,8)
> |
> - ((e1) + 15) / (16)
> + DIV_ROUND_UP(e1,16)
> |
> - ((e1) + (15)) / (16)
> + DIV_ROUND_UP(e1,16)
> |
> - ((e1) + 31) / (32)
> + DIV_ROUND_UP(e1,32)
> |
> - ((e1) + (31)) / (32)
> + DIV_ROUND_UP(e1,32)
> )

> -                     next_op =3D op_pointer + ((oplen + 7) / 8);
> +                     next_op =3D op_pointer + (DIV_ROUND_UP(oplen, 8));

I think there's a coccinelle trick for making it drop
now-unnecessary brackets in substitutions like this, but I forget
what it is. Maybe it's as simple as having substitutions for

> - (((e1) + 7) / (8))
> + DIV_ROUND_UP(e1,8)

as well?

thanks
-- PMM
