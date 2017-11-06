Received: from eggs.gnu.org ([2001:4830:134:3::10]:34397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBeRW-000269-CL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBeRS-0001sh-H9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:15:46 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eBeRS-0001rj-76
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:15:42 -0500
References: <20171103193802.11876-1-laurent@vivier.eu>
	<20076e3b-883a-b669-8453-f870eda6e31a@ozlabs.ru>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <425ee57b-641a-b8d3-7700-1ddcbc243ec3@vivier.eu>
Date: Mon, 6 Nov 2017 11:15:34 +0100
MIME-Version: 1.0
In-Reply-To: <20076e3b-883a-b669-8453-f870eda6e31a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove nmi.c and
 fw-path-provider.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@linaro.org>

Le 06/11/2017 à 01:44, Alexey Kardashevskiy a écrit :
> On 04/11/17 06:38, Laurent Vivier wrote:
>> linux-user binaries don't need firmware and NMI,
>> so don't add them in this case, move QDEV
>> firmware functions to qdev-fw.c
> 
> 
> When configured with --target-list=ppc64-linux-user , config-host.mak gets
> TARGET_DIRS=ppc64-linux-user  and I would expect CONFIG_SOFTMMU to be
> disabled in Makefile#27 and qdev.c not to be compiled at all but this is
> not happening, I wonder why...

this is driven by config-target.mak and config-target.h which are target
specific.

for ppc64-linux-user, you have ppc64-linux-user/config-target.mak:
...
CONFIG_LINUX_USER=y
...

for ppc64-softmmu/config-target.mak:
...
CONFIG_SOFTMMU=y
...

Thanks,
Laurent
