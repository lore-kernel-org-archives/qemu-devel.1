Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2ACC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8A020675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60255 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL96i-0001Ca-Mx
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:26:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL95r-0000pV-JZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL95p-0006Ir-Kv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL95p-0006I4-DJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:25:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so8450060wrs.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=WdLemah5XDODp4R5Eq7GMdg4IzMGRASWNULx4ZFp/v8=;
	b=Jf509PwXeIee4ews/vvDmnL18UX7yutT2GTbM9VlzVojwlHMQIPEkEl6b7B8TyZUpE
	74CjXNx5tblS3hEaM1i3zPfEPF/UtsT0U71h1jn6tPLLETlPzr9RSUsHGlxkFSH1VsKm
	rXEP817Xwg8huoh1N/IgzX+426ZgD3jhM8D1GvCrG1bDB1WHZ9NAdmhVBHmgUxaxPKv8
	kW+57CH++bq/hoBOERmop+Br4zY7VmVef6cCrppt1WvVlisQXYiqMWmw9fBJ1JzRNate
	XkQboC8DEO5jil8ugAsLmev16CMh2MonBuMPY68+hMxn/DBUFz5660C3R87XpSQtBtKV
	V/ng==
X-Gm-Message-State: APjAAAUMZ3UBY7fHhGN+MoCuGFbliUZilE0o4WWzx53cgcNY7Ok0MKWk
	sHERCEATVuk+mFN8Q0Novrh/3A==
X-Google-Smtp-Source: APXvYqwvku6Zrmzx1jgmEplRTwrxRkEGnVhpIMCuzIoAbHSmSEUkrGLLUscNXgSPS0EG06blF98xPw==
X-Received: by 2002:adf:f390:: with SMTP id m16mr27637822wro.25.1556555122501; 
	Mon, 29 Apr 2019 09:25:22 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	e7sm29737618wme.37.2019.04.29.09.25.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 09:25:21 -0700 (PDT)
Date: Mon, 29 Apr 2019 18:25:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bug 1826393 <1826393@bugs.launchpad.net>
Message-ID: <20190429162519.s7twbo5jiiylzdfj@steredhat>
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
	<20190429154733.GA13640@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429154733.GA13640@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [Bug 1826393] [NEW] QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429162519.sR36jJymmTKW6l5XRrfrtVhmzRvJJl37dW3dypJaX-U@z>

On Mon, Apr 29, 2019 at 11:47:33AM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 25, 2019 at 11:37:02AM -0000, Waldemar Kozaczuk wrote:
> 
> Please try building QEMU 4.0.0 from source:
> 
>   https://download.qemu.org/qemu-4.0.0.tar.xz
> 

It seems that is related to an issue with some TPM timeouts found in
SeaBIOS 1.12.0:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg575060.html

As Stefan suggested the new QEMU 4.0.0 should not have this issue since
it is shipped with SeaBIOS 1.12.1 (where the fix is applied).

If you want to use QEMU 3.1.0 with the new SeaBIOS, you can download it
and use the '-bios' parameter:
    $ wget https://github.com/qemu/qemu/blob/v4.0.0/pc-bios/bios-256k.bin
    $ qemu-system-x86_64 -bios /path/to/bios-256k.bin ...



