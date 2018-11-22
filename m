Received: from eggs.gnu.org ([2001:4830:134:3::10]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPjBd-00088p-A3
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPjBc-0003DB-DW
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:14:05 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gPjBc-0003Ba-3s
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:14:04 -0500
Received: by mail-wr1-x441.google.com with SMTP id 96so8137935wrb.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 23:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20181121224220.10595-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181121224220.10595-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Nov 2018 11:13:51 +0400
Message-ID: <CAJ+F1CLYHOQ6E34EqfMN28SsJS4vMhYque2fBuauE=CL2V5SDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Mark debugging calls as unlikely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>

Hi

On Thu, Nov 22, 2018 at 2:54 AM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> to get them out of the hot path.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/debug.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/slirp/debug.h b/slirp/debug.h
> index ff920f0b87..ad4e07aa01 100644
> --- a/slirp/debug.h
> +++ b/slirp/debug.h
> @@ -17,7 +17,7 @@
>  extern int slirp_debug;
>
>  #define DEBUG_CALL(fmt, ...) do {               \
> -    if (slirp_debug & DBG_CALL) {               \
> +    if (unlikely(slirp_debug & DBG_CALL)) {     \
>          fprintf(dfd, fmt, ##__VA_ARGS__);       \
>          fprintf(dfd, "...\n");                  \
>          fflush(dfd);                            \
> @@ -25,7 +25,7 @@ extern int slirp_debug;
>  } while (0)
>
>  #define DEBUG_ARG(fmt, ...) do {                \
> -    if (slirp_debug & DBG_CALL) {               \
> +    if (unlikely(slirp_debug & DBG_CALL)) {     \
>          fputc(' ', dfd);                        \
>          fprintf(dfd, fmt, ##__VA_ARGS__);       \
>          fputc('\n', dfd);                       \
> @@ -36,14 +36,14 @@ extern int slirp_debug;
>  #define DEBUG_ARGS(fmt, ...) DEBUG_ARG(fmt, ##__VA_ARGS__)
>
>  #define DEBUG_MISC(fmt, ...) do {               \
> -    if (slirp_debug & DBG_MISC) {               \
> +    if (unlikely(slirp_debug & DBG_MISC)) {     \
>          fprintf(dfd, fmt, ##__VA_ARGS__);       \
>          fflush(dfd);                            \
>      }                                           \
>  } while (0)
>
>  #define DEBUG_ERROR(fmt, ...) do {              \
> -    if (slirp_debug & DBG_ERROR) {              \
> +    if (unlikely(slirp_debug & DBG_ERROR)) {    \
>          fprintf(dfd, fmt, ##__VA_ARGS__);       \
>          fflush(dfd);                            \
>      }                                           \
> --
> 2.19.1
>
>

With s/unlikely/G_UNLIKELY:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
