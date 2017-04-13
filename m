Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyZlD-0004uY-M4
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyZlA-0008QV-EX
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:05:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b1a0b5a7-4528-eba8-630e-dd80bc8c26d2@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
	<w51fuhdkdbg.fsf@maestria.local.igalia.com>
	<b1a0b5a7-4528-eba8-630e-dd80bc8c26d2@redhat.com>
Date: Thu, 13 Apr 2017 10:05:39 +0200
Message-ID: <w51y3v4vijw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Wed 12 Apr 2017 04:10:46 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
>> I still don't see why we can always assume OFLAG_COPIED. Before doing
>> the COW one cluster can have references from multiple snapshots,
>
> Yes...
>
>> and OFLAG_COPIED is equally valid in that context.
>
> In what context? When having subclusters? Why?
>
>> We still need to know if we need to perform COW when writing to it,
>> regardless of whether it has subclusters or not.
>
> But why would you reference a cluster multiple times if it has
> subclusters? Yes, you can do it in theory, but we could just disallow
> it, because it doesn't make sense.

We discussed this yesterday on IRC, but I'm writing the summary here for
reference:

if you want be able to create internal snapshots quickly without having
to copy a lot of data, you need to be able to have multiple references
to one cluster.

Anyway, it seems that this discussion is only relevant if we're trying
to save as many bits as possible because we want to store everything in
a 64-bit entry -alternative (1) from my original e-mail-. I agree that
for that alternative the usefulness of that bit can be put into
question.

Berto
