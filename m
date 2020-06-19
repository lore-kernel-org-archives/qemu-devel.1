Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED23C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D74A208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEBaOEAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D74A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKka-00053m-RX
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKiT-0000he-Ij
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:22:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKiR-0006uW-JD
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:22:13 -0400
Received: by mail-oi1-x244.google.com with SMTP id b8so9128069oic.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=snliSYd+mulJizjEpl5Dl69ntnWcBXIk9+iTvlRC7E4=;
 b=HEBaOEAC8kev5ZPD5UiFF9cqi4d2t3RqPSqOs76mwNw3wJjGzq5DCeZzwgn97nKYWB
 1z3SC4DvudWLqIb4VX5W+jBXuQ+pbjU1YVIvY2KA6PKFk2kce4kJTm6tCRea914T/R3v
 3K3grTcUYNp3uSnLVbKJTc/k/v/McqREO3VXPLOeRKASJ31g3J9svUtKn7ltHpKXGR+n
 vB323qJn59sD3ghw94Y5niO/bJYPZ66uQFwJgIQkWO07ZiVro0H4ipvUQCcUoC88YrT9
 iNvkyQvM6181zHKqZDaJ8jjE4mz9mLeHWqcp3Tyh1JeY8bVlh6ahC11aYGqk4S4xYrrF
 DKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=snliSYd+mulJizjEpl5Dl69ntnWcBXIk9+iTvlRC7E4=;
 b=tm3+XOZAdR8YB8lorgIKP5tZxd8EG22SMK41L5YLQLOwNyvKoG+1d+gF2r9av88fhJ
 AR32OF8EVvsmtGmQvHVRH2DzD+EwZ1JRL08FrrphVemrxcn1Eb5RyHHd2FG3MClo4yS1
 1lhfcLm6hej26F2S2Yr8P8IOUwI1tA0wY4YY2WtzBPn4aEOFJkGkyqqgKOvtCMu+hfL9
 OW5TGUDrPU9YBU8jNw+325JYJ7dUQ2sKWMBS3R2iKVdWO2BGN/FsD4/khPGnQB7kJqZ+
 jxJ6FnjLTjCRxfH6DJ4S6mMbCzw2vYC+7G5c4Zog+0jWLS92WtzHi/s311u0tbV4FXRF
 O4ew==
X-Gm-Message-State: AOAM531K+0ZgBFYWXrAY0mAMcd/z8u9tEjX9wm73WV5Kted2Rh9Qms2P
 O0l9G917ZfwKPqLCAlaMiAglLv/fj7p65ep3mQrdXA==
X-Google-Smtp-Source: ABdhPJyhLzSs5cnuvnV6JzOrwU/mrxPMIHdjd3s3fqM0Basrvp35yvid7mm6SDHN/nMs8dW0fLMPu+dSc8RZ8HpussE=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3748675oib.146.1592587330245; 
 Fri, 19 Jun 2020 10:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200514142138.20875-1-peter.maydell@linaro.org>
 <20200514142138.20875-27-peter.maydell@linaro.org>
 <CAFEAcA_a4yiE9UZx=MAFUM+f0LSiNvjQ=X1+dObELRzfnTyUHQ@mail.gmail.com>
 <20200521113048-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200521113048-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 18:21:59 +0100
Message-ID: <CAFEAcA-PTtLvouxo5XZmgSbeRWa4WCwH7_cC5xrg3Dnr8UyZxg@mail.gmail.com>
Subject: Re: [PULL 26/45] ACPI: Record Generic Error Status Block(GESB) table
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 16:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 21, 2020 at 02:03:36PM +0100, Peter Maydell wrote:
> > On Thu, 14 May 2020 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > From: Dongjiu Geng <gengdongjiu@huawei.com>
> > >
> > > kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> > > index in etc/hardware_errors to find out Error Status Data
> > > Block entry corresponding to error source. So supported source_id
> > > values should be assigned here and not be changed afterwards to
> > > make sure that guest will write error into expected Error Status
> > > Data Block.
> > >
> > > Before QEMU writes a new error to ACPI table, it will check whether
> > > previous error has been acknowledged. If not acknowledged, the new
> > > errors will be ignored and not be recorded. For the errors section
> > > type, QEMU simulate it to memory section error.
> >
> > Hi; Coverity points out (CID 1428962) that there is
> > unreachable code in this function:
> >
> > > +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> > > +                                      uint64_t error_physical_addr)
> > > +{
> > > +    GArray *block;
> > > +
> > > +    /* Memory Error Section Type */
> > > +    const uint8_t uefi_cper_mem_sec[] =
> > > +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > > +                  0xED, 0x7C, 0x83, 0xB1);
> > > +
> > > +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> > > +     * Table 17-13 Generic Error Data Entry
> > > +     */
> > > +    QemuUUID fru_id = {};
> > > +    uint32_t data_length;
> > > +
> > > +    block = g_array_new(false, true /* clear */, 1);
> > > +
> > > +    /* This is the length if adding a new generic error data entry*/
> > > +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> >
> > Here data_length has a constant value...
> >
> > > +
> > > +    /*
> > > +     * Check whether it will run out of the preallocated memory if adding a new
> > > +     * generic error data entry
> > > +     */
> > > +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> >
> > ...but here we immediately have a runtime check which can't possibly
> > fail because of the values of the constants involved, so this
> > if() block is dead code.
> >
> > > +        error_report("Not enough memory to record new CPER!!!");
> > > +        g_array_free(block, true);
> > > +        return -1;
> > > +    }
> >
> > What was this code trying to do? Is the initial value of
> > data_length incorrect, or is the if() condition wrong, or
> > should this simply have been an assert() ?

> It's just a validity check. assert will do just as well.

Would somebody like to write a patch to make it assert instead, then,
please? That should keep Coverity happy.

thanks
-- PMM

