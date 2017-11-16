Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFHFA-0003pI-N5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eFHF6-0005ST-KF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:18:00 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:24269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eFHF6-0005PU-CA
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:17:56 -0500
Date: Thu, 16 Nov 2017 10:13:48 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171116101348.vmwthadfeu3mzuke@starbug-vm.ie.oracle.com>
References: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

On Thu, Nov 16, 2017 at 10:28:32AM +0800, Mao Zhongyi wrote:
>Cc: Peter Maydell <peter.maydell@linaro.org>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Zhang Chen <zhangckid@gmail.com>
>Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
>Reported-by: Peter Maydell <peter.maydell@linaro.org>
>Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Code-wise, this looks like a valid fix to the existing code.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

But testing wise, have you confirmed that things are behaving as you
expected with the previous patch, since previously when calling
colo_compare_connection(), the value of conn would have always been
its initialized value of NULL.

Just want to be sure that fixing this doesn't end up breaking your
expected behaviour given that all your testing before would have had
a NULL value in conn.

Thanks,

Darren.

>---
> net/colo-compare.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/colo-compare.c b/net/colo-compare.c
>index ccdcba2..1ce195f 100644
>--- a/net/colo-compare.c
>+++ b/net/colo-compare.c
>@@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>                          "drop packet");
>         }
>     }
>-    con = &conn;
>+    *con = conn;
>
>     return 0;
> }
>-- 
>2.9.4
>
>
>
>
