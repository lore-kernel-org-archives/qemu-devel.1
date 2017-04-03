Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cuyLg-00017J-7z
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cuyLb-0003P7-8G
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:32:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cuyLb-0003On-1y
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:32:27 -0400
References: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
	<1490978921-3782-3-git-send-email-gsomlo@gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <31b4d051-cc87-41c8-f568-8299f758bfe3@suse.de>
Date: Mon, 3 Apr 2017 11:32:25 +0200
MIME-Version: 1.0
In-Reply-To: <1490978921-3782-3-git-send-email-gsomlo@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] applesmc: consolidate port i/o into
 single contiguous region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, qemu-devel@nongnu.org
Cc: eshelton@pobox.com

On 03/31/2017 06:48 PM, Gabriel L. Somlo wrote:
> Newer AppleSMC revisions support an error status (read) port
> in addition to the data and command ports currently supported.
>
> Register the full 32-bit region at once, and handle individual
> ports at various offsets within the region from the top-level
> applesmc_io_[write|read]() methods (ctual support for reading
> the error status port to be added by a subsequent patch).
>
> Originally proposed by Eric Shelton <eshelton@pobox.com>
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

I would prefer if we could leave the multiplexing to the layer that 
knows how to do that the best: Memory Regions.

Why don't you just define a big region that ecompasses all of the IO 
space (with fallback I/O handlers for warnings) and then just sprinkle 
the ones we handle on top with higher prio?


Alex
