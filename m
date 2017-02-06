Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carD2-00030O-Kb
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1carD1-0003X4-T5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:52:28 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
	<dfb6b59b-07b9-a3d1-66e8-8b09ec63d634@redhat.com>
	<87r33bfaso.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32fa6b2c-e1cb-1ac5-2707-22861e908e21@redhat.com>
Date: Mon, 6 Feb 2017 22:52:21 +0100
MIME-Version: 1.0
In-Reply-To: <87r33bfaso.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 06/02/2017 19:12, Markus Armbruster wrote:
>> QOM now supports class properties.  We can convert the wide majority of
>> them, including qdev's "static" properties, to class properties.
> 
> Won't help object-add as long as dynamic properties remain.

Well, only as long as dynamic properties remain necessary for classes
that the user can create.  The main user of dynamic properties is
children properties.

Paolo
