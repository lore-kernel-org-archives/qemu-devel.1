Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfq7J-0004dU-PP
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfq7G-00057D-Lv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:43:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cfq7G-00056w-G0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:43:06 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9b1118e8-8b00-fa68-a3f8-9a8af2346e17@redhat.com>
Date: Mon, 20 Feb 2017 16:43:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] s390x: network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, agraf@suse.de

On 20.02.2017 15:19, Cornelia Huck wrote:
> This patchset implements network boot for s390x. You need to build
> a s390-netboot.img to actually perform the work (not included).

Do you plan to include this into the upstream QEMU repository later, or
will this stay an external binary?

> Basically, we add support for virtio-net devices into the ipl code
> and update the ccw bios to handle this as well.

Just out of curiosity: What's the reason for shipping an additional
binary here? Couldn't it be linked into the ccw bios as well (so that
it's easier for the user to select a different version with the -bios
parameter)?

 Thomas
