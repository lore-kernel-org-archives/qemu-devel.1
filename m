Received: from eggs.gnu.org ([2001:4830:134:3::10]:46317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g6xVG-0008BG-ML
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g6xVC-0006A7-Hp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1g6xVC-00069J-BT
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CBE73082131
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 12:40:41 +0000 (UTC)
Date: Mon, 1 Oct 2018 14:40:39 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20181001124039.GF25720@paraplu>
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-2-kchamart@redhat.com>
	<07ccc2c0-10e2-3456-3124-5aa2d87158f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ccc2c0-10e2-3456-3124-5aa2d87158f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, armbru@redhat.com, ehabkost@redhat.com

On Mon, Oct 01, 2018 at 11:28:17AM +0200, Thomas Huth wrote:
> On 2018-09-25 18:02, Kashyap Chamarthy wrote:

[...]

> > +++ b/qapi/misc.json
> > @@ -1104,7 +1104,11 @@
> >  ##
> >  # @cpu-add:
> >  #
> > -# Adds CPU with specified ID
> > +# Adds CPU with specified ID.
> > +#
> > +# Notes: This command is deprecated.  The `device_add` command should be
> 
> s/Notes/Note/ ?

Yeah, first I wrote the singular.  But went with plural as I saw it as
it was the 'majority' pattern:

    $> git grep "Note:" qapi/misc.json | wc -l
    13
    $> git grep "Notes:" qapi/misc.json | wc -l
    18

Maybe people use the plural, "Notes", as they can add multiple entries.

[...]

> Do you plan to keep the "cpu-add" HMP command? hmp_cpu_add() currently
> is only a wrapper for qmp_cpu_add(), so if you plan to get rid of the
> QMP command, it might make sense to deprecate the HMP command in the
> same breath, too.

Yeah, I did think about deprecating the HMP variant; and even brought it
up with Dave Gilbert the other day.  He pointed out an example commit of
yours (559964a1) on how to mark an HMP command as deprecated. :-)

Thanks for the reminder.  Will add it as a TODO for the next revision.

-- 
/kashyap
