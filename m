Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfVv-0006qL-Ex
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfVu-0000v4-Mk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:21:43 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-10-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
Date: Tue, 12 Sep 2017 09:21:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 09/38] libqos: Track QTestState with
 QVirtioBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

On 11.09.2017 19:19, Eric Blake wrote:
> When initializing a QVirtioDevice (which always has an associated
> QVirtioBus), we want to track which QTestState to use for all
> I/O processed through that bus and device.  Copy the paradigm
> used for QPCIBus, and track the test state at the bus level; this
> in turn requires a separate bus object per device (and associated
> cleanup) rather than just sharing a const version of the dispatch
> table.
I fail to see why we need a separate bus object here for each device.
The bus is only available one time, not multiple times, isn't it? So
there should also only be one bus object floating around, not multiple
ones... or do I miss something?

 Thomas
