Received: from eggs.gnu.org ([209.51.188.92]:48588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH58Q-0004k3-QT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH58P-0004hP-UK
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:18 -0400
Date: Thu, 18 Apr 2019 13:23:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418112308.GD5242@linux.fritz.box>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
	<20190418104737.GC5242@linux.fritz.box>
	<87b281df-e0a0-6537-0e1a-4c6af28ffc01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b281df-e0a0-6537-0e1a-4c6af28ffc01@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Am 18.04.2019 um 13:01 hat Paolo Bonzini geschrieben:
> On 18/04/19 12:47, Kevin Wolf wrote:
> >> This is acually only an issue with kernels prior to 4.5, so it should be
> >> fixed downstream instead.
> >
> > I don't think that upstream QEMU has kernels > 4.5 as an official
> > requirement, though? We try to be compatible with quite old libs, so we
> > should stay compatible with old kernels, too.
> 
> It is a pretty rare case, where the host must support very large
> scatter/gather lists (>=1024 elements) and there is a workaround by
> setting max_sectors_kb to 4096 in the host.  It also makes performance
> worse.

Fair enough. I didn't consider that it has a performance impact even on
newer kernels that don't need the patch.

Kevin
