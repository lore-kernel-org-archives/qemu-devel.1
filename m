Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxRP-0005m1-73
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxRM-000486-1G
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:34:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cuxRL-00046q-N6
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:34:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v338Xnjd137403
	for <qemu-devel@nongnu.org>; Mon, 3 Apr 2017 04:34:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29jvy03dun-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:34:16 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 3 Apr 2017 09:34:14 +0100
Date: Mon, 3 Apr 2017 10:34:09 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CA+KKJYAhsuTodm3s2rK65hR=-Xi5+Z7Q+M2nJYZQf2wa44HfOg@mail.gmail.com>
References: <CA+KKJYAhsuTodm3s2rK65hR=-Xi5+Z7Q+M2nJYZQf2wa44HfOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170403103409.5930a8f3.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 10/43] s390x: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net

On Sat, 1 Apr 2017 16:45:53 +0300
Danil Antonov <g.danil.anto@gmail.com> wrote:

> From ea9cd8f02bd98548435f561e62f4f9b672318bcb Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 12:26:05 +0300
> Subject: [PATCH 10/43] s390x: made printf always compile in debug output

s/made/make/

(Not sure where the headers above came from; might be gmail.)

> 
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
> 
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> ---
>  target/s390x/kvm.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Seems reasonable; although we should convert to tracepoints later.

Queued for 2.10 (with the commit message slightly tweaked).
