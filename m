Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009DC10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A3A20873
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 01:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A3A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40253 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEOzB-000210-Hd
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 21:58:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOy2-0001Mx-3s
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOxI-0001Dg-19
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:56:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEOxH-0001A4-MZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:56:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2019 18:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; d="scan'208";a="139268098"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2019 18:56:39 -0700
Date: Thu, 11 Apr 2019 09:56:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190411015619.GA9198@richard>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
	<20190408212911.jiqdva62ddebndut@master>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408212911.jiqdva62ddebndut@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Thomas Huth <thuth@redhat.com>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411015619.0a8NGU4Khfv2p_jRFqFUCaHJDAGV7vw0Vn18RNkVHNY@z>

On Mon, Apr 08, 2019 at 09:29:11PM +0000, Wei Yang wrote:
>>> 
>>> Thomas,
>>> 
>>> Thanks for pointing this out, while I have some different idea on how to fix
>>> this.
>>> 
>>> The reason of the core dump is errp already been set in
>>> hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
>>> The order of this check is correct, while we should  return when errp is set
>>> in hotplug_handler_pre_plug().
>>> 
>>> I got a fix like this, which I have tested and looks good to me.
>>> 
>>> 
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 6077d27361..b11f3b15c1 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>      }
>>>  
>>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>
>>Not sure, but I think you can not rely on the fact that the caller set
>>*errp = NULL already... that's why it is more common to use a local_err
>>variable and error_propagate() for such cases (which is what I did in my
>>patch).
>>
>
>Ok, that's fine for me.
>
>>Also, why don't you want the "nvdimm is not enabled: missing 'nvdimm' in
>>'-M'" check to be done first?
>>
>
>Because this function pc_memory_pre_plug() will be called not only when
>nvdimm is hot-plugged but also dimm is hot-plugged. And
>hotplug_handler_pre_plug() here is to check the acpi(if it has) hot-plug
>capability.
>
>So the check in pc_memory_pre_plug() is from generic to specific: 
>    1. Do we have capability to hot-plug?
>    2. If the device is nvdimm, do we enabled nvdimm?
>

Thomas

Do you think this is a reasonable explanation?

-- 
Wei Yang
Help you, Help me

