Received: from eggs.gnu.org ([2001:4830:134:3::10]:43676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcdr-00076p-5D
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcdn-0001XO-04
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:18:23 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:49027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcdm-0001X8-Pt
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:18:18 -0400
Received: by mail-pg0-x235.google.com with SMTP id v23so4880190pgc.5
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:18:18 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bcbe99e8-6b1a-6c50-794a-ab2601a9deda@linaro.org>
Date: Mon, 25 Sep 2017 16:18:14 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/27] s390/tcg: turn INTERRUPT_EXT into
 a mask
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
> +    } else if (env->pending_int | INTERRUPT_EXT_FLOATING) {

Surely & here.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
