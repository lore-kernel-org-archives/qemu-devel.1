Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB361C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 07:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962D727860
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpIud2W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962D727860
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXKaD-0002UO-SN
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 03:07:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry.fleytman@gmail.com>) id 1hXKZN-00028f-M3
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry.fleytman@gmail.com>) id 1hXKZM-0007Fv-VB
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:06:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
	id 1hXKZM-0007En-Or
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 03:06:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d18so9144516wrs.5
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=F4SxbNs9+OdJkEyWYQYTX5pVqTHBdHIANG5zM+kL7F8=;
	b=GpIud2W2x5CGK/kqFpnT2rSFw+x8S1p8qpDJ8l2QRjLOks2RI69NzcqWhEYY3bnUEb
	87OeIDULFIhORocj78+X9YJXt7Bfjf/mlMKjgiUiRJz47NGTzSBpJHnT+K4bWpedWmEx
	JLAZw3AQU0ODy6xJqyED7foNGCSerHinGbSF9UfN/9z6q/ZbH9jNsowRbM2L8XwWnscF
	jENvWymd6NpQFsDXnzgBH7A+LatfH/umzlDzRv88WOMreUXgI2hGI8BQqSK8aMwSNVf0
	85RciY9NPgNNxsOHkoLUIEeVyIk9ZOb/KGY1URmddkoh6dYi79nykhtglmYMZP4Jbknt
	cfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=F4SxbNs9+OdJkEyWYQYTX5pVqTHBdHIANG5zM+kL7F8=;
	b=F/RX84RQP97NrPRftAMJjkBnJZDTUdPJ1CaeXgPEu9h3QI7z2UyzjC3x8NgdJvAAT+
	v1IExFeYMiq9MJyxX//6QYaHSStML32oYAYj4+fwQRyz5fMvd991W3uZ0lsd/areT+Wr
	6tHKgyOa8c5kogVgqdBrmIgtmMGZPwbjwmwss9cTORKS8DMzx0qVMwWz8MV4BjSfVGWU
	rRyS9kIcpNtwXnF55U/nRyX5f1UPAdU+dlSZDhMHf5zWdgIeLTLn+k7d7pAeFENsnZN2
	LTgZ2jWN1uL2mBv0DMxOa/33Q1sv7aIK8Ftl8kUgKV2wNoAqVHl6aqEHz0Db8kSGnTxQ
	Vzyg==
X-Gm-Message-State: APjAAAXwtREb+6pys5n/hpvy5ydE8KqA+XKI1DyuRVpYRKJryquf++gW
	slFCbthTlzHx9YnJolhtUDo=
X-Google-Smtp-Source: APXvYqxi+52euwQxwDNXcjpxhBKPRkDojR362HUgcRhuftG/iDVhUpU0OFJHfxPj0yYkk5oaB2wgkA==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr12530401wrl.140.1559459175215;
	Sun, 02 Jun 2019 00:06:15 -0700 (PDT)
Received: from [10.0.1.34] ([141.226.29.227])
	by smtp.gmail.com with ESMTPSA id s7sm10552395wmc.2.2019.06.02.00.06.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 02 Jun 2019 00:06:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
Date: Sun, 2 Jun 2019 10:06:13 +0300
Content-Transfer-Encoding: 7bit
Message-Id: <A3FBB0D0-AAAB-461E-9CDB-9CAC7ADDBF13@gmail.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> 
> hw/net/e1000e_core.h
> hw/net/e1000x_common.h
> hw/net/vmxnet3_defs.h


Unintentional.




