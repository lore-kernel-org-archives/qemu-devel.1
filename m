Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F621C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BDD2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cm9GNDgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BDD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpIj2-0005XP-Br
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 17:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIi7-0004oI-2J
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:50:07 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIi4-00042i-QX
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:50:06 -0400
Received: by mail-ot1-x32e.google.com with SMTP id d4so12004318otk.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xkqb/jfxnlIK9kOS/fna2FLIHrzrYd2jM6XHR7O0u7s=;
 b=Cm9GNDgT2EzlVjirw1oXGDKH+SivJ2kwIm7Ef3/3sMuy5KCJ37PjBoTiAP9Btd6G2j
 pz+qin+Ld51IGz3TJfQ6OiBTHhkoyTzFkAT1AV/5FRl74qb2TIHW5TbOgHa6m1/7PUFy
 cugcSrAPCEOlyl3DdEH+Euvv71iTlpJdvlnihX2oVQDtq/NyaaxSU3KtUvCACcoSiFz6
 WX2khpBPuicWOcXBoBUpCAMKu1vBiwX1zixpJeIpaTPIqWcoE74b8JguQaMteO+Vu/5K
 NbPymWbcYazUcy4Jcn67Wirz3GkBuJIC3AR2VosbAhLyMRdB7nyJIa1m2n8emKaMhrWJ
 8Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xkqb/jfxnlIK9kOS/fna2FLIHrzrYd2jM6XHR7O0u7s=;
 b=JjFvcLhPXgJZjCrpLskjvSFKBsE434kvkijpCXQZ2K2Uthgb0A9ujD09bl7GHh2J9G
 Xc22jA7TvpvWI0w031vJsrOj+RoKXjIu3PI6guVXhMAGRds6G4Zup80LhVKAusvfeNRr
 749+tDyylqscgCudmpOhnsLtsvizLKyPTL+Zi/LiX3B2dVAyx8FwMsCedAzF3rYvKkVe
 UWOqmRBKO1evtQwZraaN72SfcWAWuT+kV+uLgQgPu9Cdt9MjaF8sN+eUpf2lckUWhjc+
 wTYD5DAmyNihoIMIXAhOPDZXSVfYm1Q4sfwIET2AuhNMc2n9Y6UdEiHg+4pAwwrg4RM8
 u0Cg==
X-Gm-Message-State: AOAM532xAqE2ys8SKif+1uv5ZqvsbZ74r/B/XFFEnAs186fHi1KUe+QX
 0YylIY32jhX2PS4nYYGJf4LM7oXRDgx3tnz7FZpKOQ==
X-Google-Smtp-Source: ABdhPJzWua/RaKuAZWsTbY5Kqz7t1pTlyy4aiLO6Mhzy0TtaJeckpSh/hqJUoRlCJ62NfIxITG01r2JRZURrT0Uxya4=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr7992742oth.135.1593294603349; 
 Sat, 27 Jun 2020 14:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-9-mst@redhat.com>
In-Reply-To: <20191029225932.14585-9-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jun 2020 22:49:52 +0100
Message-ID: <CAFEAcA8uSbC80a+yB4_DFtCB1_-sXW5R3ugTX6H9XDeBZV-mQQ@mail.gmail.com>
Subject: Re: [PULL 08/14] migration: add new migration state wait-unplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 23:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jens Freimann <jfreimann@redhat.com>
>
> This patch adds a new migration state called wait-unplug.  It is entered
> after the SETUP state if failover devices are present. It will transition
> into ACTIVE once all devices were succesfully unplugged from the guest.
>
> So if a guest doesn't respond or takes long to honor the unplug request
> the user will see the migration state 'wait-unplug'.
>
> In the migration thread we query failover devices if they're are still
> pending the guest unplug. When all are unplugged the migration
> continues. If one device won't unplug migration will stay in wait_unplug
> state.
>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Message-Id: <20191029114905.6856-9-jfreimann@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Hi; Coverity has just (rather belatedly) noticed a possible
issue in this code (CID 1429995):

> @@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
>
>      qemu_savevm_state_setup(s->to_dst_file);
>
> +    if (qemu_savevm_nr_failover_devices()) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_WAIT_UNPLUG);
> +
> +        while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
> +               qemu_savevm_state_guest_unplug_pending()) {
> +            qemu_sem_timedwait(&s->wait_unplug_sem, 250);

Here we call qemu_sem_timedwait() but ignore the return value,
whereas all the other callsites for that function do something
with the return value. Is the code correct? (This is just a
heuristic Coverity has, and it's wrong a fair amount of the
time, so if it's wrong here too I can just mark it as a
false-positive in the Coverity UI.)

thanks
-- PMM

