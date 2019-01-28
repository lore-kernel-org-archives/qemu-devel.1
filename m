Received: from eggs.gnu.org ([209.51.188.92]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go52v-0000o7-Si
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go52u-0003Dr-Uc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:25:45 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go52u-000396-06
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:25:44 -0500
Received: by mail-oi1-x244.google.com with SMTP id r62so12749945oie.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20190127015113.1599-1-samuel.thibault@ens-lyon.org>
	<20190127015509.ngofhbiduuwwbf7r@function>
	<CAJ+F1CKYNEVXNbmN2ppvPOtN_2nMyzTX612aZ9twnYc0+Rgg_Q@mail.gmail.com>
	<b71e3a2b-61d6-2a2d-3c17-f9c832b4cad4@redhat.com>
In-Reply-To: <b71e3a2b-61d6-2a2d-3c17-f9c832b4cad4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 11:25:08 +0000
Message-ID: <CAFEAcA8arejWDEYd1zZhFR+ANyOeJ8KsJvVR==pE55dDZoO5Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Replace QEMU_BUILD_BUG_ON with own
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 28 Jan 2019 at 11:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 1/27/19 12:37 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Did you try using G_STATIC_ASSERT* instead?
> [...]
>
> Is there a same plan for QEMU codebase?

Our version uses _Static_assert where possible, which I think
will give better error messages than the glib version. There are
also some corner cases where the glib macros don't work:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07090.html

Broadly, our implementation works and so I don't see much need
to mess with it, outside of the special case of slirp that's
trying to cut its ties with QEMU.

thanks
-- PMM
