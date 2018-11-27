Received: from eggs.gnu.org ([2001:4830:134:3::10]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRaLr-000102-Hc
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRaLn-0000Uz-LK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:12:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:13851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRaLn-0000UI-DW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:12:15 -0500
Message-ID: <5BFD19A9.2010000@intel.com>
Date: Tue, 27 Nov 2018 18:17:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-4-git-send-email-wei.w.wang@intel.com>
	<20181127054056.GA3205@xz-x1> <5BFCDE07.20707@intel.com>
	<5BFCE052.8070705@intel.com> <20181127074127.GD3205@xz-x1>
In-Reply-To: <20181127074127.GD3205@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v9 3/8] migration: use
 bitmap_mutex in migration_bitmap_clear_dirty
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

On 11/27/2018 03:41 PM, Peter Xu wrote:
>
> Ok then I'm fine with it.  Though you could update the comments too if
> you like:
>
>      /* protects modification of the bitmap and migration_dirty_pages */
>      QemuMutex bitmap_mutex;
>
> And it's tricky that sometimes we don't take the lock when reading
> this variable "migration_dirty_pages".  I don't see obvious issue so
> far, hope it's true (at least I skipped the colo ones...).

The caller reads the value just to estimate the remaining_size, and
it seems fine without a lock, because whether it reads a
value before the update or after the update seem not causing
an issue.

Best,
Wei
