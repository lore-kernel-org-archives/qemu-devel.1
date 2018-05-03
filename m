Received: from eggs.gnu.org ([2001:4830:134:3::10]:40949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE9N0-0007Ao-TL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE9Mv-0001IU-UX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:13:42 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fE9Mv-0001IC-Oh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:13:37 -0400
Received: by mail-pg0-x22b.google.com with SMTP id z129-v6so8398732pgz.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 01:13:37 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20180503080611.23834-1-xiaoguangrong@tencent.com>
Message-ID: <bc21ed25-a6cd-63e3-f943-c1963da54480@gmail.com>
Date: Thu, 3 May 2018 16:13:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180503080611.23834-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: introduce
 decompress-error-check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, Eric Blake <eblake@redhat.com>

On 05/03/2018 04:06 PM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> QEMU 2.13 enables strict check for compression & decompression to
> make the migration more robust, that depends on the source to fix
> the internal design which triggers the unexpected error conditions
> 
> To make it work for migrating old version QEMU to 2.13 QEMU, we
> introduce this parameter to disable the error check on the
> destination which is the default behavior of the machine type
> which is older than 2.13, alternately, the strict check can be
> enabled explicitly as followings:
>        -M pc-q35-2.11 -global migration.decompress-error-check=true
> 

[ CC: Eric ]

Hi, Dave, Eric, Peter,

Could you please have a look if it is good to you guys.

Thanks!
