Received: from eggs.gnu.org ([2001:4830:134:3::10]:59606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cWiBH-0003p4-GI
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cWiBE-0002IO-DI
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cWiBE-0002GP-6x
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:25:28 -0500
Date: Thu, 26 Jan 2017 12:25:24 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170126112524.ww27c3f6x26hxcup@eukaryote>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com


On Thu, Jan 26, 2017 at 02:46:52PM +0530, Ashijeet Acharya wrote:
> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead, place a check for
> last_ram_offset() being '0' at the start of ram_save_setup() and
> error out with a meaningful error message.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)

You state the problem in the one-line Git commit summary message, it's
usually preferred to summarize the _fix_ that you're making :-).  If the
below variant sounds any better, maybe the maintainer can reword it upon
applying:

  migrate: Gracefully handle crash of a 'none' machine with no RAM

[...]

-- 
/kashyap
