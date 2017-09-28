Received: from eggs.gnu.org ([2001:4830:134:3::10]:56875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxfpH-00023o-EU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxfpE-0005DG-4o
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxfpD-0005CZ-UA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA62E5AFC7
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 20:54:26 +0000 (UTC)
Date: Thu, 28 Sep 2017 17:54:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928205424.GV4115@localhost.localdomain>
References: <20170927204148.2311-1-ehabkost@redhat.com>
	<20170927204148.2311-2-ehabkost@redhat.com>
	<3e0e7e4a-0e66-ef49-8ee7-02e6ffd424b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0e7e4a-0e66-ef49-8ee7-02e6ffd424b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] config: qemu_config_parse() return
 number of config groups
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

On Wed, Sep 27, 2017 at 03:49:55PM -0500, Eric Blake wrote:
> On 09/27/2017 03:41 PM, Eduardo Habkost wrote:
> > Change qemu_config_parse() to return the number of config groups
> > in success and -EINVAL on error. This will allow callers of
> > qemu_config_parse() to check if something was really loaded from
> > the config file.
> > 
> > All existing callers of qemu_config_parse() and
> > qemu_read_config_file() only check if the return value was
> > negative, so the change shouldn't affect them.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > Changes v2 -> v3:
> > * None (rebase only)
> > 
> > Changes v1 -> v2:
> > * Remove unnecessary translation of qemu_config_parse()
> >   erros to -EINVAL at block/blkdebug.c:read_config()
> >   * Suggsted-by: Markus Armbruster <armbru@redhat.com>
> 
> Do you want the Suggested-by (spelled correctly) in the commit body proper?

This line refers to a one-line change in the patch between v1 and
v2, only.  Doesn't seem appropriate for a Suggested-by line in
the commit message.

-- 
Eduardo
