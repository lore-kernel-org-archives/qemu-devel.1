Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97971C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F380206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcIuGLDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F380206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvyja-0001wo-Lh
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvyit-0001LE-Ri; Thu, 16 Jul 2020 03:54:31 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvyis-0003Xh-5b; Thu, 16 Jul 2020 03:54:31 -0400
Received: by mail-il1-x143.google.com with SMTP id t4so4286119iln.1;
 Thu, 16 Jul 2020 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xUcuCANla6QWG55l5nrD61xLU5a8E+PWSqV3G7mO+Gc=;
 b=pcIuGLDRN0pEGipMQJtI2jVkys5Tut7LTuTxSiSl6kxuZUyS606+WIzHNVLCaLUcJs
 ZATqztRQH+YfRqEQIH/zkMVw/w5SFK/clCY25FbbciDhDbi6cwrDCBjzipb347HXiYvZ
 g8vp4hyFfbg+ItPmDpgPUHQ1FntCGS9kxKi2nRMVHosnHAe0HePFb1PphGSZ54jt3cpy
 pJ2eTx4zuQpnJLdun1JoZEXwm8Vczmg1A09TK8BHsOb9JDf7ysZPWqdJmC+6nTadMT0J
 l7stYaSKWKS39EMV8icx1A/WHjjlZ0w4/NdtkROM3fzXOsVQ//QbSsvzOghezKx3JsA8
 OiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xUcuCANla6QWG55l5nrD61xLU5a8E+PWSqV3G7mO+Gc=;
 b=njWXXjZEyGiafzxAawgV9p8XA93Mh0TL3kCnXSVjC0mXHzjcGK56IMSubpkqxumuxK
 JadtgSQtrrhwC3HvVdvFiyfeRV8RsjTlvJmQJrXP12iANgrevctarjNoSRm+AjO2guj/
 kM7gURo69KprdQwXnsKE5lqmPnSjZHSw6ImoilS4VsOAp3V1jrWOhtTzes8Jm01bZeJG
 lZEzIktlE7jlHVpziaTwZjpcwu7ekoV7mtktOsnzRXy1UGXZH0eqwYZxtlCR58cZVG4l
 MZJqESEVqHVaiOB2G5CN4aX7+O/3Ou4gspn02IZAP4EmzqrJxgClZ2CGOU3RT3PD7gug
 voCw==
X-Gm-Message-State: AOAM5317dZ8RyfMG4ihMWxCuUC5MhtvAeYTLNQxFmwVQSKKz+L6nDMIi
 CEvquHLT5RVNyafmwPDQaT8ywGRVdlk48q1WR0U=
X-Google-Smtp-Source: ABdhPJzxqDj/FjjQFkFYOp4RfBWCS1mkZrhmiYUxwpAmQ8iEJekAdFLyOH7c6x1FOOeNDw8dE7uwgIDn9KvbMs2vY+k=
X-Received: by 2002:a05:6e02:128d:: with SMTP id
 y13mr3315673ilq.305.1594886068312; 
 Thu, 16 Jul 2020 00:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
 <ef1d7fe4-0558-cc7b-16d7-906c4aa9915b@amsat.org>
 <87wo34u9fv.fsf@dusky.pond.sub.org>
 <CALHRZurw_HsyFmNWYuG_Cagx8cTTBCGzafWmx6JHJ+NS7aVKOw@mail.gmail.com>
 <9b3f870c-481f-79f1-e55e-074ee0d95633@redhat.com>
 <4e08aa92-0db0-1a09-0716-5f5ff896910d@amsat.org>
In-Reply-To: <4e08aa92-0db0-1a09-0716-5f5ff896910d@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 16 Jul 2020 13:24:16 +0530
Message-ID: <CALHRZuo_T5ZVS32M8jukdu6iqxsSf=apXi=dS8y-vY1u=kuWOg@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=sundeep.lkml@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, nieklinnenbank@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yep I will rework on this soon.

Thanks guys,
Sundeep

On Thu, Jul 16, 2020 at 1:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/16/20 8:07 AM, Thomas Huth wrote:
> > On 16/07/2020 04.59, sundeep subbaraya wrote:
> >> On Wed, Jul 15, 2020 at 8:12 PM Markus Armbruster <armbru@redhat.com> =
wrote:
> >>>
> >>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
> >>>
> >>>> On 7/15/20 4:04 PM, Markus Armbruster wrote:
> >>>>> Watch this:
> >>>>>
> >>>>>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdi=
o
> >>>>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major":=
 5}, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
> >>>>>     {"execute": "qmp_capabilities"}
> >>>>>     {"return": {}}
> >>>>>     {"execute": "device-list-properties", "arguments": {"typename":=
 "msf2-soc"}}
> >>>>>     Unsupported NIC model: ftgmac100
> >>>>>     armbru@dusky:~/work/images$ echo $?
> >>>>>     1
> >>>>>
> >>>>> This is what breaks "make check SPEED=3Dslow".
> >>>>>
> >>>>> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
> >>>>> qemu_check_nic_model().  That's wrong.
> >>>>>
> >>>>> We fixed the exact same bug for device "allwinner-a10" in commit
> >>>>> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_i=
nit
> >>>>> function".  Fix this instance the same way: move the offending code=
 to
> >>>>> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME commen=
t.
> >>>>
> >>>> That addresses this other thread, right?
> >>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720658.html
> >>>
> >>> Correct!  I wasn't aware of it, thanks for making the connection.
> >>>
> >>
> >> Thanks Markus for the fix.
> >
> > It's rather just a work-around that avoids the crash than a real fix. I
> > think we can use it for the upcoming 5.1 release, but it would be great
> > if you could rework this code for 5.2, so that the nd_table handling is
> > moved to msf2-som.c instead.
>
> Yes this is not a 'fix' but rather a kludge.
> Thomas gave some tips to work on a fix here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720658.html
>
> Thanks,
>
> Phil.

