Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjpg-0002hM-1o
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjpc-0002Vp-TA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjpc-0002VZ-MU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:17:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495642203-12702-5-git-send-email-felipe@nutanix.com> (Felipe
	Franciosi's message of "Wed, 24 May 2017 17:10:03 +0100")
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-5-git-send-email-felipe@nutanix.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 18:17:09 +0200
Message-ID: <874lw2e2uy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: use dirty_rate_high_cnt
 more aggressively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Felipe Franciosi <felipe@nutanix.com> wrote:
> The commit message from 070afca25 suggests that dirty_rate_high_cnt
> should be used more aggressively to start throttling after two
> iterations instead of four. The code, however, only changes the auto
> convergence behaviour to throttle after three iterations. This makes the
> behaviour more aggressive by kicking off throttling after two iterations
> as originally intended.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

First, Felipe is doing performance testing with the changes.
Second, if you want autoconverge slower, you can use smaller increments.
So, I think that this is ok.

It is more, if you want you can send numbers of your workloads with
current parameter and removing it altogether to convince me that it is a
good idea just to drop it.

Thanks, Juan.
