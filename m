Received: from eggs.gnu.org ([2001:4830:134:3::10]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1canFe-0000CW-0U
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1canFd-0008Gq-7W
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:38:54 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfb6b59b-07b9-a3d1-66e8-8b09ec63d634@redhat.com>
Date: Mon, 6 Feb 2017 18:38:43 +0100
MIME-Version: 1.0
In-Reply-To: <877f53l4a5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 06/02/2017 16:36, Markus Armbruster wrote:
> Example: QOM properties and object-add, qom-set, qom-get
> 
> QOM properties are created at run-time.  They cannot be fixed at
> compile-time *by design*.  I always hated that part of the design, but I
> was assured we absolutely need that much rope^Wflexibility.

QOM now supports class properties.  We can convert the wide majority of
them, including qdev's "static" properties, to class properties.

Paolo
