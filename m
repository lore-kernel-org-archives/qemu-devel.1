Received: from eggs.gnu.org ([2001:4830:134:3::10]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcKv-0007H3-S9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcKu-0000py-V0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:30:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629162046.4135-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56329b7b-c81d-791a-1605-6ba1017a61a4@amsat.org>
Date: Thu, 29 Jun 2017 13:30:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170629162046.4135-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] backends: remove empty
 trace-events file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 06/29/2017 01:20 PM, Daniel P. Berrange wrote:
> The content of the backends/trace-events file was entirely
> removed in
> 
>    commit 6b10e573d15ef82dbc5c5b3726028e6642e134f6
>    Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>    Date:   Mon May 29 12:39:42 2017 +0400
> 
>      char: move char devices to chardev/
> 
> Leaving the empty file around, causes tracetool to generate
> an empty .dtrace file which makes the dtrace compiler throw
> a syntax error.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile.objs         | 1 -
>   backends/trace-events | 0
>   2 files changed, 1 deletion(-)
>   delete mode 100644 backends/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index b2e6322..8004d6d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -122,7 +122,6 @@ trace-events-subdirs += crypto
>   trace-events-subdirs += io
>   trace-events-subdirs += migration
>   trace-events-subdirs += block
> -trace-events-subdirs += backends
>   trace-events-subdirs += chardev
>   trace-events-subdirs += hw/block
>   trace-events-subdirs += hw/block/dataplane
> diff --git a/backends/trace-events b/backends/trace-events
> deleted file mode 100644
> index e69de29..0000000
> 
