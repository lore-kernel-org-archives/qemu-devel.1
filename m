Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11071C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE17221707
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB9i07kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpA0o-0001rT-28
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 08:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jp9zn-0001Qg-Ew
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:31:47 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jp9zk-00079l-TY
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:31:47 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s1so5836523ybo.7
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mZVXylNS0QqeZDNUQ0AqhV35xdT2vypPbdw2qcIaTgk=;
 b=mB9i07kvncltTx+USIFQhfDsxrfy9w8lHaXu1M5l20tHl0Y90Cw7wi9lmne70ffzOs
 +NQbQowpwfCns4a9FiSXJzsrD6ISg0JaF7RSZ8+LqWWZvvZLfXHxiRPPvgscTV1tVYqS
 E0MZWuiK20xVTRXjoQSFLrj1lIf6BA8hijPf5xBDTPSsAJDIwKce8IjeaL8Q5p73n17t
 XO+C4/JS9CSpGabGl9ABST1Sx/NnAaGUSnhu0AW6DVFQrQNK79bE+II/hNmMD45oq8FS
 7OXYvok/ka5lhRGTcCK0V4zr4kz7Dy/JS/LUo+4WgT9WkrDZFX60onrXlx4I+2wqewlo
 PzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mZVXylNS0QqeZDNUQ0AqhV35xdT2vypPbdw2qcIaTgk=;
 b=l3t5zH+iiEYbX5JAEIR50Eihkax9yXJKZlGr1oCin1czdtmCHzIYSdkGVTLbAyxyfj
 W7PuNC9bLPwPVPxghDQ7HfOXPmzAQ95JKBwDIi+RA5nHbTv7mMv7d/OISj+/Kslex3lj
 BlYuprxKL/KzJrspOhLbqDSXgTlyxcKR/ZHiWPznxVuTCkaqZaX93MmxYxbd9OSG4Lhw
 wQIfiBp0c8orRgvJFRtiGE5/BbDdX357gtQ/pPhrSyRFk3jH8fCTwKhndwZkHsXcUvP0
 jQw4oIz3v3lh+BWjMYrLhUFse+Qp6qE1rDaN+YgjYT6hV1Pf1t+96NytGOuQemWuIVNT
 YGBg==
X-Gm-Message-State: AOAM532ZjEUrzHezv4IY09Q+wZ4/GKzx3iqGW2RwnZbYJo2fp/C5Z5JV
 cGu0LNRMh371FxywflqCKwBAIBx9YPbDaw3kt9E=
X-Google-Smtp-Source: ABdhPJw6c9Wtya54LpgyN9fRIdlL/6lC6lxA6TqCJw9NS2ku7ij4KwVIgIITqk1Z9ZEnF7Is8TUZFYdadqV/HXe1SZE=
X-Received: by 2002:a25:c507:: with SMTP id v7mr11874893ybe.306.1593261102721; 
 Sat, 27 Jun 2020 05:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
 <385afacc-f544-f595-ce8b-eed56fb7d017@redhat.com>
In-Reply-To: <385afacc-f544-f595-ce8b-eed56fb7d017@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 27 Jun 2020 20:31:31 +0800
Message-ID: <CAEUhbmX6jXrkC5TAgNBPBzTcy9xgFmbUeE2q+5ateFq_h7R-Pg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for OpenSBI firmware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Fri, Jun 26, 2020 at 10:05 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 6/26/20 3:13 PM, Bin Meng wrote:
> > List me as the maintainer for OpenSBI firmware related files.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1b40446..b0e2dd2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2609,6 +2609,13 @@ F: tests/uefi-test-tools/
> >  F: .gitlab-ci.d/edk2.yml
> >  F: .gitlab-ci.d/edk2/
> >
> > +OpenSBI Firmware
> > +M: Bin Meng <bmeng.cn@gmail.com>
> > +S: Supported
> > +F: pc-bios/opensbi-*
> > +F: .gitlab-ci.d/opensbi.yml
> > +F: .gitlab-ci.d/opensbi/
>
> Or simply:
>
>    F: .gitlab-ci.d/opensbi*

I was following the EDK2 entry example above. Should I send a v2 or
leave this as it is?

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for the review!

Regards,
Bin

