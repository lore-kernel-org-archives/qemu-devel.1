Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC9C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA3020675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH39MH0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA3020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVu5R-0005rF-O2
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVu4h-0005Cz-H7
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:41:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVu4f-0000Vs-9z
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588671671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APH4hBhdTuvzeDLElBxVXJocUsvJrKNmf7PAsYZm3Aw=;
 b=aH39MH0LTqLgP9re3t1zREw4+xSLTZh2C/4XC2JIa1IhkJIfOJ5UCz3G+n7jFp3kAvYHoI
 gZHSIKXaF7KinYfAPYNWZvGbSXmgz2PdndyVlTszlg8B+tSJFxLlNGTHYTJs0JDToL5Voh
 xO1W2vWjUcTIt3Oi+puSGjM7WD3rado=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-A_ZisbeTMcSKVPmN2XZBkw-1; Tue, 05 May 2020 05:41:08 -0400
X-MC-Unique: A_ZisbeTMcSKVPmN2XZBkw-1
Received: by mail-wr1-f71.google.com with SMTP id y4so952909wrt.4
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 02:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=APH4hBhdTuvzeDLElBxVXJocUsvJrKNmf7PAsYZm3Aw=;
 b=JbEZ3ncAt4QTsHiUvHZBgLiR1/9yKBvmLfforlLZpDgrAgD4oIKC73QHLmJOGFcaf5
 QysgeqK0WIfz2cMCNbWm4EsdK0I/5F72eyPZHaG0a4/7dEJWoT7iFqwFhHPR3qcOkMHN
 nYQdiIhUnmxZ3l+V7+lCbNeUiZuvZrg1XRqgAnUZXvxRdS3PZ9KpzuP5FWjytuZ9CKHI
 gbIiP4TsXmbNPbESEwiOR4iYgMrxyBdHUWBK5r4FnIf+VVgXF0kbvU/iYXBHzlUtgsWC
 MkwOzShBTecWelyM4ou4cqdREjoqST0Wg59qp8EPX+IoPb9kDl3AO9Z7grL8AVoV3z7n
 YJcw==
X-Gm-Message-State: AGi0PuarDzjlFZDibN2hWu/39r5PPZOfmu/i87S/762JqtUp6R6ooPnN
 e4Bvxq0gPjUkkU50U3HZXmZjAzioAAu21zIyobQ0BMRr0wJnS05+4cTeffxcCNoGcRTHUF7Tpj/
 l3doViZ38uDL5IGc=
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr2839977wrr.18.1588671666840;
 Tue, 05 May 2020 02:41:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+cVSW6HdW++quzjkY3kClpm7ImJkiC19JSn5hbfbtvzFIEhLh27EqkvSaZXPfJzFmkNLj0Q==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr2839937wrr.18.1588671666582;
 Tue, 05 May 2020 02:41:06 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id x16sm2271137wrn.76.2020.05.05.02.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 02:41:05 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] nvme: refactoring and cleanups
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200505054840.186586-1-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4dcfd794-5722-31d9-4f03-7b1a6425c6b8@redhat.com>
Date: Tue, 5 May 2020 11:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505054840.186586-1-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 7:48 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Changes since v5
> ~~~~~~~~~~~~~~~~
> No functional changes, just updated Reviewed-by tags. Also, I screwed up
> the CC list when sending v4.
> 
> Philippe and Keith, please add a Reviewed-by to
> 
>    * "nvme: factor out pmr setup" and
>    * "do cmb/pmr init as part of pci init"
> 
> since the first one was added and the second one was changed in v4 when
> rebasing on Kevins block-next tree which had the PMR work that was not
> in master at the time.
> 
> With those in place, it should be ready for Kevin to merge.
> 
> Klaus Jensen (18):
>    nvme: fix pci doorbell size calculation
>    nvme: rename trace events to pci_nvme
>    nvme: remove superfluous breaks
>    nvme: move device parameters to separate struct
>    nvme: use constants in identify
>    nvme: refactor nvme_addr_read
>    nvme: add max_ioqpairs device parameter
>    nvme: remove redundant cmbloc/cmbsz members
>    nvme: factor out property/constraint checks
>    nvme: factor out device state setup
>    nvme: factor out block backend setup
>    nvme: add namespace helpers
>    nvme: factor out namespace setup
>    nvme: factor out pci setup
>    nvme: factor out cmb setup
>    nvme: factor out pmr setup
>    nvme: do cmb/pmr init as part of pci init
>    nvme: factor out controller identify setup

Thinking loudly, it would be easier to differentiate emulated device vs 
block driver using 's,^nvme,hw/nvme,' in patches (and series) title. 
Kevin, if you are motivated...

> 
>   hw/block/nvme.c       | 543 ++++++++++++++++++++++++------------------
>   hw/block/nvme.h       |  31 ++-
>   hw/block/trace-events | 180 +++++++-------
>   include/block/nvme.h  |   8 +
>   4 files changed, 429 insertions(+), 333 deletions(-)
> 


