Received: from eggs.gnu.org ([2001:4830:134:3::10]:55962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAb4F-0006jg-MI
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAb48-0000hO-Q9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:31:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAb48-0000gz-9j
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:31:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so9029193wmb.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 06:31:48 -0700 (PDT)
Message-ID: <1539264705.16655.121.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 11 Oct 2018 15:31:45 +0200
In-Reply-To: <20181011132047.3zef5j5puh4lt43c@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
	<20181010103704.jqgfp3kiaiqu4hzt@sirius.home.kraxel.org>
	<1539262539.16655.99.camel@redhat.com>
	<20181011132047.3zef5j5puh4lt43c@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Thu, 2018-10-11 at 15:20 +0200, Gerd Hoffmann wrote:
> > The plan was (and still is) to limit the use cases to the following
> > two:
> > 
> > * Legacy QXL on linux with multiple monitors per display channel, but
> > only this single display channel. Multiple display channels are not
> > supported in this case, so no streaming etc.
> > 
> > * Limit the number of monitors per display channel to one for all other
> > cases.
> 
> Right, I mis-remembered.
> 
> > With these limitations, the display_id = channel_id + monitor_id
> > formula that is used on the client remains unique.
> 
> And in case no qxl card is in use we even have display_id == channel_id.
> 
> So, do we need this add display_id function at all?

You mean the addition of IDs in display_id = channel_id + monitor_id?

That's what is in the clients now, at least in remote_viewer and spicy,
although in remote_viewer it's display_id = channel_id ? channel_id :
monitor_id, which is equivalent if either of the numbers (or both) is
always zero.

We also still need to handle the "legacy" (it's still the majority in
usage on linux though...) QXL case, and this formula works for both
cases, so I'm not sure it's worth trying to replace it with something.
Although we _should_ try to clean this mess up eventually...

Cheers,
Lukas

> cheers,
>   Gerd
> 
