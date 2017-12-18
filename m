Received: from eggs.gnu.org ([2001:4830:134:3::10]:45414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <satheesh@MiWiFi-R3L-srv.gho.boulder.ibm.com>)
	id 1eQzH4-00049H-Ic
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <satheesh@MiWiFi-R3L-srv.gho.boulder.ibm.com>)
	id 1eQzH1-0006PJ-Ah
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:32:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <satheesh@MiWiFi-R3L-srv.gho.boulder.ibm.com>)
	id 1eQzH1-0006Nq-1y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:32:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIF49Ke065640
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:06:23 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exf6qtnjm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:06:22 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted for <qemu-devel@nongnu.org> from
	<satheesh@MiWiFi-R3L-srv.gho.boulder.ibm.com>;
	Mon, 18 Dec 2017 08:06:21 -0700
Date: Mon, 18 Dec 2017 20:35:12 +0530
From: satheesh rajendran <satheesh@MiWiFi-R3L-srv.gho.boulder.ibm.com>
References: <20171218105318.30367-1-danielhb@linux.vnet.ibm.com>
	<20171218105954.GE13493@redhat.com>
	<6932664e-4715-a120-e69b-638a88c9060f@linux.vnet.ibm.com>
	<20171218120144.GF13493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218120144.GF13493@redhat.com>
Message-Id: <20171218150512.GA24630@MiWiFi-R3L-srv>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, armbru@redhat.com

On Mon, Dec 18, 2017 at 12:01:44PM +0000, Daniel P. Berrange wrote:
> On Mon, Dec 18, 2017 at 09:55:55AM -0200, Daniel Henrique Barboza wrote:
> > 
> > 
> > On 12/18/2017 08:59 AM, Daniel P. Berrange wrote:
> > > On Mon, Dec 18, 2017 at 08:53:18AM -0200, Daniel Henrique Barboza wrote:
> > > > qmp_cpu is a nop that was created a while ago in commit 755f196898
> > > > ("qapi: Convert the cpu command") for the sake of compatibility,
> > > > due to the existence of hmp_cpu.
> > > > 
> > > > Today, there is no need or requirement to keep it as is. QMP is
> > > > meant to be as stateless as possible, thus any QMP command that
> > > > needs a specific monitor CPU setup should provide it in its
> > > > arguments, instead of relying in the current QMP monitor state.
> > > > 
> > > > This patch flags qmp_cpu as deprecated in qemu-doc.texi and changes
> > > > qmp_cpu body to show a deprecation message if used.
> > > > 
> > > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > > ---
> > > > Although I've changed the behavior of qmp_cpu to return an error
> > > > instead of doing nothing, no errors were found in the Travis
> > > > build of the patch. Code inspection confirms that qmp_cpu isn't
> > > > being used in QEMU.
> > > > 
> > > > A quick inspection in Libvirt code shows that there is no reference
> > > > to 'qmp_cpu' there either, but to be sure I've CCed Daniel here
> > > > so he can comment/confirm if Libvirt does not care for this change.
> > > > 
> > > >   qemu-doc.texi | 6 ++++++
> > > >   qmp.c         | 2 +-
> > > >   2 files changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > > > index f7317dfc66..2b63f9a325 100644
> > > > --- a/qemu-doc.texi
> > > > +++ b/qemu-doc.texi
> > > > @@ -2516,6 +2516,12 @@ subsystem image.
> > > >   The ``convert -s snapshot_id_or_name'' argument is obsoleted
> > > >   by the ``convert -l snapshot_param'' argument instead.
> > > > +@section System emulator machine protocol commands
> > > > +
> > > > +@subsection qmp_cpu (since 2.12.0)
> > > > +
> > > > +The ``qmp_cpu'' command is deprecated. Do not use this command.
> > > Just saying it is deprecated doesn't add any useful info, rather
> > > explain why it is deprecated & what (if anything) to use instead.
> > > e.g.
> > > 
> > >    The ``qmp_cpu'' command is a functional no-op. There is no reason
> > >    to invoke this command and it will be removed with no replacement.
> > 
> > Thanks, I'll add more info in qemu-doc.texi in the next version.
> > 
> > Also, just checked that I didn't touch qapi-schema.json. This is how
> > it reads about qmp_cpu:
> > 
> > 
> > # This command is a nop that is only provided for the purposes of
> > compatibility.
> > #
> > # Since: 0.14.0
> > #
> > # Notes: Do not use this command.
> > 
> > Should we change it to mention that the command is deprecated, something
> > like:
> > 
> > # Notes: Do not use this command - it is deprecated and will disappear in
> > the future.
> > 
> > 
> > Or just adding the deprecation note in qemu-doc.texi is enough?
> 
> Lets modify the QAPI file too, since you never know what users will read
> first !
+1

Regards,
-Satheesh.
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
