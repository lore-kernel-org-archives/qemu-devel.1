Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBK7K-00015O-6C
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBK7J-0001DY-G2
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:05:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fBK7J-0001DA-B0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:05:49 -0400
Date: Wed, 25 Apr 2018 15:05:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180425130525.omdcdwvcpclk7xsu@sirius.home.kraxel.org>
References: <20180419131051.11249-1-kraxel@redhat.com>
	<20180419131051.11249-5-kraxel@redhat.com>
	<833e23a9-4899-2a95-c4b1-027d437e2ef7@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833e23a9-4899-2a95-c4b1-027d437e2ef7@adacore.com>
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

On Mon, Apr 23, 2018 at 11:31:34AM +0200, KONRAD Frederic wrote:
> 
> 
> On 04/19/2018 03:10 PM, Gerd Hoffmann wrote:
> > If some event caused some larger playback hickup the fine-grained timer
> > adjust isn't able to recover.  Use a buffer overruns and underruns as
> > indicator for that.  Reset timer adjust logic in case we detected one.
> 
> It seems that this patch causes big lockup of my Win10 KVM guest
> when it tries to output a sound.
> The three previous patches improved considerably the audio
> output though!

Can you try drop the "underrun" chunks, keeping only the "overrun"?

thanks,
  Gerd
