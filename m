Received: from eggs.gnu.org ([2001:4830:134:3::10]:42443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt18D-00007d-E5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt18A-0007XE-Bt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt18A-0007Wf-54
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:38:46 -0400
Date: Fri, 15 Sep 2017 21:38:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170916003832.GF10621@localhost.localdomain>
References: <20170915230744.22942-1-ehabkost@redhat.com>
	<eabb65a2-cd0b-e968-2e19-c4c9ac3396a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabb65a2-cd0b-e968-2e19-c4c9ac3396a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Amador Pahim <apahim@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Sep 15, 2017 at 08:17:18PM -0400, John Snow wrote:
> 
> 
> On 09/15/2017 07:07 PM, Eduardo Habkost wrote:
> > Cleber and I are volunteering to review and queue patches for the
> > Python scripts and modules in scripts/.
> > 
> > I'm setting "M: Odd fixes" because not all scripts are actively
> > maintained.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Even before this patch is merged, I plan to send a pull request
> > including some patches for the Python code soon.
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2c333aba21..2c3b8ecde7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1390,6 +1390,13 @@ S: Maintained
> >  F: include/sysemu/cryptodev*.h
> >  F: backends/cryptodev*.c
> >  
> > +Python scripts
> > +M: Eduardo Habkost <ehabkost@redhat.com>
> > +M: Cleber Rosa <crosa@redhat.com>
> > +S: Odd fixes
> > +F: scripts/qmp/*
> > +F: scripts/*.py
> > +
> >  QAPI
> >  M: Markus Armbruster <armbru@redhat.com>
> >  M: Michael Roth <mdroth@linux.vnet.ibm.com>
> > 
> 
> I rather like the thought of having dedicated Python maintainers who can
> review python code with an eye for what is idiomatic. I am fairly
> certain the python I write is functional, but I'm rarely sure it's what
> a python programmer would do.
> 
> I suppose you are intentionally omitting any python that exists as part
> of the test infrastructure, however?

Initially, yes.  I was trying to include only the stuff we were
actively maintaining.  But later I decided to use "S: Odd fixes"
instead of "S: Maintained", so I guess it won't hurt to include
this:

---
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c3b8ecde7..876ac0df99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1396,6 +1396,8 @@ M: Cleber Rosa <crosa@redhat.com>
 S: Odd fixes
 F: scripts/qmp/*
 F: scripts/*.py
+F: tests/*.py
+K: #!.*python
 
 QAPI
 M: Markus Armbruster <armbru@redhat.com>

-- 
Eduardo
