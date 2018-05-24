Received: from eggs.gnu.org ([2001:4830:134:3::10]:34703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLt3G-000827-7Z
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLt3C-0002Jy-7t
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:25:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<20180524174603-mutt-send-email-mst@kernel.org>
	<20180524150817.GF4008@localhost.localdomain>
	<20180524152014.GW2209@redhat.com>
Date: Thu, 24 May 2018 18:25:05 +0200
In-Reply-To: <20180524152014.GW2209@redhat.com> (Richard W. M. Jones's message
	of "Thu, 24 May 2018 16:20:14 +0100")
Message-ID: <87y3g9yqam.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Thu, May 24, 2018 at 05:08:17PM +0200, Kevin Wolf wrote:
>> Am 24.05.2018 um 16:56 hat Michael S. Tsirkin geschrieben:
>> > On Thu, May 24, 2018 at 12:32:51PM +0100, Richard W.M. Jones wrote:
>> > > There is however a seed of a good idea in the thread:
>> > > 
>> > > > I don't think QEMU needs to use this information automatically,
>> > > > necessarily.  I think the first step is to simply make QEMU save
>> > > > this information in the disk image, and making qemu-img able to
>> > > > read and write this information.
>> > > 
>> > > It would be nice if qcow2 added arbitrary data sections (which would
>> > > always be ignored by qemu) for storing additional data.  This could be
>> > > used to create a compact qcow2 + metadata format to rival OVA for
>> > > management layers to use, and there are various other uses too.
>> > > 
>> > > Rich.
>> > 
>> > I think this part is pretty uncontroversial.
>> > 
>> > But can we add data without changing the verion?
>> 
>> Yes. Don't worry about where to store it, we'll solve this. Do worry
>> about what to store.
>
> Ideally from my point of view: named blobs.  More formally, any number
> of (key, value) pairs where the key is a simple string, and the value
> is a binary blob.  The binary blobs might really be XML or YAML or an
> icon or whatever, but qemu would not need to look inside them.
>
> We could then attach metadata (in some to-be-decided format) to qcow2
> files and create a compact rival to OVA without needing to encode any
> knowledge of the metadata into qemu at all.
>
> Another use for this is allowing qcow2 files to contain names, titles,
> descriptions, creation date, OS icons, etc. which could be displayed
> in file managers.

Have we just reinvented resource forks?

SCNR ;)
