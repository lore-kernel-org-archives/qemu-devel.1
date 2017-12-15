Received: from eggs.gnu.org ([2001:4830:134:3::10]:37030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePrK1-0002s3-Ey
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePrJw-00089x-HA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePrJw-00089U-Aq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:50:40 -0500
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-5-dgilbert@redhat.com>
	<20171214162731.50a95633@redhat.com> <20171215133022.GD14126@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b22f588-f7be-d1e2-9b72-072308fe8218@redhat.com>
Date: Fri, 15 Dec 2017 15:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171215133022.GD14126@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

On 15/12/2017 14:30, Dr. David Alan Gilbert wrote:
>> Also it seems that we have a race in current code where
>> region_del() unrefs memory region first and then by the
>> commit time memory region could be gone since old flatview
>> is unreffed before commit callback is called, but guest still
>> uses old memory map until vhost_set_mem_table() is complete.
>> We probably should unref deleted(old) sections after
>> guest gets new memmap.
>
> Will they really get cleaned up before the commit() returns?
> There's no rcu like thing guarding it?

The memory subsystem only keeps them alive until before commmit() is
invoked.

Paolo
