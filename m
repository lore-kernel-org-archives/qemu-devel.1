Received: from eggs.gnu.org ([2001:4830:134:3::10]:40703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqUA-0006A3-Em
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqU5-00070e-JJ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzqU5-0006zE-DM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 16:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91E5A81DF0
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 20:41:35 +0000 (UTC)
Date: Wed, 4 Oct 2017 17:41:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004204133.GA5259@localhost.localdomain>
References: <20171004025043.3788-1-ehabkost@redhat.com>
	<20171004025043.3788-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004025043.3788-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] config: qemu_config_parse() return
 number of config groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Oct 03, 2017 at 11:50:42PM -0300, Eduardo Habkost wrote:
> Change qemu_config_parse() to return the number of config groups
> in success and -EINVAL on error. This will allow callers of
> qemu_config_parse() to check if something was really loaded from
> the config file.
> 
> All existing callers of qemu_config_parse() and
> qemu_read_config_file() only check if the return value was
> negative, so the change shouldn't affect them.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Paolo, if you are OK with this I'm queueing it (only 1/2 by now)
on machine-next.

-- 
Eduardo
