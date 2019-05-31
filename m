Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C77C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6E526909
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CWicExeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6E526909
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWgz7-0007yw-Q4
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 08:50:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@gmail.com>) id 1hWZa0-0007CZ-Ph
	for qemu-devel@nongnu.org; Fri, 31 May 2019 00:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@gmail.com>) id 1hWZZz-0006no-Al
	for qemu-devel@nongnu.org; Fri, 31 May 2019 00:55:48 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@gmail.com>)
	id 1hWZZy-0006if-Nz
	for qemu-devel@nongnu.org; Fri, 31 May 2019 00:55:47 -0400
Received: by mail-it1-x144.google.com with SMTP id e184so13218739ite.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SrA62yvlpzIusJ4Q/zDn16kXQwc38lWt69NTafugZzU=;
	b=CWicExeAWqE2BkBpr8x5Lhj3ArD934+YZFkJ12kOL6EdY5CdIECATiI48dc6JGtp79
	mIgtvi1GJQ4QUa2rJliXFWEaLH/d/NJS/8hm0lv7qp57/G2oUE0eH+Jw5aaJSwjEHXy9
	j8DNBDdzN5i55N8KgqHoibhE8ZJHvaXPJ+TgQ3R5WdTEh8HpHxp6Dccj6JCat0Nhugbv
	uXvtVMJlhKNFP9lzTUxNqmy8CIjRMOYxnygXsHxoHbYbmLleHv36cH9IMgz+8UrS0Ukk
	K4WJs/zs4lyGoL6Pi2PTnbqDNOVdVoYnvLx3XTogIJEGUf0sWR+0zpjzY8xgGAIR+6Dc
	5mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SrA62yvlpzIusJ4Q/zDn16kXQwc38lWt69NTafugZzU=;
	b=kfJ7CTyY+9K6bRe/l2/YybdGrtJZjW8Rj7/4nm4jnvcxR64+kZXTONfc5lJxIaDhce
	2lR8z9qDTGFaECbdEFsoUz8pnKIxAcFMpBJcYCHPCnbPx6yK5ig/DlkEx14dQEfqpnUa
	+Gb4xkA1/MHFEdUXNzxr5IN4fs5jwtLpm+JxM39iSF8Ftehqe8lUpKFgduJ3RQFnzwKk
	hjqbjgFvsuhLdvHlZetEmdexzh9M632r2HNDL2910tEllLoLyY7n6myQaU7f0knMQSQn
	nu37VZsY2vj1DnLR0oqsNwF8xyuB26nFawgZhCtcFkZs0v/sJqqx4iVHm6Dp1uVhYosB
	ejYg==
X-Gm-Message-State: APjAAAX3OlKvnnKGOfmlJ2a/moYlYytERffW8IOly/rL8Q7ERJ0CmHc1
	pBrU6ng0OIx/2qhty2ETqpiqRB750tY1hnFXjeE=
X-Google-Smtp-Source: APXvYqzEyOz2EzW5GCbsj3MdsgN8Odl9eCYxFzIXiofkKuhVnOfszV55LiWaJtytTDIl5GA4OdiB5vN32wpRtRMIVMI=
X-Received: by 2002:a02:5143:: with SMTP id s64mr5343622jaa.54.1559278545496; 
	Thu, 30 May 2019 21:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190508061726.27631-1-tao3.xu@intel.com>
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 May 2019 21:55:34 -0700
Message-ID: <CAA9_cmefLY4ktBf4fOXPUbMGX7faiVDV+bKeUhgkUH2+yn7JuQ@mail.gmail.com>
To: Tao Xu <tao3.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
X-Mailman-Approved-At: Fri, 31 May 2019 08:48:46 -0400
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
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
Cc: xiaoguangrong.eric@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
	jingqi.liu@intel.com, linux-nvdimm <linux-nvdimm@lists.01.org>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 11:32 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the System Physical Address (SPA) Memory Ranges.
> The software is expected to use this information as hint for optimization.
>
> OSPM evaluates HMAT only during system initialization. Any changes to the HMAT
> state at runtime or information regarding HMAT for hot plug are communicated
> using the _HMA method.
[..]

Hi,

I gave these patches a try while developing support for the new EFI
v2.8 Specific Purpose Memory attribute [1]. I have a gap / feature
request to note to make this implementation capable of emulating
current shipping platform BIOS implementations for persistent memory
platforms.

The NUMA configuration I tested was:

        -numa node,mem=4G,cpus=0-19,nodeid=0
        -numa node,mem=4G,cpus=20-39,nodeid=1
        -numa node,mem=4G,nodeid=2
        -numa node,mem=4G,nodeid=3

...and it produced an entry like the following for proximity domain 2.

[0C8h 0200   2]               Structure Type : 0000 [Memory Proximity
Domain Attributes]
[0CAh 0202   2]                     Reserved : 0000
[0CCh 0204   4]                       Length : 00000028
[0D0h 0208   2]        Flags (decoded below) : 0002
            Processor Proximity Domain Valid : 0
[0D2h 0210   2]                    Reserved1 : 0000
[0D4h 0212   4]   Processor Proximity Domain : 00000002
[0D8h 0216   4]      Memory Proximity Domain : 00000002
[0DCh 0220   4]                    Reserved2 : 00000000
[0E0h 0224   8]                    Reserved3 : 0000000240000000
[0E8h 0232   8]                    Reserved4 : 0000000100000000

Notice that the Processor "Proximity Domain Valid" bit is clear. I
understand that the implementation is keying off of whether cpus are
defined for that same node or not, but that's not how current
persistent memory platforms implement "Processor Proximity Domain". On
these platforms persistent memory indeed has its own proximity domain,
but the Processor Proximity Domain is expected to be assigned to the
domain that houses the memory controller for that persistent memory.
So to emulate that configuration it would be useful to have a way to
specify "Processor Proximity Domain" without needing to define CPUs in
that domain.

Something like:

        -numa node,mem=4G,cpus=0-19,nodeid=0
        -numa node,mem=4G,cpus=20-39,nodeid=1
        -numa node,mem=4G,nodeid=2,localnodeid=0
        -numa node,mem=4G,nodeid=3,localnodeid=1

...to specify that node2 memory is connected / local to node0 and
node3 memory is connected / local to node1. In general HMAT specifies
that all performance differentiated memory ranges have their own
proximity domain, but those are expected to still be associated with a
local/host/home-socket memory controller.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-May/021668.html

