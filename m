Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46EC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A020207EA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLWxHJBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A020207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDho6-00035n-B5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDhnZ-0002gw-QY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:28:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDhnX-0004iG-94
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599110913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXPkfIbdi0U0VKJUAQ8X3T/fb8mZKyQITUgypEibqGQ=;
 b=PLWxHJBolvKH6oiNKCDkX96dJWT2VmozfmAM9I3nVvwY2i6gAnV8HQ38KN5hTcDTQBEj6v
 fsp1tNHCZ9KuYxI07han/O9zhXPtptr/Fdup82R6tNvCVuCZm+rhkJ7aVJN2weldyAWuei
 pi744O0TxFfv0tGbThWfEF5uA4p+dfY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-jTFUIYtkMbi-7UOixabYuA-1; Thu, 03 Sep 2020 01:28:30 -0400
X-MC-Unique: jTFUIYtkMbi-7UOixabYuA-1
Received: by mail-ed1-f69.google.com with SMTP id g8so786648edm.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 22:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MXPkfIbdi0U0VKJUAQ8X3T/fb8mZKyQITUgypEibqGQ=;
 b=VLj91JJeeysx2Pim91Du2WYD0GRh0LgBBGyfVrg1bx+5KwxWbcIy/xdeAE4ix3JJW5
 0wTpBwVGQ+J8R9+55i4sKDUcKcVD7dKFv5zcBxsKpZY0yNKNbD9oyCTU5mBV04I40GKd
 gnMz01idU7gML0cHPJRG3SLDb5KChlxlQ1v1x9RcdNJBuwJQ1x4m05V6byZC0cm7wq8i
 6yPnMbhO0NCcoWz9mq0plxuAvtXp93EbAGZ2bdDTadp164IjUcYRL6PqPktQHRDGIJBk
 Mf4Jt/iImmhl9ZqOCGvQhRpmCOraz1HLRVMdTQ1fKxA7VlqbJ8tJ8BuKXaMNuGnNM458
 0D/g==
X-Gm-Message-State: AOAM532srcqaZzHHx9j/LSYhc3FNW+H0Ao7NBZLGtyEXGAqUlTUrX/k7
 v1nL55ChhhiylZ2c66BxGyB3DKOfnwRgOkj7CWOsrqR1GIo7sQtY3N56Q9wxo5Ia19T6i2fQUi/
 UF4DyNzme+b9qMQg+RmMg/vkmSXvspPo=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr399231ejk.449.1599110909648; 
 Wed, 02 Sep 2020 22:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBMhcTuOf9THsqrQD1dQF28YPLyz9COLRryOm2T/mk9RO9ThFK0vC1ueUNHwG63OeTCHiyO0DzWwaa/ya4K5o=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr399221ejk.449.1599110909472; 
 Wed, 02 Sep 2020 22:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmUOtjEsQzUQZsARBcr9jjpEAu6Br8zozV8f8fQBxznFdg@mail.gmail.com>
In-Reply-To: <CAEUhbmUOtjEsQzUQZsARBcr9jjpEAu6Br8zozV8f8fQBxznFdg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 07:28:17 +0200
Message-ID: <CABgObfaVC5ts953qaJ5-0wLaF9o4BgXzQbenrY7F_SLFBR+K=A@mail.gmail.com>
Subject: Re: meson: how to determine which directory applies to the c_args
 during build?
To: Bin Meng <bmeng.cn@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b743ad05ae6205b6"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b743ad05ae6205b6
Content-Type: text/plain; charset="UTF-8"

Il gio 3 set 2020, 06:43 Bin Meng <bmeng.cn@gmail.com> ha scritto:

> It seems to me that when building hw/char directory NEED_CPU_H is not
> defined. However when building hw/riscv and hw/intc NEED_CPU_H is
> defined. I have no clue where to control c_args to build sub-directories.
> Any suggestions?


Hi!

The common_ss sourceset (and most others: block_ss, softmmu_ss, etc.) will
not have NEED_CPU_H; only specific_ss will, in addition to the entire
directories hw/riscv and target/riscv.

In other words, specific_ss is equivalent to the old obj-y Makefile
variable.

Thanks,


Paolo

--000000000000b743ad05ae6205b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 3 set 2020, 06:43 Bin Meng &lt;<a href=3D"mailt=
o:bmeng.cn@gmail.com">bmeng.cn@gmail.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">It seems to me that when building hw/char directo=
ry NEED_CPU_H is not<br>
defined. However when building hw/riscv and hw/intc NEED_CPU_H is<br>
defined. I have no clue where to control c_args to build sub-directories. A=
ny suggestions?</blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Hi!</div><div dir=3D"auto"><br></div><div dir=3D"auto">The commo=
n_ss sourceset (and most others: block_ss, softmmu_ss, etc.) will not have =
NEED_CPU_H; only specific_ss will, in addition to the entire directories hw=
/riscv and target/riscv.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>In other words, specific_ss is equivalent to the old obj-y Makefile variab=
le.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv></div>

--000000000000b743ad05ae6205b6--


