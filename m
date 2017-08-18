Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikTo-00026J-F1
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dikTj-0001zs-R6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dikTj-0001yd-EQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:50:35 -0400
Date: Fri, 18 Aug 2017 13:50:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818165032.GA3108@localhost.localdomain>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-19-git-send-email-imammedo@redhat.com>
	<20170816195640.GI3108@localhost.localdomain>
	<20170817163223.64d4a172@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817163223.64d4a172@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/28] xtensa: replace cpu_xtensa_init()
 with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Thu, Aug 17, 2017 at 04:32:23PM +0200, Igor Mammedov wrote:
> On Wed, 16 Aug 2017 16:56:40 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Jul 14, 2017 at 03:52:09PM +0200, Igor Mammedov wrote:
> > > call xtensa_irq_init() at realize time which makes
> > > cpu_xtensa_init() like generic cpu creation function.
> > > As result we can replace it with cpu_generic_init()
> > > which does the same job, reducing code duplication a bit.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > Looks good to me.  Were you able to test it?
> images are from 
> http://jcmvbkbc.spb.ru/~dumb/ws/osll/qemu-xtensa/20110829/xtensa-dc232b_kernel_rootfs.tgz
> http://jcmvbkbc.spb.ru/~dumb/tmp/201508231001/default-sim-fsf/Image.elf
> 
> instructions to test is from
> http://qemu-buch.de/de/index.php?title=QEMU-KVM-Buch/_Gast-Systeme/_Xtensa-Architektur
> 
> it boots till some point, so CPU is still there
> which should be sufficient for this patch

Thanks!

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
