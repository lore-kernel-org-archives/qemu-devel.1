Received: from eggs.gnu.org ([2001:4830:134:3::10]:58619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjnY-00013h-0M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjnU-00021Z-Rp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjnU-00021T-M6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:15:04 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495642203-12702-4-git-send-email-felipe@nutanix.com> (Felipe
	Franciosi's message of "Wed, 24 May 2017 17:10:02 +0100")
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-4-git-send-email-felipe@nutanix.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 18:14:58 +0200
Message-ID: <878tlee2yl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: set bytes_xfer_* outside of
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
> The bytes_xfer_now/prev counters are only used by the auto convergence
> logic. However, they are used alongside the dirty_pages_rate counter,
> which is calculated (and required) outside of this logic. The problem
> with this approach is that if the auto convergence capability is changed
> while a migration is ongoing, the relationship of the counters will be
> broken.
>
> This moves the management of bytes_xfer_now/prev counters outside of the
> auto convergence logic to address this issue.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
