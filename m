Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0105CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF2722200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlv/9Sgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF2722200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUROY-00037N-9o
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kURNn-0002g9-35
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:23:11 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:37674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kURNl-0007lQ-Bj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:23:10 -0400
Received: by mail-il1-x142.google.com with SMTP id j13so9740815ilc.4
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M7zMqBIzaYC8t0KoPaFRCpogFr9O8bSVaG7aPpieQD4=;
 b=mlv/9SgcqSzEsTUZx9aRiX8kkAQ5dvoCcGrbk6YP/JHefD8mEwqyBM1VYGzHZ9CQbt
 jtidmdeeBcV4VbN4G2xxlCnrDicwAvX8SJmS7PwSS3wuzRvKZiKLGuQicQGejlxlSnuB
 u5KPuO5rQuZIcabFcytDQRlyE0mj667ifS/5RYIIMUkhGPMiq1hqB5ORtJHWV44gCvRH
 7X4dxW4mVf2gvtXb+A+JRZOdE/1Hb+vtzNgt2b0NFlWoWum3DMR7BUzB/DTF0Fsm3pcl
 i2WspKoi2wZyTZnUgzIHYAgSBfqZid55HaFPxHD5dRFaaAymjo2//WtkCE3QacYbPQ8i
 LCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M7zMqBIzaYC8t0KoPaFRCpogFr9O8bSVaG7aPpieQD4=;
 b=t7rFFLpiIW5kIZXWca2aR/qqqc775uMRW0+uQdJpKPT8GegCdSQQd+F+qcy3edl/vi
 4fwG2H4p2lFTAajRSwjWQcF1hFD0OIUzkkMogEo/D93zNSOR+TOv8AXKwiqUhYtPmTJ0
 v0BLgpCnHdOMrG++FTo4C8+Rrg1OZ5r9KkoOQQx0D4gqL3SOEiseahbN2nOFHEwr4Qbb
 Eo+5qo8LgvBQFJrLAhdhzfmXzd7OM3npmH+vXp5u8FT80xvjnpmCCCOcteatwO68YhZ9
 zU2Jldnc/DDQ+moh1uIBc9HOLwCAuiCErhol5H0ooSk3XJ2QutqcqGAcBg6NDRDTalGU
 rM+g==
X-Gm-Message-State: AOAM5331IG7Uu72HWHSJEdvs7w8XXyXs9wiEJOOIzQpeey8rZRwGvt23
 zdZ5+LYSIfsT2RXM/7O5RXZREx+zY7K9xYwuixY=
X-Google-Smtp-Source: ABdhPJxGIkaEEmNkCDdDA+n1nnJLFEJi1EMI8Ug7uTfGxLgBJQBjMXMdt2JxEkCXXD/BwUsOZKovV+VDQHJ3I90X2e8=
X-Received: by 2002:a92:c04c:: with SMTP id o12mr2851792ilf.22.1603099387435; 
 Mon, 19 Oct 2020 02:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
 <20201001085900.ms5ix2zyoid7v3ra@steredhat>
 <CAD14+f1m8Xk-VC1nyMh-X4BfWJgObb74_nExhO0VO3ezh_G2jA@mail.gmail.com>
 <20201002073457.jzkmefo5c65zlka7@steredhat>
 <CAD14+f0h4Vp=bsgpByTmaOU-Vbz6nnShDHg=0MSg4WO5ZyO=vA@mail.gmail.com>
 <05afcc49-5076-1368-3cc7-99abcf44847a@kernel.dk>
 <CAD14+f0h-r7o=m0NvHxjCgKaQe24_MDupcDdSOu05PhXp8B1-w@mail.gmail.com>
In-Reply-To: <CAD14+f0h-r7o=m0NvHxjCgKaQe24_MDupcDdSOu05PhXp8B1-w@mail.gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Mon, 19 Oct 2020 11:22:56 +0200
Message-ID: <CAM9Jb+gip_ahaA6Chwrt62pkfuJ2HfZki84pPSKEJhaQaSovMw@mail.gmail.com>
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
To: Jack Wang <jack.wang.usish@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jens Axboe <axboe@kernel.dk>, Ju Hyung Park <qkrwngud825@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, io-uring@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

@Jack Wang,
Maybe four io_uring patches in 5.4.71 fixes the issue for you as well?

Thanks,
Pankaj

> Hi Jens.
>
> On Sat, Oct 17, 2020 at 3:07 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Would be great if you could try 5.4.71 and see if that helps for your
> > issue.
> >
>
> Oh wow, yeah it did fix the issue.
>
> I'm able to reliably turn off and start the VM multiple times in a row.
> Double checked by confirming QEMU is dynamically linked to liburing.so.1.
>
> Looks like those 4 io_uring fixes helped.
>
> Thanks!
>

