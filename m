Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cmvs0-0002WU-Ic
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cmvrv-0003AM-Kk
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:16:40 -0500
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cmvrv-0003AF-Eq
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:16:35 -0500
Received: by mail-io0-x236.google.com with SMTP id g6so68698211ioj.1
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 21:16:35 -0800 (PST)
In-Reply-To: <mailman.57839.1489090092.22737.qemu-devel@nongnu.org>
References: <mailman.57839.1489090092.22737.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B82103D9-50D5-4278-A985-AFCE2EDBBB37@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sun, 12 Mar 2017 00:16:32 -0500
Subject: [Qemu-devel]  [PATCH Risu v2 0/3] PPC64 Improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 9, 2017, at 3:08 PM, qemu-devel-request@nongnu.org wrote:

>
> v2:
>  - applied code review
>
> This patchset include initial support to PPC64 (Big-Endian), that  
> is pretty
> much the same: only some fixes in configure and risugen.
> Also, it adds a better random initialization of VSX registers.
>
> Jose Ricardo Ziviani (3):
>   risugen_ppc64: Load random 128-bit data to VSX registers
>   configure: Add initial support to PPC64 (big endian)
>   risugen,risugen_ppc64.pm: Add support ppc64 (big-endian)
>
>  configure        |  9 ++++-----
>  risugen          |  6 +++++-
>  risugen_ppc64.pm | 44 +++++++++++++++++++++++++++++++++-----------
>  3 files changed, 42 insertions(+), 17 deletions(-)
>
> -- 
> 2.7.4

Would this patch set work with the IBM PowerPC 970 (G5) CPU?
