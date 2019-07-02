Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA44C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDDB21473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsqarQr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDDB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHK5-0000Hs-HQ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHFi-0005yT-Uq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHFh-00014J-Hg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiHFc-0000xH-H8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id r21so16176725otq.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dSRxAHcDzhVFRmaf5h2eXJkPlzIFYCiYsZli86wZ5ls=;
 b=UsqarQr0YXlZxF+nMkyGoj5J15hUK9LpbuuEJ2KPmdnNpO1LgY630cyTaZoI35uuK6
 DUAvl2nw24uK95MEcdiywj4HJBnf/jY0NQGqYPzrWMdssmZnhio0mqs0stEzzpEcVSkb
 mYLzZZX/UaQ6l17XZZ7bZLDaEra/ariU2jOvl3UuWMRlr41Bjt/RnO8XS+C5G14X6cRW
 0GUwYrxH29JIFS5nRXVT2z6gqPMJZmaZ/4R0Z5N4NuM3m0iXbL+XK0CZKNi8BPYHOpPE
 NKMeuMBECB9TuWT87FeUb+tSVhyem2ZsYTd085A/dUb5RPv+5vdcI+1nGMK1zfT+KNvl
 Ga6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dSRxAHcDzhVFRmaf5h2eXJkPlzIFYCiYsZli86wZ5ls=;
 b=cYGvItwmA/xxPgcOjNdXL+GlHjrwl1wwl72RLdbu/PQcJgdGradgEkNKSEXgJZdAAt
 U9DTB5Gvr/3a160raOISKqPENoKCx1qjsn5fum+FG/YdpoIXHyjWESIwmzg1S8XvJIPX
 ePycpxhbQAYgO3EkgMDGjAVT+84MkII6A1nOctoUfs+g4l0MeeWmgk68tKsi+ix/SbCd
 jLkWiLtAMTrb0hPWE3J4ssV7a2Hkwn15vKA5ZHW14u448pUw+o2pnbMtZRyAgxiq4hrH
 nmWY4cRT9GiyPnIVN4a77P1RgknUyR5VTkk3USsfkbl4ZkxU0RU0tPHqLIPdfu1hdrqJ
 vxUg==
X-Gm-Message-State: APjAAAUbn0OuMDvP9RxBX/3ggO9b7WkGC6yNeAFHTuxq/0XWPU72tFHT
 Gw15FrdMfxIu5XlMYZ19I7Ebaw0gZtDxo0uuG5nijQ==
X-Google-Smtp-Source: APXvYqxKm5914TLnqudVNCijsVtzHK4mz3CSR/Hhe5Niun4eeMsSybWqIZ2MujTcA3Pf8MaE6osfoxd2a7Kh0j79NeE=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr24633658otn.135.1562068026545; 
 Tue, 02 Jul 2019 04:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
 <20190702130703.0e74cbe6@redhat.com>
In-Reply-To: <20190702130703.0e74cbe6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 12:46:55 +0100
Message-ID: <CAFEAcA8PDNTQXD3cD3XG9wkc_QOLXUcw62-8AUjSC0g7qjti7g@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 12:07, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 25 Jun 2019 13:14:13 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>
> > This series is an attempt to provide device memory hotplug support
> > on ARM virt platform. This is based on Eric's recent works here[1]
> > and carries some of the pc-dimm related patches dropped from his
> > series.
> >
> > The kernel support for arm64 memory hot add was added recently by
> > Robin and hence the guest kernel should be => 5.0-rc1.
> >
> > NVDIM support is not included currently as we still have an unresolved
> > issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
> > can be included, but not done for now, for keeping it simple.
> >
> > This makes use of GED device to sent hotplug ACPI events to the
> > Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
> > Sebastien to add the hardware-reduced support to Nemu using GED
> > device[3]. (Please shout if I got the author/signed-off wrong for
> > those patches or missed any names).
> >
> > This is sanity tested on a HiSilicon ARM64 platform and appreciate
> > any further testing.
>
> There are several things I'd fix/amend but it's nothing that couldn't
> be done on top as bugfixes (I'll comment later on specific issues).
>
> However as a whole from ACPI and memory hotplug POV series looks more
> or less ready for merging.
>
> I've asked Eric to test migration (I'm quite not sure about that part),
> (CCed David)so on condition it works:
>
>   Reviewed-by: Igor Mammedov <imammedo@redhat.com>

If we want to get this into 4.1 I'll need somebody to do a respin
with all the relevant fixes pretty soon (ie within a day or two,
and that is pushing it because really it's missed the freeze
deadline already). It might be easier just to let it go into 4.2
instead...

thanks
-- PMM

