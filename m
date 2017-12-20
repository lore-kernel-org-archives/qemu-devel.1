Received: from eggs.gnu.org ([2001:4830:134:3::10]:34014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eRbD9-00034X-4w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eRbD3-0007oL-MS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57768)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eRbD3-0007nv-E1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:02:45 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171220075804.15036.93598.stgit@pasha-VirtualBox>
	<20171220091706.GA2348@work-vm>
	<000301d37973$e85a7a80$b90f6f80$@ru>
	<20171220094036.GB2348@work-vm>
In-Reply-To: <20171220094036.GB2348@work-vm>
Date: Wed, 20 Dec 2017 13:02:46 +0300
Message-ID: <000a01d37979$af4f2640$0ded72c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [ PATCH  ] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, quintela@redhat.com, mst@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com



> * Pavel Dovgalyuk (dovgaluk@ispras.ru) wrote:
> > > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > > * Pavel Dovgalyuk (Pavel.Dovgaluk@ispras.ru) wrote:
> > > > HPET saves its state by calculating the current time and recovers timer
> > > > offset using this calculated value. But these calculations include
> > > > divisions and multiplications. Therefore the timer state cannot be recovered
> > > > precise enough.
> > > > This patch introduces saving of the original value of the offset to
> > > > preserve the determinism of the timer.
> > >
> > > Please put the extra data in a subsection and tie the subsection to a
> > > property enabled by the machine type.  That avoids breaking backwards
> > > migration compatibility.
> >
> > I thought about it and haven't found how to preserve the backward migration compatibility
> > without breaking everything else.
> > Loading old (or compatible) snapshot without changing the version will corrupt the offset in
> > post_load.
> 
> There are lots of ways; for example you could initialise hpet_offset to
> a dummy value in a pre-load and spot that in the post-load instead of
> the version_id, or set a flag in a post-load on the subsection.

Thanks. Please check the second version.

Pavel Dovgalyuk
