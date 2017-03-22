Received: from eggs.gnu.org ([2001:4830:134:3::10]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqieG-0000Xd-8H
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqieD-00057m-NF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqieD-00057O-HT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C24A61E4A
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 15:58:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170322144525.18964-1-eblake@redhat.com>
Date: Wed, 22 Mar 2017 16:58:01 +0100
In-Reply-To: <20170322144525.18964-1-eblake@redhat.com> (Eric Blake's message
	of "Wed, 22 Mar 2017 09:45:22 -0500")
Message-ID: <87zigdfgmu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Fix QemuOpts regression on bogus
 keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com

Eric Blake <eblake@redhat.com> writes:

> Reported to me off-list by Laurent Vivier, who found the
> problem while working on https://bugzilla.redhat.com/1433193;
> now split into https://bugzilla.redhat.com/show_bug.cgi?id=1434666.
> Broken since 2.7, but the fix is a one-liner (pointing out my
> embarrassing mistake of mis-converting a pre-decrement operator);
> as a bug fix, it still qualifies for 2.9 in spite of hard freeze,
> on the other hand, as the regression was not introduced in 2.9,
> I also understand if it is postponed.
>
> v1 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04072.html
> v2 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04275.html
>
> Since then:
> - more commit message tweaks
> - drop a spurious hunk from the test in commit 3

Reviewed-by: Markus Armbruster <armbru@redhat.com>
