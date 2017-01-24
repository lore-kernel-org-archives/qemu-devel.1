Received: from eggs.gnu.org ([2001:4830:134:3::10]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW73D-0001CU-MV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW739-0005Rt-7M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW739-0005Rg-1k
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:46:39 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E17176EE
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:46:39 +0000 (UTC)
Date: Tue, 24 Jan 2017 21:46:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124214541-mutt-send-email-mst@kernel.org>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<148528238622.27.17897890473229610195@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148528238622.27.17897890473229610195@eba24e3a0d7f>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] virtio: use MemoryRegionCache for
 descriptors and rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com

On Tue, Jan 24, 2017 at 10:26:27AM -0800, no-reply@patchew.org wrote:
> qemu-system-x86_64: /tmp/qemu-test/src/exec.c:3180: address_space_translate_cached: Assertion `addr < cache->len && *plen <= cache->len - addr' failed.
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....

Interesting.

-- 
MST
