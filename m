Received: from eggs.gnu.org ([209.51.188.92]:37032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwhcR-0007ev-2V
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwhcQ-0000B6-EH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:14:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gwhcQ-00007g-4W
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 01:14:02 -0500
Date: Thu, 21 Feb 2019 14:13:33 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190221061333.GA20921@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<d88127af-dbc8-fce0-f128-b23f1f6ea0ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88127af-dbc8-fce0-f128-b23f1f6ea0ce@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com, philmd@redhat.com

On Thu, Feb 21, 2019 at 02:03:19PM +0800, Xiao Guangrong wrote:
>
>
>On 2/20/19 8:51 AM, Wei Yang wrote:
>> Three trivial cleanup for pc-dimm.
>> 
>> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
>> hotpluggable.
>> Patch [2] remove nvdimm_realize
>> Patch [2] remove pcdimm realize-callback
>> 
>> v2:
>>    * fix warning in Patch 1
>>    * split Patch 2 into two
>> 
>> Wei Yang (3):
>>    pc-dimm: remove check on pc-dimm hotpluggable
>>    mem/nvdimm: remove nvdimm_realize
>
>>    pc-dimm: revert "introduce realize callback"
>
>I think the word 'revert' is not so precise as that hints
>the commit is bugly, instead, it was factored in the later
>comments then becomes useless now.
>

You are right. It is always difficult for me to pick up the proper word.

>Anyway, this pathset looks good to me.
>
>Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Thanks, Xiao.

-- 
Wei Yang
Help you, Help me
