Received: from eggs.gnu.org ([2001:4830:134:3::10]:36111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFfg-0000A8-76
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eNFfd-0006xc-2L
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:14:20 -0500
Date: Fri, 8 Dec 2017 11:14:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171208111409.2f75e054.cohuck@redhat.com>
In-Reply-To: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
References: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Interactive Boot Menu: New Fields in IPLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On Thu, 7 Dec 2017 18:56:16 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> Hello,
> 
> I'd like to bring up a formal discussion regarding the utilization of 
> reserved space
> in the IPL Parameter Blocks for s390x guests. Particularly the following:
> 
>   * How should we approach "claiming" bytes so that we do not obstruct
>     future development?
>   * What would be "the best" location to store these new fields?

As Christian said, you probably need to check with the architecture
folks whether you can get some fields reserved for your use case.

In general, having this anywhere in the reserved areas of the iplb
should probably be fine (we migrate the iplb in two mostly-opaque
blobs).
