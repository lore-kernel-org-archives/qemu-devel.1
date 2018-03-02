Received: from eggs.gnu.org ([2001:4830:134:3::10]:40994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erqsl-0007IG-LM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erqsh-0004Jf-IW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:02:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1erqsh-0004J8-Ce
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:02:15 -0500
Date: Fri, 2 Mar 2018 20:02:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180302200202.GF3154@work-vm>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520004397-28521-1-git-send-email-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

* minyard@acm.org (minyard@acm.org) wrote:
> I apologize for the resend, I left the list off the previous post.
> 
> This is unchanged since the previous post, two weeks ago.  I received
> no comments, so I guess it's ok.  It's fairly broken now, so I would
> like this fixed.

Sorry, I'll look at it on Monday; I was out last week and hadn't got
around to this set.

Dave

> Changes from v1:
>   * Validate the data values in pre_load functions.
>   * For KCS, instead of an old function, create a separate vmstate
>     structure for the new version.  The name on the old vmstate
>     structure wasn't specific enough, so a new name was needed,
>     The old structure is set up to never be sent, but it can be
>     received.
> 
> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
> 
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
> 
> are available in the git repository at:
> 
>   https://github.com/cminyard/qemu.git tags/ipmi-vmstate-fixes
> 
> for you to fetch changes up to 90797371d9a3138657e7b1f7ab4425eb67d6fd0a:
> 
>   ipmi: Use proper struct reference for BT vmstate (2018-03-02 07:48:39 -0600)
> 
> ----------------------------------------------------------------
> Fix the IPMI vmstate code to work correctly in all cases.  Heavily
> tested under load.
> 
> ----------------------------------------------------------------
> Corey Minyard (2):
>       ipmi: Use proper struct reference for KCS vmstate
>       ipmi: Use proper struct reference for BT vmstate
> 
>  hw/ipmi/isa_ipmi_bt.c  | 61 ++++++++++++++++++++++++++++++---------
>  hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 123 insertions(+), 15 deletions(-)
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
