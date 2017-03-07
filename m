Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cl8kk-0004Ao-Sc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cl8kk-0004f5-6w
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:37:46 -0500
Date: Tue, 7 Mar 2017 14:37:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307063738.GB29283@lemon.lan>
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] vmstate: fix the failed iotests
 case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, mreitz@redhat.com

On Tue, 03/07 03:53, QingFeng Hao wrote:
> Hi All,
> I am not sure if the fix is correct because I am not very clear about the
> logic in vmstate.c. From my test, once size=0, the iotests case 68 failed
> due to the assert. So just send this draft patch for your comments!
> The patch is based on commit 17783ac828a "Merge remote-tracking branch
> 'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging".

I cannot reproduce the failure on either 17783ac828a or current head
56b51708e9e. Both passes for me. I wonder where do you get the size=0.

Fam
