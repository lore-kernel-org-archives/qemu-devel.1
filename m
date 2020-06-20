Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F1C23C8D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdky9vbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F1C23C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmfJT-0001Hk-EM
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 11:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmfIj-00080Y-UD
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:21:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmfIi-0002fe-52
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 11:21:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id z13so640409wrw.5
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cp8yjQty0CYXjDEf32CauBLvI2lQ5+q1uWNFlIGopBQ=;
 b=vdky9vbzqa2cK6QE65vpL4VlWpUaKrzTTfQr0W193swx76YipUkUyb65Y50cN6vOMZ
 2wvaQFQx4s8NAw/EDVl0W3ZwB+n/2iIboqCh3tF3Ch6YH7+XaOaDRZwKKD4OfHU7kNXR
 4YM2EITKWSAdlYp5yuYy4BDVNSLkZYNAo915JHj2oU+CF6w3mk2Z1Vkak/pq1dTJpHN6
 6N7EuThUDM1X+k7NMSRfWJIiCRgHp/ot0F4mEYb/65XWyv61DkxaG1sjj7/1aGQwpK5w
 TDI/hRbmHaNjsV4cBSCj34C3VfXD6k2x+vDUrh6kdNQaVspfH/MDLfBO6b5B+d9W58cD
 m23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cp8yjQty0CYXjDEf32CauBLvI2lQ5+q1uWNFlIGopBQ=;
 b=BEkvJ6UzF4QQbyWvGjUBEI2Y1MoFlWTJvSa52uj15aOVqpewJumYsRWvpkgxJNbzTN
 qf+uoiuAG6NYy0NqgdFUbcUB47dtXKacraNtRA7LdKmyIH3Lt7RCSbGW9kG2j/I/6DUq
 6ZgDbrv1tkW/zFXhBzm4/bJdxDJX7bXBWKTrs5XZZyGGQrHoBaWQ0XgypsreM7C2bUwu
 nqC1QZXe5QAx6O6ZBAG3y6dNm4nnSnif+nZEvb/cEMT8AWH0pC7ijWJiqG7KIkPbG8Zp
 FmjDl/qZuUDpcasnCEETzbFRdLetySWlnd1Ub9F9QFaLceC+ntUYwWo7BNNY8dky7aM5
 9dCg==
X-Gm-Message-State: AOAM533z7wmCctvqWcoxFslakCiQqbMu6uEHkDW5/7zVg2x6XN03LvaE
 8NDxnoZgSbj/sU4NVUCjjLjZYbHxl3Q515+zqio=
X-Google-Smtp-Source: ABdhPJzjP013Sli/A3frcqVlumAgp7lZVuykjq5sGQzuo9+lSHNTOv0oVJLSaHpUdwl/wEaoyKRA6LDd7Ib2xp6yB08=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr9559937wrq.420.1592666458501; 
 Sat, 20 Jun 2020 08:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA9C+cJ_2DdNQBckNZJEZXiG4jNPsE1HSh9bU5AOrOGMCQ@mail.gmail.com>
 <CAHiYmc5XehmzTB953JP85zTxoqVJX7Hbuak3W0m0QrB2HsQrVw@mail.gmail.com>
In-Reply-To: <CAHiYmc5XehmzTB953JP85zTxoqVJX7Hbuak3W0m0QrB2HsQrVw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 20 Jun 2020 17:20:41 +0200
Message-ID: <CAHiYmc6yuh=dExQKMsn9tfp0BAvS4LaxWCcAu1Lq6bYLE6CJXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] checkpatch: Do appropriate kernel->qemu renaming
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=83=D0=B1, 20. =D1=98=D1=83=D0=BD 2020. =D1=83 17:09 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=81=D1=83=D0=B1, 20. =D1=98=D1=83=D0=BD 2020. =D1=83 16:25 Peter Mayde=
ll <peter.maydell@linaro.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On Sat, 20 Jun 2020 at 14:33, Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> > > There are several places where 'kernel' is mentioned instead of
> > > 'qemu' in checkpatch.pl.
> > >
> > > This small series corrects this.
> >
> > So, the thing about this kind of change is that it's implicitly saying =
"we have
> > forked checkpatch and will not try to update to newer versions of it fr=
om
> > the kernel tree", because this sort of no-behavioural-change tends to
> > get in the way of that kind of update by obscuring the delta between
> > the kernel version and ours. Effectively I think we *have* ended up
> > with our own fork,
> > simply because we haven't cared to do that kind of update from the kern=
el's
> > version and we've gradually added our own changes to our copy. But it s=
eems
> > like it's worth discussing the general principle.
> >
>
> I do not say (explicitly or implicitly) that we should or should not
> follow and attempt to mirror changes in checkpatch.pl from kernel. (In
> fact, I think we should.)
>
> However, I don't think that several differences (in this series, I
> thinks altogether 7 lines) that would originate from difference of
> names QEMU vs. kernel would not be any significant obstacle for a
> potential future attempts to do comparison QEMU checkpatch vs kernel
> chekpatch.
>

Sorry, I meant to say:

However, I don't think that several differences (in this series, I
think, altogether 7 lines) that would originate from difference of
names (QEMU vs. kernel) would be any significant obstacle for a
potential future attempts to do comparison QEMU checkpatch vs kernel
checkpatch.



> Take a look at two versions of top_of_kernel_tree below - they already
> differ in their body. Left this way, QEMU's checkpatch version simply
> violates basic naming principles in software development. And, it
> looks we want to sacrifice the principle - just for the sake of
> convenience of a potential engineer having 7 less line in his diff
> (out of much more).
>
> I don't insist on these two patches. I, of course, leave the decision
> to Peter, Paolo, Stefan, Michael, or others tracking kernel's
> checkpatch script.
>
> Thanks,
> Aleksandar
>
> QEMU version:
>
> sub top_of_kernel_tree {
> my ($root) =3D @_;
>
> my @tree_check =3D (
> "COPYING", "MAINTAINERS", "Makefile",
> "README.rst", "docs", "VERSION",
> "linux-user", "softmmu"
> );
>
> foreach my $check (@tree_check) {
> if (! -e $root . '/' . $check) {
> return 0;
> }
> }
> return 1;
> }
>
> Kernel version:
>
> sub top_of_kernel_tree {
> my ($root) =3D @_;
>
> my @tree_check =3D (
> "COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
> "README", "Documentation", "arch", "include", "drivers",
> "fs", "init", "ipc", "kernel", "lib", "scripts",
> );
>
> foreach my $check (@tree_check) {
> if (! -e $root . '/' . $check) {
> return 0;
> }
> }
> return 1;
> }
>
> > thanks
> > -- PMM

