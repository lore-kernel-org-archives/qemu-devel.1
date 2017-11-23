Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHneP-0000wa-GY
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHneL-0001s3-RR
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:18:29 -0500
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
	<215448fd-8dbf-882a-35af-7778a6c4ab38@redhat.com>
	<20171122180640.GD10954@localhost.localdomain>
	<d883af5c-7e59-6acc-c475-04c30b16de61@redhat.com>
	<E82650A0-F01C-4EE6-A024-A1AFAFCF3A3F@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
Date: Thu, 23 Nov 2017 10:18:13 +0100
MIME-Version: 1.0
In-Reply-To: <E82650A0-F01C-4EE6-A024-A1AFAFCF3A3F@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix qemu crash when
 using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deepa Srinivasan <deepa.srinivasan@oracle.com>
Cc: Kevin Wolf <kwolf@redhat.com>, mark.kanda@oracle.com, qemu-block@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 23/11/2017 03:55, Deepa Srinivasan wrote:
> I agree that passing in QEMUIOVector to blk_aio_ioctl() as a holder of
> the void* buffer used in blk_aio_ioctl_entry() is unnecessary. But, as
> Kevin noted, read and write were using the QEMUIOVector in BlkRwCo.
>=20
> To avoid changes to the callers of blk_aio_ioctl(), I=E2=80=99ll change
> blk_aio_prwv() to take a void pointer instead of QEMUIOVector* and use =
a
> union to hold the buffer in BlkRwCo.

The union is unnecessary.  A QEMUIOVector* can be stored in a void* just
fine.

Paolo
