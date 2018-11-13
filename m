Received: from eggs.gnu.org ([2001:4830:134:3::10]:43499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMVl0-0003u1-Ob
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMVkx-0003MT-DG
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:17:18 -0500
Date: Tue, 13 Nov 2018 11:17:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181113101704.GB4830@localhost.localdomain>
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: keith.busch@intel.com, mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Am 13.11.2018 um 02:45 hat Li Qiang geschrieben:
> Ping.... what't the status of this patch.
> 
> I see Kevin's new pr doesn't contain this patch.

Oh, I thought you said that you wanted to fix this at a higher level so
that the problem is caught before even getting into nvme code? If you
don't, I can apply the patch for my next pull request.

Kevin
