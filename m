Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPS7-0007ct-3G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPS2-0002mt-91
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:49:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQPS2-0002mY-41
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:49:34 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <43058759-28c7-9144-27f3-a16475281973@redhat.com>
Date: Wed, 6 Jun 2018 11:49:22 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] packed ring virtio-net userspace
 backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, mst@redhat.com, jfreimann@redhat.com



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:07, wexu@redhat.com wrote:
> From: Wei Xu<wexu@redhat.com>
>
> Todo:
> - address Rx slow performance
> - event index interrupt suppression test

And there's something more need to test:

- vIOMMU support
- migration

Thanks
