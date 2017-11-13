Received: from eggs.gnu.org ([2001:4830:134:3::10]:35911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eELGY-0008JV-34
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 15:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eELGU-000396-PC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 15:23:34 -0500
References: <151059294250.396.15891441677342276715@bafd83ae6430>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <97a152d7-e09d-1d0f-72ab-20d270d7a06f@redhat.com>
Date: Mon, 13 Nov 2017 21:23:22 +0100
MIME-Version: 1.0
In-Reply-To: <151059294250.396.15891441677342276715@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/net/vmxnet3: Fix code to work
 on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jasowang@redhat.com, dmitry@daynix.com, dgibson@redhat.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org

On 13.11.2017 18:09, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
[...]
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: hw/net/vmxnet3: Fix code to work on big endian hosts, too...
> ERROR: spaces required around that ':' (ctx:VxV)
> #202: FILE: hw/net/vmxnet3.h:232:
> +            u32 msscof:14;  /* MSS, checksum offset, flags */

FWIW, these are definitely false warnings: If I change the patch to use
spaces around ":" everywhere in the bitfields, checkpatch complains
instead that the spaces should be removed!

 Thomas
