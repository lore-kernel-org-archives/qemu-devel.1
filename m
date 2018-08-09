Received: from eggs.gnu.org ([2001:4830:134:3::10]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkAK-0001No-EJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkAG-0003Dv-I8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:35:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnkAG-0003DX-9R
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:35:40 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-8-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c1db3f10-edd5-3e8f-7028-93f1a3120b36@redhat.com>
Date: Thu, 9 Aug 2018 14:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-8-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/34] tests/qgraph: arm/raspi2 machine
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> Add arm/raspi2 machine to the graph. This machine contains a generic-sdhci, so
> its constructor must take care of setting it properly when called.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include        |  1 +
>  tests/libqos/raspi2-machine.c | 82 +++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 tests/libqos/raspi2-machine.c

globally, same cosmetic comments (destructor, fprintf, register, ...) as
for PC, otherwise it looks good.

Thanks,
Laurent
