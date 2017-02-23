Received: from eggs.gnu.org ([2001:4830:134:3::10]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgzi1-0001bW-32
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgzhx-0005nD-Q2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgzhx-0005n1-Jx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:09:45 -0500
Date: Thu, 23 Feb 2017 17:09:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170223200942.GP2778@thinpad.lan.raisama.net>
References: <20170222190029.17243-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222190029.17243-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Feb 22, 2017 at 04:00:26PM -0300, Eduardo Habkost wrote:
> This series implements query-cpu-model-expansion on target-i386.
> 
> Changes v2 -> v3:
> -----------------
> 
> * Rebased on top of my x86-next branch:
>   https://github.com/ehabkost/qemu x86-next
> * Added new patch that will extend type=full expansion to
>   return every (writeable) QOM property from the CPU object
> 
> Git branch for testing:
>   https://github.com/ehabkost/qemu-hacks work/x86-query-cpu-expansion
> 
> libvirt code to use the new feature already exist, and were
> submitted to libvir-list, at:
>   https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html
> 

As v2 was sitting on the list since Jan 16, I plan to include
this on my next pull request before soft freeze if there are no
objections.

-- 
Eduardo
