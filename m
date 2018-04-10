Received: from eggs.gnu.org ([2001:4830:134:3::10]:36493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5nMW-00071M-00
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5nMS-00089f-1P
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:06:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5nMR-00089C-Tc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:06:35 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-3-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b519a006-a647-5616-8a78-1a4b78c85a47@redhat.com>
Date: Tue, 10 Apr 2018 15:06:29 +0800
MIME-Version: 1.0
In-Reply-To: <1522846444-31725-3-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] virtio: memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org



On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:53, wexu@redhat.com wrote:
> From: Wei Xu<wexu@redhat.com>
>
> A new memory cache is introduced to for packed ring,
> the code looks pretty duplicated with split(1.0) ring,
> any refactor idea?

I think you can reuse the exist code as I replied in patch 1.

Thanks
