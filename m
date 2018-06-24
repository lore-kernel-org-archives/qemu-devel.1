Received: from eggs.gnu.org ([2001:4830:134:3::10]:38626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWvhv-0005Kn-Bn
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWvhu-0000KA-KZ
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:28:55 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:36687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWvhu-0000J7-Ez
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:28:54 -0400
Received: by mail-yw0-x242.google.com with SMTP id t198-v6so3697626ywc.3
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 20:28:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180623215313.1252-1-f4bug@amsat.org>
References: <20180623215313.1252-1-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 23 Jun 2018 20:28:53 -0700
Message-ID: <CAMo8BfK3+g-c2C9K9RxiZOAPunGoCHXrdWdz03woAxZ+aM1GUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Sat, Jun 23, 2018 at 2:53 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Xtensa cpu supported:
> - dc232b
> - dc233c
> - csp
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> based on http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06782=
.html
>
> Max: Do we need to use the overlay configuration?

You'd need to use overlay if you'd build the toolchain.
Prebuilt toolchains are already configured for specific processors.
I didn't try to run it in docker, but it looks like you're doing the
right thing,
especially that you see some tests passing.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
--=20
Thanks.
-- Max
