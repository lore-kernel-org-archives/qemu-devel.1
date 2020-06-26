Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3148DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061F2207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="ArZ88rsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F2207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jotBg-0004yP-8m
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1jot4H-0003Yd-Id
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:27:17 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:33830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1jot4F-0006pz-Qi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:27:17 -0400
Received: by mail-qt1-x842.google.com with SMTP id u17so8211887qtq.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iEJC1YlLyjXiFKqMnruqiG43upSnXlNcSKjzuG0A1wk=;
 b=ArZ88rsIy1MnR67Ncf5sMC06OJ8lS1G3Hs/drsNVP22evN7wqJ6DRWsQiTIxZxPa4x
 Aft7aRFMjn9xZ5urLDg3uVD1EP0/qJmM5FU+zYjuYT9ZYCOu1+WgW2HWAxxV6Nv11TyX
 sKVdgI+b+tgpH5GOQ1BYEp44fM9DYph5nUZe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iEJC1YlLyjXiFKqMnruqiG43upSnXlNcSKjzuG0A1wk=;
 b=rfYsKG+wVkZ4948jaZx4mwRwPaMz7eC35kKXYwMTZyJh24HV0xiUO6N9oumlELoRz0
 EVnvDB4VFfX1nvP9O3Ihrgq5wq+s36oP264t5a91O9fFy2hY8vjFjcRudbeJJkfIyI6r
 am0JtLkfF9s9K5x7n/QwmlWLVrGs2KoduWa7wnZTvhd6qGgBtDKGPFOvoaD08EmL+Hb+
 uMtqrK/LQMiTdCghB9HUg2QuZu2pexVwIUpHyP6qQWj8dq+6DekTx4PR6jpyG/dL2n0h
 g4B1f5/ZZ4O/MxSMpMUVa4EQJj3xdaBKAJaC8Ljt7Y/Ho7xEfftYqL19OOCgq66JuFQv
 /2FQ==
X-Gm-Message-State: AOAM533/gdfVYVUDjGtGT11atUPFW/mXW8pMw5mHlMfSAOdv6n2aLLrn
 B/6TEfGTmea1VDlTAAMbrpWr9Q==
X-Google-Smtp-Source: ABdhPJwopHER5LzhCPlNFZedaXF9ukpSjTepc3tAeeUrAzZPkNwFAXmdMNMjU2oRBiCgtx94lzMywQ==
X-Received: by 2002:ac8:6f26:: with SMTP id i6mr4119394qtv.61.1593196034473;
 Fri, 26 Jun 2020 11:27:14 -0700 (PDT)
Received: from localhost ([64.9.245.160])
 by smtp.gmail.com with ESMTPSA id x13sm9017992qts.57.2020.06.26.11.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:27:13 -0700 (PDT)
Date: Fri, 26 Jun 2020 14:27:13 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v2] timer: Handle decrements of PIT counter
Message-ID: <20200626182713.GA1074920@morn.lan>
References: <20200626180656.3441-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626180656.3441-1-r.bolshakov@yadro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=kevin@koconnor.net; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: seabios@seabios.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 09:06:58PM +0300, Roman Bolshakov wrote:
> There's a fallback to PIT if TSC is not present but it doesn't work
> properly. It prevents boot from floppy on isapc and 486 cpu [1][2].
> 
> SeaBIOS configures PIT in Mode 2. PIT counter is decremented in the mode
> but timer_adjust_bits() thinks that the counter overflows and increases
> 32-bit tick counter on each detected "overflow". Invalid overflow
> detection results in 55ms time advance (1 / 18.2Hz) on each read from
> PIT counter. So all timers expire much faster and 5-second floppy
> timeout expires in 83 real microseconds (or just a bit longer).
> 
> It can be fixed by making the counter recieved from PIT an increasing
> value so it can be passed to timer_adjust_bits():
> 0, 1, 2 and up to 65535 and then the counter is re-loaded with 0.
> 
> 1. https://bugs.launchpad.net/seabios/+bug/1840719
> 2. https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03924.html

Thanks.  I committed this change.

-Kevin

