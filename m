Received: from eggs.gnu.org ([2001:4830:134:3::10]:40417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1fQHBg-0004M9-PJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1fQHBd-0006VE-NA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:00:08 -0400
Received: from mail.windriver.com ([147.11.1.11]:56136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1fQHBd-0006Md-E0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:00:05 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w55HAMT9010876
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Tue, 5 Jun 2018 10:10:22 -0700 (PDT)
Message-ID: <5B16C3FC.60402@windriver.com>
Date: Tue, 5 Jun 2018 11:10:20 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <AD4B58344A9BCE45A17661C5F05E0D893925DE13@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <AD4B58344A9BCE45A17661C5F05E0D893925DE13@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The side effect of changing Processor Brand string?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/04/2018 10:09 PM, You, Lizhen wrote:
> Hi All,
>
> I'd like to change the Processor Brand
> String(CPUID[0x80000002|0x80000003|0x80000004]) of my guest OSS cpu model to
> a string that won't be standard Intel or AMD related processor brand string.
> Would this change have any side effect on the applications that run on this
> guest?  Seems some application would check the Processor Brand String for
> choosing different code path, for eg Oracle database?

Unless you know exactly what code will be running in the guest, I don't think 
it's possible to answer whether it would impact the code running in the guest.

Chris
