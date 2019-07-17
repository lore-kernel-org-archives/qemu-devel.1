Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC9CC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC84C21849
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC84C21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrt4-0004Iy-Mn
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dray@redhat.com>) id 1hnm7B-0004zm-EX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dray@redhat.com>) id 1hnm79-0000Pp-RW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:45:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dray@redhat.com>) id 1hnm79-0000O0-Kx
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:45:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so25335913wrf.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kMbwVeKNZVnC7UvuBHdjSvTubP/nHVtVLTFl+5VLlW8=;
 b=UWLyu9zZqr04PVhFbnNN1ZGOHdXeU9nlI44YL00/6OKtp6opDgX9EW3Ryjju1WLplp
 EpUCSHfuVSajHZw1U5kCcVnUHgLyjWIO4Z+3YEFexmNvCDni+T7nBPFWihzo5CjVyb9M
 FiwY4uX5veXYuR/R58F6lhKWE5lkluDhDzaguB5CYOhD2T5j7qQFl9bFWFn/fSRGk/sc
 /GKkAxiOk7dIr9Ul0TM6zBPTtrWzD/hOuAVahT9nhzKNvAbAQyXOQi5Snub1KQH4zACt
 5J8yKhgnVAUdD+Nx2AQhQYwXhL0cDPY+TqaM39AQmpJiC7rdS+KLW3XuQQJSCRT07MMG
 K02Q==
X-Gm-Message-State: APjAAAU1C39WB89X9InaUrjd9z7etfXIujf/InL5xfU5D9nRa7ZUnkWI
 zrupNOrSLH5sjW2GNGZ+iB1RZ1tXKoi0NDLcmGx2Aw==
X-Google-Smtp-Source: APXvYqzwUfdVo2DcnVAxTCQMWoYSp9X23Gi/OdV6cr5lNtAUrFrZ4gidq4AY5ibS7lixVTCPCnYbhGp822HSB0aFtKY=
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr10022871wrw.266.1563378305090; 
 Wed, 17 Jul 2019 08:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
 <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
 <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
In-Reply-To: <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
From: Debarshi Ray <dray@redhat.com>
Date: Wed, 17 Jul 2019 17:44:54 +0200
Message-ID: <CADVaYxabY2avyFQZy1gN4nyj=9mQD7n=WD5CYszhHOjOiXoq9w@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
X-Mailman-Approved-At: Wed, 17 Jul 2019 17:54:36 -0400
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, "P. Berrange, Daniel" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, debarshi@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, Debarshi Ray <rishi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 10:40 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> I am not very familiar with podman or docker, so I am not able to tell
> you why docker does work by default.  @Debarshi Ray might know, as he
> helped me finding a workaround.

You need to mention the UID mapping via --uidmap arguments (or
--userns=3Dkeep-id) because you are using Podman without involving root
on the host anywhere. With Docker the daemon always runs as root. You
either run the user-facing client also as root (with sudo and such) or
you add your user to the special 'docker' group.

These days, very recently, rootless Docker is a thing too:
https://engineering.docker.com/2019/02/experimenting-with-rootless-docker/

However, I don't think that's what the QEMU test suite has been using. :)

When running rootless, you can only map your current UID from the host
into the new user namespace, and usually that gets mapped to UID 0
inside the namespace. Hence the need to override the UID mapping. This
limitation isn't present when root is involved on the host.

Read this commit message for some more details on exactly what happens
when you specify the UID mapping like that:
https://github.com/debarshiray/toolbox/commit/cfcf4eb31e14b3a3

