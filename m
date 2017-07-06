Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwkd-00059v-L9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwkZ-0006fD-ON
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSwkZ-0006er-Hd
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:42:39 -0400
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d56ad5e6-e8ea-d372-b5a8-b570235201f6@redhat.com>
Date: Thu, 6 Jul 2017 04:42:33 +0200
MIME-Version: 1.0
In-Reply-To: <2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, armbru@redhat.com

On 05.07.2017 19:36, Alistair Francis wrote:
> This patch converts the existing error_vreport() function into a generi=
c
> qmesg_vreport() function that takes an enum describing the

s/qmesg/qmsg/

> information to be reported.
>=20
> As part of this change a new qmesg_report() function is added as well w=
ith the

s/qmesg/qmsg/

> same capability.
>=20
> To maintain full compatibility the original error_report() function is
> maintained and no changes to the way errors are printed have been made.
> To improve access to the new informaiton and warning options wrapper fu=
nctions

s/informaition/information/

> similar to error_report() have been added for warnings and information
> printing.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> RFC V3:
>  - Change the function and enum names to be more descriptive
>  - Add wrapper functions for *_report() and *_vreport()
>=20
>  include/qemu/error-report.h | 16 +++++++++
>  scripts/checkpatch.pl       |  8 ++++-
>  util/qemu-error.c           | 80 +++++++++++++++++++++++++++++++++++++=
++++++--
>  3 files changed, 100 insertions(+), 4 deletions(-)

With the typos fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
