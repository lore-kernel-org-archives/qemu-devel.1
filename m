Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVDHU-0004Kt-Iv
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cVDHP-00032k-I8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:13:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cVDHP-00032V-Cg
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 03:13:39 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e1b09efe-0201-a746-9aa9-62f798a222f9@redhat.com>
Date: Sun, 22 Jan 2017 16:13:32 +0800
MIME-Version: 1.0
In-Reply-To: <1484917736-32056-20-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing
 pages before replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
> Previous replay works for domain switch only if the original domain doe=
s
> not have mapped pages. For example, if we switch domain from A to B, it
> will only work if A has no existing mapping. If there is, then there's
> problem - current replay didn't make sure the old mappings are cleared
> before replaying the new one.

I'm not quite sure this is needed. I thought the only thing we need to=20
do is stop DMA of device during the moving? Or is there an example that=20
will cause trouble?

Thanks
