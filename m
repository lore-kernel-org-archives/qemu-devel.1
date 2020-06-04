Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4208C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 02:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88FA206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 02:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88FA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgfyz-0000gm-UQ
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 22:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jgfyR-0000EI-Ef
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 22:51:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:47445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jgfyP-0000vq-My
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 22:51:18 -0400
IronPort-SDR: Wll8fm2x1aCnUOQXx7yBnVTjlm5uTbA6wHsvKJWB9E34rX+TOR5RrM0H2pbILdz80XaoTDCY8v
 q5yz+Klnq7Lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 19:51:08 -0700
IronPort-SDR: brSlP36fZHxKNhVrs/cF2W5+i17zuvezO8xyTFHfd7e9XbDqEXMyDCZScUloY5qq85x9EejipH
 PyRUSuMUHEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; d="scan'208";a="416765167"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by orsmga004.jf.intel.com with ESMTP; 03 Jun 2020 19:51:05 -0700
Message-ID: <5ED86344.4020505@intel.com>
Date: Thu, 04 Jun 2020 10:58:12 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
 <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
In-Reply-To: <CAFXwXrm4R5nxk6ruTJ2kP5dUnF7Qm3TfRRiKVAUDNA1uwYf65w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=wei.w.wang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 22:51:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 06/04/2020 03:28 AM, Richard Henderson wrote:
> On Wed, 29 Apr 2020 at 18:54, Wei Wang <wei.w.wang@intel.com> wrote:
>> +        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
>> +            xbzrle_counters.encoding_rate = 0;
>> +        } else if (!encoded_size) {
>> +            xbzrle_counters.encoding_rate = UINT64_MAX;
>> +        } else {
>> +            xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
>> +        }
> With clang 10, this produces
>
>    CC      aarch64-softmmu/migration/ram.o
> /home/rth/qemu/qemu/migration/ram.c:919:45: error: implicit conversion
> from 'unsigned long' to 'double' changes value from
> 18446744073709551615 to 18446744073709551616
> [-Werror,-Wimplicit-int-float-conversion]
>              xbzrle_counters.encoding_rate = UINT64_MAX;
>                                            ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
> # define UINT64_MAX             (__UINT64_C(18446744073709551615))
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/stdint.h:107:25: note: expanded from macro '__UINT64_C'
> #  define __UINT64_C(c) c ## UL
>                          ^~~~~~~
> <scratch space>:36:1: note: expanded from here
> 18446744073709551615UL
> ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> UINT64_MAX apprears both arbitrary and wrong.
>
> The only way I can imagine encoded_size == 0 is unencoded_size == 0,
> so 0 seems like the correct answer.  Moreover, it really seems like
> the first test sufficiently covers that possibility.

It is possible that encoded_size==0, but unencoded_size !=0. For example,
a page is written with the same data that it already has.


>
> In addition, the only user of this value is
>
>> +        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
>> +                       info->xbzrle_cache->encoding_rate);
> which would be quite happy to print NaN even if the 0/0 computation
> were to run.  Though as I say above, I don't think that's reachable.

The encoding_rate is expected to reflect if the page is xbzrle encoding 
friendly.
The larger, the more friendly, so 0 might not be a good representation here.

Maybe, we could change UINT64_MAX above to "~0ULL" to avoid the issue?

Best,
Wei

