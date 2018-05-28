Received: from eggs.gnu.org ([2001:4830:134:3::10]:34184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNEe4-0008AG-Gk
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNEe0-0003Ji-GY
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:40:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fNEe0-0003JE-Bd
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:40:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92E104022909
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 09:40:47 +0000 (UTC)
Date: Mon, 28 May 2018 11:40:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180528114045.7a0e339d@redhat.com>
In-Reply-To: <87tvqx12no.fsf@dusky.pond.sub.org>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<20180516190242.GL4903@localhost.localdomain>
	<87tvqx12no.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/11] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org

On Thu, 24 May 2018 17:42:03 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > I'm queueing this version (including v8 of patches 5-7) on
> > numa-next.
> >
> > Markus, Daniel: you were the people I remember expressing some
> > concerns about the new preconfig mechanism.  Do you have any
> > objections to this version?  
> 
> My gut's reaction to preconfig is as nauseous as ever.  It adds
> complexity we wouldn't want or need with sanely structured program
> startup.  It might still be the best we can do, and something we need to
> do.  You have to take on technical debt sometimes.  To know for sure
> this is the case here, we'd have to explore alternatives more seriously.
> Like repaying some of the existing technical debt around there.  Sadly,
> I lack the time to take on such a project.
Usually I do quite a bit of re-factoring to reduce our technical debt,
so while working on enabling VM start with libvirt using only --preconfig
(without -S) I most likely will have to improve code around VM creation.

[...]
