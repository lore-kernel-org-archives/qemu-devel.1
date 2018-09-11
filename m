Received: from eggs.gnu.org ([2001:4830:134:3::10]:38990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze35-0004ql-Cp
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze34-0001Vk-IY
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:29:27 -0400
Date: Tue, 11 Sep 2018 16:29:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911082915.GK19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-11-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> Request callbacks can do pretty much anything, including operations that
> will yield from the coroutine (such as draining the backend). In that
> case, a decreased in_flight would be visible to other code and could
> lead to a drain completing while the callback hasn't actually completed
> yet.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
