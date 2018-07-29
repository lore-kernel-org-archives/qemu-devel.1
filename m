Received: from eggs.gnu.org ([2001:4830:134:3::10]:56110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fjc43-0007h0-RP
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 23:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1fjc3z-0007YP-SM
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 23:08:11 -0400
Received: from muon.bluestop.org ([96.73.9.1]:23831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rebecca@bluestop.org>)
	id 1fjc3z-0007YB-Kf
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 23:08:07 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
From: Rebecca Cran <rebecca@bluestop.org>
Message-ID: <a550a2c5-4024-0a4d-d7e5-644e4218af84@bluestop.org>
Date: Sat, 28 Jul 2018 21:08:05 -0600
MIME-Version: 1.0
In-Reply-To: <d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 7/25/18 1:32 AM, Thomas Huth wrote:
>
> When was it still working for you the last time? Was it still working
> with v3.0-rc1 ? Or just with v2.12 ? Any chance that you could bisect
> the problem to determine when it has been introduced?


I'm not sure if it's FreeBSD that might have changed to cause things to
break as well, since I _am_ running 12.0-CURRENT (i.e. HEAD).

However, I did some bisection and v2.12.0-rc0 and newer is broken, while
v2.11.0 works.


-- 

Rebecca
