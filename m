Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB22207ED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZuhJPnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB22207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVrq-000110-D4
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdVrG-0000HB-07
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:26:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdVrE-0002OP-3M
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:26:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id d26so15711488otc.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7NxAFNxM8EdOZ0BmRl04FUi2htZYsP9NmAhhokOQRtk=;
 b=uZuhJPnvTTS4s32NC9hW2KLviiy0hRjewctQARR51iYASwCiWI9DsnvqCk3U7Y7Zfl
 vNn4ARnzJ+cEC6A9xdjhPDmx0ZHxcA/QDL5zvj5qaEWGDiKZ1YGZfu2e4R/6ezC1QeWQ
 Rxmig5ATmM9oSBVkcewAmuHDUm7qwrMGkMOvZQzOSr95UpslM94qcaMxBufD6/FFYYi9
 ZCrhRSV5ZRV4vxT3NZ+YFscAw0GLKwVUzcmH1FkRnDMGgRvzXu/DdiTYj/esdKI2bc1x
 udOtbpxDkhgHp+cRBTiPEyt479zptxvDp/A7eRaxNLhAHybxrCr8nFxdjJSncr3AR/XV
 /1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7NxAFNxM8EdOZ0BmRl04FUi2htZYsP9NmAhhokOQRtk=;
 b=OcItYrghdYhNtseMEnxK9elXKEUK+z5+ILoyyhM/qClKN6mkU/k6LXDyyWmIVPEkmN
 +Py6r50uX3NEY2vdxAD7782FYhjSbK62XJ5MinB4hX1rfxOuB5/mVHWfbcNdvIG0svwQ
 raPqsfGzDJLNQDiHKOeeSbMwIlTiFxHEkNzBI+yveep97DvdTADzkIk6DNMrTV43452H
 VMdYLWTsIRiYVeaxVMHzsv4p4LzYts+6yhrgaTomFhdyTCRJZxAEkd30XJyWjd5Rk7GL
 rCOYm9KMgFucMmU2Q+E0jmP21piZsHtHnAwuX0h7/6pSDBuja9Y3BBdpvPCukihG4kiA
 W8+w==
X-Gm-Message-State: AOAM533+tnsFlj2r7E8ENnyqULnFGksWD0vpGl1+j5oUIT24BMbNGA9/
 guqSRvHBJ8kG4nYjYRs+coBOHU4jJ9eR5WIAsDfO2g==
X-Google-Smtp-Source: ABdhPJw18mkgdwSIAfavIANsDMhXIjxBGcjseQ6VuikUZ8MFNiZ/ZSD8VwH6dGIR8fsTZj7iJ0ZnyIlJrXjwnFRjFyM=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr180304otb.91.1590485206412;
 Tue, 26 May 2020 02:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
In-Reply-To: <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 10:26:35 +0100
Message-ID: <CAFEAcA9vG8RO1A3mSkHGN+ZMisDHzAu3QM5GfCkrDaK-A0Tw9w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: xin.zeng@intel.com, Alex Williamson <alex.williamson@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Not all of them, only those that need to return MEMTX_ERROR.  I would
> like some guidance from Peter as to whether (or when) reads from ROMs
> should return MEMTX_ERROR.  This way, we can use that information to
> device  what the read-only ram-device regions should do.

In general I think writes to ROMs (and indeed reads from ROMs) should
not return MEMTX_ERROR. I think that in real hardware you could have
a ROM that behaved either way; so our default behaviour should probably
be to do what we've always done and not report a MEMTX_ERROR. (If we
needed to I suppose we should implement a MEMTX_ERROR-reporting ROM,
but to be honest there aren't really many real ROMs in systems these
days: it's more often flash, whose response to writes is defined
by the spec and is I think to ignore writes which aren't the
magic "shift to program-the-flash-mode" sequence.)

thanks
-- PMM

