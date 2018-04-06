Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4OMV-0006RX-Jt
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4OMR-0007vg-I5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f4OMR-0007uQ-Dq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:12:47 -0400
References: <20180405162347.5623-1-pbonzini@redhat.com>
	<5a3d6ece-e68b-5eae-3808-510c4eed4d68@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a94422e9-833f-db3a-fc38-39fab45f1850@redhat.com>
Date: Fri, 6 Apr 2018 12:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <5a3d6ece-e68b-5eae-3808-510c4eed4d68@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/2] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 06/04/2018 01:10, Daniel Henrique Barboza wrote:
> Yet another fix is to fully prohibit the user to set scsi_version
> scsi-block and scsi-generic cases, returning an error message right off
> the start. Not sure how hard this would be - perhaps the above
> alternatives are cleaner.
>=20
> Another fix is ... no fix. I am not sure how far the design philosophy
> of passthrough devices allows the user to overwrite device parameters i=
n
> despite of their real values, but ....=C2=A0 what if the user wants to
> enforce a scsi_version when using a scsi-block device? The device will
> surely behave badly, but the user explicitly enforced it via command
> line, so perhaps let him/her have at it?

Yeah, that was the idea.  Removing it is as easy as dropping the
DEFINE_PROP_INT32 and initializing to -1 in scsi_block_realize (just
like for scsi_generic_realize), but for now we can keep it.  My usecase
was more to downgrade scsi_version from newer to 2.

Paolo
