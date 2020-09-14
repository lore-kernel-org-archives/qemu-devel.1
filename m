Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855CBC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC5B208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="HEb1qmo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC5B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHopq-0001lA-Sv
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHokt-0002xW-DL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHokr-00037e-PD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so18780526wrp.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FE2fTeLJIZbf1v5GTx+C8YQyot5VseGmFL4BcrF/QTw=;
 b=HEb1qmo+VCqYm6fjGY+8WBDCNatZPbfcICdF6GHqiBumt+100MI3uCQdtyk66nBIoD
 TB83Jirpk84mggnIGhcvKxxklUB07PCv43GP7CaEgk2luy2VnI65vVczz1B+HLPn06+t
 jzAwkzXx/ZypvhXrR3EYQDdRfEXumzhSXNTbaosmjqjWco7eHRpmeh3QOVwoRgmbSErp
 94+h0Zz/a+742G4fQhIgdd7SMiq+/3Ziq5xxtMVH/spcOLtQ6MRzq+yvcWrUrp5Aou3a
 SMNCJJVdbyVL/lzal4futZQNNneuHg0BF3VSv7HKxTrbaGHEBGtZrQ/ytbkJsGTyJlhi
 9qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FE2fTeLJIZbf1v5GTx+C8YQyot5VseGmFL4BcrF/QTw=;
 b=YqTvCIWsxYyaEHx1jtklzqslBKrWu+ZKtvIlpYhlxMAWTKx8kUUpFdlp0s7DoeaSYx
 ydUp4r+jLzOdrOPHQBrRKd5uzPtJt3eO8iFylfvLOnX1QbPxe6EhfjI3J9TBHFSk7s1l
 Jc7Xq2ooz81s6oHKTpgn+/BS4Qv52UhbPyNCqSZ4QLxJZS7boNs4a29GP5LoWreLIgS4
 rWxbTcgoYL6b5ahofwKyckM9gp9/r2izESst0wAJotoTdhVK5HCoNgUrLNSYQMyYcszM
 KTvXu/2lOrWUf9FP3K6BqtrRENBzanRFfgT6OFz7dsgp4VJz/twmfiHSlbbN2KCmwVSf
 h2HQ==
X-Gm-Message-State: AOAM531sCIyQ3qDPT7eSi8wux1QX3FSuZK27irEzZvmHH09JiXqt3++H
 dOnW1HTBWpLgeisJn5qsQ4mFaLV71UuuFlRrW430xQ==
X-Google-Smtp-Source: ABdhPJwbXfWaa4wDK3wwK9gMJMQ1GQLwITVQrsbFCUoFHLYTDjK26dhaAbSMB/oEHEp1tdNdDrDye98fJKxByb2kM5c=
X-Received: by 2002:adf:e410:: with SMTP id g16mr6795658wrm.76.1600090968306; 
 Mon, 14 Sep 2020 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-7-ani@anisinha.ca>
 <20200914144220.2e27d40a@redhat.com> <20200914150751.50e3ccd7@redhat.com>
In-Reply-To: <20200914150751.50e3ccd7@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 14 Sep 2020 19:12:37 +0530
Message-ID: <CAARzgwxm7DqoN3C239rvSSaVhK7GcWGVxnezsFhbVrAYnjXOLw@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 6:39 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 14 Sep 2020 14:42:20 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
> > On Fri, 11 Sep 2020 23:37:53 +0530
> > Ani Sinha <ani@anisinha.ca> wrote:
> >
> > > This change adds a new unit test for the global flag
> > > 'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
> > > bridges in i440fx. The flag can be used to turn off acpi based hotplug support
> > > for all the slots of the pci bus.
> > not true or not clear,
> > should be
> >  "turn off acpi based hotplug support on all PCI bridges"
> >
> > > Tested on the upstream qemu master branch.
> > Doesn't belong to commit message
>
> with above fixed:
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

I sent a v2

>
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > > index d8c7d57557..7632cfe1be 100644
> > > --- a/tests/qtest/bios-tables-test.c
> > > +++ b/tests/qtest/bios-tables-test.c
> > > @@ -754,6 +754,20 @@ static void test_acpi_piix4_root_hotplug(void)
> > >      free_test_data(&data);
> > >  }
> > >
> > > +static void test_acpi_piix4_bridge_hotplug(void)
> > > +{
> > > +    test_data data;
> > > +
> > > +    memset(&data, 0, sizeof(data));
> > > +    data.machine = MACHINE_PC;
> > > +    data.variant = ".hpbridge";
> > > +    data.required_struct_types = base_required_struct_types;
> > > +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> > > +    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
> > > +                  "-device pci-bridge,chassis_nr=1", &data);
> > > +    free_test_data(&data);
> > > +}
> > > +
> > >  static void test_acpi_q35_tcg(void)
> > >  {
> > >      test_data data;
> > > @@ -1159,6 +1173,7 @@ int main(int argc, char *argv[])
> > >          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> > >          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> > >          qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> > > +        qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> > >          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> > >          qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> > >          qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
> >
> >
>

