Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSkot-0001A1-NE
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSkos-0001Z4-RV
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:02:51 -0400
Date: Tue, 12 Jun 2018 17:02:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180612150233.GE4355@localhost.localdomain>
References: <20180612125821.4229-1-armbru@redhat.com>
	<20180612125821.4229-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612125821.4229-4-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/18] block: Add block-specific QDict
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Am 12.06.2018 um 14:58 hat Markus Armbruster geschrieben:
> From: Max Reitz <mreitz@redhat.com>
> 
> There are numerous QDict functions that have been introduced for and are
> used only by the block layer.  Move their declarations into an own
> header file to reflect that.
> 
> While qdict_extract_subqdict() is in fact used outside of the block
> layer (in util/qemu-config.c), it is still a function related very
> closely to how the block layer works with nested QDicts, namely by
> sometimes flattening them.  Therefore, its declaration is put into this
> header as well and util/qemu-config.c includes it with a comment stating
> exactly which function it needs.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Message-Id: <20180509165530.29561-7-mreitz@redhat.com>
> [Copright note tweaked, superfluous includes dropped]

s/Copright/Copyright/

Kevin
