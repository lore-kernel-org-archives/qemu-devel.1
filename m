Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA8C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 11:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E17A218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 11:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f43cpACl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E17A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXNne-0003OA-Qh
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 07:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jXNn0-0002gS-QF
 for qemu-devel@nongnu.org; Sat, 09 May 2020 07:37:06 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jXNmz-0007J8-Ub
 for qemu-devel@nongnu.org; Sat, 09 May 2020 07:37:06 -0400
Received: by mail-io1-xd42.google.com with SMTP id i19so4461585ioh.12
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OI6O9ALXdX2bCjIbCg+TUOTJKJ3tbYGpYUkMSDQuhSM=;
 b=f43cpAClxuhTOXwYu7bKHIQcCTYflhhrp48j62tKHF+2FnJzlnned0/d2koCNCT7cq
 BDBSDgOmwCkItI9b9aWqbEUjXW71FsjAvNQnB9RkCx1cKxw3Bl8jX1F1TA5rKy+XJMrc
 bmV7u1nQ1CJpR6CGC3SC2qD2DgeyKDwjlap45HovS7rjhVjgZ3xdS1WmugJgwv118z/d
 q/eN0erDINytqQjLzI5hUEwQatqZM+S9jBo+IqT3cZA2FTP8UyZOlYbyR+bcVAg3xBmn
 SM0MumOAJa3Sdjc70/5DMlg1dunOhFrNgBjmM9XgPewzs0A3iuKp+fHDuQwlcaSSnGI6
 +DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OI6O9ALXdX2bCjIbCg+TUOTJKJ3tbYGpYUkMSDQuhSM=;
 b=E5EzU0lKoH47wWIeCI7RHbBbIcKvsRVmQtUndDxpEwA318+v9x2nBM300JtBeZY9WH
 159Iiu+SELnZhKvR5t8gZuG0abdchdto9gzjVBoOs01cE9GIgLLC2c9+mciapubxR2q4
 bKBRijFONGW9XZFrJG8p8qDCPiyuspoZZgXnN6P/8LEPHSSNfPuApIzBXt9+QSkRGYI9
 /iPcJ0fu6UjU1frQGsjy6i3XECLGP91AZyGmxVU/sVyLqXieFmXLDlXPVHhuCHUtXLyd
 xpQU3oNaQs+XHEdOCo0JiMaMV4XE78yL87zzjgNQXC07dtj4uuzbTm6cKfr7Fp2n+z5g
 fpUQ==
X-Gm-Message-State: AGi0PuYwrMU6Cl4AZtePUXEOq6yrzotxSPSIvs6Q43SQakTUHSID5snt
 fFNbBU5ghqviFiIBBNewp66ogm50W/gx5WK4J50=
X-Google-Smtp-Source: APiQypKIRj2+vWEkSpPlI0HmoixL80AFVTl5NmFCmVJvcV/badttU5B2sXrgrEC4i4N5UmZSeuMS47tODq6H5XX8jjA=
X-Received: by 2002:a02:2a47:: with SMTP id w68mr6796705jaw.76.1589024224421; 
 Sat, 09 May 2020 04:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
 <87imh95mof.fsf@linaro.org>
 <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
In-Reply-To: <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 9 May 2020 13:36:53 +0200
Message-ID: <CABoDooNCszaFGJz6nLWsNYDh1VJpDmMr+OJEfALYqHnoYgYsEA@mail.gmail.com>
Subject: Re: [INFO] Some preliminary performance data
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ahmedkhaledkaraman@gmail.com,
 "Emilio G . Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 12:17 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>  =D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:26 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> > This is very much driven by how much code generation vs running you see=
.
> > In most of my personal benchmarks I never really notice code generation
> > because I give my machines large amounts of RAM so code tends to stay
> > resident so not need to be re-translated. When the optimiser shows up
> > it's usually accompanied by high TB flush and invalidate counts in "inf=
o
> > jit" because we are doing more translation that we usually do.
> >
>
> Yes, I think the machine was setup with only 128MB RAM.
>
> That would be an interesting experiment for Ahmed actually - to
> measure impact of given RAM memory to performance.
>
> But it looks that at least for machines with small RAM, translation
> phase will take significant percentage.
>
> I am attaching call graph for translation phase for "Hello World" built
> for mips, and emulated by QEMU: *tb_gen_code() and its calees)

Sorry if I'm stating the obvious but both "Hello World" and a
Linux boot will exhibit similar behaviors with low reuse of
translated blocks, which means translation will show up in
profiles as a lot of time is spent in translating blocks that
will run once.  If you push in that direction you might reach
the conclusion that a non JIST simulator is faster than QEMU.

You will have to carefully select the tests you run:  you need
a large spectrum from Linux boot, "Hello World" up to synthetic
benchmarks.

Again sorry if that was too trivial :-)

Laurent

