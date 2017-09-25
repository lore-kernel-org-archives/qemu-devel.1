Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd0T-0002uh-1H
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd0P-0002YB-T9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:41:45 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:48057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwd0P-0002Xz-MI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:41:41 -0400
Received: by mail-pf0-x22d.google.com with SMTP id u12so4623859pfl.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:41:41 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa5819bf-a218-eb74-8199-aaf2c134b0dd@linaro.org>
Date: Mon, 25 Sep 2017 16:41:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 14/27] s390x/kvm: factor out storing of
 adtl CPU status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> Called from SIGP code to be factored out, so let's move it. Add a
> FIXME for TCG code in the future.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c   | 29 +++++++++++++++++++++++++++++
>  target/s390x/internal.h |  1 +
>  target/s390x/kvm.c      | 30 +-----------------------------
>  3 files changed, 31 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
