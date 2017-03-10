Received: from eggs.gnu.org ([2001:4830:134:3::10]:45437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmOsB-0003sv-6m
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmOs8-00072L-2J
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmOs7-00071z-TB
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:02:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB04E85547
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 18:02:34 +0000 (UTC)
Date: Fri, 10 Mar 2017 15:02:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170310180231.GI11509@thinpad.lan.raisama.net>
References: <20170309182049.30040-1-ehabkost@redhat.com>
	<2ccd013f-ade7-58e5-aef5-a8aa94659d09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccd013f-ade7-58e5-aef5-a8aa94659d09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 0/2] vl: Print warning if a
 non-empty default config-file is found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, Mar 10, 2017 at 10:18:26AM +0100, Paolo Bonzini wrote:
> 
> 
> On 09/03/2017 19:20, Eduardo Habkost wrote:
> > (This missed hard freeze, but I would still like to include the
> > warning in 2.9 so we can remove the default config file in 2.10.
> > I will include this series in a pull request only if at least 2
> > other maintainers send their Acked-by.)
> > 
> > We plan to remove support for /etc/qemu/qemu.conf in the near
> > future. Make QEMU print a warning in case there a non-empty
> > /etc/qemu/qemu.conf is loaded, so users have time to adapt.
> 
> Thanks, it's certainly good to have this in 2.9.

Thanks. Do you want to queue it?

-- 
Eduardo
