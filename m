Received: from eggs.gnu.org ([2001:4830:134:3::10]:57113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzhr-0008CQ-9B
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzhq-0005XQ-Gt
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:44:43 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org> <20170204122150.GA15362@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e57dc20-d69a-a322-967c-61a0b7f921f7@redhat.com>
Date: Sat, 4 Feb 2017 04:44:32 -0800
MIME-Version: 1.0
In-Reply-To: <20170204122150.GA15362@lemon>
Content-Type: text/plain; charset=windows-1252
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
To: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/02/2017 04:21, Fam Zheng wrote:
>     -json "id=children0,text=[
>                 { 'driver': 'null-co://' },
>                 { 'driver': 'null-co://' },

You meant ,, at the end of this lines.  Which throws a wrench in your
proposal somewhat. :(

Paolo

>                 { 'driver': 'null-co://' }
>             ]" \
>     -dot \
>       id=quorum0,driver=quorum,read-pattern=fifo,vote-threshold=1,children=@children0 \
>     -drive if=virtio,id=primary-disk0,driver=qcow2,file=@quorum0
