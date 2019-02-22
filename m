Received: from eggs.gnu.org ([209.51.188.92]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gx62Z-0000OJ-CQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gx62T-0003Hb-B3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:18:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:51240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gx62P-0002nn-I0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:18:30 -0500
Date: Fri, 22 Feb 2019 16:17:13 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190222081713.GA4743@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
	<20190219060719.8211-3-richardw.yang@linux.intel.com>
	<a9b921ba-0486-860a-02cf-6598466857aa@redhat.com>
	<20190221153753.48b40fd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221153753.48b40fd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-dimm: remove realize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com

On Thu, Feb 21, 2019 at 03:37:53PM +0100, Igor Mammedov wrote:
>On Tue, 19 Feb 2019 13:36:57 +0100
>Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>
>> On 2/19/19 7:07 AM, Wei Yang wrote:
>> > PCDIMM's realize callback is introduced to do proper setup for NVDIMM.
>> > 
>> > Currently the NVDIMM setup task is nvdimm_prepare_memory_region(), which
>> > is done in pre_plug stage. This means related task has already been done
>> > at realize point.
>> > 
>> > This patch remove PCDIMM realize callback.
>
>pre_plug is machine helper and that it calls nvdimm_prepare_memory_region()
>indirectly is just of side effect of current nvdimm impl. Another machine
>might choose to implement it's own pre_plug to use with nvdimms, in which
>case it might not call the function before realize, hence this patch makes
>nvdimm device model incomplete and less robust.

Sounds reasonable.

Call nvdimm_prepare_memory_region() two times is really ugly. Hmm... could we
improve this?

-- 
Wei Yang
Help you, Help me
