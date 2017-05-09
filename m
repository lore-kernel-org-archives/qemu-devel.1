Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7xZ1-0000fo-8o
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7xYw-0004WU-1u
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:19:59 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2cd1e7a1-7f92-88a2-cf98-0dcea0a2f9b1@redhat.com>
Date: Tue, 9 May 2017 07:19:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] hw/pci: define msi_nonbroken in
 pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 09.05.2017 01:39, Philippe Mathieu-Daud=C3=A9 wrote:
> This field is accessed in hw/intc/arm_gicv[23*].c

default-configs/arm-softmmu.mak sets CONFIG_PCI, so this should not be
necessary, I think. Otherwise, you should extend your patch description,
to elaborate on what you're trying to do here.

 Thomas
