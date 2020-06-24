Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE62FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FCC206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="ZlX+VurW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FCC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnvf9-0003tI-QJ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 23:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1jnveJ-0003AY-1B
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:00:31 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1jnveG-0006nJ-RK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:00:30 -0400
Received: by mail-qk1-x741.google.com with SMTP id e13so586066qkg.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LyFIwB0mWcDq6u0IhVq3NzrlZxo44JvPUF3iw2kZdP0=;
 b=ZlX+VurW2vQVYJS15Uab1/0Fz6tWG7KfhcbC+gyMCjn/PPPCvp5LJOdQxFWWFqD+i5
 +LUI7HZSWirX+tqwrAfT1DraumWKedR2V8BZwBXSqhCU+pxvr4ArFtTq6JOz/TIdlYz5
 2yQbEMFdr0NYKQRFIoIVmbV9Gog6uCY0SJrVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LyFIwB0mWcDq6u0IhVq3NzrlZxo44JvPUF3iw2kZdP0=;
 b=RG7IoriSP0fJpiFt828/4U8dnN9I23/0IBsMS0LNrIVEXkp0EDiznhM+B49F8g4Eoa
 ww3sUm/6zZSOr73w0qsRB4mPRVGFJ05q6zjnsDF5p0lUG3J9qf/yQpY4LIYcRASJAsa5
 ABmqJ3Qk3kREZJx6+DpO4mNp3mJLfQJjtPQnRkVClXCLCQEaN6eCOPbMH2CaZhdCLkdo
 HvdV9slDjFefZCH5NKXZwp7TRcIuhCzPgAhdRQdDo5Zv6cXN0m62JNHu9ZosFfBG9e0t
 G4h56WXNdNMuJP4Vur49B4ILcrkvpiEcbwDeLCCpXhRyvDZzx/LU6e9NTPG2SOOLiInx
 rgJQ==
X-Gm-Message-State: AOAM533OLq7RtWj5uclNj2pH2D4/NM1rK0v6RDtYKZoodzczwWLzAbop
 3qPbrgsV1ZXX8qft3t0wctfrQQ==
X-Google-Smtp-Source: ABdhPJwJ7SKmWGzFhItijCexjX1GB0OcpZJisqjVRLzkQqKng66Ua6d4iLjlKAx9O+/gjTN7HFpOmg==
X-Received: by 2002:a37:6190:: with SMTP id
 v138mr20982269qkb.121.1592967626647; 
 Tue, 23 Jun 2020 20:00:26 -0700 (PDT)
Received: from localhost ([64.9.245.160])
 by smtp.gmail.com with ESMTPSA id k26sm2190309qki.98.2020.06.23.20.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 20:00:25 -0700 (PDT)
Date: Tue, 23 Jun 2020 23:00:24 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH] timer: Handle decrements of PIT counter
Message-ID: <20200624030024.GA885327@morn.lan>
References: <20200613111911.65497-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613111911.65497-1-r.bolshakov@yadro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=kevin@koconnor.net; helo=mail-qk1-x741.google.com
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

On Sat, Jun 13, 2020 at 02:19:12PM +0300, Roman Bolshakov wrote:
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
> Provide counter direction to timer_adjust_bits() and normalize the
> counter to advance ticks in monotonically increasing TimerLast.

Good catch.  Could we fix it using the patch below instead though?

-Kevin


--- a/src/hw/timer.c
+++ b/src/hw/timer.c
@@ -180,7 +180,7 @@ timer_read(void)
     // Read from PIT.
     outb(PM_SEL_READBACK | PM_READ_VALUE | PM_READ_COUNTER0, PORT_PIT_MODE);
     u16 v = inb(PORT_PIT_COUNTER0) | (inb(PORT_PIT_COUNTER0) << 8);
-    return timer_adjust_bits(v, 0xffff);
+    return timer_adjust_bits(-v, 0xffff);
 }
 
 // Return the TSC value that is 'msecs' time in the future.

