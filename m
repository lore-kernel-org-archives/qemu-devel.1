Received: from eggs.gnu.org ([2001:4830:134:3::10]:46578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejVB7-0003sb-8L
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejVB6-0002yU-EF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:14:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejVB6-0002x4-3S
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:14:44 -0500
Date: Wed, 7 Feb 2018 14:14:40 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180207141440.57ae0ee5@redhat.com>
In-Reply-To: <c0464781-02dd-afeb-f7a8-345ccf8fe4f4@redhat.com>
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-3-lcapitulino@redhat.com>
	<c0464781-02dd-afeb-f7a8-345ccf8fe4f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: document query-cpus performance
 issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ehabkost@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

On Wed, 7 Feb 2018 12:50:59 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/07/2018 11:50 AM, Luiz Capitulino wrote:
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >   qapi-schema.json | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 82d6f12b53..0665a14dba 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -526,6 +526,10 @@
> >   #
> >   # Returns a list of information about each virtual CPU.
> >   #
> > +# WARNING: This command incurs a performance penalty for latency
> > +#          sensitive workloads and hence it's not recommended to
> > +#          to be used in production. Use query-cpus-fast instead
> > +#  
> 
> Ah, I asked for this on 1/2.  You could squash these.
> 
> I didn't review the code, just the interface, so if you squash them, you 
> can add the weaker:
> 
> Acked-by: Eric Blake <eblake@redhat.com>

OK, I'll wait for more review and do the changes you requested.
