Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5hP-0000xw-1Z
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5hK-00019C-Cj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:16:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez5hK-000190-7P
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:16:26 -0400
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
	<20180322180940.8253-2-jcmvbkbc@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6de7c7f7-c2db-c575-53ef-18118c0f4df3@redhat.com>
Date: Thu, 22 Mar 2018 14:16:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180322180940.8253-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/xtensa: add .inc. to non-top
 level source file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/22/2018 01:09 PM, Max Filippov wrote:
> Fix definitions of existing cores and core importing script.

This mentions the script...

> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   target/xtensa/core-dc232b.c                                           | 4 ++--
>   target/xtensa/core-dc232b/{gdb-config.c => gdb-config.inc.c}          | 0
>   target/xtensa/core-dc232b/{xtensa-modules.c => xtensa-modules.inc.c}  | 0
>   target/xtensa/core-dc233c.c                                           | 4 ++--
>   target/xtensa/core-dc233c/{gdb-config.c => gdb-config.inc.c}          | 0
>   target/xtensa/core-dc233c/{xtensa-modules.c => xtensa-modules.inc.c}  | 0
>   target/xtensa/core-de212.c                                            | 4 ++--
>   target/xtensa/core-de212/{gdb-config.c => gdb-config.inc.c}           | 0
>   target/xtensa/core-de212/{xtensa-modules.c => xtensa-modules.inc.c}   | 0
>   target/xtensa/core-fsf.c                                              | 2 +-
>   target/xtensa/core-fsf/{xtensa-modules.c => xtensa-modules.inc.c}     | 0
>   target/xtensa/core-sample_controller.c                                | 4 ++--
>   .../xtensa/core-sample_controller/{gdb-config.c => gdb-config.inc.c}  | 0
>   .../core-sample_controller/{xtensa-modules.c => xtensa-modules.inc.c} | 0
>   14 files changed, 9 insertions(+), 9 deletions(-)

...but only touches .c files.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
