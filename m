Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7EC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEA220714
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYAhubbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEA220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC4XF-0001lu-JE
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <macallan1888@gmail.com>)
 id 1kC3Ue-0004vC-Mu
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:14:16 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:37951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <macallan1888@gmail.com>)
 id 1kC3Uc-00055H-Jh
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:14:16 -0400
Received: by mail-qv1-xf42.google.com with SMTP id x7so1068192qvi.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grClpKsHrOjfMYJGvY6nrakf23oOqtLr8nRbqA6ub6g=;
 b=dYAhubbkJE6fcADoNW2XfyHaCGeCcZxQjz2hu8LeucrdtQVxoyiSMXk1lpXpqlsuPZ
 gJ9dlkZ4dOmNaAlbhoWQ4VLLLY8STfHzEzuVH6Nk4cYzpfZuPAMGIRix9KmZJL/T33nJ
 8VMRmeRhFh89plm9/1chsu7d01wOochQE34dPk7/d2BZOBICfu8uVyq/tsRf8/yksugU
 YdQvaUIAxz4327SeLhzM2nrn7KD2xjJyO3xxHjblumeamldLG89if4Sg2Cc5sUzRM6Hu
 MN8ieOWkggyf3H8C4M+qnNfL2Wdta5OpZC+uKZQus02GIyqkgP9LgIQR6WVr+HqxNEQx
 f1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=grClpKsHrOjfMYJGvY6nrakf23oOqtLr8nRbqA6ub6g=;
 b=ZwE+pbC5TIf2TpwittnRXhCnzZ3U30YebjHtwRW69WQjfIcMRAC9yz6X5AgrNdGi7D
 cI2jEbaBqi8kkdYqxzb93jXejwZUN+kgJJNcOICz04ULJ6eWPEridoGzdy4gGB5U0w/F
 j9kXMbtE+OPg52BC91fic1teoLbU78JGTwuYiM24iAaioEKsEeG6L/k9OzTA5y/ZnAlC
 Oxw0pq6Br0jDpSQ3DC1YzORYhxmohK0IT9mHmPcLV8m3Wf5s3CKuFTUYAh7LYB/x4Lu7
 TsSLXpE56Bc/UtyPslRPkQAhfnNKt6AnVykizMmgXtCzRqL4sH6F0LwDr6OYH1AnxadO
 IA5w==
X-Gm-Message-State: AOAM5329rXxLvKLx/481OWFssVtMdOPnpmkR2i8hfcassdQJgWgAILpi
 fctlXRPhqB9RnBU4/fWdl6I=
X-Google-Smtp-Source: ABdhPJwDbwpsVUXE628vNdc9mEq0pS6yT6QWP6281pcAXJf6WV39xuWqVXRG+r1gB1lQy9JEyhfsCQ==
X-Received: by 2002:a0c:cdc9:: with SMTP id a9mr1293465qvn.187.1598717650746; 
 Sat, 29 Aug 2020 09:14:10 -0700 (PDT)
Received: from glenfarclas (c-73-121-86-106.hsd1.tn.comcast.net.
 [73.121.86.106])
 by smtp.gmail.com with ESMTPSA id m30sm3140505qtm.46.2020.08.29.09.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 09:14:10 -0700 (PDT)
Date: Sat, 29 Aug 2020 12:13:41 -0400
From: Michael <macallan1888@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
Message-ID: <20200829121341.59d8277b@glenfarclas>
In-Reply-To: <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
References: <20200822142127.1316231-1-f4bug@amsat.org>
 <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; powerpc--netbsd)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=macallan1888@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2020 13:20:27 -0400
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
Cc: Michael Lorenz <macallan@NetBSD.org>, 1892540@bugs.launchpad.net,
 Andreas Gustafsson <gson@gson.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

since I wrote the NetBSD code in question, here are my 2 cent:

On Sat, 29 Aug 2020 08:41:43 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 8/22/20 7:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > The S24/TCX datasheet is listed as "Unable to locate" on [1].

I don't have it either, but someone did a lot of reverse engineering
and gave me his notes. The hardware isn't that complicated, but quite
weird.

> > However the NetBSD revision 1.32 of the driver introduced
> > 64-bit accesses to the stippler and blitter [2]. It is safe
> > to assume these memory regions are 64-bit accessible.
> > QEMU implementation is 32-bit, so fill the 'impl' fields.

IIRC the real hardware *requires* 64bit accesses for stipple and
blitter operations to work. For stipples you write a 64bit word into
STIP space, the address defines where in the framebuffer you want to
draw, the data contain a 32bit bitmask, foreground colour and a ROP.
BLIT space works similarly, the 64bit word contains an offset were to
read pixels from, and how many you want to copy.

have fun
Michael

