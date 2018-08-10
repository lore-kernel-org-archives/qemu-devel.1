Received: from eggs.gnu.org ([2001:4830:134:3::10]:49198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv4B-00054A-2Y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv47-0000s6-0P
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:14:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1fnv46-0000rS-LJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:14:02 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 10 Aug 2018 00:13:54 +0000
Message-ID: <52619520-A764-4F72-B70A-64C3C886CF81@nutanix.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
	<20180808195235.5843-3-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-3-gedwards@ddn.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E94237AF231EE4FAF5C0916A8533624@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] vhost-scsi: unify vhost-scsi
 get_features implementations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Edwards <gedwards@ddn.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>


> On 8 Aug 2018, at 12:52, Greg Edwards <gedwards@ddn.com> wrote:
>=20
> Move the enablement of preset host features into the common
> vhost_scsi_common_get_features() function.  This is in preparation for
> having vhost-scsi also make use of host_features.
>=20
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
> hw/scsi/vhost-scsi-common.c |  3 +++
> hw/scsi/vhost-user-scsi.c   | 14 +-------------
> 2 files changed, 4 insertions(+), 13 deletions(-)

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
