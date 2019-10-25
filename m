Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37CCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C5420679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C5420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0Fz-00061R-Ow
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iO09l-0000uq-LD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iO09j-0006nC-OR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iO09i-0006mV-VM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:01:31 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF7164628B
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:01:29 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e25so1197361wra.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XzFepOgs1y7bKGmpXv9Xpk2pWQ0kEHcpdtk2ozhrDbY=;
 b=pt8cz6kvbxmdPSvSclZdRJ7HxTCu56Eg36/5G+scuIZGCwZ+6C52B4bnZ5zPzTMm6W
 OKiL6cuDZDW5Z2n0plf6DOlJLyDXw4iCFfIXh2exg2tHMk/4rCMTJ0EJ4lYgx38RqaYa
 ezH/mCz/n285qTHgpnErniMJKyl/38unCaz6ePtjSIb6nPNQXVbZqw6fX27zkp6mC21Q
 K1a6qsReffEkC4AsBk4BDBnGLt/3sQ9FaZFh1MB8tm792U+fX5fcSIQaSMIYgNAgNRik
 biObrYq/7PVG5Z6NbYlH26mhsd9fOetSWqTFel4MWf1S11teVpkhQ+IX1/8Dw8L+pyj/
 h70Q==
X-Gm-Message-State: APjAAAU4LMG4sIrHYMiyK7lFQFT0DdTmCXi3ijcblq6Y1+Y8v8T3xjgB
 DNUbAXdE9E4HBzl/86rLKIJ4W9wiHIuMosBD2S46wz13QF6UQ1DWbT1jPozw9k2HE+ewGQ/C2+b
 EEFEByPwx+CsR770=
X-Received: by 2002:a5d:630b:: with SMTP id i11mr3013004wru.87.1572012088488; 
 Fri, 25 Oct 2019 07:01:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd54nw2Ao5J74UcO28L4aiMvtwLk0FFDWq1roDdKbqq9LOW+6tvmll9aHHGwQtAcv3b4PbKA==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr3012966wru.87.1572012088140; 
 Fri, 25 Oct 2019 07:01:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c7b:17ec:2a40:d29?
 ([2001:b07:6468:f312:9c7b:17ec:2a40:d29])
 by smtp.gmail.com with ESMTPSA id t185sm1443569wmf.45.2019.10.25.07.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 07:01:27 -0700 (PDT)
Subject: Re: [PATCH v14 1/9] esp: add pseudo-DMA as used by Macintosh
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191022111738.20803-1-laurent@vivier.eu>
 <20191022111738.20803-2-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dd7dbbb-dc48-7705-3865-e8a7bed75394@redhat.com>
Date: Fri, 25 Oct 2019 16:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022111738.20803-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/19 13:17, Laurent Vivier wrote:
> +        if (s->dma_memory_read) {
> +            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
> +        } else {
> +            set_pdma(s, CMD, s->cmdlen, len);
> +            s->pdma_cb = do_dma_pdma_cb;
> +            esp_raise_drq(s);
> +            return;
> +        }
> +        trace_esp_handle_ti_cmd(s->cmdlen);
> +        s->ti_size = 0;
> +        s->cmdlen = 0;
> +        s->do_cmd = 0;
> +        do_cmd(s, s->cmdbuf);
>          return;

Can you explain these lines after s->dma_memory_read?  I suppose they
are related to

> -    }
> -    if (s->do_cmd) {
> +    } else if (s->do_cmd) {

If so, it would be nice to make those a separate patch.  Otherwise seems
okay.

Paolo

