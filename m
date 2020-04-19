Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE550C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 13:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77552206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77552206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQAK7-0006FA-Jr
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 09:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jQAJV-0005ne-E2
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 09:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jQAJU-0005PQ-AM
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 09:48:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:61319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jQAJT-0004uy-Nt
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 09:48:47 -0400
IronPort-SDR: CBTU7ukLOGemcrKFzM2mRFQjq4BlVEbR4xnt91ouofE/dW/A56pmRIkZcZFPwEzXfAUyftbtUv
 Agk3LzZOQK/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 06:48:35 -0700
IronPort-SDR: vgeUMwP0gVOZIVhSwK2Zh5byONuPk5cWzZtP17CSEOrWzWYxjfeSzg0vyk6lNcLeWFh/oGtm4E
 K2XLYWUDZ8ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,403,1580803200"; d="scan'208";a="243535269"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.213.87])
 ([10.254.213.87])
 by orsmga007.jf.intel.com with ESMTP; 19 Apr 2020 06:48:33 -0700
Subject: Re: [PATCH v2 0/3] fetch the alignment of device dax
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <ff757c4e-4091-164f-0876-439dd7b13aa0@intel.com>
Date: Sun, 19 Apr 2020 21:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415033538.43329-1-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=jingqi.liu@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.93
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments.

Hi Paolo, Dan, Joao,
Any comments for this series.

Thanks,
Jingqi

On 4/15/2020 11:35 AM, Liu, Jingqi wrote:
> This series adds libdaxctl support and fetchs the alignment of
> device dax through libdaxctl [1] APIs.
>
> QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
> address to the page size (getpagesize(2)) by default. However, some
> types of backends may require an alignment different than the page
> size. The 'align' option is provided to memory-backend-file to allow
> users to specify the proper alignment.
>
> For device dax (e.g., /dev/dax0.0), the 'align' option needs to
> match the alignment requirement of the device dax, which can be fetched
> through the libdaxctl APIs.
>
> [1] Libdaxctl is a part of ndctl project.
> The project's repository is: https://github.com/pmem/ndctl
>
> Changelog:
>    v2: Per Paolo and Dan suggestions, fetch the alignment of device dax
>        through libdaxctl APIs.
>
>    v1: The initial version.
>        Fetch the alignment through "/sys/dev/char/%d:%d/device/align".
>
> Jingqi Liu (3):
>    exec: fetch the alignment of Linux devdax pmem character device nodes
>    docs/nvdimm: add description of alignment requirement of device dax
>    configure: add libdaxctl support
>
>   configure       | 30 +++++++++++++++++++++++++++
>   docs/nvdimm.txt |  9 +++++++++
>   exec.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 92 insertions(+), 1 deletion(-)
>

