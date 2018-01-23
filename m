Received: from eggs.gnu.org ([2001:4830:134:3::10]:58037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edxIp-0007aH-JU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edxIm-0000jK-GW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:03:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1edxIm-0000in-9I
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:03:44 -0500
Message-ID: <1516709019.31897.4.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 23 Jan 2018 13:03:39 +0100
In-Reply-To: <20180123112025.GI11419@umbus>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com>
	<20180123112025.GI11419@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, 2018-01-23 at 22:20 +1100, David Gibson wrote:
> > David, I know you're busy with linux.conf.au, but it would be
> > really helpful if you could carve out five minutes to look over
> > Alexey's proposal again, with my reply above in mind, and let us
> > know whether it looks a reasonable design. Doesn't have to be a
> > review, just a quick feedback on the high-level idea.
> 
> It looks ok, I think, but I don't think I'm really the right person to
> ask.  I do wonder if creating a throwaway instance could cause
> trouble, especially for something like machine that might well have
> gotten away with having global side-effects in the past.  I think we
> need to talk with someone who knows more about qom and qapi - Markus
> seems the obvious choice.

Good point. CC'ing Markus to try and grab his attention :)

-- 
Andrea Bolognani / Red Hat / Virtualization
