Received: from eggs.gnu.org ([209.51.188.92]:52696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goorO-0008Kk-6z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goorM-0002Ba-6v
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:20:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1goorK-00029T-7A
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:20:51 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-3-git-send-email-pbonzini@redhat.com>
	<f4208837-83e7-a090-91d5-fc978490da9c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a56cfb65-55a6-5c0d-8e86-d2e71d233d78@redhat.com>
Date: Wed, 30 Jan 2019 13:20:42 +0100
MIME-Version: 1.0
In-Reply-To: <f4208837-83e7-a090-91d5-fc978490da9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, BALATON Zoltan <balaton@eik.bme.hu>

On 30/01/19 13:07, Thomas Huth wrote:
> I think adding ioport.o to IDE_PCI and IDE_VIA is wrong. The
> ide_init_ioport() function is only used by isa.c and piix.c, so it
> should only be added for IDE_ISA and IDE_PIIX here.

Good idea, another one for Yang. :)

Paolo
