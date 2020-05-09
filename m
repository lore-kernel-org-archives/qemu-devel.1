Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760BC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099C1208CA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4uILE5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099C1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXOkj-00020N-6u
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 08:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jXOk5-0001JB-BB
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:38:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jXOk4-0007zl-EZ
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:38:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so12911124wmj.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nGp6fPGha/RBSFyW+ZcDgpnIeDPdxn8Z5p2SqFOLs/0=;
 b=l4uILE5/K7ZhaHwCO62GQXmB6ZCh7r+tDgYiMY2ALDyots9nRDe+a70rmFreF6wwkY
 Vh0mLPIOcS1E3KVxa7WN9dr2Hz1aflKKwafdw4b/p84zjr+Qk2hJ0OcXPSdZFJR4yBwt
 DhQL/QT8VLloSqjlMAmrYJPp8TvU9748wM0NhHc4DGDo9/8sNkYDHN4T3QTshPzVtw5n
 PvJLroQ+fjK879RqhZ1p2RMqHya2IZ+WdB9d7Ifc90kqdypx3exoD9xAlchqdtWyP4Q6
 OZDDsl14JtsUuTP42PQabpCbun8U/VH1TDf04PT5zieFJx585P0DVAYATvOYrcmewenR
 DLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nGp6fPGha/RBSFyW+ZcDgpnIeDPdxn8Z5p2SqFOLs/0=;
 b=bNuXOZ36PhGCAghE4lAnfGTH4R13BpR5TEKn6kR0A26wh372IP8Fgy4fGP4OcPBUcJ
 52fFHj21q6oCKb/WEq7XqY8ITycWCG+vo1zRrQkm9Zi9+/7YvCh93OWLvWOW20tVlmH4
 o86ncQRBBLZPuy4MznVcpHVkKD91qfij1IYlPIieq5JzDPDTHLGCFicAaObbUgeXD7J+
 EIAP/w5w7D39bLWiVkBde6qRmqz6mTSL5jLQ1WENx/2HmduFW4LlCir1SsUqHOj8Az6U
 2O+EljuxN8582HZwlDRZtVISvG6tDM1rRd9uZVukl9hMN+/OGgEwPTK8HA0IsxV+jATk
 ZOug==
X-Gm-Message-State: AGi0PubK9DOOHMp1mQ4CqLAuNaKRSgwfs0jdsGT8gMux0XEsSGq7NtNe
 hciVAOmWpUJWHBYHjGyXujUwvl3IUmsoXt9oOv0=
X-Google-Smtp-Source: APiQypJ8Jtoqfmkf4h77UZ032/Z4UE+pDiVwEZl3NxrkPGSV/dOgovS/unlKulbW/HhAnx6MacMvHfBTGd7N4o3cdME=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr23307990wmc.168.1589027886694; 
 Sat, 09 May 2020 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
 <87imh95mof.fsf@linaro.org>
 <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
 <CABoDooNCszaFGJz6nLWsNYDh1VJpDmMr+OJEfALYqHnoYgYsEA@mail.gmail.com>
In-Reply-To: <CABoDooNCszaFGJz6nLWsNYDh1VJpDmMr+OJEfALYqHnoYgYsEA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 9 May 2020 14:37:52 +0200
Message-ID: <CAHiYmc4ovS5B1ctaMpRGxtf3NzC64AzUAs-A5Of-A_cV7Lc1tw@mail.gmail.com>
Subject: Re: [INFO] Some preliminary performance data
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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

=D1=81=D1=83=D0=B1, 9. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:37 Laurent Desnog=
ues
<laurent.desnogues@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Sat, May 9, 2020 at 12:17 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >  =D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:26 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > > This is very much driven by how much code generation vs running you s=
ee.
> > > In most of my personal benchmarks I never really notice code generati=
on
> > > because I give my machines large amounts of RAM so code tends to stay
> > > resident so not need to be re-translated. When the optimiser shows up
> > > it's usually accompanied by high TB flush and invalidate counts in "i=
nfo
> > > jit" because we are doing more translation that we usually do.
> > >
> >
> > Yes, I think the machine was setup with only 128MB RAM.
> >
> > That would be an interesting experiment for Ahmed actually - to
> > measure impact of given RAM memory to performance.
> >
> > But it looks that at least for machines with small RAM, translation
> > phase will take significant percentage.
> >
> > I am attaching call graph for translation phase for "Hello World" built
> > for mips, and emulated by QEMU: *tb_gen_code() and its calees)
>

Hi, Laurent,

"Hello world" was taken as an example where code generation is
dominant. It was taken to illustrate how performance-wise code
generation overhead is distributed (illustrating dominance of a
single function).

While "Hello world" by itself is not a significant example, it conveys
a useful information: it says how much is the overhead of QEMU
linux-user executable initialization, and code generation spent on
emulation of loading target executable and printing a simple
message. This can be roughly deducted from the result for
a meaningful benchmark.

Booting of a virtual machine is a legitimate scenario for measuring
performance, and perhaps even attempting improving it.

Everything should be measured - code generation, JIT-ed code
execution, and helpers execution - in all cases, and checked
whether it departs from expected behavior.

Let's say that we emulate a benchmark that basically runs some
code in a loop, or an algorithm - one would expect that after a
while, while increasing number of iterations of the loop, or the
size of data in the algorithm, code generation becomes less and
less significant, converging to zero. Well, this should be confirmed
with an experiment, and not taken for granted.

I think limiting measurements only on, let's say, execution of
JIT-ed code (if that is what you implied) is a logical mistake.
The right conclusions should be drawn from the complete
picture, shouldn't it?

Yours,
Aleksandar

> Sorry if I'm stating the obvious but both "Hello World" and a
> Linux boot will exhibit similar behaviors with low reuse of
> translated blocks, which means translation will show up in
> profiles as a lot of time is spent in translating blocks that
> will run once.  If you push in that direction you might reach
> the conclusion that a non JIST simulator is faster than QEMU.
>
> You will have to carefully select the tests you run:  you need
> a large spectrum from Linux boot, "Hello World" up to synthetic
> benchmarks.
>
> Again sorry if that was too trivial :-)
>
> Laurent

