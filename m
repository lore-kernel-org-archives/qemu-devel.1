Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fpA-0004cl-2m
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fp6-0005rs-VP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:31:28 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:51317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5fp6-0005ph-Qu
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:31:24 -0400
Received: by mail-qk0-x244.google.com with SMTP id 17so16067524qkq.8
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:31:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020141027.17010-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4acbba22-9346-205e-49a4-8c01402f499d@amsat.org>
Date: Fri, 20 Oct 2017 19:31:16 -0300
MIME-Version: 1.0
In-Reply-To: <20171020141027.17010-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: allow setting a custom GIT binary
 for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Chen, Farrah" <farrah.chen@intel.com>

Hi Daniel,

> diff --git a/configure b/configure
> index 6f21aaf989..ce5a2d0105 100755
> --- a/configure
> +++ b/configure
> @@ -271,6 +271,7 @@ then
>  else
>      git_submodules=""
>  fi
> +git="git"
>  
>  # Don't accept a target_list environment variable.
>  unset target_list
> @@ -1294,6 +1295,8 @@ for opt do
>            error_exit "vhost-user isn't available on win32"
>        fi
>    ;;
> +  --with-git=*) git="$optarg"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -5338,6 +5341,7 @@ echo "local state directory   queried at runtime"
>  echo "Windows SDK       $win_sdk"
>  fi
>  echo "Source path       $source_path"
> +echo "GIT binary        $git"

"GIT command"

>  echo "GIT submodules    $git_submodules"
>  echo "C compiler        $cc"
>  echo "Host C compiler   $host_cc"
> @@ -5528,6 +5532,7 @@ echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
>  echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
>  echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
>  echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
> +echo "GIT=$git" >> $config_host_mak
>  echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
