Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44546C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C382184B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 08:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C382184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEVVb-0007pw-Kz
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 04:56:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEVUo-0006nA-Ho
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEVEl-0004va-S3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:39:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:8266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEVEk-0004ad-G2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:39:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 01:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,336,1549958400"; d="scan'208";a="160690733"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2019 01:38:46 -0700
Date: Thu, 11 Apr 2019 16:38:27 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190411083827.GA24390@richard>
References: <20190411071739.22889-1-richardw.yang@linux.intel.com>
	<fc11042f-023f-3396-e68a-22dfd4ab0be7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <fc11042f-023f-3396-e68a-22dfd4ab0be7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
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
Cc: pbonzini@redhat.com, rth@twiddle.net,
	Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411083827.GziZbahuTo0PgwnTuNv5lUYZ-GOQPOrZGMzM2IVrrX4@z>

On Thu, Apr 11, 2019 at 10:32:39AM +0200, Thomas Huth wrote:
>On 11/04/2019 09.17, Wei Yang wrote:
>> pc_memory_pre_plug() is called during hotplug for both pc-dimm and
>> nvdimm. This is more proper to check apci hotplug capability before
>> check nvdimm specific capability.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/i386/pc.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f2c15bf1f2..d48b6f9582 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>          return;
>>      }
>>  
>> -    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>> -        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> -        return;
>> -    }
>> -
>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>>      }
>>  
>> +    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> +        return;
>> +    }
>> +
>>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>>                       pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>>  }
>
>Works fine for me, too (i.e. no crash with older machine types).
>
>Tested-by: Thomas Huth <thuth@redhat.com>
>

Thanks :-)

-- 
Wei Yang
Help you, Help me

