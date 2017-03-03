Received: from eggs.gnu.org ([2001:4830:134:3::10]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjn1c-0004J1-4T
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjn1W-0008S3-BB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:13:36 -0500
Date: Fri, 3 Mar 2017 14:13:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170303131325.GA14351@noname.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488491046-2549-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/15] sheepdog: Fix error handling
 sd_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Am 02.03.2017 um 22:43 hat Markus Armbruster geschrieben:
> As a bdrv_create() method, sd_create() must set an error and return
> negative errno on failure.  It prints the error instead of setting it
> when connect_to_sdog() fails.  Fix that.
> 
> While there, return the value of connect_to_sdog() like we do
> elsewhere, instead of -EIO.  No functional change, as
> connect_to_sdog() returns no other error code.
> 
> Many more suspicious uses of error_report() and error_report_err()
> remain in other functions.  Left for another day.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
