Received: from eggs.gnu.org ([2001:4830:134:3::10]:57983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTkUw-0001d3-4w
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTkUs-0006rz-64
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:17:34 -0500
Received: from ns3.fnarfbargle.com ([43.245.164.105]:45611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
	id 1cTkUr-0006ph-Nn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 02:17:30 -0500
Received: from srv.home ([10.8.0.1] ident=heh4524)
	by ns3.fnarfbargle.com with esmtps
	(TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <lists2009@fnarfbargle.com>) id 1cTkKG-0000PT-CU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:06:32 +0800
References: <86a7d976-780a-508e-1edd-af4334cf9d5d@fnarfbargle.com>
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <83d9e4c6-e85c-01d5-6e55-f3260eb7a032@fnarfbargle.com>
Date: Wed, 18 Jan 2017 15:16:17 +0800
MIME-Version: 1.0
In-Reply-To: <86a7d976-780a-508e-1edd-af4334cf9d5d@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] commit : "virtio: set ISR on dataplane
 notifications" breaks virtio-pci network on linux guest.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 18/01/17 10:21, Brad Campbell wrote:
> G'day all,
>
> Upgrading from 2.7.1 to 2.8 on my machines here leaves the guests
> without networking. All guests are using a vanilla self-compiled 4.8.12
> kernel. The host is using a 4.9.3 kernel.
>
> Guests are using virtio networking into a bridge on the host.
>

Further testing indicates this only breaks when CONFIG_GENERIC_MSI_IRQ 
is not set in the guest kernel. My guest kernel didn't have this 
enabled. Once I recompiled and re-deployed the kernels, all linux VM's 
networked fine.

I can however confirm it breaks Windows XP 32 bit guests. Upgrading to 
the latest driver (51.74.104.13000) does not solve the problem either, 
so I've had to go back to 2.7.1 to be able to use these Windows VM's.

When I get some time I'll try and set up a test environment outside of 
libvirt and run further tests.

Regards,
Brad
