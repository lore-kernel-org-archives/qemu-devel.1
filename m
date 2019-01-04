Received: from eggs.gnu.org ([208.118.235.92]:34792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQ3a-00011O-Cf
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQ3X-000143-8q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:02:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfQ3X-00012M-1t
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:02:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so36655151wrt.4
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 06:02:34 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbed296d-eab2-80d7-e3f7-40050bf7f247@redhat.com>
Date: Fri, 4 Jan 2019 15:02:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/25] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On 27/12/18 07:33, Yang Zhong wrote:
> (*) defconfig
>     "randconfig" build has some issues, which are mostly related
>     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
>     some CONFIG* has different setting value in config-host.mak and
>     %/config-device.mak, which make QEMU build failure.

I'll look into this once you fix the other issue from the review of this
RFC.  Thanks for updating the patches!

Paolo
