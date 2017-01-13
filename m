Received: from eggs.gnu.org ([2001:4830:134:3::10]:45457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cRzk8-0004vp-T4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cRzk5-0004K3-OQ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:10:00 -0500
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
	<CAFEAcA9fENz1=__4-upW=HLZJ50pAYkA4H2T13wDs62PNDXK3A@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <8a20edcf-67dc-eb57-42b3-78494dd5c738@redhat.com>
Date: Fri, 13 Jan 2017 12:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fENz1=__4-upW=HLZJ50pAYkA4H2T13wDs62PNDXK3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/67] ppc-for-2.9 queue 20170112
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 13/01/2017 11:54, Peter Maydell wrote:
> Q: can we just enable these tests for PCI with
> check-qtest-ppc64-y += $(check-qtest-pci-y)
> gcov-files-ppc64-y += $(gcov-files-pci-y)
> 
> the way we do for i386/x86_64 ? Or is that doing too much
> unwanted extra testing?

For most of the devices tested in check-qtest-pci-y, the test has not
been ported to ppc64 and fails (or hangs).

This is why we don't add the full list in check-qtest-ppc64-y.

Laurent
