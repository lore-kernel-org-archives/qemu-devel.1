Received: from eggs.gnu.org ([2001:4830:134:3::10]:60520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cnWxF-0000rg-3q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cnWxB-0005Rz-7N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:52:33 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cnWxB-0005Qe-2u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:52:29 -0400
Received: by mail-qt0-x241.google.com with SMTP id r45so7768945qte.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 13:52:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170311183016.GA20514@ls3530.fritz.box>
	<ccf72219-1498-4434-8dd4-625c49afee7c@twiddle.net>
	<198870a8-664f-06a0-e479-2167ebbfb01d@gmx.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2bd34b43-7efc-8081-c637-2fbeb0747926@twiddle.net>
Date: Tue, 14 Mar 2017 06:52:19 +1000
MIME-Version: 1.0
In-Reply-To: <198870a8-664f-06a0-e479-2167ebbfb01d@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add TARGET_MAP_STACK and
 TARGET_MAP_HUGETLB for all remaining architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 03/14/2017 12:09 AM, Helge Deller wrote:
> But the main intention of my patch was not to fix MAP_STACK or MAP_HUGETLB,
> but more to ensure that those flags are avoided to be handed over to the host.
> For example, TARGET_MAP_STACK is 0x40000 on hppa, and if it's not filtered out
> in e.g. a mmap() call, then this becomes to MAP_HUGETLB on x86_64 (which is
> 0x40000 on x86_64).

Ah... yes.  That is a much better point.


r~
