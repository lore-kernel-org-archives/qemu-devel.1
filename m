Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD87C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58F22B45
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLX3LtFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A58F22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2g7V-0007r0-Ml
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1k2g6f-0007Rf-42
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:26:45 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132]:39776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1k2g6c-0002kv-5s
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:26:44 -0400
Received: by mail-il1-x132.google.com with SMTP id z17so17010709ill.6
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yHVKzHFXa9jrRnMz2PvpKXx9/pDJ3BHkuUd4w/M2sIg=;
 b=vLX3LtFxFWdkbrM6FVpQdWhZ7JLEtGPow6FRt0cPZRoDuqNOol5ub91jKsjahjyvLZ
 9gakKAVOKCrNuXLcAz+3ngb2CY5KiYjPXLrm9lmjo85DXp3mOOWvgRCOPUtkdDJnc0Xi
 FaEn3Ji1QidV4m6qK8xav7Ak2aWwR7Erb8jqF3wAmYkj89ESLadNbQOeca0a63G/oBnw
 4LBEWpFkzKb8v6Ls6IByW4j2P0KH745aR2uqKCvRUWpaj0S19c7rgVdxhfmvlWCsdPTy
 oQuKFCXECnio9eDsPmp9f91I0dsPN2hdG3LLssTp6wX+xtnL7SGPvDr/ByNyJxoD0b1z
 bcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yHVKzHFXa9jrRnMz2PvpKXx9/pDJ3BHkuUd4w/M2sIg=;
 b=QVytAUF9V19Tym5GyvaUqMXPLqh2UfQu/TNoyWnRhHRcdOwz7NCo2O9+k8RkZYvdns
 AYUMPsI55T9+df+Ij3AGy5i0LyPRNXdxIls3+FqyvCBNjin0qGRn0K6USKZGBaJA0iTG
 Sea7npJQKNOgIbfURQX2TkSdL7QWqaYcbl/D6kVk/sglLd0LbdGGYbCSEUz0Rjlmm1Np
 EwQ4b/mIA4mkt5bxG0dbLwL41GzPpJoNjTny3Ym9uocOvaI6jjU08XMEm2J3OrOn9GV/
 JFR1CYt5VRY99K7BhnrJigo1Y3YKD9iss+OmM3+f3PHD4AUCL4OZ20IfW/I6rxGZXERX
 D2dg==
X-Gm-Message-State: AOAM5320KDvqp6Z5TjtyGYoVEwblpGnbg2IBgqHv6UdEy1yCW6DTO5Dh
 zJz4eiyoDwkAIJ2fp0w0dXYCOuEjiZcRP5iIQn0=
X-Google-Smtp-Source: ABdhPJz7H77rjP+9ntWVv8pKROdkcyzZj4PXgFW+wrp8M+/vNi2qEc8q1tG9vob29WxuhPS6eX2nlF283EgGBS64ekw=
X-Received: by 2002:a92:bac5:: with SMTP id t66mr933259ill.125.1596482801220; 
 Mon, 03 Aug 2020 12:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200710201911.3a3e336c.hc981@poolhem.se>
 <20200803192645.48513f57.hc981@poolhem.se>
 <43e05cbb-14aa-80ed-d39a-1456f2a0e480@redhat.com>
 <CACXAS8CkSX1knsStsL1azYQQFrbYV5ZXXOWm9bp_F-CU7ph=7w@mail.gmail.com>
 <20200803203632.76222bb1.hc981@poolhem.se>
In-Reply-To: <20200803203632.76222bb1.hc981@poolhem.se>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 3 Aug 2020 21:26:29 +0200
Message-ID: <CACXAS8CyRSTuerymwNdc0Y=N1dWcKWGXGCzkAGqyLO_tJa-jvw@mail.gmail.com>
Subject: Re: Ping: [PATCH] Emulate dip switch language layout settings on SUN
 keyboard
To: Henrik Carlqvist <hc981@poolhem.se>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=atar4qemu@gmail.com; helo=mail-il1-x132.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 8:36 PM Henrik Carlqvist <hc981@poolhem.se> wrote:
>
> Thanks for finding my typos!

:-)

> On Mon, 3 Aug 2020 20:16:43 +0200
> Artyom Tarasenko <atar4qemu@gmail.com> wrote:
>
> > > > On Fri, 10 Jul 2020 20:19:11 +0200
> > > > Henrik Carlqvist <hc981@poolhem.se> wrote:
> > > >> hardcoded to allways use an US keyboard layout.
>
> > Can you please move this description to the commit message? (Fixing
> > typo in "always" ;-) )
>
> I don't think I have access to push commits to the git repo, or did you mean
> that Paolo should make the commit?

I mean the part of the commit message before "From 2f86bd..." will be
lost after committing, and I would like to preserve the link to the
documentation and the invocation command.

>
> > >> Subject: [PATCH] Emulating sun keyboard languate layout dip switches,
>
> > typo: language
>
> > Looks good otherwise. For the v2:
> > Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
>
> Do you want me to post the same patch again to the mailing list with corrected
> typos in subject and description?
>

Yes, please.



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

