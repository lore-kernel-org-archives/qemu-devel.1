Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA60C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6E52068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBrmCf86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6E52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAhc-0002L7-PF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgAgg-0001jB-10
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:26:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgAgd-0004YL-KQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:26:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id a21so6343394oic.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L0leHX2ehTsHfJecJjDI6d8/S15qM5czrJL/+Mp4PQc=;
 b=pBrmCf86ert2IW7q4ulJDj34QhGFE7S+GKLydo+X3jgkcNLWBfP1NeGCwWu1v2x3F3
 qtA2h82hjVFs2pFjG1Lpdqv87vozdydQEGxba1ef+80Imacph1oK9Db2artnNBlJXn1X
 gFPXAoezApTpksthUjXcmJvgu0gm183aYCA9Ct7GHy78vsSDHCLFZfzQCFq/8Sj6/+2U
 j+U0v0xIVv7oV9ol9KNREjW3lGocsTtknlv95fWMgNsKfTXFmOyslcKh+ua3joqiKZXG
 cdrcnm2Tz/bAjm/24cv0W7YAiZfaJgYiTFZeOgReTNzAsPK2hq0DUSVLlJep63BuK8Pu
 qQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L0leHX2ehTsHfJecJjDI6d8/S15qM5czrJL/+Mp4PQc=;
 b=bbqq6JZhvtXQqb4ga8zwGdeluJcRddHlLvPI/pvcpC4DKbS0BDtO+j6oiDvqlnt1sF
 i4Uu5femHDU/lh8Z0sQVaYvsBYqL+OBf+5egycEbq7SIW+t9Y50tABxo62JxE6bITJDM
 CUnAQECRrV8cvl0p2n6lVSZMWCiU5lCeM9ipaXtbaNIlq3ftN3HMcCI6SI61gn9+qZHv
 976jbV+57dge8YkkDY6XdTgYzKl//G3TqqDA/UKDmnvmNKlW4YgUGPJu6YSARlsHkhmw
 rcufNtjGLy61JZotPa79WwOueb+MMw8RkrKwcknVJ6w6FEseGiXhiKQDJLHNxrSv5PsL
 DJ4w==
X-Gm-Message-State: AOAM531aIBbcJc7hQN9w3Ae1+e8LuNBTC+1pM1XjHPnhgywOb4XzF71w
 HIZm4QdZxf9ZofA1Jm9LpXqKdueAtfkAtJo/DdTTGw==
X-Google-Smtp-Source: ABdhPJyyDwgVE1a1khAUFLiXZgSR76k7E6dKTSpgW+tg8jgUUoMjwr9VhWj2I7P4AuPu4vCziPErarCsk63+nGzql9k=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3561939oib.146.1591118808614; 
 Tue, 02 Jun 2020 10:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
 <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
 <CALQG_WgP=ZebEMrXh_EpQJXqJPi48i6nwZU_yWq7VqhV_=eTVQ@mail.gmail.com>
In-Reply-To: <CALQG_WgP=ZebEMrXh_EpQJXqJPi48i6nwZU_yWq7VqhV_=eTVQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 18:26:37 +0100
Message-ID: <CAFEAcA_iW_0jTk=9hCh+UatyhY_HFgzmZeSxqqyUCH19Vv1jCA@mail.gmail.com>
Subject: Re: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 18:19, Fabien Chouteau <chouteau@adacore.com> wrote:
> Le mar. 2 juin 2020 =C3=A0 18:44, Peter Maydell <peter.maydell@linaro.org=
> a =C3=A9crit :
> >
> > By default gdb does not attach to all clusters (this is IIRC something
> > that can't
> > be influenced on the QEMU end);
>
> You mean I cannot have QEMU attach all clusters by default?

I mean that the end of the gdb remote protocol connection that
decides what to attach to is gdb, not QEMU. In theory gdb could
be improved to automatically attach to all available inferiors,
or the remote protocol could be improved to allow the QEMU end
to say "I recommend you attach to inferiors X, Y and Z". But
at the moment that doesn't exist so the best you can do I suspect
is going to be to script gdb to do the attaching without you
having to type the commands yourself.

> > are you explicitly asking it to attach to the second cluster?
>
> So far the behavior that we had was to see all the CPUs without asking
> explicitly.
> I want to go back to that behavior because the current situation is a
> huge drawback for our users.

That works when there's only one cluster. When there's multiple
clusters, by default gdb will show you all the CPUs in the first
cluster. Would the behaviour be better if the other cluster in
this machine was the first (default) one?

> > https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07035.html
> > is a mailing list post from January which gives the gdb commands which
> > ought to cause it to attach to the second cluster on this machine.
>
> The commands:
>         target extended-remote :1234
>         add-inferior
>         inferior 2
>         attach 2
>         set schedule-multiple
>         info threads
>
> Do not work for me, "attach 2" in GDB asks me to kill the debugged progra=
m.

Hmm. That's the behavior for 'target remote' but 'target extended-remote'
ought to support multiple inferiors. What gdb version is this?

thanks
-- PMM

