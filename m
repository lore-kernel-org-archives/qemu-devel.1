Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKk6A-0006Jh-CH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKjsD-0006Bn-2u
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:57:25 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKjsC-0006BJ-SM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:57:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so1162817wmc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 04:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20181108125223.30804-1-peter.maydell@linaro.org>
In-Reply-To: <20181108125223.30804-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Nov 2018 16:57:11 +0400
Message-ID: <CAJ+F1CJoi8C+KfhE-0JdZBO9myj9E0922Arv2GNG4yECCbHhkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: Add multiple include guard to
 guest-agent-core.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, patches@linaro.org

Hi

On Thu, Nov 8, 2018 at 4:52 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> The guest-agent-core.h header was missing the usual guards
> against multiple inclusion; add them.
>
> (Spotted by lgtm.com's static analyzer.)

neat,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qga/guest-agent-core.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> index 6f4d214cb9f..60eae16f27a 100644
> --- a/qga/guest-agent-core.h
> +++ b/qga/guest-agent-core.h
> @@ -10,6 +10,9 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
>   */
> +#ifndef GUEST_AGENT_CORE_H
> +#define GUEST_AGENT_CORE_H
> +
>  #include "qapi/qmp/dispatch.h"
>  #include "qemu-common.h"
>  #include "qga-qapi-types.h"
> @@ -46,3 +49,5 @@ int ga_parse_whence(GuestFileWhence *whence, Error **er=
rp);
>  #ifndef _WIN32
>  void reopen_fd_to_null(int fd);
>  #endif
> +
> +#endif /* GUEST_AGENT_CORE_H */
> --
> 2.19.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
