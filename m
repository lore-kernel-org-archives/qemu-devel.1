Received: from eggs.gnu.org ([209.51.188.92]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1gwhSK-0004oJ-74
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1gwhSJ-00047N-9J
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:03:36 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1gwhSI-00044g-Sv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:03:35 -0500
Received: by mail-pg1-x542.google.com with SMTP id i130so13250507pgd.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 22:03:25 -0800 (PST)
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <d88127af-dbc8-fce0-f128-b23f1f6ea0ce@gmail.com>
Date: Thu, 21 Feb 2019 14:03:19 +0800
MIME-Version: 1.0
In-Reply-To: <20190220005124.24224-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, philmd@redhat.com



On 2/20/19 8:51 AM, Wei Yang wrote:
> Three trivial cleanup for pc-dimm.
> 
> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
> hotpluggable.
> Patch [2] remove nvdimm_realize
> Patch [2] remove pcdimm realize-callback
> 
> v2:
>    * fix warning in Patch 1
>    * split Patch 2 into two
> 
> Wei Yang (3):
>    pc-dimm: remove check on pc-dimm hotpluggable
>    mem/nvdimm: remove nvdimm_realize

>    pc-dimm: revert "introduce realize callback"

I think the word 'revert' is not so precise as that hints
the commit is bugly, instead, it was factored in the later
comments then becomes useless now.

Anyway, this pathset looks good to me.

Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>
