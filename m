Received: from eggs.gnu.org ([2001:4830:134:3::10]:57827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dmyA8-0008P1-84
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dmyA4-0003l2-IJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:15:47 -0400
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
Date: Wed, 30 Aug 2017 10:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <1075529669.195794.1504079702032@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mahmood <nt_mahmood@yahoo.com>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

On 30.08.2017 09:55, Mahmood wrote:
>> You don't have to write "fsdriver" here, but replace it with "local",
>> "handle" or "proxy".
> 
> Still get the same error
> 
> mahmood@cluster:qemu-vm$ qemu-system-x86_64 -m 4000 -cpu Opteron_G5 -smp 2 -hda centos7server.img -boot c  -usbdevice tablet -enable-kvm -device e1000,netdev=host_files -netdev user,net=10.0.2.0/24,id=host_files -virtfs local,id=shared,path=/home/mahmood/Downloads,mount_tag=Downloads 
> qemu-system-x86_64: -virtfs local,id=shared,path=/home/mahmood/Downloads,mount_tag=Downloads: Parameter 'driver' expects device type 

Hmm, I've got the strange feeling that the -virtfs parameter might
currently be broken.

Could you please try to replace the -virtfs option with these two options:

 -fsdev local,id=shared,path=/home/mahmood/Downloads \
 -device virtio-9p-pci,fsdev=shared,mount_tag=Downloads

I hope that works better...

 Thomas
