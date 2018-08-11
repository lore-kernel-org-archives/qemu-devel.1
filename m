Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHOx-0006LX-0O
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHOt-0004zj-1D
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:05:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1foHOs-0004yu-Mc
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:04:58 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20180810100005.3ttvqgaz7sc3iajj@sirius.home.kraxel.org>
Date: Sat, 11 Aug 2018 03:04:53 +0300
Content-Transfer-Encoding: 7bit
Message-Id: <6E4D921B-7291-4967-90C3-FA3B8BC75C20@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-7-git-send-email-liran.alon@oracle.com>
	<20180810100005.3ttvqgaz7sc3iajj@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 06/29] vmsvga: Fix parse of
 SVGA_CMD_UPDATE_VERBOSE to consider additional opaque cookie
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>



> On 10 Aug 2018, at 13:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
>  Hi,
> 
>> +            if (cmd == SVGA_CMD_UPDATE_VERBOSE)
>> +                vmsvga_fifo_read(s);
> 
> Code style.  qemu wants braces unconditionally.  There might be more of
> this in following patches.  You can use scripts/checkpatch.pl to check.
> 
> cheers,
>  Gerd
> 

Oops. Will fix for v2 of patch series.

Thanks,
-Liran
