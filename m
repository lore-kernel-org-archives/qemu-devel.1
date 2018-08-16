Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqHuI-0003W8-L8
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqHuC-0001WZ-Te
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fqHuC-0001Uo-L4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:36 -0400
Date: Thu, 16 Aug 2018 15:01:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180816130131.lvg3hnv3xum55nvw@sirius.home.kraxel.org>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
	<20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>

> > Hmm, needs_autoscan is a fixed property of the device (depending on
> > configuration), it should not be switched on and off.
> > 
> > What problem you are trying to solve?
> I'm trying to live migrate a vm to local host, but found the host-usb device was removed then.
> Is it possible not to remove it after migrating vm?

Why live-migrate to localhost?  That is rather tricky due to both source
and target qemu accessing host resources at the same time, and I guess
this is the reason you are seeing the problems here.

If it is for QA purposes I'd suggest to use two machines for actual live
migration tests, or store the live migration stream in a file so the two
qemu instances never run at the same time (this is what "virsh save" is
doing).

cheers,
  Gerd
