Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8FD222B9
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vk+vq6Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8FD222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48487 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7Pf-0005T6-QB
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7Mj-0002VI-Bo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX7Mi-0002Mp-4e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:32:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX7Mh-0002MW-Sr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:32:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id d22so12760191oic.7
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uGZ209V/4VBhCA0wFn9wY0wY0qbDWQuHpGPekvq+T2I=;
 b=Vk+vq6XrpiP713LCrqyzXM1v44TKwQOybLOXnApM1BPqhXot2R/UequZG3ZaFOVzbi
 ZDpZDhGQW/4tYHfNYATSICBUmS9P2GUSXN/a3o3PJlXIovlg2iY4EA1cxKxyOOmXmrqo
 u76Lc5gj/7NN4w1o8kWH410s7f1kb3XUl9oVnX9qWUglkn4kRBgVsRzuCy6LtryPRNJx
 tpEchdAiSKfSr5rO40vZ4j4lWzTAxgtXkN09eoXVbHG7dZ8GybXPe7n/QALyR55vcskp
 xpVtoR9Xx1jXYDsL07ydO8WYaiF+PgdG9z9YESjSlWaVUYYSTlcVTR5BGqKiqObsiFZb
 qUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uGZ209V/4VBhCA0wFn9wY0wY0qbDWQuHpGPekvq+T2I=;
 b=NGBz5oLcsbf8vr0jER/O6pnzUJpLunbiX955UquaPPpxcb+R9ZYTsar3FP5pcTBX7t
 uuf+Nz2kvuPTacBc5CY5+ZoGQfVU/cL8wbSiP7hhQ951+HYkNOSTptgvHP5rNfsFMzB2
 lfE3xTuH1UyXukAtkLYRhQo/ZqRemOJBiG2TRt8fybqVYZtaw1aRzZKPClELx/mjhHpv
 Q3+zg7CrIiIDbhQWkNKTlWOE+FfACJj/t1Z2W3EuJwvh3HmuvisyeGE0qEUtwB1dh8u8
 E3LlziUAXjcPNkc4ur+v+YykbJev1F1UjwMs6zhL4jIyGYWXEoL1bJuwnMPzTJuPYkzh
 X2ig==
X-Gm-Message-State: APjAAAUhWmcu5H2wRrihiYk64FZWmQLEXo6pfFTGxK0thd4qErBqyHrh
 uw7KOLk/HmZjfVeWUKVWywFMjm4tNaBXEkLd2mug7w==
X-Google-Smtp-Source: APXvYqy1hKDC74SJiPnwBqVILfhoSUs2rg23045PSuejfbXO2s82uvk1ODvQYPSVnJvMdaIv3x/y1aLWkT1a/8zrjR0=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr5014672oie.146.1574184754984; 
 Tue, 19 Nov 2019 09:32:34 -0800 (PST)
MIME-Version: 1.0
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 17:32:23 +0000
Message-ID: <CAFEAcA8ZADX2KyTii0Pmgc0jtnvV0pac_NyB31-vvvdC=FJLzQ@mail.gmail.com>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 17:23, Taylor Simpson <tsimpson@quicinc.com> wrote:
> - Laurent suggested I split the patch into two parts: linux-user and targ=
et/hexagon.  If I do that, which one should contain the changes to common f=
iles (e.g., configure)?  Also, note that we won't be able to build until bo=
th patches are merged.  Is that OK?

Rule of thumb -- patches should generally be 200 lines
or less (less is good!), with exceptions where something
is very mechanical/repetitive and there's no point
splitting it up (eg there's no need to have the new
syscall_nr.h additions split into multiple patches).
Judging purely by the "2184 insertions" summary you
should probably be looking to split this into somewhere
between 5 and 10 patches, where each patch is a coherent
chunk with a commit message describing it.

Typically a new port is a complete patchset consisting
of multiple patches which are intended to be applied in
sequence. (They should be sent to the mailing list so
they appear as a cover letter plus a set of patch
emails each of which is a follow-up/reply to the cover
letter. git-send-email can do this kind of thing for you.)

The requirement for a patch series like that is that
at each intermediate point QEMU should still build
and pass 'make check'; but the new port will obviously
not be completely functional until all the parts are
present. You can probably look at how the initial
commits for various other recent ports were structured
to see the general idea.

thanks
-- PMM

