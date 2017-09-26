Received: from eggs.gnu.org ([2001:4830:134:3::10]:48745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq1W-0005Kb-MN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq1T-0006rS-Hi
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwq1T-0006rA-B1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:35:39 -0400
Date: Tue, 26 Sep 2017 15:35:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926153531.12728883.cohuck@redhat.com>
In-Reply-To: <20170925112917.21340-5-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] migration: wire vmstate_save_state
 errors up to vmstate_subsection_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, rth@twiddle.net

On Mon, 25 Sep 2017 12:29:15 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Route the errors from vmstate_subsection_save up through
> vmstate_subsection_save (and back down, all rather recursive).
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/vmstate.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

With the patch description fixed up:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
