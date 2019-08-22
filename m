Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E19321655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEm5RHs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E19321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vn0-0005Xx-RG
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i0vm1-0004gU-P6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i0vm0-0005mD-4I
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:41:41 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i0vlv-0005fk-S1; Thu, 22 Aug 2019 18:41:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id e27so7041684ljb.7;
 Thu, 22 Aug 2019 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k+7/+TSz1c2Nzi76RUXcfoz8jfFx9QVnpvMtgMDZcSE=;
 b=IEm5RHs2+DL+efy1MJCnasox8oAC1R0ihbGA6+NfKijVYXEzsRG8Io+AtmjUGi6dmp
 1/zjISxl7ou5e8+UeOwUeBLpbfPjDvVUG6Wf+fPSxbcSOnpg4NOpEQ2Qbxzl89CM1/B1
 jqRusBNPaYBm4bMU/uuU/mURaKNo/paSHwpzjoj9U/AUUOHT18z/afNun089adxO8UiR
 Qx5LgSuhXLsGbKLD/PFuUpAokLZh68+CwL7HY0UDRgqlDtrjrT/5HLk1gy6hTFEoofVs
 N8OD7lnr82GM66dkVXWy5zDB6N+dEceMkG1hl1I/7m152EZiQwTbg3SvKpRgSNHoTPKO
 wtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k+7/+TSz1c2Nzi76RUXcfoz8jfFx9QVnpvMtgMDZcSE=;
 b=QsiqIzW7ttWtrG88sVt/MUFRAXoQWuYPwhnYpSGQ8u/8BPdDg/5ZJyIcwqQJwaigBb
 98rXdpjrEVna1TzhitgoCKdXONiRfhxUnS/gcICvUINXeCtGXMGeKALHhbn38mVVJpIa
 6j5LGfGmxOo+LGMo84D/9pfuyn/28zAZpMzr/C4UAIN4DqgqKz3C29yZmBqtaMBPH6xr
 81+T6CvuXoBRvsdUqCeFE5La2nLNLfn6wW7rYh2/gKwYT895849cD5lU+KvaYinDEGHl
 ODVhcZLlsqiMAmWhAFI49ft8oRpfGJMmq3lRvaUtyywaP5QpwYE923/t75cQMxyy3+jK
 ZjgQ==
X-Gm-Message-State: APjAAAVi7VftMyGbqiz7xwSCDyhWAHIv9EOxV2Dg+Io1cQRo0o+Lob8i
 87hSaKooAZCfvXtlw4KR0lUjaiBaUcZcbHeadt4=
X-Google-Smtp-Source: APXvYqzFhGJMl0uGarsG2R7wvkqfahSBVRJiK5O0dv+IFrfmY7fwTfKd34cWq+ZjXr6QwzlXSfN4DR16sM2fC7xam0A=
X-Received: by 2002:a2e:8102:: with SMTP id d2mr965696ljg.58.1566513680994;
 Thu, 22 Aug 2019 15:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-04cdd93a-df3e-4de0-b1f5-0365f2be0fab@palmer-si-x1c4>
 <96d32c8a-a4a2-9e40-d5be-97a0617703ac@c-sky.com>
