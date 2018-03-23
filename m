Received: from eggs.gnu.org ([2001:4830:134:3::10]:52972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTwb-0008C4-Ir
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTwW-0002WX-Kw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezTwW-0002W6-Em
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:09:44 -0400
Date: Fri, 23 Mar 2018 18:09:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323210941.GE28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-3-git-send-email-imammedo@redhat.com>
	<20180323204218.GC28161@localhost.localdomain>
	<ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/9] numa: split out NumaOptions parsing
 into parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, Mar 23, 2018 at 03:49:38PM -0500, Eric Blake wrote:
> On 03/23/2018 03:42 PM, Eduardo Habkost wrote:
> > On Mon, Mar 12, 2018 at 02:11:08PM +0100, Igor Mammedov wrote:
> > > it will allow to reuse parse_NumaOptions() for parsing
> > > configuration commands received via QMP interface
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> 
> > >   end:
> > > +    if (err) {
> > > +        error_propagate(errp, err);
> > > +    }
> > 
> > "if (err)" is not necessary here.  See
> > scripts/coccinelle/error_propagate_null.cocci.
> > 
> 
> > > +    parse_NumaOptions(ms, object, &err);
> > > +
> > > +end:
> > >       qapi_free_NumaOptions(object);
> > >       if (err) {
> > >           error_report_err(err);
> > 
> > We can fix this one too while at it.
> 
> Hmm - this is the same script mentioned here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06293.html
> 
> Except that patch didn't pick up this file.  Why is Coccinelle not seeing
> this?

I don't know.  I've seen Coccinelle being confused by some of our
preprocessor magic before, and in those cases it simply skipped
some files.

-- 
Eduardo
