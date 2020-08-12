Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B18C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7112076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbvhY7jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7112076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nzv-0007Km-HL
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k5nzE-0006vb-Ca
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:28:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:38342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k5nzC-0004gR-SM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:28:00 -0400
Received: by mail-pg1-x533.google.com with SMTP id 128so821978pgd.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b/g5ePmXHjLvU/djFoetGGZ91cg2f+7NCWI2rwXpdFk=;
 b=lbvhY7jDMOLhyJUdHNLM5UrmcUCwtMfmrkgcjBQuO1ljnvdsqwsB5LKwmMVV5zhwFb
 jINpuyRsIfF2fnwhlKdHoiYO71w9XT19ROlRw0c+mZuRQkC7o5Vt8SHf9Qldc0MWICd2
 3Ydft7FoP8742BZ7aSTvAiwhnTjIwn8nDzidFLhYSs53E7v41RpXycY09CLN2mZGuotI
 oCPgoMDtJZwoh9nQ+IRvYIysY+JEMHQA7JZQ1jRIpgk7v7OJNyS+terjsD35F6kCnIjP
 OwWaYDv1FsIBzDUd+oxNNIhPwkq4sLz+GgBqS0BmYJ2FXx3N3N/xMLBxggs9ZijEpRcy
 22Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b/g5ePmXHjLvU/djFoetGGZ91cg2f+7NCWI2rwXpdFk=;
 b=X5hwHlAZe7jvvO9hjkwour23GqgGhXf8cJK43+bPWMTmucp6B2Q95wV6yzpYsUzV4j
 iQ6EMaB28Q3A5Ut204bXrY/DwgWee6wiO/Xi3STRK/Xv/W6Z7gXFdvklXd0S3BjJq5w2
 H9VXPFAHBoV+4Ds0zFG/oH32eHkPwTGwaA0DrgU88bRFxE+iIxXahNN2EGRuYhQfdeF6
 CTMTO3oCAfy5i+D9Xut/0RwLrOtUZLVT3cyZac5eN2dFAAXAz8GffPpZ+VGlTlsobDW2
 7IlQh/u+VgPHTPYw7zcjEb6GDiL9R3Dk45xOqBM2NTDaobhIyDmRV5VmHYbLd9lWmh3S
 KBlw==
X-Gm-Message-State: AOAM532Lax5lsffFgp1C6WypT43+yafkpP65i3WvGHpG3qLKArQ5xRe5
 +DZT3mjeR1E2zoWEwdjBj45UHeBJ0bSwRncT9ww=
X-Google-Smtp-Source: ABdhPJw02/xoN/wQnDCI3eqorzVqzaMZVdviG4Tiz9hHfJEH9QkBrQ5vV8TF3Jtv23FOiIdYWYckfD3ROgDTA7ubRWc=
X-Received: by 2002:a62:aa05:: with SMTP id e5mr10268382pff.70.1597228076971; 
 Wed, 12 Aug 2020 03:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200511040622.xus3eqvsxbjkfum2@mozz.bu.edu>
In-Reply-To: <20200511040622.xus3eqvsxbjkfum2@mozz.bu.edu>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Aug 2020 11:27:45 +0100
Message-ID: <CAJSP0QXxC+D4qmgh=yHxcUakpBHNyi9DonCheF9K6_KhgjrRzg@mail.gmail.com>
Subject: Re: Assertion failure through virtio_blk_req_complete
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 5:07 AM Alexander Bulekov <alxndr@bu.edu> wrote:
> While fuzzing, I found an input that triggers an assertion through
> virtio-blk.c:

This reproducer does not work anymore in 5.1 but the underlying bug is
still there so I am sending a patch series.

Stefan

