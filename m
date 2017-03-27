Received: from eggs.gnu.org ([2001:4830:134:3::10]:43587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1csbLx-0000OC-Bs
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1csbLt-0003KS-Gw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1csbLt-0003Js-CD
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:34:57 -0400
References: <db8ccb55-0570-4b6f-1635-7df2ff0b9ec3@redhat.com>
	<20170326183908.cogmdiisen2jlsh5@var.youpi.perso.aquilenet.fr>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <0436cb6b-9cfe-efd0-5084-a3d79af73dd3@redhat.com>
Date: Mon, 27 Mar 2017 16:34:54 -0400
MIME-Version: 1.0
In-Reply-To: <20170326183908.cogmdiisen2jlsh5@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] slirp + ipxe + ipv6 dns issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: ondrejj@salstar.sk, qemu-devel <qemu-devel@nongnu.org>

On 03/26/2017 02:39 PM, Samuel Thibault wrote:
> Hello,
> 
> Cole Robinson, on ven. 24 mars 2017 21:17:43 -0400, wrote:
>> I bisected to this commit:
>>
>>     slirp: Add RDNSS advertisement
> 
> Mmm, I see.  Could you try the attached patch to confirm that it fixes
> the issue for you too?
> 

I also confirmed your patches fix the test case. Thanks!

- Cole
