Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB1C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D68207DA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6tJ+wUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D68207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC0qN-0006T1-3n
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 09:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kC0pd-00062D-3c
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:23:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kC0pb-0000Gm-8y
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:23:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id w186so1799010pgb.8
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kj8aS717dXo0LwjPCItJC7KW1mwDZvfgLhvy3UbS6Ts=;
 b=I6tJ+wUu+cEashMoc9jLFH9v2pi8Gl2YQMIUtKx7+2sLaWexOJXQkTotYth0/uLhwB
 OdbxRxMuTPehorofFt9RAOgdZJVmjnolWATnmTS6IPj5vIug5zHLLNrcgyRHfrtJ7Tgg
 9RZecrR+0tmT8sI8gFxblXyWVo3bqv9DpHEDafO7ZtK/xKmbZUoDbHGlTBDh4wHz1ysi
 knNy/PT4cwT81AuqnEiMn2dazNA3aI7NOxPzf9R5d0ghbFc1sqsoWVZU7FAY2WjlpiJC
 akdjK+CbfShpbnjiLYBMqPPiiJV9o5zTNM5l7B9bMy3GCxVC3joisfHok+yAKs52qgaJ
 kHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kj8aS717dXo0LwjPCItJC7KW1mwDZvfgLhvy3UbS6Ts=;
 b=NzunXXX3UYo689TVQtAXrqI1IoXyN9amWmi+NBcMMPQBT+0aOW91x+oJyLY+DTGe7+
 1cPxOhkHH4RHjXQkvRPzR1HUb0xjiZ+6ZtR+KlpSdeUhrlde91mOkiaCUZf0Lou3dsae
 hEHZl2xWLH5I2rZOLk3WJo76lO5zWxHxlFDpWnfiiWhk7jrDt/7i+WtkK95DQNkjFMd8
 KIIEm2ZEUylotcdOU4puLMtxfIW2UY4cII0wIKylaex/B1/d04A8DgfIIj8Arrq/Qw0U
 TsccFM31l+ac/b+tcl+dG5j/RFtMIFUrPg1lKYijILckRMQ1qTjfKSEVC6vUvAO0H/Kz
 yBbA==
X-Gm-Message-State: AOAM530F4oWqHDKsQX6mOvAnOnW3fcp4rWuyQzl4ly+47A1RoXZj8OVC
 4vN0yrKY3J6zgBD96pQqS9i0vDOj5ArIf36PYmM=
X-Google-Smtp-Source: ABdhPJzvvgno4yBSG/DVdwQe1zPaZ9exPQDX5NOHLRuPGUlKQTNZao3SxA9U7mmdCho5rD+VmM02y0wElgc5GWC8Syw=
X-Received: by 2002:a63:6346:: with SMTP id x67mr2501311pgb.121.1598707420080; 
 Sat, 29 Aug 2020 06:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200828161315.193-1-luoyonggang@gmail.com>
 <CAE2XoE8w+GpqPmVDxg6yHA4kv8_-0v_u+1CzHv7-OfjuyFTuGg@mail.gmail.com>
In-Reply-To: <CAE2XoE8w+GpqPmVDxg6yHA4kv8_-0v_u+1CzHv7-OfjuyFTuGg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 29 Aug 2020 14:23:28 +0100
Message-ID: <CAJSP0QWoibTiRvx9F4QyW+3PapmAx6dNL2HCk5-BCQrVmhSaaQ@mail.gmail.com>
Subject: Re: [PATCH v2] meson: Convert undefsym.sh to undefsym.py
To: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 5:18 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
> I am confusing, why my patch are not recognized by Patchew?

I looked at the message headers in case git-publish corrupted the
email, but I didn't notice any issues.

Some of your other patches were detected correctly by Patchew:
https://patchew.org/search?q=3Dproject%3AQEMU+from%3Aluoyonggang%40gmail.co=
m

Maybe Paolo can check what happened to this particular patch?

Stefan

