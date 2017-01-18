Received: from eggs.gnu.org ([2001:4830:134:3::10]:46560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTprC-0006Se-2X
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTprB-0007MG-Ck
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:00:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTprB-0007Ld-7H
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:00:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41916148FEE
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:00:53 +0000 (UTC)
Date: Wed, 18 Jan 2017 11:00:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118130049.GB6657@thinpad.lan.raisama.net>
References: <20170117180051.11958-1-ehabkost@redhat.com>
	<50210df4-dcd8-8b2e-daab-d0c53449689a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50210df4-dcd8-8b2e-daab-d0c53449689a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] arch_init: Remove unnecessary
 default_config_files table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Jan 18, 2017 at 10:17:17AM +0100, Paolo Bonzini wrote:
> 
> 
> On 17/01/2017 19:00, Eduardo Habkost wrote:
> > The existing default_config_files table in arch_init.c has a
> > single entry, making it completely unnecessary. The whole code
> > can be replaced by a single qemu_read_config_file() call in vl.c.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> 
> Looks good!  Please include it yourself in your next pull request.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Applied to machine-next. Thanks!

-- 
Eduardo
