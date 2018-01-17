Received: from eggs.gnu.org ([2001:4830:134:3::10]:41366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbt-0004GX-Q0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbo-0007i1-NK
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:33 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnbo-0007hd-Gp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:18:28 -0500
Received: by mail-qk0-x243.google.com with SMTP id b76so25193300qkc.1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:18:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 17 Jan 2018 10:18:18 -0300
Message-Id: <20180117131821.18700-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/3] add QEMU_WARN_NONNULL_ARGS() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Weil <sw@weilnetz.de>

Some old PoC series I remember after reading
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03545.html

I had few more changes but then I found the code was harder to read
so I didn't continue further.
Only 2 patches are included as example.

This might still be useful in few cases, so I'm still sending as RFC
to have different thoughts.

This macro is, however, helpful to the Clang static analizer (reducing
false positive).

BTW another useful macro for the static analizer I used is:

    #define QEMU_FALLTHROUGH __attribute__((fallthrough))

It replaces the /* fall through */ comment, i.e.:

    switch (rap) {
    case BCR_SWS:
        if (!(CSR_STOP(s) || CSR_SPND(s)))
            return;
        val &= ~0x0300;
        QEMU_FALLTHROUGH;
    case BCR_LNKST:
    case BCR_LED1:
    case BCR_LED2:
    case BCR_LED3:
    case BCR_MC:
    case BCR_FDC:
    case BCR_BSBC:
    case BCR_EECAS:
    case BCR_PLAT:
        s->bcr[rap] = val;
        break;

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  compiler: add QEMU_WARN_NONNULL_ARGS()
  virtio: let virtio_add/clear_feature() use QEMU_WARN_NONNULL_ARGS()
  utils: let qemu_find_file() use QEMU_WARN_NONNULL_ARGS()

 include/hw/virtio/virtio.h | 2 ++
 include/qemu-common.h      | 2 +-
 include/qemu/compiler.h    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.15.1
