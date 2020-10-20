Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95837C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A708D2225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kENGFVCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708D2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUyjB-0002Ru-Dj
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kUyiW-00020k-RM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:58:48 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kUyiV-0002aL-Bd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:58:48 -0400
Received: by mail-qt1-x843.google.com with SMTP id h12so248875qtu.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Tw532YjI+4ea1/5k+2RooAWDam2OM7mRuaOB71IBBk8=;
 b=kENGFVCv45LWuSbzh6Hfsd2XYNXdD9LyD/PjuZ8cVYTc1xg8Tl0jKHMMpsIJ4pwn2V
 T05MF4bTHJ1HS0CiuxXXo5efaJAN3NJqprM5BuXYIxnYzVyddyp4K5ekFh956SDts8RC
 tsJ9tysZo5ttAOUnVO8hv80T7TUtDfxwLrYSZB5UQU4eKLejtI1Rq0DrjgiAbpxJ9wB7
 a4/xbedkJH/Il1PFcolMjc6IOlBwN7G+d0THSbW9RaQkyMUl9lBqmIqUeY1CDUEZhy0P
 Vq58Je1SZ9AnEEKbrmw8VEwTjPK+jXRWmjVYCgy/PiOQyGnpa8cjYmM4vaM9Gqc6Q72g
 LN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tw532YjI+4ea1/5k+2RooAWDam2OM7mRuaOB71IBBk8=;
 b=gZU3MO3eFoFDz7VK/uEXKq9vnVH+rKt5KsnWcZunx6i9O3ogIt9kRDEJNXFY/Um/0J
 94o3sUQDB5KWj0MH+HeEIZ3avc5Huy/xJdM9qqZ8hKLFAnUFpbzfHBBcjmdy47jtM5nR
 pY02/paTdKinDH1w2TeNYkM4kqM0NwtsTapE7SWDvvyowrWsEwGx592f5eIE1LkFBW0z
 dmVewMnQa/68Hi5p6opVrzgub6wEULTS+pHvhcwbgFTBwYFnVKhnFJc52qs0Q2pSxj90
 0m+69Y2PPdkA3hNs9AsbYbHdZ9s9AWq7QxPHdh+tQht0V65b6oP8/cLM9jhOXNURNVHq
 X4pQ==
X-Gm-Message-State: AOAM5314i+FwU8sC1oB2zfjdaJuwYZ50/DzkA1zPAt06ZbbBR5azfuHH
 sgeddYqjymwrNKL4wlaQCDHwNt0IpM8yjvQmlB4=
X-Google-Smtp-Source: ABdhPJx+p5KXGGeSiLBxzjAX5VDfsKQzQT9dLe1EGmKJug8eVtL9s4bidQiaNGCtbGXIyteSfI7MwBbSXZNmCKzZJqM=
X-Received: by 2002:aed:3e3a:: with SMTP id l55mr41254qtf.19.1603227525935;
 Tue, 20 Oct 2020 13:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 20 Oct 2020 22:58:34 +0200
Message-ID: <CAAM0arMinF=U2iRazD+NNGntLesE0Ke8mAaAHxTu+TWa7FtjZw@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=a.tarasenko@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: James Hogan <jhogan@kernel.org>, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Sven Schnelle <svens@stackframe.org>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, David Carlier <devnexen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 4, 2020 at 8:25 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> These individual contributors have a number of contributions,
> add them to the 'individual' group map.
>
...
> +atar4qemu@gmail.com
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

