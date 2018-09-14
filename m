Received: from eggs.gnu.org ([2001:4830:134:3::10]:38353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0ldw-0001ee-Tj
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0ldt-0002Y4-Ox
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0ldt-0002Xh-Ip
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5E523082A36
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:48:04 +0000 (UTC)
Date: Fri, 14 Sep 2018 12:48:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180914104802.hhbktwbxh7swkeh7@sirius.home.kraxel.org>
References: <20180914095645.24612-1-kraxel@redhat.com>
	<20180914102057.GA3082@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914102057.GA3082@work-vm>
Subject: Re: [Qemu-devel] [PATCH] usb: assign unique serial numbers to hid
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

> > +    [STR_SERIAL_MOUSE]     = "89126",
> > +    [STR_SERIAL_TABLET]    = "28754",
> > +    [STR_SERIAL_KEYBOARD]  = "68284",
> 
> Is there any significance to the magical numbers?

No, other than that the three device types should have different ones.

> Will this change trigger a serial number change across migrate
> or will the current serial be carried across?

No, it is not migrated over.
So I guess we should better add a compat property ...

cheers,
  Gerd
