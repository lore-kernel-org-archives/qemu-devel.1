Received: from eggs.gnu.org ([2001:4830:134:3::10]:43568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOik0-00029E-65
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOijv-0002YS-8r
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOijv-0002Y2-2a
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:28:47 -0500
References: <20171211194610.3962-1-dgilbert@redhat.com>
	<20171211194610.3962-2-dgilbert@redhat.com>
	<97feaaf8-b08e-2c49-6cdb-b1556f6326cd@redhat.com>
	<20171212103138.GC2409@work-vm>
	<7677f3f3-72b9-0f0c-13ca-ace1196ed45b@redhat.com>
	<20171212110357.GD2409@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <514f0650-ceb1-0658-a640-72e5336a8483@redhat.com>
Date: Tue, 12 Dec 2017 12:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171212110357.GD2409@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] memory: address_space_iterate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

On 12/12/2017 12:03, Dr. David Alan Gilbert wrote:
>> nop means that attributes (readonly, romd_mode, mr+offset_in_region)
>> haven't changed; nop is optionally followed by log_start or log_stop.
>> If any of them changes, you get del+add (del is always before add).
>>
>>> Th nice thing we have here is we get a full walk of the physical memory
>>> in order; keeping it in order makes our data structure easy for merging.
>> That's the same that you get with region_del/add.
> Hmm it would be good if that was documented somewhere.
> I thought you'd only get an _add/_del and then a commit.
> 
> However, what do I do in vhost_dev_start?  At the moment I'm forcfully
> regenerating it using the same code.

When you add a listener, you get adds and a commit for the current state
of the AddressSpace.

Paolo
