Received: from eggs.gnu.org ([2001:4830:134:3::10]:59506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZzzZ-0005Dx-QL
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cZzzY-0003TK-VI
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:03:01 -0500
Date: Sat, 4 Feb 2017 21:02:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170204130250.GA7596@lemon>
References: <87bmukmlau.fsf@dusky.pond.sub.org> <20170204122150.GA15362@lemon>
	<6e57dc20-d69a-a322-967c-61a0b7f921f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e57dc20-d69a-a322-967c-61a0b7f921f7@redhat.com>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Sat, 02/04 04:44, Paolo Bonzini wrote:
> 
> 
> On 04/02/2017 04:21, Fam Zheng wrote:
> >     -json "id=children0,text=[
> >                 { 'driver': 'null-co://' },
> >                 { 'driver': 'null-co://' },
> 
> You meant ,, at the end of this lines.  Which throws a wrench in your
> proposal somewhat. :(

Ahh right.. We could just specially ditch the ,, escape here and start over with
a faithful JSON parser added to which a mere id syntax (i.e. the "ID=" prefix):

    -json "children0=[
                 { 'driver': 'null-co://' },
                 { 'driver': 'null-co://' },
                 { 'driver': 'null-co://' }
             ]" \


> 
> Paolo
> 
> >                 { 'driver': 'null-co://' }
> >             ]" \
> >     -dot \
> >       id=quorum0,driver=quorum,read-pattern=fifo,vote-threshold=1,children=@children0 \
> >     -drive if=virtio,id=primary-disk0,driver=qcow2,file=@quorum0
> 
