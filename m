Received: from eggs.gnu.org ([208.118.235.92]:52129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXmOo-0006Mx-6R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXmOh-0005m9-7I
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:16:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gXmOg-0005lZ-Np
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:16:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 436B6A08EC
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 12:16:49 +0000 (UTC)
Date: Fri, 14 Dec 2018 13:16:46 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20181214121646.GP14101@paraplu>
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-3-kchamart@redhat.com>
	<2ce67a1c-caaf-cac1-1374-c09da3c4e472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce67a1c-caaf-cac1-1374-c09da3c4e472@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] Update that HMP 'cpu_add' is
 deprecated in 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On Thu, Dec 13, 2018 at 09:03:23PM +0100, Thomas Huth wrote:
> On 2018-12-13 13:42, Kashyap Chamarthy wrote:
> > Also fix the wrong spelling of it: s/cpu-add/cpu_add/
> > 
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> >  qemu-deprecated.texi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 46bec688db..79743ab8bd 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -121,9 +121,9 @@ replaced by the ``target'' output member.
> >  The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
> >  'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
> >  
> > -@subsection cpu-add (since 3.1)
> > +@subsection cpu_add (since 4.0)
> >  
> > -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> > +Use ``device_add'' for hotplugging vCPUs instead of ``cpu_add''.  See
> 
> AFAIK the spelling was right. It's "cpu-add" ... only device_add is
> using the underscore. Welcome to the wonderful world of QEMU
> inconsistencies...

Huh...I thought I checked the HMP spelling; but indeed you're right!
Confusingly enough, the QMP spelling _doesn't_ have underscore:

    [...]
    ETEXI
    
        {
            .name       = "cpu-add",
            .args_type  = "id:i",
            .params     = "id",
            .help       = "add cpu (deprecated, use device_add instead)",
            .cmd        = hmp_cpu_add,
        },
    
    STEXI
    @item cpu-add @var{id}
    @findex cpu-add
    Add CPU with id @var{id}.  This command is deprecated, please
    +use @code{device_add} instead. For details, refer to
    'docs/cpu-hotplug.rst'.
    [...]

Thanks for the eagle eyes, Thomas.

-- 
/kashyap
