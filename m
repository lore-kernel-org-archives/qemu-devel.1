Received: from eggs.gnu.org ([208.118.235.92]:57815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf4Zq-0001FX-JP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf4Zn-0002aL-D7
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:06:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf4Zn-0001tP-4g
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:06:27 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-8-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3ca63f5-1d18-81ed-1e31-f373222cf481@redhat.com>
Date: Thu, 3 Jan 2019 16:04:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 07/25] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> The Kconfig files were generated mostly with this script:
> 
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# = 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
> 
> EOF
>       git add $(dirname $1)/Kconfig
>     else
>       echo $i $*
>     fi
>   done
>   sed -i '$d' hw/*/Kconfig
>   for i in hw/*; do
>     if test -d $i && ! test -f $i/Kconfig; then
>       touch $i/Kconfig
>       git add $i/Kconfig
>     fi
>   done
> 
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
> 
> Kconfig.host and hw/Kconfig were created manually.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---

Looks sane to me at a first glance... FWIW:
Acked-by: Thomas Huth <thuth@redhat.com>
