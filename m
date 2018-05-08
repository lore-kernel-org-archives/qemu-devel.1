Received: from eggs.gnu.org ([2001:4830:134:3::10]:45790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG201-00051Z-S8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG1zw-0003lI-Sk
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:45:45 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG1zw-0003kz-O3
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:45:40 -0400
Received: by mail-qk0-x241.google.com with SMTP id p186so24503952qkd.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:45:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-19-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4096cacd-2d3a-8793-6c80-cb269c67f5cb@amsat.org>
Date: Tue, 8 May 2018 09:45:37 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-19-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/67] qga: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, peter.maydell@linaro.org

Hi Michael,

On 05/03/2018 04:50 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  qga/channel-posix.c             | 2 +-
>  qga/channel-win32.c             | 4 ++--
>  qga/commands-posix.c            | 2 +-
>  qga/commands-win32.c            | 2 +-
>  qga/commands.c                  | 2 +-
>  qga/guest-agent-command-state.c | 2 +-
>  qga/main.c                      | 4 ++--
>  qga/vss-win32.c                 | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index b812bf4..5a925a9 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -2,7 +2,7 @@
>  #include <termios.h>
>  #include "qapi/error.h"
>  #include "qemu/sockets.h"
> -#include "qga/channel.h"
> +#include "channel.h"
>  
>  #ifdef CONFIG_SOLARIS
>  #include <stropts.h>
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index 7e6dc4d..b3597a8 100644
> --- a/qga/channel-win32.c
> +++ b/qga/channel-win32.c
> @@ -1,8 +1,8 @@
>  #include "qemu/osdep.h"
>  #include <windows.h>
>  #include <io.h>
> -#include "qga/guest-agent-core.h"
> -#include "qga/channel.h"
> +#include "guest-agent-core.h"
> +#include "channel.h"
>  
>  typedef struct GAChannelReadState {
>      guint thread_id;
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 0dc219d..eae8171 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -16,7 +16,7 @@
>  #include <sys/utsname.h>
>  #include <sys/wait.h>
>  #include <dirent.h>
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2d48394..bc64fe8 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -32,7 +32,7 @@
>  #include <wtsapi32.h>
>  #include <wininet.h>
>  
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  #include "qga/vss-win32.h"

You missed:

#include "vss-win32.h"

>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
> diff --git a/qga/commands.c b/qga/commands.c
> index a64b34c..cce3010 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/qga/guest-agent-command-state.c b/qga/guest-agent-command-state.c
> index e609d32..18bcb59 100644
> --- a/qga/guest-agent-command-state.c
> +++ b/qga/guest-agent-command-state.c
> @@ -10,7 +10,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  #include "qemu/osdep.h"
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  
>  struct GACommandState {
>      GSList *groups;
> diff --git a/qga/main.c b/qga/main.c
> index df1888e..127b51d 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -23,12 +23,12 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qstring.h"
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  #include "qemu/module.h"
>  #include "qga-qapi-commands.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/error.h"
> -#include "qga/channel.h"
> +#include "channel.h"
>  #include "qemu/bswap.h"
>  #include "qemu/help_option.h"
>  #include "qemu/sockets.h"
> diff --git a/qga/vss-win32.c b/qga/vss-win32.c
> index 0199c2a..e834ec5 100644
> --- a/qga/vss-win32.c
> +++ b/qga/vss-win32.c
> @@ -14,7 +14,7 @@
>  #include <windows.h>
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "qga/guest-agent-core.h"
> +#include "guest-agent-core.h"
>  #include "qga/vss-win32.h"
>  #include "qga/vss-win32/requester.h"

Ditto, "vss-win32.h" and "vss-win32/requester.h".

Fixing vss-win32:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
