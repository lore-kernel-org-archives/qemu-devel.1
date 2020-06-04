Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35354C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0619F206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0619F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjYq-00044G-34
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jgjXN-00031G-F3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:39:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:14037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jgjXM-0000DX-72
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:39:36 -0400
IronPort-SDR: 9eoIggk7s3wMJXWeiR2/ze6MdENG3VtqI/s9or0enyTzTBcNragJU6iEfE4DVU+tde/2uB/mBq
 xA2scGM4uoxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 23:39:34 -0700
IronPort-SDR: JfGoEJlwwLFzzAFv/lpKDFsT0WE2gZ6vSYkpz1mLZzQv3Zj4gHNQG95XRQbqwSAJ1DE54SXgnf
 cEDTrmsDExmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; d="scan'208";a="445396140"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 23:39:31 -0700
Message-ID: <5ED898CE.9030305@intel.com>
Date: Thu, 04 Jun 2020 14:46:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
 <5ED86344.4020505@intel.com>
 <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
In-Reply-To: <4b9cd244-0d96-d1c8-11ec-b61a6bc2bfaa@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wei.w.wang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:39:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kevin.tian@intel.com, Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/04/2020 11:22 AM, Richard Henderson wrote:
> On 6/3/20 7:58 PM, Wei Wang wrote:
>> It is possible that encoded_size==0, but unencoded_size !=0. For example,
>> a page is written with the same data that it already has.
> That really contains 0 bytes?
> Not even the ones that say "same data"?

Yes. It's a just delta operation, the diff (encoded_size) is 0 in that case.

>
> You certainly have a magical compression algorithm there.
> Or bad accounting.
>
>> The encoding_rate is expected to reflect if the page is xbzrle encoding friendly.
>> The larger, the more friendly, so 0 might not be a good representation here.
>>
>> Maybe, we could change UINT64_MAX above to "~0ULL" to avoid the issue?
> ~0ull is no different than UINT64_MAX -- indeed, they are *exactly* the same
> value -- and is not an exactly representible floating-point value.
>
> If unencoded_size != 0, and (somehow) encoded_size == 0, then
>
>    unencoded_size / encoded_size = Inf
>
> which is indeed the limit of x -> 0, n / x.
>
> Which is *also* printable by %0.2f.
>
> I still contend that the middle if should be removed, and you should print out
> whatever's left.  Either NaN or Inf is instructive.  Certainly nothing in the
> middle cares about the actual value.
>

OK, leave it as "inf" looks good to me. Will send a patch to remove the 
middle. Thanks!

Best,
Wei