In-Reply-To: <96d32c8a-a4a2-9e40-d5be-97a0617703ac@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Aug 2019 15:37:15 -0700
Message-ID: <CAKmqyKNZsmN6WmHLH8kL85oGYe6eX_pPmUXqUMr8Avhs--TYbQ@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>, Jonathan Behrens <fintelia@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 6:56 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
> On 2019/8/22 =E4=B8=8A=E5=8D=883:31, Palmer Dabbelt wrote:
> > On Thu, 15 Aug 2019 14:37:52 PDT (-0700), alistair23@gmail.com wrote:
> >> On Thu, Aug 15, 2019 at 2:07 AM Peter Maydell
> >> <peter.maydell@linaro.org> wrote:
> >>>
> >>> On Thu, 15 Aug 2019 at 09:53, Aleksandar Markovic
> >>> <aleksandar.m.mail@gmail.com> wrote:
> >>> >
> >>> > > We can accept draft
> >>> > > extensions in QEMU as long as they are disabled by default.
> >>>
> >>> > Hi, Alistair, Palmer,
> >>> >
> >>> > Is this an official stance of QEMU community, or perhaps Alistair's
> >>> > personal judgement, or maybe a rule within risv subcomunity?
> >>>
> >>> Alistair asked on a previous thread; my view was:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03364.html
> >>> and nobody else spoke up disagreeing (summary: should at least be
> >>> disabled-by-default and only enabled by setting an explicit
> >>> property whose name should start with the 'x-' prefix).
> >>
> >> Agreed!
> >>
> >>>
> >>> In general QEMU does sometimes introduce experimental extensions
> >>> (we've had them in the block layer, for example) and so the 'x-'
> >>> property to enable them is a reasonably established convention.
> >>> I think it's a reasonable compromise to allow this sort of work
> >>> to start and not have to live out-of-tree for a long time, without
> >>> confusing users or getting into a situation where some QEMU
> >>> versions behave differently or to obsolete drafts of a spec
> >>> without it being clear from the command line that experimental
> >>> extensions are being enabled.
> >>>
> >>> There is also an element of "submaintainer judgement" to be applied
> >>> here -- upstream is probably not the place for a draft extension
> >>> to be implemented if it is:
> >>>  * still fast moving or subject to major changes of design direction
> >>>  * major changes to the codebase (especially if it requires
> >>>    changes to core code) that might later need to be redone
> >>>    entirely differently
> >>>  * still experimental
> >>
> >> Yep, agreed. For RISC-V I think this would extend to only allowing
> >> extensions that have backing from the foundation and are under active
> >> discussion.
> >
> > My general philosophy here is that we'll take anything written down in
> > an official RISC-V ISA manual (ie, the ones actually released by the
> > foundation).  This provides a single source of truth for what an
> > extension name / version means, which is important to avoid
> > confusion.  If it's a ratified extension then I see no reason not to
> > support it on my end.  For frozen extensions we should probably just
> > wait the 45 days until they go up for a ratification vote, but I'd be
> > happy to start reviewing patches then (or earlier :)).
> >
> > If the spec is a draft in the ISA manual then we need to worry about
> > the support burden, which I don't have a fixed criteria for --
> > generally there shouldn't be issues here, but early drafts can be in a
> > state where they're going to change extensively and are unlikely to be
> > used by anyone.  There's also the question of "what is an official
> > release of a draft specification?".
> > That's a bit awkward right now: the current ratified ISA manual
> > contains version 0.3 of the hypervisor extension, but I just talked to
> > Andrew and the plan is to remove the draft extensions from the
> > ratified manuals because these drafts are old and the official manuals
> > update slowly.  For now I guess we'll need an an-hoc way of
> > determining if a draft extension has been officially versioned or not,
> > which is a bit of a headache.
> >
> > We already have examples of supporting draft extensions, including
> > priv-1.9.1.  This does cause some pain for us on the QEMU side (CSR
> > bits have different semantics between the specs), but there's 1.9.1
> > hardware out there and the port continues to be useful so I'd be in
> > favor of keeping it around for now.  I suppose there is an implicit
> > risk that draft extensions will be deprecated, but the "x-" prefix,
> > draft status, and long deprecation period should be sufficient to
> > inform users of the risk.  I wouldn't be opposed to adding a "this is
> > a draft ISA" warning, but I feel like it might be a bit overkill.
> >
> Hi, Palmer
>
> Maybe it is the headache of open source hardware. Everyone cooperates to
> build a better architecture.
>
> In my opinion, we should focus on the future. The code in QEMU mainline
> should evolve to the  ratified extension step by step, and only support
> the best extension at last.
>
> At that time,  even many hardwares just support  the deprecated draft
> extension,  the draft codes should be in the wild and maintained by the
> hardware manufactures.
>
> But before that,  it is better to  have a draft implementation. So that
> We can work step by step to accelerate the coming of the ratified
> extension.
>
> Even at last draft extension implementation are deprecated, they are not
> meaningless. The manufactures may use  the  history commit to support
> their hardwares that
>
> only support drafted extension.

Overall I agree with Palmer that we should accept all extensions in
the RISC-V foundations ISA manual once the extension has reached some
level of maturity.

I think it then makes sense to only keep the latest version of these
drafts until they are ratified. At that point we do have to support
the ratified version for longer.

Alistair

>
> Best Regards,
>
> Zhiwei
>
> >>
> >> Alistair
> >>
> >>>
> >>> thanks
> >>> -- PMM
> >

