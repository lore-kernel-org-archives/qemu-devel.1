Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070BE20833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070BE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsKd-0007mG-AW
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:06:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsJY-0007FW-Gr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDsJS-0002UU-OG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDsJQ-0002T0-Ui
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:05:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id s81so10399532qke.13
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=DkI6+Jmr1HqoXwpqBnUVXx75L5SH7HYiCrTxxaiZLls=;
	b=fLYv/k0eu5Dy2BGWTr5L2rDECBukzX9mnLpJa3GtZA5TUtbbCBC86pgU3hf3IM8ydp
	FqyfhVJNOTrE9NmIFbOhxTe2i+ll9yv5foxh6RSP+uTM+MMeWYcuzVq6qdTC84IGMbDI
	4rJztkyACHZcjiimZv6l1Xz7eWXLtwExsmCFpRLg0gy+73LKSz2/iMgcMbxKYmwfleuf
	orFyum7m5mahDPb6Qg+DKGbdzW9fbw9cO3Gpv48ahqIqrqIrDsPt1LWoq9edWn9jDaGk
	NEbzy2qNpP/HwgTs9b+dV5mgl3SVXadyEPjYYsYmxY06z0z+pvkkKVsR2a0nNQsf3EGY
	RZ1A==
X-Gm-Message-State: APjAAAU/4JDhwi5RSiIwcFnz/dtup8VHH2Wm4M1XN60bhW+Q0EeIXQl4
	WUVBr/K1HW4+oteAu8uIgGjoag==
X-Google-Smtp-Source: APXvYqyM1juXANwTP+9FvFK2jk5EGiMdFdf9NZunZpze1c1zTRrzmSA+XEAR2YWbVZXj8/03sz/qsA==
X-Received: by 2002:a37:a4d1:: with SMTP id n200mr27633833qke.62.1554822322529;
	Tue, 09 Apr 2019 08:05:22 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	w12sm18192633qkb.91.2019.04.09.08.05.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 08:05:21 -0700 (PDT)
Date: Tue, 9 Apr 2019 11:05:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190409110456-mutt-send-email-mst@kernel.org>
References: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409150519.D2888BzZdtE20aDf2LvbnBQAeCxz_dtEf2j3ujP42qw@z>

On Tue, Apr 09, 2019 at 03:45:34PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Two trivial fixes to avoid the latest EDK2 testing series to
> cause trouble to downstream distributions (in particular if
> they have PIE enforced).
> 
> Since v2:
> - addressed Laszlo's suggestion
> - reworded patch description
> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00992.html
> 
> Regards,
> 
> Phil.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


Peter do you want to merge this directly?

> Philippe Mathieu-Daudé (2):
>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>   roms: Allow passing configure options to the EDK2 build tools
> 
>  roms/Makefile | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1

