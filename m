Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D1C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0920872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iapIuslD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCvhK-0002IX-NN
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCvfa-0001YF-I5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCvfZ-0002Kl-49
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:00:38 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCvfW-0002H5-8y; Tue, 24 Sep 2019 21:00:34 -0400
Received: by mail-lf1-x141.google.com with SMTP id u3so2810788lfl.10;
 Tue, 24 Sep 2019 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OsLAdtOJ4d4XRcWVNX29HP2/TvlvaQtk0cleys/zOx4=;
 b=iapIuslDOar4kgK9iNJfswxluQmM7W6VDlA+S7dR3GdwSoStMuYBfa5G9I9kQgGzKz
 JZBsio62aErG1SNcit31Uy35b3xkW3/NOOZpF/4m2VjvtOlTnPsjykoBFBtmMF/nsAec
 YXl8Ms7NZDty2KcQI0seEQeWHy/o76CqiCpmj8f+K5Pjf5LVC13Ctn/AczqiCMGWd6qw
 KSEQyJuPBtB1yb7EDP0cznOUtHVtQz4s0zq9jseho7b572yPAJ8DjY9o75XEKSYuz6wI
 ep5KtrfEUXWLkwucQs3DXYGYt7vMeQ+dKEdtzUG0NKbUhRF5BH+zctrejCZYCzWWhMR5
 kzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OsLAdtOJ4d4XRcWVNX29HP2/TvlvaQtk0cleys/zOx4=;
 b=ahc027xsb9w01V2cKIgqwMi3PdO35e6z0QpVGT4OsKPCAgTfthUMXA2zkfLrEMDiHh
 QTWKj5STq0T+ZAvDLMnUQmDcLVsmnNkFJuc8XbBhYOzy5XRt49CbFbhbB4Ni7CWz/xQh
 KJITkUVV+CWUaHWPEjIsPHe6FzdcyXSBnAYoH1eOxyn0KSTPueHuuHWwQLu8K//woZcy
 lsG6bgVXN0ugVlhIeVtiBSajahksvQUt1wTLzNMdSgM0AcnR+FbSvLGkuqFbz2tOxox2
 oYd5bmeAoOa9X5Vy2r4zX0IKix5iFvHLizlewTcr0FLjecO9ZqTo19Dv2fVq1AHIdUrx
 NCqg==
X-Gm-Message-State: APjAAAWyD6jomtVsMQuSDYxQmAwfVZpsDjL0tAeMOvqqlnSDvOF5KC77
 9I1IXMqnLhPbb4DN7y2vDE9Sld6SRPoun81A6Xc=
X-Google-Smtp-Source: APXvYqycuilbOIFwHcvLzaU7giMAv7YuAF+TkxXbGTWGOoKzMtIm8vpFFXHUeCoUjzlwSH1+9EamvUC0+Fwi2W4oJC4=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr3683371lfq.5.1569373232985;
 Tue, 24 Sep 2019 18:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
 <16bab4bf-b91e-ef0c-2d22-53538f74cfc4@redhat.com>
In-Reply-To: <16bab4bf-b91e-ef0c-2d22-53538f74cfc4@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2019 17:55:50 -0700
Message-ID: <CAKmqyKNitR4YCLh1y8YThfVZqZj603pat3C=i=86Wx8=SWV3Wg@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 2:32 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 9/23/19 11:46 PM, Peter Maydell wrote:
> > On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> w=
rote:
> >> On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>> I don't think we should mirror what is used on ARM virt board to
> >>> create 2 flash for sifive_u. For ARM virt, there are 2 flashes becaus=
e
> >>> they need distinguish secure and non-secure. For sifive_u, only one i=
s
> >>> enough.
> >>
> >> I went back and forward about 1 or 2. Two seems more usable as maybe
> >> someone wants to include two pflash files? The Xilinx machine also has
> >> two so I'm kind of used to 2, but I'm not really fussed.
>
> The Xilinx machine has 2 because it matches the hardware.
>
> > One of the reasons for having 2 on the Arm board (we do this
> > even if we're not supporting secure vs non-secure) is that
> > then you can use one for a fixed read-only BIOS image (backed
> > by a file on the host filesystem shared between all VMs), and
> > one backed by a read-write per-VM file providing permanent
> > storage for BIOS environment variables. Notably UEFI likes to
> > work this way, but the idea applies in theory to other
> > boot loader or BIOSes I guess.
>
> IIRC Laszlo's explanation, the only reason it is that way is because the
> pflash_cfi01 model still doesn't implement sector locking. At the OVMF
> emerged from EDK2, to have a safe ROM vs DATA storage it was decided to
> use 2 different flashes.
> When I understood when this config layout started, I suggested Laszlo to
> use a real ROM to store the OVMF CODE since it is pointless to do
> firmware upgrade in virtualized environment, but he said it was too late
> to change the design.
>
> If you don't plan to run UEFI "Capsule Update" on your Virt board, I
> suggest using memory_region_init_rom() with your firmware CODE, and a
> parallel/SPI flash for the data VARStore.

We might run that one day, who knows :)

Alistair

>
> > I would suggest also checking with Markus that your code
> > for instantiating the flash devices follows the current
> > recommendations so the backing storage can be configured
> > via -blockdev. (This is a fairly recent change from June or
> > so; current-in-master virt and sbsa boards provide an example
> > of doing the right thing, I think.)
> >
> > thanks
> > -- PMM
> >

