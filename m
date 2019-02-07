Received: from eggs.gnu.org ([209.51.188.92]:56434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gri8l-0004XB-Le
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gri8i-0005bt-Dd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:46 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gri8b-0005Wj-KA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:42 -0500
Received: by mail-ot1-x341.google.com with SMTP id 81so17729023otj.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 11:46:23 +0000
Message-ID: <CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Tue, 5 Feb 2019 at 18:28, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e159d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-request' into staging (2019-02-05 14:01:29 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 1e924479dce65a26a7432bf5920f89c1bf957d74:
>
>   slirp: API is extern C (2019-02-05 20:27:27 +0200)
>
> ----------------------------------------------------------------
> More work towards libslirp
>

Format string issues for the Windows build:

/home/petmay01/qemu-for-merges/slirp/slirp.c: In function
'slirp_send_packet_all':
/home/petmay01/qemu-for-merges/slirp/slirp.c:1116:20: error: unknown
conversion type character 'z' in format [-Werror=format=]
         g_critical("Failed to send packet, ret: %zd", ret);
                    ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmessages.h:333:32:
note: in definition of macro 'g_critical'
                                __VA_ARGS__)
                                ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1116:20: error: too many
arguments for format [-Werror=format-extra-args]
         g_critical("Failed to send packet, ret: %zd", ret);
                    ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmessages.h:333:32:
note: in definition of macro 'g_critical'
                                __VA_ARGS__)
                                ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:21: error: unknown
conversion type character 'z' in format [-Werror=format=]
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
                     ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmessages.h:342:32:
note: in definition of macro 'g_debug'
                                __VA_ARGS__)
                                ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:9: note: in
expansion of macro 'DEBUG_ERROR'
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
         ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:21: error: unknown
conversion type character 'z' in format [-Werror=format=]
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
                     ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmessages.h:342:32:
note: in definition of macro 'g_debug'
                                __VA_ARGS__)
                                ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:9: note: in
expansion of macro 'DEBUG_ERROR'
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
         ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:21: error: too many
arguments for format [-Werror=format-extra-args]
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
                     ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmessages.h:342:32:
note: in definition of macro 'g_debug'
                                __VA_ARGS__)
                                ^
/home/petmay01/qemu-for-merges/slirp/slirp.c:1118:9: note: in
expansion of macro 'DEBUG_ERROR'
         DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret, len);
         ^
cc1: all warnings being treated as errors


All the other builds went OK.

thanks
-- PMM
