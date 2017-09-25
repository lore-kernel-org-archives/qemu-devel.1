Received: from eggs.gnu.org ([2001:4830:134:3::10]:44298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcfv-0008MM-6M
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcfu-0002X7-FE
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:20:31 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:53544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcfu-0002Wi-85
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:20:30 -0400
Received: by mail-pg0-x22e.google.com with SMTP id j70so4876549pgc.10
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:20:30 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3771b0cd-4ba5-748f-d1ff-a87c80c3f983@linaro.org>
Date: Mon, 25 Sep 2017 16:20:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/27] s390x/tcg: STOPPED cpus can never
 wake up
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
> Interrupts can't wake such CPUs up. SIGP from other CPUs has to be used
> to toggle the state.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
