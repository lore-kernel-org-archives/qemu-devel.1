Received: from eggs.gnu.org ([2001:4830:134:3::10]:60086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMsk8-0000Wf-Px
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMsk4-0006B9-P8
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:49:56 -0500
Date: Wed, 14 Nov 2018 11:49:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181114104934.GB10481@dhcp-200-186.str.redhat.com>
References: <20181113164544.9906-1-berto@igalia.com>
	<bf4041ab-7288-53fc-055c-1c7c7a607d42@redhat.com>
	<w51wopgjfrc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51wopgjfrc.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [for 3.1? PATCH] qcow2: Assert that refcount block
 offsets fit in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 14.11.2018 um 08:10 hat Alberto Garcia geschrieben:
> On Tue 13 Nov 2018 06:06:54 PM CET, Eric Blake <eblake@redhat.com> wrote:
> 
> >> Refcount table entries have a field to store the offset of the
> >> refcount block. The rest of the bits of the entry are currently
> >> reserved.
> >> 
> >> The offset is always taken from the entry using REFT_OFFSET_MASK to
> >> ensure that we only use the bits that belong to that field.
> >> 
> >> While that mask is used every time we read from the refcount table, it
> >> is never used when we write to it. Due to the other constraints of the
> >> qcow2 format QEMU can never produce refcount block offsets that don't
> >> fit in that field so any such offset when allocating a refcount block
> >> would indicate a bug in QEMU.

Missing S-o-b.

> >>   block/qcow2-refcount.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >> 
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Yes, for 3.1, shall I resend it with the updated subject message?

Honestly, I don't see why an additional assertion should qualify as a
fix? If it changes the behaviour, it's a bug.

You wouldn't have to resend for the updated subject message, but you do
for the missing S-o-b.

Kevin
