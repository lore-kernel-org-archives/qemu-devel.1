Received: from eggs.gnu.org ([2001:4830:134:3::10]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fCJ6m-0006pX-Rh
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 02:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fCJ6j-0008Sx-M3
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 02:13:20 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fCJ6j-0008Sl-Ff
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 02:13:17 -0400
Received: by mail-pg0-x22e.google.com with SMTP id p10-v6so3020944pgn.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 23:13:17 -0700 (PDT)
References: <20180426091519.26934-1-xiaoguangrong@tencent.com>
	<32eaad8e-35a0-5240-37a2-4242b7890ab9@redhat.com>
	<a14b1b5b-4f0c-c085-35b8-9539afa5091f@gmail.com>
	<20180427112926.GE2608@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ddcf623a-83c6-973e-577b-b8f956d51a8d@gmail.com>
Date: Sat, 28 Apr 2018 14:13:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180427112926.GE2608@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn



On 04/27/2018 07:29 PM, Dr. David Alan Gilbert wrote:

>>
>> Yes, can not agree with you more. :)
> 
> The challenge is how to put something into the stream without breaking
> an old version of QEMU that's receiving the stream.
> 

Er, i did not think this case :(.

The new parameter as this patch did is the only idea now in my mind...
not sure if Eric and Peter have another solution.
