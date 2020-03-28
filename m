Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6229C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 05:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE8120716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 05:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE8120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI3mk-0000FY-LE
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 01:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jI3mC-0008I0-7w
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jI3mA-0007M2-Dh
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:12:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:8176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jI3mA-0007AN-6K
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 01:12:54 -0400
IronPort-SDR: dFr62eK8V9XrEFKRxmE6WzmZ44WJ0TDNhpCgayxpA/Ox4rC6T/EEDFEj1YecVYM0iHl4kJO8FQ
 T/auhdA7iw4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 22:12:46 -0700
IronPort-SDR: oFNzmKGc7dI5tAhEtxmdk4Nr0OIvf7ILNm6KRBl5yx4J2pQlO2Gm4Y+x+nmEv69d0jBrxLHQr2
 WigIcMXsSyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,315,1580803200"; d="scan'208";a="394582432"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.174.239])
 ([10.249.174.239])
 by orsmga004.jf.intel.com with ESMTP; 27 Mar 2020 22:12:44 -0700
Subject: Re: [PATCH v2 3/4] target/i386: add the missing features for
 Icelake-Server CPU model
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200328030625.16428-1-chenyi.qiang@intel.com>
 <20200328030625.16428-4-chenyi.qiang@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <437d5644-a1ae-a278-b846-ac8254561bd2@intel.com>
Date: Sat, 28 Mar 2020 13:12:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328030625.16428-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: qemu-devel@nongnu.org, Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/28/2020 11:06 AM, Chenyi Qiang wrote:
> Add the SHA_NI and AVX512IFMA feature bits in FEAT_7_0_EBX, RDPID
> feature bit in FEAT_7_0_ECX and FSRM feature bit in FEAT_7_0_EDX.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   target/i386/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b01421c6bb..babb074abf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3552,6 +3552,16 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ }
>                   },
>               },
> +            {
> +                .version = 3,

Maybe you need to make it as version = 4, since 3 is used to add 
ARCH_CAPABILITIES bits and the Patch is queued:

https://lore.kernel.org/qemu-devel/20200323183936.GA3784@habkost.net/

> +                .props = (PropValue[]) {
> +                    { "sha-ni", "on" },
> +                    { "avx512ifma", "on" },
> +                    { "rdpid", "on" },
> +                    { "fsrm", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
>               { /* end of list */ }
>           }
>       },
> 


