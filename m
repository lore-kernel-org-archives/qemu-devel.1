Received: from eggs.gnu.org ([2001:4830:134:3::10]:41265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0ln3-0005EC-Pc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0ln0-0002uz-FN
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g0ln0-0002uV-9H
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA220307D90E
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:57:29 +0000 (UTC)
Date: Fri, 14 Sep 2018 11:57:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180914105722.GA3081@work-vm>
References: <20180914095645.24612-1-kraxel@redhat.com>
	<20180914102057.GA3082@work-vm>
	<20180914104802.hhbktwbxh7swkeh7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914104802.hhbktwbxh7swkeh7@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> > > +    [STR_SERIAL_MOUSE]     = "89126",
> > > +    [STR_SERIAL_TABLET]    = "28754",
> > > +    [STR_SERIAL_KEYBOARD]  = "68284",
> > 
> > Is there any significance to the magical numbers?
> 
> No, other than that the three device types should have different ones.

OK, I had vague memories a while ago of us asking about encoding things
in serial numbers and the previous 42 not actually being magical.

> > Will this change trigger a serial number change across migrate
> > or will the current serial be carried across?
> 
> No, it is not migrated over.
> So I guess we should better add a compat property ...

Thanks,

Dave

> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
