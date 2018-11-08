Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk59-0006Jh-JF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk4R-0001PO-Sl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:10:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKk4R-0001Oz-Jk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:10:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so1145480wmf.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:10:03 -0800 (PST)
References: <20181108125223.30804-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5617372-b4dc-e602-e565-421bbef000f4@redhat.com>
Date: Thu, 8 Nov 2018 14:09:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181108125223.30804-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, patches@linaro.org

On 8/11/18 13:52, Peter Maydell wrote:
> The guest-agent-core.h header was missing the usual guards
> against multiple inclusion; add them.
> 
> (Spotted by lgtm.com's static analyzer.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   qga/guest-agent-core.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> index 6f4d214cb9f..60eae16f27a 100644
> --- a/qga/guest-agent-core.h
> +++ b/qga/guest-agent-core.h
> @@ -10,6 +10,9 @@
>    * This work is licensed under the terms of the GNU GPL, version 2 or later.
>    * See the COPYING file in the top-level directory.
>    */
> +#ifndef GUEST_AGENT_CORE_H
> +#define GUEST_AGENT_CORE_H
> +
>   #include "qapi/qmp/dispatch.h"
>   #include "qemu-common.h"
>   #include "qga-qapi-types.h"
> @@ -46,3 +49,5 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp);
>   #ifndef _WIN32
>   void reopen_fd_to_null(int fd);
>   #endif
> +
> +#endif /* GUEST_AGENT_CORE_H */
> 
