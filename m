Received: from eggs.gnu.org ([209.51.188.92]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gme2k-0007sB-Go
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gme2i-00027q-8r
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:23:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gme2g-00021n-Cx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:23:34 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-36-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <149c7475-ed07-ebc3-964c-5b1a7bbf797e@redhat.com>
Date: Thu, 24 Jan 2019 13:23:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-36-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 35/44] isa: express dependencies
 with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On 2019-01-23 07:56, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak | 9 ---------
>  hw/audio/Kconfig                 | 2 ++
>  hw/block/Kconfig                 | 2 ++
>  hw/char/Kconfig                  | 6 ++++++
>  hw/display/Kconfig               | 3 +++
>  hw/i386/Kconfig                  | 1 +
>  hw/ide/Kconfig                   | 1 +
>  hw/input/Kconfig                 | 2 ++
>  hw/isa/Kconfig                   | 5 +++++
>  hw/misc/Kconfig                  | 4 ++++
>  hw/net/Kconfig                   | 3 +++
>  hw/watchdog/Kconfig              | 2 ++
>  12 files changed, 31 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
