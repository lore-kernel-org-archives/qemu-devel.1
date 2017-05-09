Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d87Ws-0003qU-9K
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d87Wm-0007sJ-S1
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:58:26 -0400
References: <27a960b7-1d4d-a430-46f3-5c12e2e29893@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a419f42-0190-343f-184c-fbbffa7996fb@redhat.com>
Date: Tue, 9 May 2017 17:58:14 +0200
MIME-Version: 1.0
In-Reply-To: <27a960b7-1d4d-a430-46f3-5c12e2e29893@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Strange location of the "qemu-ga Invocation"
 chapter in the qemu-doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>



On 09/05/2017 16:29, Thomas Huth wrote:
>  Hi all,
> 
> I noticed that the "qemu-ga Invocation" chapter in the QEMU doc is in a
> strange location - it's a sub-chapter of the "Disk images" chapter.
> Since the guest agent is not directly related to the handling of disk
> images, that sounds somewhat wrong to me - or do I miss something?
> Does anybody have a suggestion for a better location?

It should be part of a separate manual, probably, together with QMP and
other management stuff.  But for now just moving it to a @chapter would do.

Paolo
