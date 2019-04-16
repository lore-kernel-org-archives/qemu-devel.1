Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9348CC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6273A2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6273A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIjd-00074s-DA
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGIis-0006o4-Ka
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGIir-0007oi-At
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hGIiq-0007ne-Uv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:41:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so23969060wmf.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 00:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=d1yMsvMrviqv10APImcyeMeq0Hogl8pUfApgsPnOIaU=;
	b=FqpQu4zT9KNBI4TFjB5Wkdq1hLFtaO2EuTKcObWgoLkMvRiFcuzQ1q50Wvssdr57lc
	0bN7Jijp3Oj44EzaioP8zPRCvwBzEvjV8x7mUx1NSJ2zwtt/aZDbbCMZ+CyyGsjmvk6l
	ii7ErSQoXS4kW8QNXAkP+oP8efrK6MlKmx7szKpaV3ZUZeINC/tio1/4p5AUf88gQ8cv
	S5xqHgILDO2BlU/9JoDkFSWeQD88Yyoi4cy39SZ3MFpVVUkObY33n4LepH1YlLAaaDvG
	Z7AAdDsL0A+bBgIn60eqffYIS9DadNxolZHuMsFHPPXAsrWNypKUVPOMS0YsZ4ntR4w2
	LFkA==
X-Gm-Message-State: APjAAAU01VRCu6qMnRRhbj4oo3R3K4nBnL+k9pflxeHiHGidwAx8U6Lu
	eSMWfhHn4pUeFCM+Hw4JFUKtDQ==
X-Google-Smtp-Source: APXvYqzsr2a8XqVC1FqMnUubY22lWdpUOO1Ve9LijbDpV0eCpFuMeyyjRPyAWhB8FvXFWpj0ZnvQhA==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr25130969wme.16.1555400498653; 
	Tue, 16 Apr 2019 00:41:38 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
	by smtp.gmail.com with ESMTPSA id
	t81sm40675234wmb.5.2019.04.16.00.41.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 16 Apr 2019 00:41:37 -0700 (PDT)
Date: Tue, 16 Apr 2019 09:41:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Message-ID:
 <20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416074135.xnc5Dx8NNOU_-_qC2Kd1NzQX-20QrTWA9gS-yClFbMw@z>

On Mon, Apr 15, 2019 at 03:20:42PM -0700, Max Filippov wrote:
> Hello,
> 
> recent qemu-system-i386 for w64 (e.g. one installed from
> https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
> refuses to load multiboot kernel by default:
> 
>   "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
>   C:\Program Files\qemu\qemu-system-i386.exe: Error loading
> uncompressed kernel without PVH ELF Note
> 
> Adding -M pc-i440fx-3.1 (as well as most other machines, but not
> pc-i440fx-4.0) fixes that. On linux host the same kernel gets loaded
> either way (with or without -M).

Hi Max,
there was an issue when we introduced PVH support and we fixed it. [1]
Maybe the build that you used (20190218) was compiled before the merge of
that fix (20190311).

Can you try to build the 4.0-rc3?

Cheers,
Stefano


[1] https://patchwork.ozlabs.org/patch/1042337/


