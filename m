Received: from eggs.gnu.org ([2001:4830:134:3::10]:32849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fI8UY-0005Tu-Q6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fI8UV-0004pA-Mk
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:05:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fI8UV-0004mD-Hp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:05:55 -0400
Date: Mon, 14 May 2018 10:05:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180514080551.xm7lqfzbqf7d2jiy@sirius.home.kraxel.org>
References: <20180419131051.11249-1-kraxel@redhat.com>
	<20180419131051.11249-5-kraxel@redhat.com>
	<833e23a9-4899-2a95-c4b1-027d437e2ef7@adacore.com>
	<20180425130525.omdcdwvcpclk7xsu@sirius.home.kraxel.org>
	<1c9836b5-727d-b723-3abc-2cd98a59f050@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9836b5-727d-b723-3abc-2cd98a59f050@adacore.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] audio/hda: detect output buffer
 overruns and underruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, martin@schrodt.org

On Fri, May 11, 2018 at 11:25:37AM +0200, KONRAD Frederic wrote:
> 
> 
> On 04/25/2018 03:05 PM, Gerd Hoffmann wrote:
> > On Mon, Apr 23, 2018 at 11:31:34AM +0200, KONRAD Frederic wrote:
> > > 
> > > 
> > > On 04/19/2018 03:10 PM, Gerd Hoffmann wrote:
> > > > If some event caused some larger playback hickup the fine-grained timer
> > > > adjust isn't able to recover.  Use a buffer overruns and underruns as
> > > > indicator for that.  Reset timer adjust logic in case we detected one.
> > > 
> > > It seems that this patch causes big lockup of my Win10 KVM guest
> > > when it tries to output a sound.
> > > The three previous patches improved considerably the audio
> > > output though!
> > 
> > Can you try drop the "underrun" chunks, keeping only the "overrun"?
> > 
> > thanks,
> >    Gerd
> > 
> 
> Hi Gerd,
> 
> Tested yesterday it seems that both are causing lockup. The
> overrun a little less though.

Hints how to reproduce this?  Which guest?  Which application?

thanks,
  Gerd
