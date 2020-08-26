Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE2F2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFg604e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE2F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxT7-0002wl-Kj
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxSH-0002QT-OA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:35:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxSF-000795-68
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zd3U2ZqiVcOpyVZoC8gS1a5oVN3G0Cv7jXqLT8FNZMU=;
 b=KFg604e1AzikApwiEidi43NVQ2eexmQa86Zhz9VFsJnz7zZMs9NQDj4epCC4DwzLoogl7T
 nnWEZCIHPyxVbRQEmW3ioF69w1ghBWzuDx/OjL/V3x0ehU1QQRaQUyhE3GB+bTgPpofU1t
 a4M49Ed0R6Rr1nOZX99L0TxRr36BumY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-sbSHa_tYMYa_2nbbtllZIw-1; Wed, 26 Aug 2020 11:35:11 -0400
X-MC-Unique: sbSHa_tYMYa_2nbbtllZIw-1
Received: by mail-ed1-f70.google.com with SMTP id c3so819938edm.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zd3U2ZqiVcOpyVZoC8gS1a5oVN3G0Cv7jXqLT8FNZMU=;
 b=J7xWYBjzeroT6qQXaTg3udZ54LA0hnDLzm7kwRuT1X0Evdio8IuO9VvRKTjTvEXV6K
 9bMAz3kWUk6QRLKrCrdyWLzKolxIYys2T6ThhID+cCRmJn5pECx0JYTgAXdXiDTyUpdp
 KjSaCL/sQhsX/v5FlfiAJOBpY1+KLQ+JdGBxi9OcRDEu3e1xHRUsxHLwZjvw4Lgyrfgy
 lF+7LERKSIhLcRDDevRMz+aKnZhWGLZ2RVIPkTmyMMTmPDccSmkeA17HhLaukY8EraxR
 HaTmPFVOo1KwrEkoRQJ0c5F/FGu9a3kxNTS75W8bGpgJhtCKdehxgNdY3MRXhS+FvWyV
 2S3w==
X-Gm-Message-State: AOAM533ndFN99O1d1T0kSZIzJB61Af1nKdy/hp/vN4AZ4MCjGzLtpwuR
 kUrFn+yW5GpOADBw/8atXLNUf7KHm3cnKWPkeWH1/gIxqDyofCvQeucrNjLXrZAcLZ+zm0xrmmf
 JXFjcgb+29JXYDRo+Y5ume7TEIqvOo/Q=
X-Received: by 2002:a50:f781:: with SMTP id h1mr1357276edn.308.1598456110599; 
 Wed, 26 Aug 2020 08:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvrVi0BgjHBdOpW7PC7JWwfge0CEYnZLDPNv6jaMX1fdrWZPgb/KWENHFU7c78mwfC5cLrL/I/rs9u476KWMI=
X-Received: by 2002:a50:f781:: with SMTP id h1mr1357257edn.308.1598456110404; 
 Wed, 26 Aug 2020 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
 <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
 <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
 <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
 <5ae18146-7a8a-c0e6-0b25-c5d0408392e7@ilande.co.uk>
In-Reply-To: <5ae18146-7a8a-c0e6-0b25-c5d0408392e7@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:34:58 +0200
Message-ID: <CABgObfbW9b9StcYAN+uR-tsj123OPKW2qwoSR-k9+8q1XkNCSw@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: luoyonggang@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 12:15 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> ...
> -rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-stdvga.bin
> -rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-virtio.bin
> -rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-vmware.bin
>
>
> I would expect the majority of these files to be in share/ or bin/ subdirectories as
> they are in Linux.

This has always been different between Windows and Linux:

if test "$mingw32" = "yes" ; then
    mandir="$prefix"
    datadir="$prefix"
    qemu_docdir="$prefix"
    bindir="$prefix"
    sysconfdir="$prefix"
    local_statedir=
else
    mandir="${mandir:-$prefix/share/man}"
    datadir="${datadir:-$prefix/share}"
    qemu_docdir="${qemu_docdir:-$prefix/share/doc/qemu}"
    bindir="${bindir:-$prefix/bin}"
    sysconfdir="${sysconfdir:-$prefix/etc}"
    local_statedir="${local_statedir:-$prefix/var}"
fi

See also how os_find_datadir() is different between Windows and POSIX.
I plan to fix this mess (and incidentally the pre_prefix hack) in 5.2
by making the installation relocatable.

Paolo


