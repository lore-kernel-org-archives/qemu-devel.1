Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393BBC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C8E2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C8E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfwCT-000154-UZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 20:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Colin.Xu@intel.com>) id 1hfwBd-0000Ka-6C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1hfwBb-0002Cq-Sb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:53:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:24174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1hfwBb-0001Ri-IZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:53:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Jun 2019 17:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; d="scan'208";a="164176794"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.21])
 ([10.239.160.21])
 by orsmga003.jf.intel.com with ESMTP; 25 Jun 2019 17:52:57 -0700
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20190625032142.13854-1-colin.xu@intel.com>
 <20190625104246.GD3139@redhat.com>
 <73d2325b-155b-cc74-3475-d01f83d7a7f4@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <9346a54e-5423-8144-dd0a-4387039b1617@intel.com>
Date: Wed, 26 Jun 2019 08:52:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <73d2325b-155b-cc74-3475-d01f83d7a7f4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH] ui: Correct icon install path
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
Cc: qemu-devel@nongnu.org, "stefanha@redhat.com" <stefanha@redhat.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-06-25 21:40, Eric Blake wrote:
> On 6/25/19 5:42 AM, Daniel P. Berrangé wrote:
>> On Tue, Jun 25, 2019 at 11:21:42AM +0800, Colin Xu wrote:
>>> The double slash in path will fail the installation on MINGW/MSYS.
>>>
>>> Fixes: a8260d387638 (ui: install logo icons to $prefix/share/icons)
>>>
>>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>>> ---
>>>   Makefile | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>> Hmmm I swear this exact fix has been posted before but I can't find
>> / remember where and obviously it didnt get merged.
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04885.html
>
Aha, you are right Daniel. This has been posted before.
-- 
Best Regards,
Colin Xu


