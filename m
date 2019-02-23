Received: from eggs.gnu.org ([209.51.188.92]:54322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gxKmV-0006ru-Qc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gxKmV-00064T-3s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:03:03 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1gxKmU-0005oK-Re
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:03:03 -0500
Received: by mail-ed1-x541.google.com with SMTP id p27so3234083edc.6
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 16:02:52 -0800 (PST)
Date: Sat, 23 Feb 2019 00:02:49 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190223000249.e56gmq6su7vqor6k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190221155004.010f7b7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221155004.010f7b7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, xiaoguangrong.eric@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Thu, Feb 21, 2019 at 03:50:04PM +0100, Igor Mammedov wrote:
>On Wed, 20 Feb 2019 08:51:21 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> Three trivial cleanup for pc-dimm.
>> 
>> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
>> hotpluggable.
>> Patch [2] remove nvdimm_realize
>> Patch [2] remove pcdimm realize-callback
>even though this series doesn't break anything, I disagree with it
>conceptually as it makes device less abstracted and make it more
>dependent on how existing machine code uses it.
>I'd drop whole series.
>

Is Patch [1] also make device more dependent on existing implementation?

For example, when we look at the counterpart of acpi_memory_plug_cb():

    acpi_pcihp_device_plug_cb

which handle the pci device hotplug. We don't check the hotpluggable
property for pci devices.

To me, this is a general rule for PCDIMM, they are hotpluggable.

For Patch[2][3], I agree with you.

-- 
Wei Yang
Help you, Help me
