Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjnE-0000ou-Lr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjnB-0001xr-Gr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjnB-0001xk-AY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:45 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495642203-12702-3-git-send-email-felipe@nutanix.com> (Felipe
	Franciosi's message of "Wed, 24 May 2017 17:10:01 +0100")
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-3-git-send-email-felipe@nutanix.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 18:14:41 +0200
Message-ID: <87d1aqe2z2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: set dirty_pages_rate before
 autoconverge logic
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
> Currently, a "period" in the RAM migration logic is at least a second
> long and accounts for what happened since the last period (or the
> beginning of the migration). The dirty_pages_rate counter is calculated
> at the end this logic.
>
> If the auto convergence capability is enabled from the start of the
> migration, it won't be able to use this counter the first time around.
> This calculates dirty_pages_rate as soon as a period is deemed over,
> which allows for it to be used immediately.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
