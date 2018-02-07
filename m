Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVa5-0006DK-R9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejVa1-0001l3-0v
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:40:33 -0500
Received: from mail-ve1eur01hn0231.outbound.protection.outlook.com
	([104.47.1.231]:47584
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejVa0-0001im-Ko
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:40:28 -0500
Date: Wed, 7 Feb 2018 22:40:15 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207194015.GB19541@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-28-rkagan@virtuozzo.com>
	<e6efa53a-3a65-e15d-9ee2-89dcaded1b22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6efa53a-3a65-e15d-9ee2-89dcaded1b22@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 27/34] tests: hv-scsi: add start-stop
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 12:15:50PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> > +        g_printerr("Hyper-V / VMBus are only available on x86\n");
> > +        exit(EXIT_FAILURE);
> > +    }
> 
> This shouldn't be needed.
> 
> > +
> > +    if (access("/dev/kvm", R_OK | W_OK)) {
> 
> Maybe try opening it too?  In theory you could have a /dev/kvm device
> that triggers loading the kvm module (see
> https://github.com/systemd/systemd/pull/7795 for gory details).

Makes sense, will replace with open(O_RDWR).

Thanks,
Roman.
