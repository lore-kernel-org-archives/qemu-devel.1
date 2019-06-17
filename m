Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C213C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AC020833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="G/al513u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AC020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctWB-0003bW-Jg
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin@koconnor.net>) id 1hcsvi-0000YM-LV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1hcsvg-0001At-9g
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:48:18 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1hcsvf-00014E-IQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:48:15 -0400
Received: by mail-qk1-x744.google.com with SMTP id r6so6347613qkc.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/1G9F38qB4o9DsVWneX5D1Bhwhggpy6nLM7P47JkQe4=;
 b=G/al513utvUfliy3Q9Z4JfwvZxNajXLl26d7OJqniSSHpgL1V8fZDVLct39D91fwtT
 x5IaVv+LyTKglDqdRQ37yz4k0O8xfO02qeCchmb/g8Zw9Dmak9I2XgIrdOFF/peP5cyt
 P9pXugODc1V1l0WIgrFqAxthdqtKiRGMSyN+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/1G9F38qB4o9DsVWneX5D1Bhwhggpy6nLM7P47JkQe4=;
 b=ZVOd+vsCzb/0T0tw7SugJ9HLDwp7lWC7MXKw04kDUt/mUGKVhJB0CLEUg3CugFIAHd
 llqx4WkI8DlfAAvB6M/9EIm/f9SPzVTe7DrnVTkmZRv7nKFrIvDariEMN5QMRXjg5uRj
 YpDwaC9CR+nnZRE8HwzkIcfD3bbGf1Z+MLYsV7wmAbGC2SM7cUsk5cMS1XJhIRxivr3C
 3+P3MAdrJO84MzmJRVMpkXFv2xn7MlJgAtrCNxthhu2/Ru+AXBNVOsal4w5aIeYEMTnB
 Ht+Z9E27R1TzpRGHl0K2mf4JgFW/k1/75hsaeGVLVqfnCGMgiWiGPwGZ9QZOVQXioUNQ
 66KA==
X-Gm-Message-State: APjAAAVLakow+6zjFmHT2DRu/nr65sP176DgfIgfWxmZ4QEUzeGf94Fg
 ztRgSzEqPnUivWW1IfzFIgYrJg==
X-Google-Smtp-Source: APXvYqwEEz8Q3+X/FiYIwSzszk/c+Ur9oCEHuDRmioxne+NeW+dWXgrfReqU4I7sEputHIFa2jgwRg==
X-Received: by 2002:a37:9d50:: with SMTP id g77mr88982696qke.311.1560782892041; 
 Mon, 17 Jun 2019 07:48:12 -0700 (PDT)
Received: from localhost ([64.9.249.161])
 by smtp.gmail.com with ESMTPSA id u19sm7779037qka.35.2019.06.17.07.48.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Jun 2019 07:48:10 -0700 (PDT)
Date: Mon, 17 Jun 2019 10:48:10 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190617144810.GA31709@morn.lan>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612115939.23825-8-shmuel.eiderman@oracle.com>
 <20190617072040.yriunmoffbjhvqc5@sirius.home.kraxel.org>
 <ECEA4896-C290-45A7-9574-D1704C63842C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ECEA4896-C290-45A7-9574-D1704C63842C@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 7/8] bootdevice: FW_CFG interface
 for LCHS values
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
 liran.alon@oracle.com, Gerd Hoffmann <kraxel@redhat.com>,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 10:36:54AM +0300, Sam Eiderman wrote:
> So overall, WDYT?
> Keep it extendible for a low price of ABI + “bootdevices” name.
> Or go strict and rename to “bios-geometries”?

If we add another qemu to firmware interface I think the interface
should be documented.  I also think that a mix of an ascii and binary
interface is going to be difficult to describe and document.  I'd
prefer a pure ascii interface - for example a newline separated list
of four space separted fields: <device name> <cylinders> <heads> <spt>

-Kevin

