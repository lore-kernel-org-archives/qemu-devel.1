Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A5DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D1A207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D1A207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdPEZ-0000BI-Bs
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 22:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jdPDy-00088P-EL
 for qemu-devel@nongnu.org; Mon, 25 May 2020 22:21:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:2188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jdPDw-0005R4-O1
 for qemu-devel@nongnu.org; Mon, 25 May 2020 22:21:49 -0400
IronPort-SDR: BGpFemti2/t6JLccOz73cLvIfDCo5VCx1NUFbTYU5+r4cBruqtmpECkGwxRqXEpbaIT1WdATs9
 7RLVTSqMjGdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2020 19:21:40 -0700
IronPort-SDR: yIytw6V5Ek3y//vZm38EIs7GP6ZyGJZaVxuWYgWlzLSIac+5YvTkyibCZ9syc6wppd5n6/POjz
 YshJDCNRPmJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,435,1583222400"; d="scan'208";a="468127531"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 25 May 2020 19:21:38 -0700
Date: Mon, 25 May 2020 22:11:46 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200526021145.GB698@joy-OptiPlex-7040>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <229ec974-1939-31d8-3516-12e7b8fee27f@redhat.com>
 <f1c43064-7a47-3fb5-8114-ff223ad9f0d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1c43064-7a47-3fb5-8114-ff223ad9f0d3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yan.y.zhao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 22:21:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 xin.zeng@intel.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 01:04:56PM +0200, Paolo Bonzini wrote:
> On 25/05/20 12:54, Philippe Mathieu-Daudé wrote:
> >> Not all of them, only those that need to return MEMTX_ERROR.  I would
> >> like some guidance from Peter as to whether (or when) reads from ROMs
> >> should return MEMTX_ERROR.  This way, we can use that information to
> >> device  what the read-only ram-device regions should do.
> > Is it only device-specific or might it be partly arch/machine-specific
> > (depending on the bus it is mapped)?
> 
> Good point, I think that could be handled by propagating the error up in
> the memory region hierarchy (i.e. the cached AddressSpaceDispatch radix
> tree is used in the common case, but when you have a failure you
> percolate it up through the whole hierarchy since that's not a fast path).
> 
>
but if we decide to propagate the error up by providing with
ops->write_with_attrs, then we have to remove ops->write correspondingly. 
as in

memory_region_dispatch_write()
{
    ...
    if (mr->ops->write) {
        return access_with_adjusted_size(addr, &data, size,
                                         mr->ops->impl.min_access_size,
                                         mr->ops->impl.max_access_size,
                                         memory_region_write_accessor, mr,
                                         attrs);
    } else {
        return
            access_with_adjusted_size(addr, &data, size,
                                      mr->ops->impl.min_access_size,
                                      mr->ops->impl.max_access_size,
                                      memory_region_write_with_attrs_accessor,
                                      mr, attrs);
    }
    ...
}

so which regions should keep ops->write and which regions should not?

Thanks
Yan


