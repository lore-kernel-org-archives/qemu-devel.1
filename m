Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27FC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F612085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F612085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2KD-0002NH-Ol
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2IZ-0000zu-Eb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:23:19 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2IX-0003rJ-8v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:23:19 -0400
Received: by mail-ej1-f68.google.com with SMTP id i26so9198337ejb.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hNTinDprqW3xii2yLM0IctNp22SsHY/bLENgVkpbQGM=;
 b=cSmPwTxdb0N/gLuU0RYdo7XaZKnI4nl/JhZz1tDdZUmeg/mlJn1McWRXp5ZhTQknTr
 7ljkO/Ms9Gl8RuPrnSoSJfSHQeOYsIfZu64JU7IjKku0pGDhNWPJ4Zfz62LGdaBoVsnf
 n4cYUG0QTU2vhMdVrnWvqEBMZBTEC3lHRfIJsed0174F5vkBDs2SDqWU1n1diTdZu6HA
 cpOaWRzZ592bOFXy3LY+5LfePvPNHiAtI+AKDv45dm/6QoA68Nxs8ntlpZwomy/oyeJZ
 3OAZ9UZMT5Bz74Yq2oHvhxGa29ywo7CyYDVXDn7AbJ35IDEZX3YKoOYf5pZRkb4UMVlr
 /y9g==
X-Gm-Message-State: AOAM530gRI3HghTcPCeC6ACiTIku+mXjAacZp5soFKOS4KXURm6ypWcS
 1R+ImxdJhuPcDLtuyjXc6k3IHehx56h+4jxpRO6f5ImV
X-Google-Smtp-Source: ABdhPJxtV1vg1ZDmK/ubQeTiScvjDa0sCSJSOcW4OHusDNe7H7p6tPYyunjV8brWh4gWAIgpJRAk0lOL+isyXu6ZNPM=
X-Received: by 2002:a17:906:cb94:: with SMTP id
 mf20mr9648974ejb.8.1601572995313; 
 Thu, 01 Oct 2020 10:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201001172159.1619456-1-f4bug@amsat.org>
In-Reply-To: <20201001172159.1619456-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 1 Oct 2020 19:23:03 +0200
Message-ID: <CAAdtpL7u_XBCjUrOGVtLAr9WjE9cCeHiacQ5sQCzrmDLUdJbPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] hw: Let DMA/PCI API take MemTxAttrs argument and
 propagate MemTxResult
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 13:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 7:22 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> This is a respin of:
>
> "dma: Let the DMA API take MemTxAttrs argument and propagate MemTxResult"
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
>
> and:
> "pci: Let PCI DMA API functions propagate a MemTxResult"
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html

Err, wrong git-profile.

