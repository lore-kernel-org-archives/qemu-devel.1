Received: from eggs.gnu.org ([209.51.188.92]:44798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwP2o-0001A0-4t
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwP2n-0005au-IX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:24:02 -0500
References: <1550591757-6192-1-git-send-email-thuth@redhat.com>
	<482a82e6-ce89-bb04-7a0f-a674397827a8@redhat.com>
	<be997f90-8afd-5e57-a84d-2872a4c77c60@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0f3b781-cc6d-5e13-52b7-c9bc330980c9@redhat.com>
Date: Wed, 20 Feb 2019 11:23:50 +0100
MIME-Version: 1.0
In-Reply-To: <be997f90-8afd-5e57-a84d-2872a4c77c60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ide/ich: Compile ich.c only if
 CONFIG_PCI is also set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com

On 20/02/19 07:16, Thomas Huth wrote:
> By the way, what's the current status of the Kconfig series? Will there
> be another respin soon? ... the next softfreeze is not that far away ...

Waiting on the vhost series; I'll talk to Peter about merging it without
ARM and handling ARM later.

Paolo
