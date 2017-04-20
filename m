Received: from eggs.gnu.org ([2001:4830:134:3::10]:41209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10GM-0002mL-6w
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10GL-0001bi-CA
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:47:58 -0400
Date: Thu, 20 Apr 2017 08:47:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420004745.GB25568@lemon.lan>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-4-git-send-email-ashijeetacharya@gmail.com>
	<20170419125614.GC9638@lemon.lan>
	<CAC2QTZZgrHPWP1epZpWoWKfjbWGA+uZuqdp-g7KV3-mY2N4kPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZZgrHPWP1epZpWoWKfjbWGA+uZuqdp-g7KV3-mY2N4kPg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vmdk: New functions to assist
 allocating multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@gmail.com

On Wed, 04/19 15:13, Ashijeet Acharya wrote:
> > In the second iteration, remaining is always 0 because of "remaining -=
> > n_bytes". What's the point of the while loop?
> 
> 
> I need the while loop in case if I truncate the bytes according to the L2
> table margins....[scroll up to handle alloc() __^ ]

Yes, I see it now.

Fam
