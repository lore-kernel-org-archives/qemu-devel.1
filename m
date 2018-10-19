Received: from eggs.gnu.org ([2001:4830:134:3::10]:54939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDKzk-0005FM-SU
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDKze-0004EP-OZ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:58:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:41453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDKzb-0003wk-RI
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:58:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id m77-v6so15808403pfi.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 19:58:23 -0700 (PDT)
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-8-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f8fa71c-555c-72d4-70a7-031f9b69e9bc@linaro.org>
Date: Thu, 18 Oct 2018 19:58:18 -0700
MIME-Version: 1.0
In-Reply-To: <20181018143042.29588-8-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 07/16] hw/arm/virt: Implement kvm_type
 function for 3.2 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

On 10/18/18 7:30 AM, Eric Auger wrote:
> +#define SZ_1G (1024ULL * 1024 * 1024)

<qemu/units.h> already defines GiB.


r~
