Received: from eggs.gnu.org ([2001:4830:134:3::10]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzns-0000j2-MI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZznp-00021Y-Ct
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:55:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZznp-00020S-1i
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:55:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E43C1D5525
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:55:23 +0000 (UTC)
Date: Fri, 12 Jan 2018 14:55:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112135509.uvtx6yzhs4pacno3@sirius.home.kraxel.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-38-marcandre.lureau@redhat.com>
	<20180112130416.rsdydqy4popkugrm@sirius.home.kraxel.org>
	<1027552109.5988061.1515763378153.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027552109.5988061.1515763378153.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 37/51] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  Hi,

> > Move to ui/vnc.c, so we don't need #ifdef here?
> 
> Not so simple either. hmp-commands-info.h (needed for the function
> declaration) is built per target, but not ui/vnc.c.

Ok, thanks for checking.

> Again, some future cleanup?

Fine with me.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
