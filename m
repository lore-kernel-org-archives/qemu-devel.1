Received: from eggs.gnu.org ([2001:4830:134:3::10]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ciiht-0001Ss-Sv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ciiht-0002Tn-3N
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:24:49 -0500
Date: Tue, 28 Feb 2017 22:24:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170228142440.GA2344@lemon.lan>
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/44] New op blocker system, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Tue, 02/28 13:53, Kevin Wolf wrote:
> This series is the first part of implementing the new op blocker system
> whose design was agreed on quite a while ago, but proved a bit tricky to
> implement in places. There is more work to do to fully replace the old op
> blocker system, but realistically we don't have that much time until the 2.9
> freeze. So let's merge this series to complement the traditional op blockers
> and plan with a second part for the 2.10 timeframe.

If we don't merge this, what should we do during the lengthy winter^Wfreeze? ;-)

Seriously, the series looks pretty good to me. I didn't leave my rev-by patch by
patch when reviewing previous versions, because I focused on my overall
happiness on the API (frankly, I was a bit skeptical about the apparent
complexity of this at the first sight). Now that I think I am happy, and also as
I don't have time for a blanket review on the whole series today that upholds a
full rev-by, I'm going to give:

Acked-by: Fam Zheng <famz@redhat.com>
