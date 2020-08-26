Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081D2206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opit0uym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081D2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kApDm-0002MN-9Q
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kApD5-0001ly-Cn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:47:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kApD3-0003CR-GW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 02:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598424420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53fJffuhVAFqcaiP+FBQJVj/VoR1GkkHjrfT7N0R34E=;
 b=Opit0uym6tShM3oEOt/Etws1eZA6frLk19dWUn/AtCKLmuEPTqZQVo22ltIURjnamUvrJq
 qew4InYHn9svJlu681rYfUbK16pddxYxiap8OGL7rCNqpoN7CENsttWcNfOapO4R3MxsC0
 8wxiPryCQdhzoagNjIRyGfSBH02g1n8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-dYUpKqq4OFy0F4lufgJMTQ-1; Wed, 26 Aug 2020 02:46:58 -0400
X-MC-Unique: dYUpKqq4OFy0F4lufgJMTQ-1
Received: by mail-ej1-f70.google.com with SMTP id f10so495343ejc.23
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 23:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53fJffuhVAFqcaiP+FBQJVj/VoR1GkkHjrfT7N0R34E=;
 b=ZOsOU2kHA9yZS0Hn8gQ+OKeuh7xVnNs6qnhLZju8GV2MYC0W+M+HV13AvvVu+mxMHw
 FsIziUjBsEUu2b0fRsqTEiapTEoD6gBpoqNKvz7e2f/ZgWsQCOzasE7amV7Sg0TXy6Oj
 zFEUphRExrXl3Wcbl1ySbYuSnvWbNPjMacTyAAqbwLSeWDNSn+Prf7ptGp5oVqQiAhAW
 qbMGZds8S73+/c6syA6pEvvwNZ3fwwQ79xOEtrdakAged+SKfKocdf4QHsbpVpdMAuvl
 kB6S/W+kWHjo7S20IP0za4y9TNqcUPQd29Vtjs0hY7tDSgwQKz1wZ4oMSwU0MoFNRJ97
 RoDg==
X-Gm-Message-State: AOAM533JvzqykiKSDYqlWUClZSjzyssclvOy9Gml7GDRRhgv/6BvIQyY
 ewrnvL1BsX9ob07Cp/ItbwuN9pbOXo85t5NPszrXT4bk2qqfdiWsgnUZOdScGrxtqyd8MQdBnBa
 SSUhu4LHxnfgCbgu/YWunNrF1t3aTTK4=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr5070241ejb.121.1598424417202; 
 Tue, 25 Aug 2020 23:46:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/oxJ1ZGLduhh8WuCNTvPUvA06J4/u1jdy9h9k0X6xJf9uUNOPKMzYwsfhvFk76dD9z8nZwTRDX1+rpO+cUmE=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr5070235ejb.121.1598424417047; 
 Tue, 25 Aug 2020 23:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200825165341.520-1-luoyonggang@gmail.com>
 <20200825165341.520-2-luoyonggang@gmail.com>
 <acdc6a3d-5188-e906-bc86-b0090ffe5a42@ilande.co.uk>
In-Reply-To: <acdc6a3d-5188-e906-bc86-b0090ffe5a42@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 08:46:46 +0200
Message-ID: <CABgObfZUkzym4-SbuAtzh-Hkhg9=ZVq==UEFutmcrpKP5x1r_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] meson: fixes relpath may fail on win32.
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:47:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com,
 =?UTF-8?B?RGFuaWVsIFAgLiBCZXJyYW5n6IyF?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 11:31 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 25/08/2020 17:53, luoyonggang@gmail.com wrote:
>
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > On win32, os.path.relpath would raise exception when do the following relpath:
> > C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
> > So we try catch it for stopping it from raise exception on msys2
> I don't think this is relevant in my particular environment, however it didn't seem
> to break the build. I'm curious as to why os.path.relpath throws an exception in this
> particular case on Windows though - can you give us a bit more information about the
> Exception that is being thrown?

I think it's because it's impossible to make a relative path between
two different drives.

The patch is correct but is missing the Signed-off-by line.

Paolo


