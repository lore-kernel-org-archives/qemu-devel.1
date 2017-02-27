Received: from eggs.gnu.org ([2001:4830:134:3::10]:39738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciNvR-0006EA-Fk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciNvO-0000JK-9F
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:13:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciNvO-0000Iz-3E
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:13:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43016C04BD37
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:13:22 +0000 (UTC)
Date: Mon, 27 Feb 2017 13:13:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170227161319.GA11509@thinpad.lan.raisama.net>
References: <20170118135624.17368-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118135624.17368-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] vl: Print warning if a non-empty
 default config-file is found
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

Ping?

I would like to include the warning on QEMU 2.9 (and I assume it
qualifies as post-soft-freeze material).

I am not sure I should go with a simpler solution and print the
warning even if the config file was empty. Opinions?


On Wed, Jan 18, 2017 at 11:56:22AM -0200, Eduardo Habkost wrote:
> We plan to remove support for /etc/qemu/qemu.conf in the near
> future. Make QEMU print a warning in case there a non-empty
> /etc/qemu/qemu.conf is loaded, so users have time to adapt.
> 
> This series is based on my machine-next branch, at:
>   https://github.com/ehabkost/qemu.git machine-next
> 
> Eduardo Habkost (2):
>   config: qemu_config_parse() return number of config groups
>   vl: Print warning when a default config file is loaded
> 
>  util/qemu-config.c | 15 +++++++--------
>  vl.c               |  6 ++++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> -- 
> 2.11.0.259.g40922b1
> 
> 

-- 
Eduardo
