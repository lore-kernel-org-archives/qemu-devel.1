Received: from eggs.gnu.org ([2001:4830:134:3::10]:44113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVYXZ-00080n-JG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVYXW-0001Jp-Gg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVYXW-0001Jb-AS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:27:58 -0400
Date: Thu, 13 Jul 2017 09:27:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713092753.5a3ba530@gondolin>
In-Reply-To: <e44ca276-3318-1a18-9075-8edd6305c69c@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
	<20170712170713.1f5cf6b2@dhcp-192-215.str.redhat.com>
	<e44ca276-3318-1a18-9075-8edd6305c69c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] s390x/flic: introduce
 modify_ais_mode callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Thu, 13 Jul 2017 09:12:50 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/12/2017 05:07 PM, Cornelia Huck wrote:
> >> +
> >> +    switch (mode) {
> >> +    case SIC_IRQ_MODE_ALL:
> >> +        flic->simm &= ~AIS_MODE_MASK(isc);
> >> +        flic->nimm &= ~AIS_MODE_MASK(isc);
> >> +        break;
> >> +    case SIC_IRQ_MODE_SINGLE:
> >> +        flic->simm |= AIS_MODE_MASK(isc);
> >> +        flic->nimm &= ~AIS_MODE_MASK(isc);  
> > 
> > Can we have some documentation about the meaning of simm/nimm in qemu?
> > The one from the patch description of the respective kernel patch would
> > be fine.  
> 
> Do you want to have that description as part of the patch description or
> somewhere in the docs folder or somewhere in the code?

A comment near the definition of simm/nimm would be nice. Or in the
commit message, as for the kernel.
