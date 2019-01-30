Received: from eggs.gnu.org ([209.51.188.92]:59384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gopSV-0000Yb-GH
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gopSU-0006F5-Pt
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:59:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:19558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gopSU-0006Br-HF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:59:14 -0500
Date: Wed, 30 Jan 2019 20:55:26 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190130125526.GC3384@yangzhon-Virtual>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-3-git-send-email-pbonzini@redhat.com>
	<f4208837-83e7-a090-91d5-fc978490da9c@redhat.com>
	<a56cfb65-55a6-5c0d-8e86-d2e71d233d78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56cfb65-55a6-5c0d-8e86-d2e71d233d78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/52] ide: split ioport registration to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, yang.zhong@intel.com

On Wed, Jan 30, 2019 at 01:20:42PM +0100, Paolo Bonzini wrote:
> On 30/01/19 13:07, Thomas Huth wrote:
> > I think adding ioport.o to IDE_PCI and IDE_VIA is wrong. The
> > ide_init_ioport() function is only used by isa.c and piix.c, so it
> > should only be added for IDE_ISA and IDE_PIIX here.
> 
> Good idea, another one for Yang. :)
>
  Yes, for ioport.o, i will add as below: 

  +common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
  +common-obj-$(CONFIG_IDE_PIIX) += piix.o ioport.o

  The newest hw/ide/via.c has removed ide_init_ioport() call.

  By the way, i plan to send non-RFC patches 1-27 tomorrow if there is not any new comments. thanks!

  Yang 
 
> Paolo
