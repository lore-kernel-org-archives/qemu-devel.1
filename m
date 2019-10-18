Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0601CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9005D21835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QTGK7ZDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9005D21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLX7G-0005Wx-Qk
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLX6Q-0004jj-M1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLX6O-0003O5-Lz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:35:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLX6O-0003N9-Gg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:35:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id b128so4413140pfa.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=J5NHhj92JqRcZSqlpsHIP0+hdLynWn5d3wktBBmpCYg=;
 b=QTGK7ZDdXIs7cxJFi5s9ixZUuS/B+ZNhUpfFbg7PW/qczPNWT9RrWS+MG0N6+s4Gas
 UjP97+i1MgYommZbR9TO5sYBHQCi3dBUYUegVWZPascI0u+Sd0I6T1zvh8sp5FaKO+oM
 RDt7M5XaHf6/Fw6tU3FwdRj140qFJk+zQZimKD/4HOlSLSIH9Hm8yz+YbC4lKQxkr4aN
 Z5UZ0KOCyIdeX8AD25ZMzTEUaRtpHtz2zb3+JfvDKHrpr/nq4/32D7CpZgKdaYzxNLxf
 8dPwzFQ1gI7BWvvh97d9uqpUfNJ4TzFEDLAP7x8cmBF9j8a5WA1YYOEB3cZmS+2oSM+S
 gbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=J5NHhj92JqRcZSqlpsHIP0+hdLynWn5d3wktBBmpCYg=;
 b=jjD0xwsXnl7bOk661TnNRXvQjsuLFrsErU91J/d/k5BE1XhQ+tjh8SZCTBfRMaa+Zf
 +/Nt2ZERKY4X9A+QHw09AfE5jn4XwtKADKs4yCelMearr1kJn6L14bbSazhxnHT9DnAt
 UZyL0DENXYybGTet/DIdOlFWnslZt8iOyoBLbSVHyIsWsLXIMesRGu9fGLAynG+F7Z5K
 3w/tyMLqvl4g90nugfNkZft2nHkDLTtTB0F68NW7MZencve1k3+6PaK89sUXQHIWhRu+
 0IAoeavwtcQsk2Dk06h37Yg4euSPjYZ+k7xZ8zVmRTPtvQmc8BQgEtBcDJYMRDZstVE6
 l9Ew==
X-Gm-Message-State: APjAAAUxmk1tMBUa5eixJZG5SM8TBY15TvPl3Y1mNlrBf4EH4Yc3/lju
 yw+D9MLbqpx5CeIZgGnOjE3RIsqLHGkmYg==
X-Google-Smtp-Source: APXvYqzOR7+oMOgBS+Yxzp5UOu5HBeaQ4tE+v6HcO+GgBkQbGv28ynTZSLqWESLfJoEMWRch7VqdoQ==
X-Received: by 2002:a63:5064:: with SMTP id q36mr11357638pgl.393.1571423750491; 
 Fri, 18 Oct 2019 11:35:50 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id o42sm6170313pjo.32.2019.10.18.11.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 11:35:49 -0700 (PDT)
Date: Fri, 18 Oct 2019 11:35:49 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 11:35:29 PDT (-0700)
Subject: Re: [PATCH v4 0/3] target/riscv: Expose "priv" register for GDB
In-Reply-To: <20191014154529.287048-1-jonathan@fintelia.io>
From: Palmer Dabbelt <palmer@sifive.com>
To: jonathan@fintelia.io
Message-ID: <mhng-734b54c4-1d13-4fe2-8ded-bec866ecf2f0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 08:45:26 PDT (-0700), jonathan@fintelia.io wrote:
>
> This series adds a new "priv" virtual register that reports the current
> privilege mode. This is helpful for debugging purposes because that information
> is not actually available in any of the real CSRs.
>
> The third patch in this series makes the priv virtual register writitable. I'm
> not entirely sure this is a good idea, so I split it out into its own patch. In
> particular, this change will conflict with the hypervisor extension work which
> assumes that the privilege mode does not change in unexpected cases.
>
> As pointed out in a previous version of this series, GDB actually contains some
> support already for the accessing the privilege mode via a virtual "priv"
> register, including to convert the values into human readable forms:
>
> (gdb) info reg priv
> priv           0x3      prv:3 [Machine]
>
> Changlog V4:
> - Fix typo in filename
>
> Changlog V3:
> - Break patch into series
> - Make priv a virtual register
>
> Changelog V2:
> - Use PRV_H and PRV_S instead of integer literals
>
> Jonathan Behrens (3)
>   target/riscv: Tell gdbstub the correct number of CSRs
>   target/riscv: Expose priv register for GDB for reads
>   target/riscv: Make the priv register writable by GDB
>
>  configure                       |  4 ++--
>  gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
>  gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
>  target/riscv/gdbstub.c          | 36 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 58 insertions(+), 4 deletions(-)

Thanks.  I've taken these into my patch queue, which I hope to submit soon!

