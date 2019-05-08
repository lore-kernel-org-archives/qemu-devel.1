Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51894C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1851D20675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1851D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOArE-0000TK-Dn
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:54:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOAqS-00008Z-FP
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOAqR-0001Qe-Fd
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:54:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:46051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOAqR-0001NJ-6X
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:54:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 17:54:02 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.113])
	([10.239.196.113])
	by FMSMGA003.fm.intel.com with ESMTP; 07 May 2019 17:54:00 -0700
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
	<berrange@redhat.com>
References: <20190507124853.9015-1-tao3.xu@intel.com>
	<20190507130722.GQ27205@redhat.com>
	<69089c48-629c-1297-84cf-63877f803802@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <fee742a0-a836-c7aa-37f9-607986a57876@intel.com>
Date: Wed, 8 May 2019 08:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <69089c48-629c-1297-84cf-63877f803802@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
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
Cc: ehabkost@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, robert.hu@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/2019 11:06 PM, Eric Blake wrote:
> On 5/7/19 8:07 AM, Daniel P. Berrangé wrote:
>> On Tue, May 07, 2019 at 08:48:53PM +0800, Tao Xu wrote:
>>> As noted in
>>> http://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02212.html
>>
>> Rather than pointing to the mailing list post, please just refer
>> to the git commit hash that patch was merged under, which IIUC
>> is c7a88b52f62b30c04158eeb07f73e3f72221b6a8.
>>
>>> Because MSR based feature has been supported by QEMU,
>>> we add CPUID_7_0_EDX_ARCH_CAPABILITIES on Cascadelake-Server CPU
>>> model, and add IA32_ARCH_CAPABILITIES MSR based features (RDCL_NO,
>>> IBRS_ALL and SKIP_L1DFL_VMENTRY).
>>>
>>> And "014018e19b i386: Make arch_capabilities migratable" has been
>>> in QEMU upstream, the CPUID_7_0_EDX_ARCH_CAPABILITIES can be
>>> safely added into CPU Model.
> 
> Also, this paragraph:
> 
>>>
>>> Changes in v2:
>>>      - rebased patch to latest qemu base
> 
> is useful to the list reader but not to the permanent git history, so it
> belongs better...
> 
>>>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
> 
> ...here, after the --- marker, so that 'git am' will strip it on the
> maintainer's behalf when they prepare the patch for a pull request.
>

Thank your for your suggestion, Eric. I will rewrite my commit message.

