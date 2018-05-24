Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLsNV-0005t3-8y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLsNR-0001Ox-Du
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:42:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLsNR-0001Ob-AE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:42:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 992E87C6A9
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:42:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<20180516190242.GL4903@localhost.localdomain>
Date: Thu, 24 May 2018 17:42:03 +0200
In-Reply-To: <20180516190242.GL4903@localhost.localdomain> (Eduardo Habkost's
	message of "Wed, 16 May 2018 16:02:42 -0300")
Message-ID: <87tvqx12no.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> I'm queueing this version (including v8 of patches 5-7) on
> numa-next.
>
> Markus, Daniel: you were the people I remember expressing some
> concerns about the new preconfig mechanism.  Do you have any
> objections to this version?

My gut's reaction to preconfig is as nauseous as ever.  It adds
complexity we wouldn't want or need with sanely structured program
startup.  It might still be the best we can do, and something we need to
do.  You have to take on technical debt sometimes.  To know for sure
this is the case here, we'd have to explore alternatives more seriously.
Like repaying some of the existing technical debt around there.  Sadly,
I lack the time to take on such a project.

Since I lack the money to put where my mouth is, I'm going to shut up
and get out of your way.
