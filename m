Received: from eggs.gnu.org ([2001:4830:134:3::10]:40260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNlv-00021X-Sh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNls-0002Ma-Ph
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fTNls-0002MT-K7
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B9758011059
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 08:38:20 +0000 (UTC)
Date: Thu, 14 Jun 2018 10:38:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180614083816.33lmfhfrjzjwugod@sirius.home.kraxel.org>
References: <20180531195119.22021-1-marcandre.lureau@redhat.com>
	<fed332fd-84de-3749-2a67-29d0c89bf505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <fed332fd-84de-3749-2a67-29d0c89bf505@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix usb-ccid hotplug regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, spopovyc@redhat.com

On Wed, Jun 13, 2018 at 06:18:19PM +0200, Paolo Bonzini wrote:
> On 31/05/2018 21:51, Marc-Andr=E9 Lureau wrote:
> > Hi,
> >=20
> > The following series fixes the usb-ccid hotplug regression introduced
> > by commit 675f22c6d3b0: the plugged device is not completely removed
> > on device_del anymore, due to an extra reference added when doing
> > set_link(). It turns out the memory management of qdev bus/child is a
> > bit weird, this is my attempt to improve the situation and fix the
> > regression.
>=20
> It's my fault for not reviewing this promptly, but can patches 1 and 3
> please be reverted?  Thanks,

Can you have a look at the revert series posted by Marc?

thanks,
  Gerd
