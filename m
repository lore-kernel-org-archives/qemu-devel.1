Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA89206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVVv2dLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA89206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd0X-0000Cw-Hg
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVcy9-0005Im-OY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:25:21 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:40859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVcy8-0002ZP-Hk
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:25:21 -0400
Received: by mail-ot1-x335.google.com with SMTP id i27so9189673ota.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B3bAFYIgqzE1Vt0R1RjY4ZCOcoIRnSwFclvtMowDTHY=;
 b=QVVv2dLe37JKP5cvEM9Fv0rk/r3aM0r/F5xE9L48p/wzB6ptzhOwXEQXOeSiVYYLfy
 NHgLsa2CsrIrNWnq7GAPf2Z5o86qLmu7aaUMosGZFlpGVajhHBIcAxtGSrMs8q51Iwuj
 Zr3CjKPd8MlF82IJ/mKzkREqbz7iGqgd74D7Orx/DgcYjXCJwhTCKLqUvqLQdTIs3hFx
 q2XaxkW9Gof+ES9ViIGb9p0uRtDok4nS51r8JAbBEMM/K8MgQri7JDKtx8jyn0yLTYow
 q9HneBzHSrLmLVB0RnAC7IGeunOc9VXPM6HARqKQUQX4FUuYMBTqTz26jt2zEBzsfMVJ
 ddbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B3bAFYIgqzE1Vt0R1RjY4ZCOcoIRnSwFclvtMowDTHY=;
 b=dOHR98l4A28ZxQfrw2O/x7wulmGJEYJXvCdHJzO+WjLzFvRwu7X4B4uw7U9p1HhtOT
 jjOdf64C6h5eL0ky3TeeDLiUC9KGigKI7HxqewBLIoFWWjT7tk+qVqUV6FruxAxH5dAZ
 CfKuUaqKQVj6JsKddzDNtshd1us6Je09IxTMbaNib487F2VZTCv9po6z93Z/XxoyzULq
 5DLI4bJpPaYuIIaMuuY+r7rcp27QqBuL6hMVGpJdu7tiWw0+XcJISAkoWL98z2Wk4uy7
 ilF/+SfOa/t1+byUWLifSlTGmqngW5pmf3TKRHkP8V0sO7QyY/vBofiRAvDqvq+xqMyN
 lMww==
X-Gm-Message-State: AGi0Pua3fx/qeG1dCs1TcHWgtkC52EhFbzUJvQMUpA9S5dnz1V39jCNc
 SjSz6s0YzN1ihe2qgpw1l1urTf4Bs/bHtMuv5bRE9A==
X-Google-Smtp-Source: APiQypJuwdV1/hdZCnxRACVFl8g6xqV1odiw3sJsFNpULaIZ2tXwvNXxqKXOk47coXmpcqYaL12CMYpEonCAWRtF63E=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr13930621otc.221.1588605917845; 
 Mon, 04 May 2020 08:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
In-Reply-To: <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 16:25:06 +0100
Message-ID: <CAFEAcA9jL4oLE7AHsue_taDQjMCne6atVPycLN2gOovRm82p7A@mail.gmail.com>
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 16:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/05/20 16:38, Markus Armbruster wrote:
> > makes no progreess because OBJECT(dev)->parent is still null, and
> > therefore object_unparent() does nothing.
> >
> > Possible culprit: qdev_try_create() calls qdev_set_parent_bus(), which
> > adds the device to the bus, but leaves ->parent null.  If this isn't
> > wrong outright, it's at least a dangerous state.
> >
> > Work-around: call qdev_set_id(dev, NULL) right after qdev_create().
> > This sets ->parent.
>
> That's a good one, and especially a safe one, since it matches
> qdev_device_add.  It has the disadvantage of having to touch all
> qdev_create() calls.

qdev_create() is supposed to be a "board code etc uses this to
create devices" function; I don't think we should impose extra
usage requirements like "you must immediately afterwards call this
function you weren't calling before". If qdev_set_id() needs to
be called, why not call it inside qdev_create() ?

thanks
-- PMM

