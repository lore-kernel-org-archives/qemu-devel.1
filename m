Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWSv-00037g-3m
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyWSu-00064r-EI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 01:39:13 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-3-pbonzini@redhat.com>
	<663bee4b-0554-9b68-6253-1ebe75bc7b3b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ec25159-2ce7-1eaf-19fe-3ffccbad1c00@redhat.com>
Date: Wed, 21 Mar 2018 06:39:03 +0100
MIME-Version: 1.0
In-Reply-To: <663bee4b-0554-9b68-6253-1ebe75bc7b3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] ide: push end_transfer callback to
 ide_transfer_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On 20/03/2018 23:11, John Snow wrote:
> Seems sane, with some lingering questions about what the PIO Setup FIS
> is supposed to do to begin with still remaining.

I agree here too.  Smashing the ATA and controller in the same device
makes things tricky, so I tried to make these patches pure code motion,
as much as I could.

Paolo
