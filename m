Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE472073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4eEYPkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE472073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX2G-0002V6-Hd
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdX1K-000242-Cw
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:41:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdX1J-0000yU-Lp
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:41:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so2652684wmh.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KDb1k3gIlJOUwEbOPgZgn2WJCatP0vJMX1zPjMQzynU=;
 b=b4eEYPkZ0Q8ops+zX0FRQx5SARpGTNzQVB1Ilkwc69Y0L9tU/ZGNqnUar0IQkHyzW1
 cYUuLzGG7EOL50/rWg/bZqcgq5SC1ZpUezbw8w+sbOuyWQcttT6BZ9d9IneK+6XN35jX
 sDlfy99hQ9V5QGThVldNACFvogphYySPlUya11MXRiryyRvJ9zEU+IvF2fVRm9QlJuvD
 84Kysl7eAHF5ypdT4MO10RdlpkKH/ZM6BQYUSN4/Zs4xAYHEccjwnVDCEk7BruDiZFbe
 U37tTipPMVdBSPqwDlGRnmjJFRKpS0g3Bmb9dYawf0YBA+t1v9ydJno82t/MyELW8yDC
 +0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KDb1k3gIlJOUwEbOPgZgn2WJCatP0vJMX1zPjMQzynU=;
 b=Wxaf5Qy1PfFGzTGQWnLSvMGNQHhtwkVHMwePDWeZxePyitz6zMa9goIAl9hERvCQ7O
 0gGA9mR0G9bOmwbturHk28m4/tV0QTayXnXrGYFD4RyghLO3IV519HEWPiMZQ+oMy0bI
 n4IKzzouEVGdpF/V0stz7zm/oKdwjKohJIW18Y2eJzXvjNSys2EZrN0h+tJ2aE47PhT4
 TZtODGwdwDXfDdKfbzPrOpYlC5AV5mxeXGR3f3pJFbRZLp2a+9dWZ0MK5Tr8yWwApj8U
 gD8iqjv8H18nQtkLqw2iBcXTwwR7BHQAu58s4jXye40aJ5ZBtccv+BPeiU7lD1UDxZau
 nM8w==
X-Gm-Message-State: AOAM533vKPa/upqQFy2HtV6zFZLqCnOb36fHUMpbOdIEiFw70esvtJEs
 IgqKWEyrTCRcHgVdDyNP5wvEskeRVPW0AI4doV/NLexp
X-Google-Smtp-Source: ABdhPJz8Uub4psrHQNCVZlr9NJ/Cr+JCN+Rh/fktiOVE/+R/SD6BqLtmtz9kHfOAU0WBKdK5ohWpMYN2RKswNMJg2Zc=
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr737529wmt.129.1590489676292; 
 Tue, 26 May 2020 03:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <2d2d03c8-d881-2fe1-b7d6-ed539273012b@redhat.com>
In-Reply-To: <2d2d03c8-d881-2fe1-b7d6-ed539273012b@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 12:41:03 +0200
Message-ID: <CAHiYmc6JC7piuzAszVWSVQKVFBgTUqwMB2EKqYY==fDJocBwMw@mail.gmail.com>
Subject: Re: [PATCH 00/12] hw/mips/fuloong2e: PoC to fix hang after reboot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 09:47 Philippe Math=
ieu-Daud=C3=A9 <philmd@redhat.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/10/20 11:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > The PMON firmware behave differently regarding it is run
> > after a cold/warm reset. A simple bit flip fix the issue,
> > however we need to know the type of reset to set it.
> > Currently QEMU only supports COLD reset.
> >
> > This series contains various of my current Fuloong queue,
> > - Welcome Huacai Chen as co-maintainer,
> > - Fix typo in machine name,
> > - Few cleanups in Bonito64,
> > - Report various Bonito64 accesses as UNIMP,
> > - Proof-of-concept fix for the reset bit.
> >
> > The last patch is not for merging, but is included to see
> > if the Multi-phase reset mechanism can fix the problem.
> >
> > Regards,
> >
> > Phil.
> >
> > Huacai Chen (1):
> >   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
> >
> > Philippe Mathieu-Daud=C3=A9 (11):
> >   hw/mips/fuloong2e: Rename PMON BIOS name
> >   hw/mips/fuloong2e: Move code and update a comment
> >   hw/mips/fuloong2e: Fix typo in Fuloong machine name
> >   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
> >   hw/pci-host/bonito: Fix DPRINTF() format strings
> >   hw/pci-host/bonito: Map peripheral using physical address
> >   hw/pci-host/bonito: Map all the Bonito64 I/O range
> >   hw/pci-host/bonito: Map the different PCI ranges more detailled
> >   hw/pci-host/bonito: Better describe the I/O CS regions
> >   hw/pci-host/bonito: Set the Config register reset value with
> >     FIELD_DP32
> >   POC hw/pci-host/bonito: Fix BONGENCFG value after a warm-reset
>
> Thanks, patches 1, 3-11 queued to mips-next after addressing Aleksandar
> comments.
>

Over all, I think you should have sent a new version of the series
rather than starting applying to the queueu.
Philippe, I think you should "unqueue" everything, and start from
scratch you queue.
In future, I think you should coordinate better queuing, possibly in
some separate off-list messages.
Patch 4/12 - does it have r-b?

Patch 9/12 - I don't want to block you r work, but you are making some
missteps that are not good here:

- i did not see how you addressed mu comments
- I didnt give the patch R-b, neither I remember anyone else
- I am against pull request with patches without r-b, if that is the
case with 9/12, and insist on applying the same principle to hw/mips

