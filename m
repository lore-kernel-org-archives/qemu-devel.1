Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSSPw-0005ut-9s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSSPs-0005Ot-1E
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSSPr-0005OW-Su
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:23:47 -0400
Date: Mon, 11 Jun 2018 22:23:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611192206.339122-2-mst@redhat.com>
References: <20180611192206.339122-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611192206.339122-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] hw/i386: Update SSDT table used by "make
 check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Ross Zwisler <ross.zwisler@linux.intel.com>

This commit:

commit aa78a16d8645 ("hw/i386: Rename 2.13 machine types to 3.0")

updated the name used to create the q35 machine, which in turn changed the
SSDT table which is generated when we run "make check":

  acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-QZDWJZ.dsl,
  aml:/tmp/aml-T8JYJZ], Expected [asl:/tmp/asl-DTWVJZ.dsl,
  aml:tests/acpi-test-data/q35/SSDT.dimmpxm].

Here's the only difference, aside from the checksum:

  <     Name (MEMA, 0x07FFF000)
  ---
  >     Name (MEMA, 0x07FFE000)

Update the binary table that we compare against so it reflects this name
change.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Fixes: commit aa78a16d8645 ("hw/i386: Rename 2.13 machine types to 3.0")
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 685 -> 685 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/q35/SSDT.dimmpxm b/tests/acpi-test-data/q35/SSDT.dimmpxm
index 8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4..2d5b721bcf9c398feb6d005761f898015042e8a4 100644
GIT binary patch
delta 23
fcmZ3>x|WqIIM^j*EfWI+qr*n71x(Bz{<8xBPCEwk

delta 23
fcmZ3>x|WqIIM^j*EfWI+W57nP1x(Bj{<8xBPMZev

-- 
MST
