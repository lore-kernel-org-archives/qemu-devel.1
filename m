Received: from eggs.gnu.org ([2001:4830:134:3::10]:56877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxfpH-000241-MQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxfpG-0005ER-OW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxfpG-0005Dw-Hf
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 819B583F43
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 20:54:29 +0000 (UTC)
Date: Thu, 28 Sep 2017 17:52:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928205248.GU4115@localhost.localdomain>
References: <20170927204148.2311-1-ehabkost@redhat.com>
	<20170927204148.2311-3-ehabkost@redhat.com>
	<d06c7b8f-02aa-3e5f-1c76-0355a016bb09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06c7b8f-02aa-3e5f-1c76-0355a016bb09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vl: Print warning when a default
 config file is loaded
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Wed, Sep 27, 2017 at 03:47:18PM -0500, Eric Blake wrote:
> On 09/27/2017 03:41 PM, Eduardo Habkost wrote:
> > In case there were options set in the default config file, print
> > a warning so users can update their scripts.
> > 
> > If somebody wants to keep the config file as-is, avoid the
> > warning and use a command-line that will work in future QEMU
> > versions, they can use:
> > 
> >  $QEMU -no-user-config -readconfig /etc/qemu/qemu.conf
> > 
> > I was going to add an additional message suggesting it as a
> > solution, but I thought it could make it more confusing. The
> > solution can be documented in the QEMU 2.11 ChangeLog.
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v2 -> v3:
> > * Rebase (no code changes)
> > * Commit message update: suggest -no-user-config
> 
> > +    if (ret > 0) {
> > +        loc_set_none();
> > +        error_report("Warning: Future QEMU versions won't load %s automatically",
> > +                     CONFIG_QEMU_CONFDIR "/qemu.conf");
> 
> Shouldn't we now use warn_report() with no 'Warning:' prefix?

Oops, yes.  I will fix it and send v4.

-- 
Eduardo
