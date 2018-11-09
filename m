Received: from eggs.gnu.org ([2001:4830:134:3::10]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL7w4-0001Dg-BV
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL7vy-00044m-DU
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:39:00 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gL7vy-000418-2W
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:38:54 -0500
Received: by mail-ot1-x341.google.com with SMTP id g27so1776231oth.6
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 06:38:50 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181108125223.30804-1-peter.maydell@linaro.org>
References: <20181108125223.30804-1-peter.maydell@linaro.org>
Message-ID: <154177430958.30260.271593048509294891@sif>
Date: Fri, 09 Nov 2018 08:38:29 -0600
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

Quoting Peter Maydell (2018-11-08 06:52:23)
> The guest-agent-core.h header was missing the usual guards
> against multiple inclusion; add them.
> =

> (Spotted by lgtm.com's static analyzer.)
> =

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/guest-agent-core.h | 5 +++++
>  1 file changed, 5 insertions(+)
> =

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
> -- =

> 2.19.1
>=20
