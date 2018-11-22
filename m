Received: from eggs.gnu.org ([2001:4830:134:3::10]:58822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPtz2-00028E-C6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPtyz-0003zn-Ma
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:45:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gPtyz-0003xb-Hb
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:45:45 -0500
Date: Thu, 22 Nov 2018 19:45:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122184541.GH31879@linux.fritz.box>
References: <20181122182335.9038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122182335.9038-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: fix CMB endianness confusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

Am 22.11.2018 um 19:23 hat Paolo Bonzini geschrieben:
> The CMB is marked as DEVICE_LITTLE_ENDIAN, so the data must be
> read/written as if it was little-endian output (in the case of
> big endian, we get two swaps, one in the memory core and one
> in nvme.c).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch.

Kevin
