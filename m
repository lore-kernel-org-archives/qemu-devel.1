Received: from eggs.gnu.org ([2001:4830:134:3::10]:48464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9ci7-0001ap-H6
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9ci2-0002Lk-IY
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1e9ci2-0002KZ-A0
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:00:26 -0400
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
	<BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
	<f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
	<BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e88f74be-e219-bc1f-2f41-05ec29824897@redhat.com>
Date: Tue, 31 Oct 2017 16:00:16 -0400
MIME-Version: 1.0
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 10/26/2017 03:18 AM, Changlimin wrote:
> If the qcow2 file is created with preallocation=full, I think metadata will not corrupt when it is shared between two vms? Snapshot is not required. 
> 
> Is this right?
> 

You can only share images read-only in this way. If you are asking to
share one qcow2 as r/w across two VMs, that's not going to work
regardless of how you allocate them, or the image format you are using.

--js

> BR
> Chang limin
> 
