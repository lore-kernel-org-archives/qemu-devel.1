Received: from eggs.gnu.org ([2001:4830:134:3::10]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOcOn-0004sb-HT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOcOk-00065w-8d
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:14:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:44823)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fOcOj-0005uA-UR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:14:46 -0400
From: Junyan He <junyan.he@gmx.com>
Sender: Junyan He <junyan.he@hotmail.com>
Date: Fri, 1 Jun 2018 05:14:10 +0000
Message-ID: <HK2PR06MB0531C309B13F989AEB78842AEB620@HK2PR06MB0531.apcprd06.prod.outlook.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-3-git-send-email-junyan.he@gmx.com>,
	<20180531130942.GK27838@stefanha-x1.localdomain>
In-Reply-To: <20180531130942.GK27838@stefanha-x1.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/9 V5] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Haozhong Zhang <haozhong.zhang@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, Junyan He <junyan.he@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Because we have disk backend imitation for NVDimm kind memory, I think it i=
s more

flexible for user to specify the real or not real pmem rather than we check=
 in qemu

using the pmem_is_pmem API

________________________________
From: Stefan Hajnoczi <stefanha@gmail.com>
Sent: Thursday, May 31, 2018 1:09:42 PM
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org; Haozhong Zhang; xiaoguangrong.eric@gmail.com; cr=
osthwaite.peter@gmail.com; mst@redhat.com; dgilbert@redhat.com; ehabkost@re=
dhat.com; quintela@redhat.com; Junyan He; stefanha@redhat.com; pbonzini@red=
hat.com; imammedo@redhat.com; rth@twiddle.net
Subject: Re: [Qemu-devel] [PATCH 2/9 V5] hostmem-file: add the 'pmem' optio=
n

On Thu, May 10, 2018 at 10:08:51AM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>
> When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
> needs to know whether the backend storage is a real persistent memory,
> in order to decide whether special operations should be performed to
> ensure the data persistence.
>
> This boolean option 'pmem' allows users to specify whether the backend
> storage of memory-backend-file is a real persistent memory. If
> 'pmem=3Don', QEMU will set the flag RAM_PMEM in the RAM block of the
> corresponding memory region.

I'm still not sure if this option is necessary since pmem_is_pmem() is
available with the introduction of the libpmem dependency.  Why can't it
be used?

Stefan
