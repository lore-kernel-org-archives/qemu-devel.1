Received: from eggs.gnu.org ([2001:4830:134:3::10]:49993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBd4T-0001DS-0x
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fBd4P-0004ng-OO
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:20:09 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:42128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fBd4P-0004n7-HZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:20:05 -0400
Received: by mail-pg0-x241.google.com with SMTP id e12so15459244pgn.9
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 02:20:05 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
Message-ID: <f58e5e7d-da9c-6424-f0a7-29b5cadd72e4@gmail.com>
Date: Thu, 26 Apr 2018 17:19:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180426091519.26934-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: introduce decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>


Hi Dave,

On 04/26/2018 05:15 PM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> QEMU 2.13 enables strict check for compression & decompression to
> make the migration more robuster, that depends on the source to fix
> the internal design which triggers the unexpected error conditions
> 
> To make it work for migrating old version QEMU to 2.13 QEMU, we
> introduce this parameter to disable the error check on the
> destination

We noticed this issue when evaluated your pull request, could you
please review this fix and pull it to 2.13 release? Sorry, i did
not realize it before. :(
