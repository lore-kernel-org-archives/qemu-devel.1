Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120DAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD59420717
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD59420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADyQ-0002B8-VA
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1jA8lZ-0001qY-9Z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1jA8lY-0005ot-3S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:55:33 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1jA8lX-0005lK-TG; Fri, 06 Mar 2020 03:55:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id gc16so1471303pjb.1;
 Fri, 06 Mar 2020 00:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCRRo8mhsNgX7iUXkBf5uiGaRmrvVTy07+qmcaPwud4=;
 b=L1ptLheCt8Kuw33o58RTtdC1xdxFhx5ulsbqHkXJrN30e7a2W6xzxF3Ewb5vKMKBTj
 X66kTE3xGOrI/3Yf8nwhI2NR0Cn9ZX3B9+Hi7nVk0aWcCVRz7cCAekc6U4sZFu/xnzGV
 QK/0NKxl3/f1dogxlyl/VUG7I5oGjoq4utUaszHRm+Q+vvs1EmbP70cZql1OaGb+dddO
 Ku9xxy4Ui9whsq2O6bYy8jk9RJ/AYedVhmpaLNaSgHJ7ZLvovQEdoNGUQ9pjM97huM86
 2y/xUrw19wECJnjHBb1k7T5n0EVu0AJNH2bQhgTazVm3E1NOSDToa75JzA9G3ZR1vwlM
 XddA==
X-Gm-Message-State: ANhLgQ0Ne0Ae04FZCDmtK1t2fmA+Mt4R0E8u6J87e0Cc5nL3pQMlkE/D
 khf0kN5v15ro5SOz1M/Chc8N8/kEPUuBk4ex
X-Google-Smtp-Source: ADFU+vsdm4/WlKZZmf9hNyngp+EutIs2bjth6sOW2z7pr/KZUmg3fsPO7FqM1mWFVZXrUXV9MjrGjQ==
X-Received: by 2002:a17:90a:c687:: with SMTP id
 n7mr2571465pjt.155.1583484929801; 
 Fri, 06 Mar 2020 00:55:29 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com.
 [209.85.215.172])
 by smtp.gmail.com with ESMTPSA id t142sm25885022pgb.31.2020.03.06.00.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 00:55:29 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id z12so782268pgl.4;
 Fri, 06 Mar 2020 00:55:28 -0800 (PST)
X-Received: by 2002:a63:7453:: with SMTP id e19mr2304147pgn.50.1583484928522; 
 Fri, 06 Mar 2020 00:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-2-vsementsov@virtuozzo.com>
In-Reply-To: <20200306051536.27803-2-vsementsov@virtuozzo.com>
From: Paul Durrant <paul@xen.org>
Date: Fri, 6 Mar 2020 08:55:17 +0000
X-Gmail-Original-Message-ID: <CACCGGhB-Y6Jjwmn4CvydPGFZQnfvyeG=vbr5wCxt4GrCMjf80g@mail.gmail.com>
Message-ID: <CACCGGhB-Y6Jjwmn4CvydPGFZQnfvyeG=vbr5wCxt4GrCMjf80g@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.68
X-Mailman-Approved-At: Fri, 06 Mar 2020 09:27:28 -0500
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 05:16, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with an errp OUT parameter.
>
> It has three goals:
>
> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
>
> 2. Fix issue with error_abort and error_propagate: when we wrap
> error_abort by local_err+error_propagate, the resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
> the local_err+error_propagate pattern, which will definitely fix the
> issue) [Reported by Kevin Wolf]
>
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
>
> To achieve these goals, later patches will add invocations
> of this macro at the start of functions with either use
> error_prepend/error_append_hint (solving 1) or which use
> local_err+error_propagate to check errors, switching those
> functions to use *errp instead (solving 2 and 3).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Paul Durrant <paul@xen.org>

