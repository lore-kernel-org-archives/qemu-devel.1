Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F7C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED58220673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="HGKw/kSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED58220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyT4-0002Oz-H0
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin@koconnor.net>) id 1hdyCN-0006rR-VQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1hdyCJ-0000qz-U8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:37:59 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:42095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1hdyCJ-0000nI-Mr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:37:55 -0400
Received: by mail-qk1-x744.google.com with SMTP id b18so2033942qkc.9
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aNKDNvClUyiTS4GUiOcDaW+Einh5AtS/yLc5zOLbd7U=;
 b=HGKw/kSDHEFvBtmgf41QyWlKyzwdDYbeao/3+wPrZdAfkOofclAECeinXv7KxSQSgC
 SKndW05QbVoT92SpJODWRSOfpkFrlxRr9K4qZqIZWfPZ0oCAM2m2JnGrIhHeU/9t9EjA
 25rKvwpSnjeON26FogN31RrMG52qtbnDckvGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aNKDNvClUyiTS4GUiOcDaW+Einh5AtS/yLc5zOLbd7U=;
 b=GHRbKoKvF6mmCj5WGxtB8VrQvQdBEBOtPTdSbLxqkhycZ9x6QjXHu2iIQzGGN6W15z
 fgOLqDe81WPB365kBVEWwpoZraZ0rcqSSQW0j2BdkoL56dgmAtDnf0M+CB6wHaer5pYM
 1l0J6tptqmLSu9VqFpuoWWtJPIqnhyG84g+JPQjXgARheqfK0FPPC+Z3G9nj8A5qoKT9
 J8mcSIQy09dIN0/+qlQiCuT/UwiTT7crr0rlP6pyqpWXp33NULqVTinmxaPfDnGflkRi
 CUUL8p1U90IyKsgqVu84VXFuxw8iQxYXMXOf5IGRBv19Tio2MuMf07MRFV3CQ0LAizPY
 CgIA==
X-Gm-Message-State: APjAAAXxEpc1VqCKZ+Kiu7exc/afHqQ4eJyUadh+B4wXhPqtjz/9Wy13
 tzzOTobSDts9RJL23qJ4MxRJeQ==
X-Google-Smtp-Source: APXvYqxHlMLJ1XTRmnc0J5YEyDjI+bhXJOy+QkfGfoJ/9OwcFAzH79ONOPZibnWuvhLmu8RKuvvLqg==
X-Received: by 2002:ae9:ef92:: with SMTP id d140mr1112951qkg.443.1561041470584; 
 Thu, 20 Jun 2019 07:37:50 -0700 (PDT)
Received: from localhost ([64.9.249.162])
 by smtp.gmail.com with ESMTPSA id v30sm14338799qtk.45.2019.06.20.07.37.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 07:37:49 -0700 (PDT)
Date: Thu, 20 Jun 2019 10:37:49 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190620143749.GC17015@morn.lan>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619092352.23583-4-shmuel.eiderman@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 3/4] geometry: Add
 boot_lchs_find_*() utility functions
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 liran.alon@oracle.com, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 12:23:51PM +0300, Sam Eiderman wrote:
> Adding the following utility functions:
> 
>     * boot_lchs_find_pci_device
>     * boot_lchs_find_scsi_device
>     * boot_lchs_find_ata_device

FWIW, this leads to a bit of code duplication.  I think it would be
preferable to refactor the bootprio_find_XYZ() calls.  Instead of
returning an 'int prio' they could return a znprintf'd 'char *devpath'
instead.  Then the boot_add_XYZ() calls could directly call
find_prio(devpath). The boot_add_hd() could then directly populate
drive->lchs or call setup_translation().

-Kevin

