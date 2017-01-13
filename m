Received: from eggs.gnu.org ([2001:4830:134:3::10]:37546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRwZP-0005nO-Og
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRwZM-0004WK-MF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cRwZM-0004W6-GQ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:46:40 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-5-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1e4ed054-d933-6e73-e1a1-cdf898f05ba8@redhat.com>
Date: Fri, 13 Jan 2017 15:46:31 +0800
MIME-Version: 1.0
In-Reply-To: <1484276800-26814-5-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 04/14] intel_iommu: fix trace for
 inv desc handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> VT-d codes are still using static DEBUG_INTEL_IOMMU macro. That's not
> good, and we should end the day when we need to recompile the code
> before getting useful debugging information for vt-d. Time to switch to
> the trace system.
>
> This is the first patch to do it.
>
> Generally, the rule of mine is:
>
> - for the old GENERAL typed message, I use error_report() directly if
>    apply. Those are something shouldn't happen, and we should print tho=
se
>    errors in all cases, even without enabling debug and tracing.

Looks like some were guest trigger-able. If yes, let's try not use=20
error_report() for not being flooded.

Thanks

>
> - for the non-GENERAL typed messages, remove those VTD_PRINTF()s that
>    looks hardly used, and convert the rest lines into trace_*().
>
> - for useless DPRINTFs, I removed them.
