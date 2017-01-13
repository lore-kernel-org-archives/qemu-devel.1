Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRxse-0001ND-R7
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRxsa-0007w2-N4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:10:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:27900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guangrong.xiao@linux.intel.com>)
	id 1cRxsa-0007f8-DP
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:10:36 -0500
References: <5878435d.54b31c0a.39a7b.4e93@mx.google.com>
From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Message-ID: <011014c2-1129-cd48-f13d-66d7951d3e3c@linux.intel.com>
Date: Fri, 13 Jan 2017 17:00:31 +0800
MIME-Version: 1.0
In-Reply-To: <5878435d.54b31c0a.39a7b.4e93@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvdimm: allow read/write zero-size
 namespace label
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>



On 01/13/2017 11:02 AM, Li Qiang wrote:
> From: Li Qiang <liqiang6-s@360.cn>
>
> The spec doesn't say the namespace label can't be zero
> when read/write it. As this is no harmful, just allow
> it.
>

WHY?

The spec said that the label should be at least 128K.
