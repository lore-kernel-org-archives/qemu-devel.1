Received: from eggs.gnu.org ([2001:4830:134:3::10]:33268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Sxi-0002iF-1f
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Sxd-0001MX-P3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8Sxd-0001M9-Jb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:51:29 -0400
References: <20170510111350.18422-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70706623-df88-fec7-9402-d076abd20d29@redhat.com>
Date: Wed, 10 May 2017 16:51:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170510111350.18422-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: megasas: check request object in
 MegasasCmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Zhangyanyu <zyy4013@stu.ouc.edu.cn>, Prasad J Pandit <pjp@fedoraproject.org>



On 10/05/2017 13:13, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When processing completed commands, if SCSIRequest object
> 'cmd->req' was null, it could lead to null pointer dereference
> in megasas_complete_command. Add check to avoid it.
> 
> Reported-by: Zhangyanyu <zyy4013@stu.ouc.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

What version was this reported for?  It should be fixed in v2.8.0 and
newer by commit 9e55d58806 ("megasas: clean up and fix request
completion/cancellation", 2016-11-28).

Thanks,

Paolo
