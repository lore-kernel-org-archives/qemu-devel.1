Received: from eggs.gnu.org ([2001:4830:134:3::10]:40855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJyKj-0005Al-Lv
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJyKe-0002om-FA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJyKe-0002o6-5y
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:07:04 -0500
Date: Wed, 29 Nov 2017 17:06:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129090657.GB12220@lemon>
References: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gmail.com>
	<791b0b92-a232-bf63-bd12-0e663c19175c@redhat.com>
	<75400a80-c90c-8d8f-7823-f87c6e8a32d8@redhat.com>
	<20171128103632.48f11fba.cohuck@redhat.com>
	<72bd7016-cf0b-713c-444b-cc1f25787cd8@redhat.com>
	<20171129093109.121851dd.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129093109.121851dd.cohuck@redhat.com>
Subject: Re: [Qemu-devel] QEMU Summit 2017: minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 11/29 09:31, Cornelia Huck wrote:
> On Tue, 28 Nov 2017 13:30:23 -0500
> John Snow <jsnow@redhat.com> wrote:
> 
> > On 11/28/2017 04:36 AM, Cornelia Huck wrote:
> > > On Tue, 28 Nov 2017 09:33:52 +0100
> > > Thomas Huth <thuth@redhat.com> wrote:
> > >   
> > >> On 27.11.2017 23:03, John Snow wrote:  
> > >>>
> > >>> On 11/23/2017 11:31 AM, Peter Maydell wrote:    
> > >> [...]  
> > >>>> Continuous Integration:
> > >>>>  * Christian Borntraeger: qemu-iotests have broken a lot, they should be
> > >>>>    run before patches are merged    
> > >>>
> > >>> This, rather unfortunately, is a huge testing burden. I try to make sure
> > >>> I do it for everything I submit, but for the volume of block patches it
> > >>> really does rely CI. The more we add (to our pitifully sparse iotesting,
> > >>> I might add) the longer it takes. Ensuring per-patch testing begins to
> > >>> take prohibitively long.
> > >>>
> > >>> Perhaps per-pull or per-merge becomes more feasible. Maybe if we do
> > >>> implement a block-next amalgam we'd be able to batch our testing on a
> > >>> weekly basis.    
> > >>
> > >> I think you block-layer folks should do at least run the qemu-iotests
> > >> before sending a pull request to Peter. The iotests should really not be
> > >> broken in upstream master.  
> > > 
> > > This is unlikely to cover the iotest failures on s390 (due to usage of
> > > ccw, strange backing devices, etc.), though. We have basically two
> > > options here:
> > > - Continue to rely on the IBM folks finding those problems (which will
> > >   likely be post-merge, but better than nothing.)
> > > - Have patchew (which has a bot on s390) execute the iotests - which is
> > >   time-consuming.
> > >   
> > 
> > Does patchew test pull requests? Perhaps Peter could wait for an ACK
> > from patchew before committing. Peter and patchew could check PRs in
> > tandem and perhaps he can commit fully only when patchew ACKs.
> > 
> > for PRs specifically, perhaps patchew can indeed send an affirmative ACK
> > to the list indicating success.
> 
> I'd assume patchew can figure out whether it deals with a pull request
> by checking for 'PULL', and we post all patches in a pull request, so
> some special handling might be feasible.
> 
> Fam, what do you think?

Yes, but I guess we need to first address Peter's specific unhappiness about
patchew reports, before placing it in the pull request process: a lot of lines,
especially in the beginning of the email is not quite useful making the email
unfriendly to read.

If we want explicit ACKs from patchew on PULL process, two more changes are
needed (they apply to pull requests only):

1) Fetch from the pull request's git branch instead of applying. This has two
   advantages: when failed to apply a series, patchew doesn't test it, which
   cannot happend if we git-fetch instead of git-am; quite often a pull request
   v2, v3, ... only includes changed patch in the series, making git-am more
   likely to fail, which again is not a problem if we git-fetch.

2) Report if all tests cannot complete in time (e.g. a tester is down and some
   tests cannot run). The rationale is the same as above.

Fam
