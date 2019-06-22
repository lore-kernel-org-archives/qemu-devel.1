Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98062C48BE7
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65698205C9
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="QqLjs3fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65698205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hehwI-0002Mp-Vq
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 11:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin@koconnor.net>) id 1hehvN-0001t0-AS
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1hehvM-0007Tq-Dh
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:27:29 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1hehvL-0007RQ-Ux
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:27:28 -0400
Received: by mail-qt1-x841.google.com with SMTP id d17so10032571qtj.8
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2019 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=D8Ghnt7rx1ESzpx7eR/mkd2Nbcrnhfto5Fzru2YRauY=;
 b=QqLjs3fyoAED1/4ujYfP6b8W3cs7iOrH14DV5VAagqbipNH6o4egb09Di/bOhbR68F
 jzz6Ch+YBrJB/keQO2b1FFTfHolnrN1DOGpZzKcwnZXyGVuPzpSv6JxjR+jmDX4wCbKZ
 JIR8n6VE5pVL6yrZDv6yrMnEulPTjIlFf3Qnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=D8Ghnt7rx1ESzpx7eR/mkd2Nbcrnhfto5Fzru2YRauY=;
 b=IrDuilWVx0KClT7RM1ugRMAiCWnsxxFwsIPXQj2q0V2zsQZU147i5Y5U46UMTQyBlR
 S3+sB9SXvEsbKivn2ez0Q92n6AVXC0BwI+XxVDGapchrSFgh3mToRWboo3c13LfgDalE
 VlHLydZtiUQBy7DEfFlnsnRxsquB5NYHbqupQQfWVQI168aMHpSWo/j0Kkg17Mch08KN
 RGig1J0SCTGSrRGftQFndbAGXOBpG04Icsh4L9A9SHYnnILLr75B8XTtNVgEbZlZHCQD
 YtR+ngCzl2YP39JengsTu5CGFlKpaXEu8iam7fslaRXXIFdcnFOW9boTxEjCnx1kck8G
 ZLHw==
X-Gm-Message-State: APjAAAV2Kg2zsXx0fJjGcVpCzvq5ReBIDB3PScY+DPFJTRuVfpWy1+lt
 WgE0nW3VWt/2igjK7BysB1NSVQ==
X-Google-Smtp-Source: APXvYqzixu13IJFt8Qu9BD48SvZ/S5NtxcssHwdC/LhdV7ZC5Q81ocWc71SENVZxz8sOr5Oas0IfUA==
X-Received: by 2002:ac8:234a:: with SMTP id b10mr67605845qtb.261.1561217245803; 
 Sat, 22 Jun 2019 08:27:25 -0700 (PDT)
Received: from localhost ([64.9.249.135])
 by smtp.gmail.com with ESMTPSA id t8sm4167308qtc.80.2019.06.22.08.27.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 22 Jun 2019 08:27:24 -0700 (PDT)
Date: Sat, 22 Jun 2019 11:27:24 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190622152723.GA3357@morn.lan>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-4-shmuel.eiderman@oracle.com>
 <20190620143749.GC17015@morn.lan>
 <62F1EBAB-C7E8-42D1-BB6F-22C4945E51B5@oracle.com>
 <20190621185953.GA6620@morn.lan>
 <78884F3A-DA66-43B0-B504-AD12BC7BDC3C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78884F3A-DA66-43B0-B504-AD12BC7BDC3C@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com,
 liran.alon@oracle.com, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 22, 2019 at 11:51:48AM +0300, Sam Eiderman wrote:
> But maybe someone wants bootorder but doesn’t want to override legacy disk translations…
> 
> I’m thinking of maybe adding
> 
> if (!CONFIG_BOOTORDER || !CONFIG_BIOS_GEOMETRY)
>     return NULL;

That's fine - though it's (!CONFIG_BOOTORDER && !CONFIG_BIOS_GEOMETRY).

FYI, I think BIOS_GEOMETRY is a little confusing - maybe
CUSTOM_DISK_GEOMETRY.

-Kevin

