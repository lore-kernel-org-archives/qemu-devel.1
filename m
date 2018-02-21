Received: from eggs.gnu.org ([2001:4830:134:3::10]:35521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobW5-00020m-9i
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobV9-0001Eh-2Y
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:01:29 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53e504b6-cb8e-e261-e7b9-c2ea9453621b@redhat.com>
Date: Wed, 21 Feb 2018 14:57:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/36] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/test-qemu-opts.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 125 insertions(+)
> 
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 6c3183390b..2c422abcd4 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -10,6 +10,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
>   #include "qemu/option.h"
> +#include "qemu/option_int.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
>   #include "qapi/qmp/qstring.h"
> @@ -868,6 +869,127 @@ static void test_opts_append(void)
>       qemu_opts_free(merged);
>   }
>   
> +static void test_opts_to_qdict_basic(void)
> +{
> +    QemuOpts *opts;
> +    QDict *dict;
> +
> +    opts = qemu_opts_parse(&opts_list_01, "str1=foo,str2=,str3=bar,number1=42",
> +                           false, &error_abort);

Worth any additional craziness in regards to our QemuOpts parsing, like 
str1=foo,,bar,str2... for an option containing commas, or 
str2=,str1=foo, for supplying options in a different order than the 
list?  But what you have is a good addition even if you don't tweak it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
