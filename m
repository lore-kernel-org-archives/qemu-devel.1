Received: from eggs.gnu.org ([2001:4830:134:3::10]:48342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWlJX-00051j-LI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWlJU-0000V5-Vd
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWlJU-0000S5-PN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:55:16 -0500
Date: Tue, 11 Dec 2018 14:55:10 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181211165510.GF7141@habkost.net>
References: <20181207221417.5152-1-wainersm@redhat.com>
	<20181210164657.GB4669@habkost.net>
	<5cd0b649-c74f-877d-4b5d-a0943a04c7eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd0b649-c74f-877d-4b5d-a0943a04c7eb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, ccarrara@redhat.com, crosa@redhat.com

On Tue, Dec 11, 2018 at 02:40:33PM -0200, Wainer dos Santos Moschetta wrote:
[...]
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index f81d35e1f9..2502a3adda 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -3615,19 +3615,29 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
> > >       x86_cpu_filter_features(xc);
> > > +    /* Uses an auxiliar dictionary to ensure the list of features has not
> > > +       repeated name. */
> > > +    QDict *unique_feats_dict = qdict_new();
> > Multiline comments are formatted this way:
> > 
> >   /*
> >    * like
> >    * this
> >    */
> > 
> > (See CODING_STYLE for details)
> 
> scripts/checkpatch.pl did not catch it. Should it?

It should, we just need a volunteer who understands Perl to fix
that.  :)

-- 
Eduardo
