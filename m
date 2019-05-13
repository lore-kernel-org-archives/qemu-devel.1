Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33FBC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 03:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D38D208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 03:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIGVt5F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D38D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ1De-0005Pc-Fl
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 23:01:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hQ1Cr-0004qr-AA
	for qemu-devel@nongnu.org; Sun, 12 May 2019 23:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hQ1Cq-0003BK-4N
	for qemu-devel@nongnu.org; Sun, 12 May 2019 23:00:49 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hQ1Cp-00034v-S1
	for qemu-devel@nongnu.org; Sun, 12 May 2019 23:00:48 -0400
Received: by mail-ot1-x343.google.com with SMTP id g18so10157731otj.11
	for <qemu-devel@nongnu.org>; Sun, 12 May 2019 20:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ffYqaRQjj6Bw+d/4U7194D9n2Zurfvvnyd3y9ldvc9k=;
	b=XIGVt5F5PvnbSg5W97T4i7Xk3Wg3YAMKJNPb2uZnjZxWV9xwSu7rvzTHlVmRIEANcZ
	hKbCjIp22aYMu7WRhnCp4nb4vP9dLgL/R+HsYcFfpsEtqcOfnC46QRiFKGAPT7L04tv8
	Erl2lIo0qY8qAlI/+8VJpQ/+JQ1Vv4JvS27lqRTDp6BNBvJ4jyU2yNGETEgiBK2p2Snp
	LsdAVr4CN5EIl54vP4qNPcdug8VGCouU+RuPFSVBXyw6BUlD8I9WO4SnzfiNCHztuAN/
	07cQ0I4vStTNjxdRlgqehy2URsvdff2xVibhWXCU/XFCCq4cNWRqU5oMU0jZAEcXaPIS
	RWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ffYqaRQjj6Bw+d/4U7194D9n2Zurfvvnyd3y9ldvc9k=;
	b=NkKsXvho9HfWodobgT2s2qzK8U3VutFVtqYVXY/cT54UmWgNkzkVj9rQiYwK1NF6oa
	+qQQA1bCwKWtO46cWGByHXy76S3Ub4X6PPIucPkJkNTLQA8XlhcOe39hXbvu+iLXo8aE
	WmxGqwiMTU2G0y/Z74nx4zrSHvMUsO3DhCfHg+l7ky6viJ3+lQ9rNfbK5R2RrrckYZk8
	KXDb4wqBlknssRdl62XyLPkQk8EYxWppBHsOg6/IzuL28hOtyyIa51CSaJoN77rMMOi+
	EJqae9HUZMJXfVuYAc1qDG+7Cvn6VIF72fHAVopK812/mrh8xU/WHv8ksuKWEMdqvKNR
	o5Fg==
X-Gm-Message-State: APjAAAV4Xdpg9smrKOfxNotn4IVgL08uhv6zf6b6GLHJQEhs8y6HHMj6
	DXWJyv2U1hwY2vJWWE8tOUWJUyXl04eb3rGq0nw=
X-Google-Smtp-Source: APXvYqxnD9TQsZQbZOoXWRRE1HjtBk5Iwlna6twkAX2sbIV18QyqRxWfwvcMTbwzt7Bvz3LwzdpdS/K5Qq6fbfsmFWQ=
X-Received: by 2002:a9d:469b:: with SMTP id z27mr12253213ote.11.1557716445673; 
	Sun, 12 May 2019 20:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
	<1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
	<20190416025147.GA20550@xz-x1>
In-Reply-To: <20190416025147.GA20550@xz-x1>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Mon, 13 May 2019 11:00:33 +0800
Message-ID: <CAEn6zmFs5gMVHO0vxnGU4jJRYyZ0y5uBdiiiDFL8xoKPG1XYJA@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for the noise, is there any more comment for this patch?
Without this patch, ignore shared capabilities can not be used on arm64

B.R.
Catherine

On Tue, 16 Apr 2019 at 10:51, Peter Xu <peterx@redhat.com> wrote:

> On Mon, Apr 08, 2019 at 04:42:13AM -0400, Catherine Ho wrote:
> > Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> > addes ignore-shared capability to bypass the shared ramblock (e,g,
> > membackend + numa node). It does good to live migration.
> >
> > As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> > until VM starts, but it does on aarch64 qemu:
> > Backtrace:
> > 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> > exec.c:3458
> > 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> > 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> > 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> > 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> > 6  0x000055f4a2c9851d in main () at vl.c:4552
> >
> > Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> > druing rom_reset. In ignore-shared incoming case, this rom filling
> > is not required since all the data has been stored in memory backend
> > file.
> >
> > Further more, as suggested by Peter Xu, if we do rom_reset() now with
> > these ROMs then the RAM data should be re-filled again too with the
> > migration stream coming in.
> >
> > Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> > capability")
> > Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>
