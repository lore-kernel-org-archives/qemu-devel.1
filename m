Received: from eggs.gnu.org ([2001:4830:134:3::10]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZSb-000198-Ny
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZSa-0008K3-MH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:28:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e186d31f-0fb0-98c2-6385-d46f8e2fc5df@amsat.org>
Date: Wed, 9 Aug 2017 19:28:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170809215510.22802-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/12] qemu-iotests: get rid of AWK_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 08/09/2017 06:55 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/qemu-iotests/check         | 4 ++--
>   tests/qemu-iotests/common        | 2 +-
>   tests/qemu-iotests/common.config | 3 ---
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 01fd5a26e5..5075029e89 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -128,7 +128,7 @@ tmp="${TEST_DIR}"/$$
>   
>   _wallclock()
>   {
> -    date "+%H %M %S" | $AWK_PROG '{ print $1*3600 + $2*60 + $3 }'
> +    date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
>   }
>   
>   _timestamp()
> @@ -147,7 +147,7 @@ _wrapup()
>           if [ -f $TIMESTAMP_FILE -a -f $tmp.time ]
>           then
>               cat $TIMESTAMP_FILE $tmp.time \
> -            | $AWK_PROG '
> +            | awk '
>           { t[$1] = $2 }
>   END        { if (NR > 0) {
>               for (i in t) print i " " t[i]
> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> index 867918895b..130f647a4d 100644
> --- a/tests/qemu-iotests/common
> +++ b/tests/qemu-iotests/common
> @@ -366,7 +366,7 @@ testlist options
>       if $xpand
>       then
>           have_test_arg=true
> -        $AWK_PROG </dev/null '
> +        awk </dev/null '
>   BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
>           | while read id
>           do
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
> index b599c72211..0f571d46eb 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -56,9 +56,6 @@ _fatal()
>       exit 1
>   }
>   
> -export AWK_PROG="`set_prog_path awk`"
> -[ "$AWK_PROG" = "" ] && _fatal "awk not found"
> -
>   if [ -z "$QEMU_PROG" ]; then
>       export QEMU_PROG="`set_prog_path qemu`"
>   fi
> 
