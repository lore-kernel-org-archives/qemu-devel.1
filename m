Received: from eggs.gnu.org ([2001:4830:134:3::10]:57805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRAex-0002vD-KV
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRAes-0002P8-HW
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRAes-0002Mb-B5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:46:14 -0500
Date: Mon, 26 Nov 2018 07:46:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181126064611.zgsxden3jemuglaj@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302D325DC@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302D325DC@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [question] live migration about redir-usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

On Mon, Nov 26, 2018 at 02:29:12AM +0000, linzhecheng wrote:
> Hi, Gerd
> I have read this discussion thread about live migration in tcp mode.
> https://bugzilla.redhat.com/show_bug.cgi?id=1254971
> Only spice redirection supports live migration not, but why not tcp mode?
> Does usbredirserver not support it or qemu?

usbredirserver.

spice client holds a connection to both source and target host for a
seamless connection handover, and usb-redir needs that too to hand over
the usb device without interruption.

usbredirserver can't do that.

cheers,
  Gerd
