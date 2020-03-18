Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95570C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B24620663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B24620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMYD-0002yW-Le
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1jEMUS-00087C-Hp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1jEMUQ-0006yk-P5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:23:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:55569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1jEMUQ-0006pC-G4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:23:18 -0400
IronPort-SDR: 9m7Z04/hM7cxD5+7e1RrAxH6ci5duohZDlGOFL2vuLC96DKRz4rYGWh1aRr7ZyWs/SvD/YMNWJ
 mgUgkT4gEMkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 17:23:14 -0700
IronPort-SDR: AK0VJkZQXsILYkl8HHmjXK9q+vBoe2ZAWfSylQagnbvid0EsduBc99jhLDWhSphuvryInl2ke0
 Mu9uW0d+oTGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; d="scan'208";a="391256814"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.52])
 ([10.239.160.52])
 by orsmga004.jf.intel.com with ESMTP; 17 Mar 2020 17:23:13 -0700
Subject: Re: [PULL 09/61] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
 <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
 <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
 <bc354cda-b731-183f-3860-43c3a0af434c@redhat.com>
 <41756673-bbd4-593f-ade8-3232db8b512e@intel.com>
 <1eead546-c06f-2ec0-e3b7-fdc5bb426620@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <aba00b92-26a4-d80d-79ec-eb0e1df7b747@intel.com>
Date: Wed, 18 Mar 2020 08:23:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1eead546-c06f-2ec0-e3b7-fdc5bb426620@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Reply-To: Colin.Xu@intel.com
Cc: Wenchao Wang <wenchao.wang@intel.com>, Hang Yuan <hang.yuan@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-03-17 18:27, Paolo Bonzini wrote:
> On 17/03/20 09:55, Colin Xu wrote:
>> On 2020-03-17 16:26, Paolo Bonzini wrote:
>>> On 17/03/20 08:46, Colin Xu wrote:
>>>> Hi Paolo,
>>>>
>>>> For future HAX patch, once it's "Reviewed-by" haxm maintainers and other
>>>> reviewers, do we need "SubmitAPullRequest" separately or you will do it
>>>> together with other patches?
>>> As you prefer.  I wouldn't mind having to send fewer pull requests. :)
>>>
>>> Paolo
>> Would you mind continue help HAX send pull request? It feels like easier
>> to track the changes when stay together with other accelerator patches.
>> We'll regularly check the reviewed patches and do necessary tests, and
>> send you a list of patches that can be queued for next pull.
>>
>> What do you think?
> Sure, that's okay.  The number of patches is low enough.
>
> Paolo

Cool. Thanks a lot for the help.

Colin.

-- 

Best Regards,
Colin Xu


