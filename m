Received: from eggs.gnu.org ([2001:4830:134:3::10]:37637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e0VMu-0006ad-CT
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e0VMr-0004Q1-6M
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:20:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e0VMq-0004Ou-U3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AF82883BA
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 16:20:51 +0000 (UTC)
Date: Fri, 6 Oct 2017 17:20:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171006162047.GD2166@work-vm>
References: <20171005190725.18712-1-dgilbert@redhat.com>
	<874lrc92u1.fsf@dusky.pond.sub.org>
	<87d1601cgd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d1601cgd.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> >
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> opt was declared as a separate local inside the last loop,
> >> shadowing the local at the top of the function.
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > I can take this through my tree.
> 
> I'd like to change the headline to "option: Remove shadowing opt decl
> from qemu_opt_print()", if that's alright with you.

Sure.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
