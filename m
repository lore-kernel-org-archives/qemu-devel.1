Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0OHL-0004iO-Vp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d0OHI-0004ZK-0g
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:14:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d0OHH-0004ZD-Qi
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 04:14:23 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so10500848wmb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 01:14:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
Date: Tue, 18 Apr 2017 01:14:19 -0700
MIME-Version: 1.0
In-Reply-To: <fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/openrisc: Implement full
 vmstate serialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org

On 04/16/2017 04:23 PM, Stafford Horne wrote:
> Previously serialization did not persist the tlb, timer, pic and other
> key state items.  This meant snapshotting and restoring a running os
> would crash. After adding these I am able to take snapshots of a
> running linux os and restore at a later time.
>
> I am currently not trying to maintain capatibility with older versions
> as I do not believe this really worked before or anyone used it.

That's fine, but you still have to bump the version numbers.


r~
