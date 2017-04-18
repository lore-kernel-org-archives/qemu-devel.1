Received: from eggs.gnu.org ([2001:4830:134:3::10]:49969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Q6t-0002h9-1J
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Q6o-0003iE-4I
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Q6n-0003i2-Uj
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:11:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F25B27D0C4
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 10:11:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <9c1de8f4-f30a-e189-0da0-40768fb0e5a3@redhat.com> (Paolo
	Bonzini's message of "Tue, 18 Apr 2017 11:44:21 +0200")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-19-quintela@redhat.com>
	<9c1de8f4-f30a-e189-0da0-40768fb0e5a3@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 12:11:38 +0200
Message-ID: <87lgqyhvol.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/19] monitor: move hmp_savevm() to
 monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/04/2017 22:00, Juan Quintela wrote:
>> hmp_loadvm is already there, so be consistent.
>
> Can you move both to hmp.c instead?

Discussed on irc with David.  On my tree is already on hmp.c.

Thanks, Juan.
