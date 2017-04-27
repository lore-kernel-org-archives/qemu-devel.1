Received: from eggs.gnu.org ([2001:4830:134:3::10]:49841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3kvx-0007qc-Fk
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3kvt-0005G3-Jc
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3kvt-0005Fy-E2
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:13 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170427120215.GG2082@work-vm> (David Alan Gilbert's message of
	"Thu, 27 Apr 2017 13:02:16 +0100")
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170427120215.GG2082@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 27 Apr 2017 17:02:06 +0200
Message-ID: <87fugtki6p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/41] Migration cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>
> High level question:
>   A lot of this is splitting migration.h which is a GPLv2 licensed file, and you're
> carefully copying the authorship (Anthony) to each new header file and
> also the license.
> Can we fix the license while we're at it?
> The migration.c has the clause saying contributions after 2012-01-13
> are GPL2 or later
> but we don't seem to have it in the header.
>
> I suggest for any case where you split it out to a new header and all
> the contributions
> in that header are from one easily contactable person, that you ask.

/*
 * QEMU live migration
 *
 * Copyright IBM, Corp. 2008
 *
 * Authors:
 *  Anthony Liguori   <aliguori@us.ibm.com>
 *
 * This work is licensed under the terms of the GNU GPL, version 2.  See
 * the COPYING file in the top-level directory.
 *
 */

This is what is on migration.h, where I have basically copied all of the
stuff that is splitted.  I tried not to enter in Copyrigth wars, so I
left everything as it was.

Only place where I put a new Copyright was on vmstate.c, didn't have
any, and I am the initial author O:-)

Later, Juan.
