Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqcB0-0006ZW-FK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eqcAv-0002WT-LG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:08:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:30066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eqcAv-0002Ut-AZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:07:57 -0500
Message-ID: <5A952EA7.8010708@intel.com>
Date: Tue, 27 Feb 2018 18:10:47 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
	<20180209121517.GD2428@work-vm> <5A938E93.5020502@intel.com>
	<20180227024325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180227024325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio-balloon: add a timer to
 limit the free page report waiting time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com

On 02/27/2018 08:50 AM, Michael S. Tsirkin wrote:
> On Mon, Feb 26, 2018 at 12:35:31PM +0800, Wei Wang wrote:
>> On 02/09/2018 08:15 PM, Dr. David Alan Gilbert wrote:
>>> * Wei Wang (wei.w.wang@intel.com) wrote:
>
> I think all this is premature optimization. It is not at all clear that
> anything is gained by delaying migration. Just ask for hints and start
> sending pages immediately.  If guest tells us a page is free before it's
> sent, we can skip sending it.  OTOH if migration is taking less time to
> complete than it takes for guest to respond, then we are better off just
> ignoring the hint.

OK, I'll try to create a thread for the free page optimization. We 
create the thread to poll for free pages at the beginning of the bulk 
stage, and stops at the end of bulk stage.
There are also comments about postcopy support with this feature, I plan 
to leave that as the second step (that support seems not urgent for now).


Best,
Wei
