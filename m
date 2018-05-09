Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGHFT-0004X4-KZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGHFS-0005MC-UQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:02:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525840700-30635-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f0a24157-3aa9-4b51-8870-e83407e85697@amsat.org>
Date: Wed, 9 May 2018 02:02:31 -0300
MIME-Version: 1.0
In-Reply-To: <1525840700-30635-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add trace-events and
 qemu-option-trace.texi to tracing section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi Thomas,

On 05/09/2018 01:38 AM, Thomas Huth wrote:
> The "trace-events" and "qemu-option-trace.texi" files in the top directory
> are currently "unmaintained" according to scripts/get_maintainer.pl. They
> obviously belong to the Tracing section, so add an entry for them there.

I agree qemu-option-trace.texi belongs to the Tracing section,
however I think trace-events is not specific to Tracing but belongs to
everybody maintaining a C file in the top directory... Since they'll
need to modify this file.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 459e359..e187b1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1656,6 +1656,8 @@ Tracing
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Maintained
>  F: trace/
> +F: trace-events

So without "trace-events":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +F: qemu-option-trace.texi
>  F: scripts/tracetool.py
>  F: scripts/tracetool/
>  F: docs/devel/tracing.txt
> 
