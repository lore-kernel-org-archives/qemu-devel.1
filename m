Received: from eggs.gnu.org ([2001:4830:134:3::10]:56632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckx1W-0002JT-Cd
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckx1T-0002AI-7M
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckx1T-00029o-2U
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:06:15 -0500
Date: Mon, 6 Mar 2017 23:36:07 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
Message-ID: <alpine.LFD.2.20.1703062325370.6862@wniryva>
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-3-ppandit@redhat.com>
	<988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory
 for execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>

+-- On Mon, 6 Mar 2017, Eric Blake wrote --+
| On 03/06/2017 01:17 AM, P J P wrote:
| > Arguments passed to execve(2) call from user program could
| > be large, allocating stack memory for them via alloca(3) call
| > would lead to bad behaviour. Use 'g_malloc0' to allocate memory
| > for such arguments.
| > 
| > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| > ---
| >  linux-user/syscall.c | 7 +++++--
| >  1 file changed, 5 insertions(+), 2 deletions(-)
| 
| Is this patch alone (without 1/2) sufficient to solve the problem?  If
| so, then drop 1/2.

  Yes, it seems to fix the issue. Still I think having ARG_MAX limit would be 
good, as system exec(3) routines too impose _SC_ARG_MAX limit. I'll send a 
revised patch with 'g_try_new' call instead of g_malloc0.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
