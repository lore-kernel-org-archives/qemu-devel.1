Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF250C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FC62087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FC62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaKA-0007wp-N8
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <star.zeng@intel.com>) id 1hzaHH-0004EJ-Ds
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <star.zeng@intel.com>) id 1hzaHF-00058Y-DK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:32:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:52443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <star.zeng@intel.com>) id 1hzaHF-00055g-3l
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:32:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Aug 2019 22:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; d="scan'208";a="206895690"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2019 22:32:16 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 18 Aug 2019 22:32:16 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.139]) with mapi id 14.03.0439.000;
 Mon, 19 Aug 2019 13:32:14 +0800
From: "Zeng, Star" <star.zeng@intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>, David Hildenbrand
 <david@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to
 use goto for the last check
Thread-Index: AQHVRm8sI9RcDIduCkeWmeFT3LDTHabwhy4g//+DlICAAIksAP//fbAAgABK94CAEP7tgIAAtkoQ
Date: Mon, 19 Aug 2019 05:32:14 +0000
Message-ID: <0C09AFA07DD0434D9E2A0C6AEB0483104039E3A1@shsmsx102.ccr.corp.intel.com>
References: <20190730003740.20694-1-richardw.yang@linux.intel.com>
 <20190730003740.20694-2-richardw.yang@linux.intel.com>
 <0C09AFA07DD0434D9E2A0C6AEB0483104038F59D@shsmsx102.ccr.corp.intel.com>
 <20190808021329.GC26938@richard>
 <0C09AFA07DD0434D9E2A0C6AEB0483104038F61B@shsmsx102.ccr.corp.intel.com>
 <20190808023802.GD26938@richard>
 <a73f638c-e33d-c3d8-0b4a-0fa78943a30d@redhat.com>
 <20190819023855.GC6368@richard>
In-Reply-To: <20190819023855.GC6368@richard>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to use
 goto for the last check
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zeng,
 Star" <star.zeng@intel.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Wei Yang [mailto:richardw.yang@linux.intel.com]
> Sent: Monday, August 19, 2019 10:39 AM
> To: David Hildenbrand <david@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>; Zeng, Star
> <star.zeng@intel.com>; imammedo@redhat.com; qemu-devel@nongnu.org;
> mst@redhat.com
> Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory-device: not necessary to
> use goto for the last check
>=20
> On Thu, Aug 08, 2019 at 09:06:21AM +0200, David Hildenbrand wrote:
> >On 08.08.19 04:38, Wei Yang wrote:
> >> On Thu, Aug 08, 2019 at 02:30:02AM +0000, Zeng, Star wrote:
> >>>> -----Original Message-----
> >>>> From: Wei Yang [mailto:richardw.yang@linux.intel.com]
> >>>> Sent: Thursday, August 8, 2019 10:13 AM
> >>>> To: Zeng, Star <star.zeng@intel.com>
> >>>> Cc: Wei Yang <richardw.yang@linux.intel.com>;
> >>>> qemu-devel@nongnu.org; imammedo@redhat.com;
> david@redhat.com;
> >>>> mst@redhat.com
> >>>> Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory-device: not
> >>>> necessary to use goto for the last check
> >>>>
> >>>> On Thu, Aug 08, 2019 at 01:42:14AM +0000, Zeng, Star wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: Qemu-devel [mailto:qemu-devel-
> >>>>>> bounces+star.zeng=3Dintel.com@nongnu.org] On Behalf Of Wei Yang
> >>>>>> Sent: Tuesday, July 30, 2019 8:38 AM
> >>>>>> To: qemu-devel@nongnu.org
> >>>>>> Cc: imammedo@redhat.com; david@redhat.com; Wei Yang
> >>>>>> <richardw.yang@linux.intel.com>; mst@redhat.com
> >>>>>> Subject: [Qemu-devel] [PATCH v2 1/2] memory-device: not
> necessary
> >>>>>> to use goto for the last check
> >>>>>>
> >>>>>> We are already at the last condition check.
> >>>>>>
> >>>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >>>>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>>>> ---
> >>>>>>  hw/mem/memory-device.c | 1 -
> >>>>>>  1 file changed, 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-
> device.c
> >>>> index
> >>>>>> 5f2c408036..df3261b32a 100644
> >>>>>> --- a/hw/mem/memory-device.c
> >>>>>> +++ b/hw/mem/memory-device.c
> >>>>>> @@ -186,7 +186,6 @@ static uint64_t
> >>>>>> memory_device_get_free_addr(MachineState *ms,
> >>>>>>      if (!range_contains_range(&as, &new)) {
> >>>>>>          error_setg(errp, "could not find position in guest addres=
s space
> for "
> >>>>>>                     "memory device - memory fragmented due to
> alignments");
> >>>>>> -        goto out;
> >>>>>
> >>>>> Is it better to return 0 (or set new_addr to 0) for this error
> >>>>> path and another
> >>>> remaining "goto out" path?
> >>>>>
> >>>>
> >>>> I may not get your point.
> >>>>
> >>>> We set errp which is handled in its caller. By doing so, the error i=
s
> propagated.
> >>>>
> >>>> Do I miss something?
> >>>
> >>> Yes, you are right. Currently, the caller is checking errp, but not t=
he
> returned address, so there should be no issue.
> >>> But when you see other error paths, you will find they all return 0.
> >>> To be aligned (return 0 when error), so just suggest also returning
> >>> 0 for these two "goto out" error path. :)
> >>>
> >>
> >> You may have some point.
> >>
> >> Let's see whether others have the same taste, or we can refine it
> separately.
> >>
> >
> >I don't think that's necessary (callers really should check for errors
> >before using the return values), but I would also not object to that cha=
nge.
> >
>=20
> In case there is no strong requirement to refactor the code. I would leav=
e it
> here.

It was just my suggestion. I am fine with any preference you and other expe=
rts have.

Thanks,
Star

>=20
> >--
> >
> >Thanks,
> >
> >David / dhildenb
>=20
> --
> Wei Yang
> Help you, Help me

