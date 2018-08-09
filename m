Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlbr-0006JB-RL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlbn-0005uY-N0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:08:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnlbn-0005tc-Gf
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:08:11 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-15-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <e941983c-6c17-8163-7cb0-1dba75cb106e@redhat.com>
Date: Thu, 9 Aug 2018 16:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-15-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/34] test/qgraph: virtio-pci driver
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
> +void qvirtio_pci_destroy(QOSGraphObject *obj)
> +{
> +    QVirtioPCIDevice *v9p = (QVirtioPCIDevice *)obj;
> +    qvirtio_pci_device_disable(v9p);
> +    qvirtio_pci_device_free(v9p);
> +}
> +
> +void qvirtio_pci_start_hw(QOSGraphObject *obj)
> +{
> +    QVirtioPCIDevice *v9p = (QVirtioPCIDevice *)obj;
> +    qvirtio_pci_device_enable(v9p);
> +    qvirtio_start_device(&v9p->vdev);
> +}

Perhaps you can use a generic name rather than v9p?

Thanks,
Laurent
