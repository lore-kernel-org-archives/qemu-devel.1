Received: from eggs.gnu.org ([2001:4830:134:3::10]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtZV-0003bB-L8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtZU-0000ee-RJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:25:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhtZU-0000dy-NF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54EDF4074478
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 09:25:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180723123305.24792-5-peterx@redhat.com> (Peter Xu's message of
	"Mon, 23 Jul 2018 20:33:05 +0800")
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-5-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 11:25:24 +0200
Message-ID: <87y3e1f0jf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 4/4] tests: torture release-ram in
 postcopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The release-ram capability will run some extra code for postcopy to
> release used ram right away, let's just turn that on for the postcopy
> unix test always to torture that code path too to make sure release-ram
> feature won't break again.  The recovery test needs to turn that off
> since release-ram cannot coop with that.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But I think that the proper thing to do here is to have two tests.  One
for postcopy and another for postcopy + release-ram.
