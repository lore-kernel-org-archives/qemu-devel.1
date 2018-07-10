Received: from eggs.gnu.org ([2001:4830:134:3::10]:46336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcqaq-0007XB-Qf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcqap-0001rG-T5
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:14:04 -0400
Date: Tue, 10 Jul 2018 13:13:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710111349.GC5852@localhost.localdomain>
References: <20180709163719.87107-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163719.87107-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

Am 09.07.2018 um 18:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all.
> 
> This fixes image fleecing scheme for 3.0, details are in 04 patch.
> 01 is a significant fix too.
> 
> v5: - keep one _internal recursive function like in original code [Fam]
>     - grammar and rewording [Eric] (a bit changed,
>                                     be free to fix/reword in flight)
> 
> PS: 222 now fails for me, no matter with or without these series...

Thanks, applied to the block branch.

Kevin
