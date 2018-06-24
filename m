Received: from eggs.gnu.org ([2001:4830:134:3::10]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWwUq-0005YD-II
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWwUp-0001mN-QO
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:19:28 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWwUp-0001m8-Kq
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:19:27 -0400
Received: by mail-yw0-x242.google.com with SMTP id u124-v6so3720150ywg.0
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 21:19:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f0f6c235-f66c-bd81-0a53-34a9268fdcc0@amsat.org>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<CAMo8BfK3+g-c2C9K9RxiZOAPunGoCHXrdWdz03woAxZ+aM1GUA@mail.gmail.com>
	<f0f6c235-f66c-bd81-0a53-34a9268fdcc0@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 23 Jun 2018 21:19:26 -0700
Message-ID: <CAMo8BfKyOGqnnauq6PVv8BjypMTxzYR+QmyE999VNPjaYXuCzw@mail.gmail.com>
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

On Sat, Jun 23, 2018 at 9:04 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> I appreciate including the csp cpu because it is big-endian.

csp is little endian. FSF was big endian, but the name no longer refers
to a specific processor, so it is also not very useful. Perhaps I just
need to add a well-defined big endian xtensa configuration to QEMU
and publish the overlay and prebuilt toolchain for it.

--=20
Thanks.
-- Max
