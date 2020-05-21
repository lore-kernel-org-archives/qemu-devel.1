Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BFEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC77204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpDEDABG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC77204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnBv-0000SA-DQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbnAi-0007s9-2P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbnAf-0006mF-K7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aDNyRDq5+mPsmlId7pdEEtQcMCH9MCYgjQvMhcUog8=;
 b=BpDEDABGbNoGHQnvnkk7ipzR4F3ZOQfh5r8mqKrcgHhhRUYO/wDsLMTnPLs4NvHXMuq46U
 hIoRwwsDw3rAKzanAjBG7sWPqEvmJjEASsrlFnkhkKys9XgxgRELA/AHjvjcNnu31UTjwY
 GCAgH49sTc4sAMx513JYBNTZKtxR7eE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-n55KUL9APaCcrgLU6rjpEA-1; Thu, 21 May 2020 11:31:41 -0400
X-MC-Unique: n55KUL9APaCcrgLU6rjpEA-1
Received: by mail-wm1-f71.google.com with SMTP id t23so1985386wmi.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6aDNyRDq5+mPsmlId7pdEEtQcMCH9MCYgjQvMhcUog8=;
 b=X944AfF81pBZtM7iYk9hegjJyqUIegru7Yp/+gv136mni994kVS5bxUU6QNZ5On407
 lWcHzd8qlL7dWu1/w0QGvJiFgcpjamFTLFu1lu1/NoT1HhqVwG68Ctle3HBgqwLlaB91
 snBmi3n9omAthIHHnsULChHVUOyyxLYO1PEh02wK6XS+JjmqPl6qas7/erEnHL7aT/6O
 xDz0h3OPW4ZyO6oFi92FmEuw3620FjNqouiZnEkrWkrkc+IixSpJmv0P7UvNL1BYOaTj
 TlGoPO146t4wbsZNgakQkohSWhVnk65yeQ7URmmRm3RVnx+nUcN4uIktz6TDPt+AVlk5
 DqCA==
X-Gm-Message-State: AOAM531Nr2sB9qiq6sEG7KSQquH7TikJ2DA+LZpWvrJZyeGR7GQIPFne
 YSBfuMlAti4uFVt8UykA8dp32uYoOs8J5dCYkVuy0YZvL9EmDv8ZQPjR4rgqyJ3ra5ENQmruo0Y
 M/GTetOGE6Ykt7KM=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr693623wrm.424.1590075100329;
 Thu, 21 May 2020 08:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnbpunuTYuBkloG3oC+AqVokDA4yfPxsKCJDihDmEcjRaytXhIpngRoe3jQZzU6QUqj3NIYA==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr693593wrm.424.1590075099938;
 Thu, 21 May 2020 08:31:39 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 n17sm6560597wrr.42.2020.05.21.08.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 08:31:39 -0700 (PDT)
Date: Thu, 21 May 2020 11:31:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 26/45] ACPI: Record Generic Error Status Block(GESB) table
Message-ID: <20200521113048-mutt-send-email-mst@kernel.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
 <20200514142138.20875-27-peter.maydell@linaro.org>
 <CAFEAcA_a4yiE9UZx=MAFUM+f0LSiNvjQ=X1+dObELRzfnTyUHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_a4yiE9UZx=MAFUM+f0LSiNvjQ=X1+dObELRzfnTyUHQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 02:03:36PM +0100, Peter Maydell wrote:
> On Thu, 14 May 2020 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Dongjiu Geng <gengdongjiu@huawei.com>
> >
> > kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> > index in etc/hardware_errors to find out Error Status Data
> > Block entry corresponding to error source. So supported source_id
> > values should be assigned here and not be changed afterwards to
> > make sure that guest will write error into expected Error Status
> > Data Block.
> >
> > Before QEMU writes a new error to ACPI table, it will check whether
> > previous error has been acknowledged. If not acknowledged, the new
> > errors will be ignored and not be recorded. For the errors section
> > type, QEMU simulate it to memory section error.
> 
> Hi; Coverity points out (CID 1428962) that there is
> unreachable code in this function:
> 
> > +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> > +                                      uint64_t error_physical_addr)
> > +{
> > +    GArray *block;
> > +
> > +    /* Memory Error Section Type */
> > +    const uint8_t uefi_cper_mem_sec[] =
> > +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > +                  0xED, 0x7C, 0x83, 0xB1);
> > +
> > +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> > +     * Table 17-13 Generic Error Data Entry
> > +     */
> > +    QemuUUID fru_id = {};
> > +    uint32_t data_length;
> > +
> > +    block = g_array_new(false, true /* clear */, 1);
> > +
> > +    /* This is the length if adding a new generic error data entry*/
> > +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> 
> Here data_length has a constant value...
> 
> > +
> > +    /*
> > +     * Check whether it will run out of the preallocated memory if adding a new
> > +     * generic error data entry
> > +     */
> > +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> 
> ...but here we immediately have a runtime check which can't possibly
> fail because of the values of the constants involved, so this
> if() block is dead code.
> 
> > +        error_report("Not enough memory to record new CPER!!!");
> > +        g_array_free(block, true);
> > +        return -1;
> > +    }
> 
> What was this code trying to do? Is the initial value of
> data_length incorrect, or is the if() condition wrong, or
> should this simply have been an assert() ?
> 
> thanks
> -- PMM

It's just a validity check. assert will do just as well.

-- 
MST


