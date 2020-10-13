Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3512FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6107820708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrAyvVig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6107820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHIM-0000jy-F6
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSHGz-0008E3-QB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:11:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSHGx-0000nL-8m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:11:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so21162207wme.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sSe5wrRim20NdHE0LAnmpZEydwLu6yipm4oRcRMoQMk=;
 b=mrAyvVig8bLfpUfUJiK8dttcxKZNLLzcCHxdN869wNKJOzJEaJ+XaniiFheRL9FuQ9
 y6HHDP9AO3ouUWXF6ce4mFdhUKzkyXzI1Q036MuxRrLnwunML/V62E7qNWg8z7gATY9T
 3W7jpxpBkBamnG/OQcTsE/kj3dESE2tEv11ZsFao3npj0H7Nxn6MVhEpSrcRh40sfEM2
 ujhR93r+m8Ag0dCn3NxCUjQ2Q/BDUzU8Z/39qri2IMkP1RGZofaHUwYg42tzmAPe8Egg
 348bPiUoeOPcR3Q2Nd17tuHKdpbODf5Kq2+M2UG3Yf4mqcGv3S7OMGHNwX7gNzKGsJ+w
 1skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sSe5wrRim20NdHE0LAnmpZEydwLu6yipm4oRcRMoQMk=;
 b=fd4DgxVJJNwjPsdMwr2tQs1ZL5JEZNgXjqMGarOztWnSkBGc2G5Ek3hxAHzvRtxSIN
 YMo96fjRnOS/JRN0cqGFa0rnHu/60F8yLoZ7dAu7gJcT8YnjkLQ1OmV94UL2RXPm1tCQ
 zLhZp8qmb4FHZTdYupWP4LiTWnIHc1k4NORP1LgUQGDa6nKlmi5xbYffCrmzVbV7yw2h
 awjgGybO1+SbYvlXc7kks4qRnXJ+IOXflS59yLeJf944ZZnjHVKhlTLHg3Q/aMbQckgt
 lgKSdYzLp5K0rfWvSdeXsbKaicSv+m3/N3V0P83lJAGVDCmmV/f0ZLoQJBYEXkztqC33
 mbCw==
X-Gm-Message-State: AOAM531AOhg0XQxMmMEql0DJbOWcLDl6k8gWBq9vry3VTUzAy+d+bDI2
 QGXu4/rKgXW9VM7hEa5URGWQ1g==
X-Google-Smtp-Source: ABdhPJx/5TgcIQbuy3r4vhSXdjO4ibf35BXUB+xACQ6k7CODNN+F4YOzobmh4O7IplK/Ufec1FSsoA==
X-Received: by 2002:a1c:3285:: with SMTP id
 y127mr15533264wmy.183.1602583868229; 
 Tue, 13 Oct 2020 03:11:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm26066707wma.0.2020.10.13.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:11:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE48E1FF7E;
 Tue, 13 Oct 2020 11:11:05 +0100 (BST)
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
 <87lfgbzb2m.fsf@linaro.org> <20201012172556.GF2954729@toto>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
In-reply-to: <20201012172556.GF2954729@toto>
Date: Tue, 13 Oct 2020 11:11:05 +0100
Message-ID: <87a6wqzb9i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 takahiro.akashi@linaro.org, Alistair Francis <alistair23@gmail.com>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Edgar E. Iglesias <edgar.iglesias@gmail.com> writes:

> On Mon, Oct 12, 2020 at 05:02:57PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Alistair Francis <alistair23@gmail.com> writes:
>>=20
>> > On Fri, Oct 9, 2020 at 10:07 AM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
>> >>
>> >> Hi,
>> >>
>> >> This series adds the ability to append FDT data for blobs loaded by
>> >> the generic loader. My principle use-case was to be able to directly
>> >> boot Xen with a kernel image which avoided having to:
>> >>
>> >>   - get the kernel image into my system image
>> >>   - deal with bugs in FDT munging by -bios firmware and/or grub
<snip>
>> >> "Polluting" the generic loader arguments
>> >>
>> >> This was mainly out of convenience as the loader already knows the
>> >> size of the blob being loaded. However you could certainly argue it
>> >> makes sense to have a more generic "FDT expander" virtual device that
>> >> could for example query the QOM model somehow to find the details it
>> >> needs.
>> >
>> > That seems like a better option. Why not have a generic way to modify
>> > the device tree with a specific argument? It could either be -device
>> > loader,file=3Dfdt,... or -fdt ...
>>=20
>> Well it comes down to how much of a special case this is? Pretty much
>> all FDT (and ACPI for the matter) is basically down to the board level
>> models - and not all of them just the funky configurable ones. For other
>> board models we just expect the user to pass the FDT they got with their
>> kernel blob.
>>=20
>> For modern VirtIO systems the only thing you really need to expose is
>> the root PCI bus because the rest of the devices are discover-able
>> there.
>>=20
>> So the real question is are there any other -devices that we want to be
>> able to graft FDT entries on or is the generic loader enough of a
>> special case that we keep all the logic in there?
>>
>
> Hi,
>
> Another option is to allow the user to pass along a DTB overlay with the
> generic loader option (or with a separate option as Alistair suggested).
> With overlways we wouldn't need all the command-line options to enable
> construction of dtb fragments, it would be more or less transparent to
> QEMU. There may be limitations with the overlay flows that I'm not aware
> of though...

So the problem of adding DTB overlays is it's not that much easier than
the current options of using -machine dumpdtb and then hand hacking the
magic values and rebuilding, for example:

  https://medium.com/@denisobrezkov/xen-on-arm-and-qemu-1654f24dea75

Unless we come up with some sort of template support that allows QEMU to
insert numbers like address and size while processing the template. But
that seems a little too over engineered and likely introduces complexity
into the system.

Given the generic-loader is so simple I'm leaning towards another
approach of just c&p'ing generic-loader into a new "magic" device (maybe
guest-loader) and stripping out the bits we don't need (data, data-len,
be etc) and making the options more tuned what we are trying to achieve.
For example:

  -device guest-loader,kernel=3Dpath/to/Image,args=3D"command line",addr=3D=
0x47000000,hyp=3Dxen
  -device guest-loader,initrd=3Dpath/to/initrd,addr=3D0x42000000,hyp=3Dxen

And then we can embed the smarts in the loader to set either DTB or ACPI
entries as required and if we need additional magic to support different
hypervisors (which hopefully you don't but...) you can modulate the
hyp=3DFOO variable.

There may be an argument for having a -hypervisor as a sugar alias for
-kernel (which maps to machine.kernel) but currently I see no practical
differences you need to launch it except maybe forcing the
virtualisation property to true if it exists - but that seems a little
ARM focused.

--=20
Alex Benn=C3=A9e

