Received: from eggs.gnu.org ([2001:4830:134:3::10]:56736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdgXl-0002bJ-Ed
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdgXg-0005vQ-H0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:05:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cdgXg-0005v2-8V
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:05:28 -0500
Date: Tue, 14 Feb 2017 12:05:26 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170214170526.GR27752@localhost.localdomain>
References: <20161108204413.GA6353@localhost.localdomain>
	<CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
	<20170213133725.GA10361@stefanha-x1.localdomain>
	<20170213163232.GN27752@localhost.localdomain>
	<B3F9860E-E786-48A5-8BBD-918833905E73@veritas.com>
	<20170213232302.GP27752@localhost.localdomain>
	<983C87E0-DE5B-4147-82CD-CE6A8D093B6C@veritas.com>
	<CAAo6VWNYZG5fc7Z9_u+9Qew5VgbTRA_cRfTu8wqPpOXzTrjvfA@mail.gmail.com>
	<20170214163517.GQ27752@localhost.localdomain>
	<20170214165109.GF17056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214165109.GF17056@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: ashish mittal <ashmit602@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>

On Tue, Feb 14, 2017 at 04:51:09PM +0000, Daniel P. Berrange wrote:
> On Tue, Feb 14, 2017 at 11:35:17AM -0500, Jeff Cody wrote:
> > From 7c135439fd0151860cb0f6ef1a857dfbee6e6317 Mon Sep 17 00:00:00 2001
> > From: Jeff Cody <jcody@redhat.com>
> > Date: Tue, 14 Feb 2017 09:51:42 -0500
> > Subject: [PATCH] qemu-iotests: exclude vxhs from image creation via protocol
> > 
> > The protocol VXHS does not support image creation.  Some tests expect
> > to be able to create images through the protocol.  Exclude VXHS from
> > these tests.
> 
> [snip]
> 
> > diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
> > index e3f9e75..4f9302d 100755
> > --- a/tests/qemu-iotests/017
> > +++ b/tests/qemu-iotests/017
> > @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> >  # Any format supporting backing files
> >  _supported_fmt qcow qcow2 vmdk qed
> >  _supported_proto generic
> > +_unsupported_proto vxhs
> >  _supported_os Linux
> >  _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
> 
> I've no objection to your patch as is, just a thought for future
> improvements.
> 
> There's quite a few block protos that doen't support image
> creation. Rather than listing protocols in _unsupported_proto
> it would be more scalable if we could list features. eg if
> each test had
> 
>   _supported_feature imagecreate
> 
> Then, the tests/qemu-iotests/common file could set the list
> of features supported by each protocol/format. Thus avoiding
> the need to update all iotests when adding new protocols. We
> could have features for "encryption", and "snapshots" and
> "backing_files", etc too
>

I like that approach, good idea.

-Jeff
