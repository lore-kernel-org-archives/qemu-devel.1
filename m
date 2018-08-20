Received: from eggs.gnu.org ([2001:4830:134:3::10]:51626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frcTs-0005L0-75
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frcTo-0004aR-WC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:11:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frcTo-0004a2-SQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:11:52 -0400
Date: Mon, 20 Aug 2018 07:11:49 +0200
From: gerd hoffmann <kraxel@redhat.com>
Message-ID: <20180820051149.o223egvipejgks7h@sirius.home.kraxel.org>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
	<20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
	<20180816130131.lvg3hnv3xum55nvw@sirius.home.kraxel.org>
	<73b38635.29ad9.165434fe949.Coremail.linzc@zju.edu.cn>
	<20180817060758.yish2qstu7hld7s6@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CDB549@dggemm509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302CDB549@dggemm509-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH] usb-host: insert usb device into hostdevs
 to be scaned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: CheneyLin <linzc@zju.edu.cn>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> > We don't copy any state.  It is rather pointless, even for save/resume on the
> > same machine we don't know what state the usb device has and whenever it is
> > still in the state the guest has left it.
> I have tried stop/cont a vm with host-usb device during coping large files(makes usb device busy woking), 
> but usb device was not detached/attached and coping task was completed properly.
>  It seems that we can restart it where we left it off.

stop/cont isn't a problem.

save/resume means "virsh save" + "virsh resume".  This sends the live
migration stream to a file (using "migrate exec:cat>file" monitor
command for save, then 'qemu -incoming "exec:cat file' for resume).

cheers,
  Gerd
