Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1888C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC35420797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdHfuh/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35420797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3Iv-0005d4-OT
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kQ3HV-00053Q-EP; Wed, 07 Oct 2020 02:50:34 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kQ3HT-0005sZ-Dt; Wed, 07 Oct 2020 02:50:33 -0400
Received: by mail-il1-x141.google.com with SMTP id t12so1342893ilh.3;
 Tue, 06 Oct 2020 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K65nqW5b51X5LzxkVyAKNheO+CdmApsdfUMTcPTC+r4=;
 b=sdHfuh/3s6eK0ysaw8qKRu0w8+DjnoRyoM3/Vd6oKtmRARV33Hu47y7rq2RBlVOwGv
 xAngM+ALkkDZrilDmlR3yJsy9duNFb2b7r836y+Nk7LBGs0+x1hpTrYBc5TqVi4Le58n
 UIMllrHkdAr3IidXNVqhxGWoxxrQ/LS9otEHJ2IlR7TlneObln5uEUpo6zTtW0xYNkV4
 BQW2alOG4pAN1S4J/gMBxblx67I0xTtm5KTFpH6h3PAkgFtGOurlQUTnYOX2wQSECzXf
 yRlmrcUeRqaQz130CID6l1xQlHQr1AZZ7h5CAcl+XR862udeNPrT4LZJ1me8mjUenKPb
 s9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K65nqW5b51X5LzxkVyAKNheO+CdmApsdfUMTcPTC+r4=;
 b=ZKjMz0iDZPJ7ItJqUG6PgQvH8pamHdP1j9q0p54ATP1/x5pfDHVoQ9UEAdmhKqewRh
 Y85tlKDllGgCkNuAF+j+pjqtldI2mmj192Dpmey5gdnYcyfcZgcLcHi/9gCnNpwSB5Jp
 EjhO1z2b+Z4lAM+mEfD9qH7KmDo6l18a3rhg/Ok2pXj1j4g5AWTNt7ASeIaclioKoLlt
 ka5Ym2RioiMDbyIpRSfScUZXe8wcQlVaMZEnIn5vdu8SP+kA2ulgC6VW4hoGtWUibr2B
 FQedAJiOtTCOi0zB1ijozSNJaMuvVvejya+gpvcO4imn7G38HgEY7KzxPXSNfw0CU6L5
 7COg==
X-Gm-Message-State: AOAM532gyQ9yFSwNDIbuKzVrLA4jjdzX3S0Gxo1SWajsBoNsi+HZRJTz
 YhPscU3FYrE/Akv0DwUzrQgiBjJmgTOpReoziG8=
X-Google-Smtp-Source: ABdhPJw8CkUJFKjIe9mJWcgBgxiXlMYlOBGCLBHQttkveUP1AzZQFxtLeKPd+Yf96Zm8PxGr+JWpZ+UlbQ1dfQwohCQ=
X-Received: by 2002:a92:907:: with SMTP id y7mr1549294ilg.276.1602053428977;
 Tue, 06 Oct 2020 23:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com> <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
In-Reply-To: <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 6 Oct 2020 23:50:01 -0700
Message-ID: <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
To: Thomas <74cmonty@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 6, 2020 at 11:28 PM Thomas <74cmonty@gmail.com> wrote:
>
> Hello!
>
> Many thanks for your support.
>
> I managed to get emulated RPi starting.
>
> However there's one question I want to ask:
> How can I accelerate the startup sequence?
> I mean booting the emulated RPi takes more than 3 minutes.
>
> Regards
> Thomas

Get a faster computer? ;)

On my Intel i7 desktop it takes about 40 seconds to boot to the login:
prompt on the serial console, and about 1 min 8 seconds before the
GUI is up. On my 5 year old laptop it's probably twice that. I don't know
of any way to make it go faster.

- Paul

>
> Am 06.10.20 um 11:58 schrieb Alex Benn=C3=A9e:
> > Thomas Schneider <74cmonty@gmail.com> writes:
> >
> >> Hello Paul,
> >>
> >> many thanks for sharing this info.
> >>
> >> Can you confirm that the emulated RPi with your command will use
> >> "internal QEMU" network, means the client cannot be accessed from any
> >> other device in LAN?
> > The support for user-mode and TAP networking is orthogonal to the
> > emulated device. However if you only want a few ports it's quite easy t=
o
> > use port forwarding, e.g:
> >
> >   -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22
> >
> > which forwards 2222 to port 22 on the device. I have an alias in
> > .ssh/config for accessing my QEMU devices.
> >
> >> If yes, what is required to setup a TAP connected to host's network
> >> bridge?
> > I'll defer to others for this but generally when I want proper bridged
> > networking for a VM I use virt-manager/libvirt to configure it because
> > it can be quite fiddly to do by hand.
> >
>

