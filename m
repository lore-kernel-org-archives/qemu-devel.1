Received: from eggs.gnu.org ([2001:4830:134:3::10]:33560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZQy-0000Ke-TG
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfZQx-0007G3-NN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:26:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6fb59584-a1fd-066c-69af-65bc2490d331@amsat.org>
Date: Wed, 9 Aug 2017 19:26:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170809215510.22802-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/12] qemu-iotests: do not include
 common.rc in "check"
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
> It only provides functions used by the test programs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/qemu-iotests/check     |  6 ------
>   tests/qemu-iotests/common.rc | 13 +++++--------
>   2 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 5075029e89..1ef6d0ac3a 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -113,12 +113,6 @@ then
>       _init_error "failed to source common.config"
>   fi
>   
> -# we need common.rc
> -if ! . "$source_iotests/common.rc"
> -then
> -    _init_error "failed to source common.rc"
> -fi
> -
>   # we need common
>   . "$source_iotests/common"
>   
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index ef5cdb3385..390aa81224 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -40,14 +40,11 @@ poke_file()
>       printf "$3" | dd "of=$1" bs=1 "seek=$2" conv=notrunc &>/dev/null
>   }
>   
> -# we need common.config
> -if [ "$iam" != "check" ]
> -then
> -    if ! . ./common.config
> -        then
> -        echo "$iam: failed to source common.config"
> -        exit 1
> -    fi
> +
> +if ! . ./common.config
> +    then
> +    echo "$iam: failed to source common.config"
> +    exit 1
>   fi
>   
>   _fatal()
> 
