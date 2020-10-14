Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC5EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE2021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBHjjhHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSn0m-0005uC-Fh
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmz4-0004Ws-JN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:02:55 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmz2-0006kD-A9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:02:50 -0400
Received: by mail-il1-x143.google.com with SMTP id w17so814143ilg.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IsVclhuB3CcMv2K3r48JAMSmE9W74o6J2nFuIa+NoE4=;
 b=kBHjjhHd2c/4cdP0M0EsRmLGqcJbkb2e75HcayOhf9r7Wkw4Ioa51/EkyhmYwZR4QB
 kCyYI169+dA2lnhyb7hsDi9mnC5Nm83ml5jdYsyN/S+VKM7H/+dlc1u86zLA2KSoUR+n
 Mhtods8nT4Sw5Jl6PpyKhdbG84V61u5ndR6B4EyEd1Acfc6dMXAUpqY7/D5EN2AP7h8h
 7rNmczH2tmMUfEmlyijuZHEaa1JNYpyOC63Ugywak0/mxSL+lOm21StRhRaNBOsbip73
 7Sx2/jYqwuQ+wTQSpl+vYDv02yrt0U7ILA7121JewnusSkUjhpBbfX6ohopUG9kYP0ZH
 Z4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IsVclhuB3CcMv2K3r48JAMSmE9W74o6J2nFuIa+NoE4=;
 b=Cv5Jn5JgutSGLtwb9w5jML+7JSTTxbtpvebm4MT4VcUi8k8dF5XBjxtpqwAtWQHKaI
 yVvWBPdUmHiHJWon7bovz2Y+JfPalMHAhRYebjBgv7VGWRmTmK7tFH1OwiQens1u00Tj
 dut7bruVuUNuXTCHBqnhnMSAnGaBDUAzyU1mriIQWBYQD8jtf6Xc7zKX4dxigbtQVdad
 Q/n2varCZt8AZuIHqv1fZH5qoaEBCc/rdnHEF4diwjUZiOAqqYAD8mJLWhitZXduffpQ
 HEVQOLo86k18OBVz8aZeSV5T9jaxEah5WsvEJVetC5lIu30+CXDz8o3T0+5sODi9c2m/
 ZfCQ==
X-Gm-Message-State: AOAM533oycDMXT8qJQTcDIZQVm5yhGvO2DJhggvDzOMoD1ro5/fL4bXH
 nyNYnKG/67Ib1WcoIuRgkSPW5JMnuBJr+NkbbgY=
X-Google-Smtp-Source: ABdhPJwjl3UnOyLgM7BTr6v1WdIzJ3HXUnqJQHrcnBO59ZnQT4l5adwm5cCdRl4oBOYzCoUiIMwdZ8k/AD7xZUih3ig=
X-Received: by 2002:a05:6e02:1241:: with SMTP id
 j1mr697096ilq.267.1602705766852; 
 Wed, 14 Oct 2020 13:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
 <87lfgbzb2m.fsf@linaro.org> <20201012172556.GF2954729@toto>
 <87a6wqzb9i.fsf@linaro.org>
In-Reply-To: <87a6wqzb9i.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 12:51:08 -0700
Message-ID: <CAKmqyKP+8gFEpaWX5PWiuiK1O4FGmhoECj9QHid3JHhMtxZzeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: julien@xen.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 3:11 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Edgar E. Iglesias <edgar.iglesias@gmail.com> writes:
>
> > On Mon, Oct 12, 2020 at 05:02:57PM +0100, Alex Benn=C3=A9e wrote:
> >>
> >> Alistair Francis <alistair23@gmail.com> writes:
> >>
> >> > On Fri, Oct 9, 2020 at 10:07 AM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> This series adds the ability to append FDT data for blobs loaded by
> >> >> the generic loader. My principle use-case was to be able to directl=
y
> >> >> boot Xen with a kernel image which avoided having to:
> >> >>
> >> >>   - get the kernel image into my system image
> >> >>   - deal with bugs in FDT munging by -bios firmware and/or grub
> <snip>
> >> >> "Polluting" the generic loader arguments
> >> >>
> >> >> This was mainly out of convenience as the loader already knows the
> >> >> size of the blob being loaded. However you could certainly argue it
> >> >> makes sense to have a more generic "FDT expander" virtual device th=
at
> >> >> could for example query the QOM model somehow to find the details i=
t
> >> >> needs.
> >> >
> >> > That seems like a better option. Why not have a generic way to modif=
y
> >> > the device tree with a specific argument? It could either be -device
> >> > loader,file=3Dfdt,... or -fdt ...
> >>
> >> Well it comes down to how much of a special case this is? Pretty much
> >> all FDT (and ACPI for the matter) is basically down to the board level
> >> models - and not all of them just the funky configurable ones. For oth=
er
> >> board models we just expect the user to pass the FDT they got with the=
ir
> >> kernel blob.
> >>
> >> For modern VirtIO systems the only thing you really need to expose is
> >> the root PCI bus because the rest of the devices are discover-able
> >> there.
> >>
> >> So the real question is are there any other -devices that we want to b=
e
> >> able to graft FDT entries on or is the generic loader enough of a
> >> special case that we keep all the logic in there?
> >>
> >
> > Hi,
> >
> > Another option is to allow the user to pass along a DTB overlay with th=
e
> > generic loader option (or with a separate option as Alistair suggested)=
.
> > With overlways we wouldn't need all the command-line options to enable
> > construction of dtb fragments, it would be more or less transparent to
> > QEMU. There may be limitations with the overlay flows that I'm not awar=
e
> > of though...
>
> So the problem of adding DTB overlays is it's not that much easier than
> the current options of using -machine dumpdtb and then hand hacking the
> magic values and rebuilding, for example:

I agree with this. If a user is changing a DTB from a command line
they probably only want small changes and are unlikely to need the
full power of an overlay.

>
>   https://medium.com/@denisobrezkov/xen-on-arm-and-qemu-1654f24dea75
>
> Unless we come up with some sort of template support that allows QEMU to
> insert numbers like address and size while processing the template. But
> that seems a little too over engineered and likely introduces complexity
> into the system.

This though sounds interesting :)

>
> Given the generic-loader is so simple I'm leaning towards another
> approach of just c&p'ing generic-loader into a new "magic" device (maybe
> guest-loader) and stripping out the bits we don't need (data, data-len,
> be etc) and making the options more tuned what we are trying to achieve.
> For example:
>
>   -device guest-loader,kernel=3Dpath/to/Image,args=3D"command line",addr=
=3D0x47000000,hyp=3Dxen
>   -device guest-loader,initrd=3Dpath/to/initrd,addr=3D0x42000000,hyp=3Dxe=
n

At first I'm not thrilled of adding a new loader. In saying that,
there are lots of times where -kernel and friends doesn't do what I
want it to do and I have to fall back to the generic loader and code
changes to QEMU so maybe this is a good idea for image loading.

I'm guessing this would be the same for every platform which would be
a nice change from -kernel.

Alistair

>
> And then we can embed the smarts in the loader to set either DTB or ACPI
> entries as required and if we need additional magic to support different
> hypervisors (which hopefully you don't but...) you can modulate the
> hyp=3DFOO variable.
>
> There may be an argument for having a -hypervisor as a sugar alias for
> -kernel (which maps to machine.kernel) but currently I see no practical
> differences you need to launch it except maybe forcing the
> virtualisation property to true if it exists - but that seems a little
> ARM focused.
>
> --
> Alex Benn=C3=A9e

