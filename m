Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD33C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6CE2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqKOQdjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6CE2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIcQ-0000pO-7K
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jqIbT-00080Z-95; Tue, 30 Jun 2020 11:55:23 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jqIbR-00078I-Kn; Tue, 30 Jun 2020 11:55:22 -0400
Received: by mail-ej1-x643.google.com with SMTP id n26so7230556ejx.0;
 Tue, 30 Jun 2020 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=etBpffCKQSmPKqrcY2CSes+qNsgtWnbyzT0LnHfFSBw=;
 b=JqKOQdjzrYgdtPqwXKCDoDKiTDfyJ5LKCSD0osiI+X2IKTvgmt3OTFJS2/GobZOR70
 tg7W+/Rfr8Zmv64T7NtINvVfK+V0RFXTBU7daLMODoYqa1TIGtgoWOBdWj4PSb0oyzWc
 YtADyAwqtpNmXdd3tNYNi0sLmwEJygXA++PjVpraO2dFemrnujVgDqVdnbF4XN8voW79
 2ogclAcOhAruLrC8OZujVmCGXIfag6p5ltCT2+YkMVIeaug7/6J4XWPiSyWltBlJ5eDI
 s9XskEMvKQBHoDeDL7QVajDMbQeReE8/LUUSHA/FKc4bW3YFaG2CiYUZdibnHoKQSNBR
 KQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=etBpffCKQSmPKqrcY2CSes+qNsgtWnbyzT0LnHfFSBw=;
 b=qQ7iOhNd9SPMbJ2R9StGNxqL/UAKKGpGHuD/Z8zcwqWHf0agkxY3kw04eJ35s+7o+g
 F9qwcXCQrDZZxRpBKs/MQqbUTEZX/gH9yZgqsyvmqfv/YwdhiqAICV4uaGwmaaSDQ7vM
 PkeqJsxHWTDKNOU6dtJTkZrlmTDdYJmghW8ElspwVqflHATbxj44DB58bKRA8QgFdGRO
 z8NgQcZtqL4STZ81NTN7wTmY0KQMsQbz/pOPiiaISoC0bY1UtLmHeR57XdFoDsIrouvC
 ir/0nm28JHhyQa6dt7aU/i4mxlhPNhzx2cBVb6Jup5KtENzjMPKYtWC1WkRdgDLIEQd4
 0XVw==
X-Gm-Message-State: AOAM5319a/l8Mr6I0MsZn7A2KBe+SzK2FMu657bGLB/bnm8LbCua/JCR
 CaeYvE8t6M6bOaEOL49YwIdp87KpRCLgZZEunm8=
X-Google-Smtp-Source: ABdhPJzb7TLHXgrnRsu7Nn7Y2sqJoFxVfF5X7Bd8x8JYMdLzPpudp0N3ihTeKVV8JLYfma34it00NR9HU7qCiJyo2sw=
X-Received: by 2002:a17:906:9244:: with SMTP id
 c4mr18562169ejx.60.1593532519395; 
 Tue, 30 Jun 2020 08:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
 <a482bd09-28c8-7de7-de06-dba60d1c8160@redhat.com>
 <20200630154825.k7ut6m3trfhwlmas@sirius.home.kraxel.org>
In-Reply-To: <20200630154825.k7ut6m3trfhwlmas@sirius.home.kraxel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 30 Jun 2020 16:55:08 +0100
Message-ID: <CA+XhMqyANFyTxm8j_1hyLskeA1inDBCtpf3iR5sNR1PTwDUt1g@mail.gmail.com>
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1/ It does not compile on Haiku has dirent does not contain d_type
field (among other things).
2/ does not support drm anyway.
3/ Haiku is less portable than a illumos or NetBSD system, even with
the BSD compatibility layer.

On Tue, 30 Jun 2020 at 16:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Jun 30, 2020 at 10:46:59AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 6/30/20 10:23 AM, Gerd Hoffmann wrote:
> > > On Tue, Jun 30, 2020 at 08:44:24AM +0200, Philippe Mathieu-Daud=C3=83=
=C2=A9 wrote:
> > >> +Gerd
> > >>
> > >> On 6/29/20 11:48 PM, David CARLIER wrote:
> > >>> From 157a0374093371719de42e99364352d64190f52a Mon Sep 17 00:00:00 2=
001
> > >>> From: David Carlier <devnexen@gmail.com>
> > >>> Date: Mon, 29 Jun 2020 22:20:06 +0000
> > >>> Subject: [PATCH 7/9] Skipping drm build, unsupported.
> > >
> > > --verbose please.
> >
> > David has difficulties understanding how to send patches,
> > so you missed the cover/context. This is for the Haiku OS
> > which apparently is POSIX.1-2001 compatible.
>
> That doesn't explain why he thinks this patch is needed.
> It should build just fine on Haiku ...
>
> take care,
>   Gerd
>

