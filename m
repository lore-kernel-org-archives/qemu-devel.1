Received: from eggs.gnu.org ([2001:4830:134:3::10]:47327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faC7G-0001FN-L5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faC7D-0004go-HW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:36:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faC7D-0004ga-CN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8443C4072CE6
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 03:36:30 +0000 (UTC)
Date: Tue, 3 Jul 2018 11:36:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180703033625.GP2455@xz-mi>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702162218.13678-8-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/32] qmp: Make "id" optional again even
 in "oob" monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On Mon, Jul 02, 2018 at 06:21:53PM +0200, Markus Armbruster wrote:
> Commit cf869d53172 "qmp: support out-of-band (oob) execution" made
> "id" mandatory for all commands when the client accepted capability
> "oob".  This is rather onerous when you play with QMP by hand, and
> unnecessarily so: only out-of-band commands need an ID for reliable
> matching of response to command.
> 
> Revert that part of commit cf869d53172 for now.  We may still make
> "id" mandatory for out-of-band commands.

This change should be okay with current implementation when
out-of-band commands are still in order themselves, though I'm still
not that confident on whether we really want this change if only for
the sake of easier usage for human beings.

If we see Libvirt, the real player for QMP - it has the "id" field
even for in-band commands always.  I'd say the "id" field is really
helpful for machines, though not that friendly to us.

Basically I'll read it as: machines like "id"s, humans hate "id"s.
And QMP is Qemu Machine Protocol after all... so not sure whether
it'll be good we change that for us humans.

Regards,

-- 
Peter Xu
