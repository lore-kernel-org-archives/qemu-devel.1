Received: from eggs.gnu.org ([2001:4830:134:3::10]:59028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtsXz-0006KA-KG
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtsXw-00049s-HY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:40:59 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtsXw-00049Y-Bd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:40:56 -0400
Received: by mail-wr0-x244.google.com with SMTP id p37so4728099wrb.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:40:56 -0700 (PDT)
Date: Mon, 18 Sep 2017 10:40:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918094053.GC31063@stefanha-x1.localdomain>
References: <20170915230744.22942-1-ehabkost@redhat.com>
	<eabb65a2-cd0b-e968-2e19-c4c9ac3396a4@redhat.com>
	<20170916003832.GF10621@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170916003832.GF10621@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Sep 15, 2017 at 09:38:32PM -0300, Eduardo Habkost wrote:
> On Fri, Sep 15, 2017 at 08:17:18PM -0400, John Snow wrote:
> > 
> > 
> > On 09/15/2017 07:07 PM, Eduardo Habkost wrote:
> > > Cleber and I are volunteering to review and queue patches for the
> > > Python scripts and modules in scripts/.
> > > 
> > > I'm setting "M: Odd fixes" because not all scripts are actively
> > > maintained.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > Even before this patch is merged, I plan to send a pull request
> > > including some patches for the Python code soon.
> > > ---
> > >  MAINTAINERS | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 2c333aba21..2c3b8ecde7 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1390,6 +1390,13 @@ S: Maintained
> > >  F: include/sysemu/cryptodev*.h
> > >  F: backends/cryptodev*.c
> > >  
> > > +Python scripts
> > > +M: Eduardo Habkost <ehabkost@redhat.com>
> > > +M: Cleber Rosa <crosa@redhat.com>
> > > +S: Odd fixes
> > > +F: scripts/qmp/*
> > > +F: scripts/*.py
> > > +
> > >  QAPI
> > >  M: Markus Armbruster <armbru@redhat.com>
> > >  M: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > 
> > 
> > I rather like the thought of having dedicated Python maintainers who can
> > review python code with an eye for what is idiomatic. I am fairly
> > certain the python I write is functional, but I'm rarely sure it's what
> > a python programmer would do.
> > 
> > I suppose you are intentionally omitting any python that exists as part
> > of the test infrastructure, however?
> 
> Initially, yes.  I was trying to include only the stuff we were
> actively maintaining.  But later I decided to use "S: Odd fixes"
> instead of "S: Maintained", so I guess it won't hurt to include
> this:
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
