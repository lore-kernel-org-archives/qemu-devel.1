Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C8C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8604206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFyMBpKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8604206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUuw-0002JL-1R
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jGUuG-0001Ts-9P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jGUuF-0000SL-6k
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:46:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jGUuE-0000R1-KI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:46:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id e1so1477422plt.9
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lOhU+P5/z3iIKb3J+KQwVAO/9UpQ/XIqujgmXd1fkSM=;
 b=IFyMBpKmE5NC6eDj6M1e04bVd6fpo+OCPUOeadd7JrWkWTxzvnNYKZyygByIHZmdZ0
 6qvPa7apUurxaWis7BKjK0T+5UpoiMTY+nwSO0OOeiZiuUs2nxowC+QpzCqT8wKgLsaO
 v+NNTQaLxN4CI+D63Em02dRFRTDL2TJsoh1E4wrIKWKTICfbOYuv6IqPaQf5qUYolyZt
 +RT11SCMMSHcRBU3O5+ihI2dmx4TFGALbVgChKEPE//ryBuYD3igkB7WrsQkQyxo1Hoo
 b45c5iowRm2DgfrWAioYCOu3qekvMAVcBHILyLmZqNPCHC7mVUiDEy80FJJTHrKHHGUP
 gTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lOhU+P5/z3iIKb3J+KQwVAO/9UpQ/XIqujgmXd1fkSM=;
 b=Z1N3IagGdBzmadb0A+o+1hLCZE+km2ggEGp3IEga52YX+nhCNpyqc9wLl6nt4QpcQN
 qFAUnRbh+5DW2fvdAkwtxu0Jgax4kZ/yzbaNyh3Ub9JXDBp0btBnYo7nJNX3zmK5vuAV
 MC+1WEpgliYCPvXQujZYKEoTku3huzX2hGDlK2DbCmLMahi9B0b8v1TzpGTmj9xteCTv
 ztXoVuyF7R8lkrDPOT4AI6bU2YTGYhgxMJzMdfNvbsY4ZrfurnlBXaFyGSxPhE9N3uj9
 eS9wMxqAtgcCMMaFz4wf3Az9FjE8BkCD1oFvzfTK1yk3g3BckeCn73s2jEq6qr9l8bE/
 qa4Q==
X-Gm-Message-State: ANhLgQ3gxAhmfmNzyNOD/j6HdnuYJsvWxxHa7P4gQbkojAWHAOLKL8vy
 eeGYlG4iUFFy/CUBIfko4nw95L5hCDYkQi6pzpE=
X-Google-Smtp-Source: ADFU+vux+EzvDodg5md6jCMDjPqvsckEf43W1mSxUCT5AddVZKPUbJvFJHRZ6TmMwjIKn2xoAjQtIL2v/JadTBwWjic=
X-Received: by 2002:a17:902:7e05:: with SMTP id
 b5mr21402281plm.253.1585000004754; 
 Mon, 23 Mar 2020 14:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
In-Reply-To: <20200323132556.GG261260@stefanha-x1.localdomain>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Mon, 23 Mar 2020 14:46:34 -0700
Message-ID: <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 6:25 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Mar 20, 2020 at 06:43:23AM -0700, no-reply@patchew.org wrote:
> > /tmp/qemu-test/src/util/thread-pool.c:213:5: error: unused variable 'qemu_lockable_auto1' [-Werror,-Wunused-variable]
> >     QEMU_LOCK_GUARD(&pool->lock);
> >     ^
> > /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from macro 'QEMU_LOCK_GUARD'
>
> Apparently gcc suppresses "unused variable" warnings with g_autoptr() so
> we didn't see this warning before.
>
> clang does report them so let's silence the warning manually.  Please
> add G_GNUC_UNUSED onto the g_autoptr variable definition in the
> QEMU_LOCK_GUARD() macro:
>
>   #define QEMU_LOCK_GUARD(x) \
>       g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ G_GNUC_UNUSED = \
>               qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))
>
> The WITH_*_LOCK_GUARD() macros should not require changes because the
> variable is both read and written.
>
> You can test locally by building with clang (llvm) instead of gcc:
>
>   ./configure --cc=clang

Using --cc=clang is causing the following error in several different places:
qemu/target/ppc/translate.c:1894:18: error: result of comparison
'target_ulong' (aka 'unsigned int') <= 4294967295
is always true [-Werror,-Wtautological-type-limit-compare]
        if (mask <= 0xffffffffu) {
            ~~~~ ^  ~~~~~~~~~~~

these errors don't come up when building with gcc. Any idea how to fix
this? Or should I just suppress it?

