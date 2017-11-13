Received: from eggs.gnu.org ([2001:4830:134:3::10]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEDET-0003za-NZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEDEQ-0001eB-MP
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:48:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eEDEQ-0001dZ-Gx
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:48:50 -0500
Date: Mon, 13 Nov 2017 12:48:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171113124843.7a7c0d42.cohuck@redhat.com>
In-Reply-To: <b1d8f3bf-b04c-1270-6ed0-ef5dfe7940d5@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175018.1c2f1b60.cohuck@redhat.com>
	<b1d8f3bf-b04c-1270-6ed0-ef5dfe7940d5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] s390x/pci: rework PCI STORE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Mon, 13 Nov 2017 10:03:37 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 09/11/2017 17:50, Cornelia Huck wrote:
> > On Tue,  7 Nov 2017 18:24:34 +0100
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> >> +    case PCI_ROM_SLOT:  
> > 
> > So, will this be filled in a later patch? (Reading from the top.)  
> 
> No it will not it is only a reminder that we explicitly do not support it.
> Since I do not know if we ever will support it do you think I better let 
> it fall?

Either add a comment, or drop it. Otherwise I will ask again in the
future :)
