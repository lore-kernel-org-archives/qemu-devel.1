Received: from eggs.gnu.org ([2001:4830:134:3::10]:46124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkVw-0001tg-L9
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkVr-0000SK-Nu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:58:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnkVr-0000Rx-H1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:57:59 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <224e7583-f2b6-4dbf-5dfd-d3b66465c9ac@redhat.com>
Date: Thu, 9 Aug 2018 14:57:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/34] tests/qgraph: pci-spapr driver
 and interface nodes
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
> Add pci-bus-spapr node, that produces pci-bus. Move QPCIBusSPAPR struct
> declaration in its header (since it will be needed by other drivers)
> and introduce a setter method for drivers that do not need to allocate
> but have to initialize QPCIBusSPAPR.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include   |  2 +-
>  tests/libqos/pci-spapr.c | 57 ++++++++++++++++++++++++----------------
>  tests/libqos/pci-spapr.h | 24 +++++++++++++++++
>  3 files changed, 59 insertions(+), 24 deletions(-)

globally, same comments as for pci-pc.c

Thanks,
Laurent
