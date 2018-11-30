Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gScsM-0001dz-DG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gScrE-0007qN-Ot
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:05:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:30049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gScrE-0007m5-DY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:05:00 -0500
Message-ID: <5C00E243.10409@intel.com>
Date: Fri, 30 Nov 2018 15:09:55 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com>
	<20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com>
	<20181128093220.GF12839@xz-x1> <5BFF5FC9.2020402@intel.com>
	<20181129051014.GC29246@xz-x1> <5C00C52F.20606@intel.com>
	<20181130055736.GA15865@xz-x1>
In-Reply-To: <20181130055736.GA15865@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/8] migration/ram.c: add a notifier
 chain for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/30/2018 01:57 PM, Peter Xu wrote:
>>
>>
>> Or you can introduce migration_bitmap_sync_precopy() and let precopy
>> code call that one instead.

Agree, thanks.

> PS. I'm a bit unsure on why we need to sync bitmap in ram_init_bitmaps.
> I feel like it can be removed...

Seems it was added in early days to fix some bug:
https://git.virtualopensystems.com/dev/qemu/commit/79536f4f16934d6759a1d67f0342b4e7ceb66671?w=1

Hopefully, Juan could share some details about that.

Best,
Wei
