Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2AC47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642CD2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfaqKQfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642CD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3nM-0005Vy-I5
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3mW-000511-KY; Tue, 05 May 2020 16:03:08 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:37548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW3mV-0004Hy-Rp; Tue, 05 May 2020 16:03:08 -0400
Received: by mail-il1-x143.google.com with SMTP id n11so11293ilj.4;
 Tue, 05 May 2020 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mg6aRzAs1PiRXeP8N6F3+uzviD7Pj5yIv4OQsIs2Ds0=;
 b=GfaqKQfs/Hk+rJEa399uKn2PvjeDut1a/hA/Ez9VuN8VOY4fMlroE33HL+Ax1RPNaa
 AXKYWiws9Av4nzU866I1kGcjee9O8xcm1OAhY+Y7Lo16b7P8+Qc1x1HM5bB4Tg0k5pFA
 snSwIUvLugfMer6JyFYRNdr2FRVsSGwlg4e9eaG0rZTj/Vyg5VB3XB21xiXHhGc7WWJI
 buoa0jHPF0KAiky9XmRJwuGxUCFd3EV8GxFvdab4SEpU9Doh2J3J8hMhfca+dHnf8XMM
 kET8oDinJTNvMQPAlYo+v2FieXvjmX0B3IkaGutxaTpozox0TNknGPsoLfL29d3IBv0s
 73Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mg6aRzAs1PiRXeP8N6F3+uzviD7Pj5yIv4OQsIs2Ds0=;
 b=irz+sDiFgap6jujvxW1v+ZyvljdValeqQNNPTWu4Xq4IG3+39lXnbd5PK9EK7sM/2C
 AoIFyE2eDM3ifD8//ZsJ+yE9mLqpf2rog3lmQXajEXxCtCwkKzo0D2FEUhLWUzLvih6w
 KlySouk1s3mqS5Y4e+y+v7PuJvuZoCDmYNgr+Syb5FsTItkAJg7nuOtt1wuXyCJQNuDb
 NhCBzs9DTC6XZoegHwHad+bmXhi551hiFzM2eg70Qpyfj0rgx1hEXBQvyqnanAF2N1lh
 e+TSKu+F5V6YOi+vbSInaeVWVotDGx39HslLfGNCY+wUTFkJiPUtIwDZShEL68qRf0br
 v/Ug==
X-Gm-Message-State: AGi0Puboz/J/JqWMagiA6lXKkrP1zF9Zru9i7ZkzXjavicrmF5fa4R2f
 A24KXbvD3OCq6BkNYGV2Y4WASU37WnLZItP9IqE=
X-Google-Smtp-Source: APiQypLR1dOBTbGl2x7Yk8gv6q24isesGTq4oPgqkd8yorcJgItTUwE6HRSg9sOCNRUcm4z0bu9n6nrx0ZddNM/ULkg=
X-Received: by 2002:a92:ad09:: with SMTP id w9mr5738083ilh.177.1588708985039; 
 Tue, 05 May 2020 13:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
 <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
 <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
 <CAKmqyKOnpJQUHVnzGVBjPkib-Z1vfdWqLx1HmfbGascFFG4DVQ@mail.gmail.com>
 <CAC41xo2-knUMRVALdftzu4cNz5u5UmBf1aK=mAt9YKzvOcCjpg@mail.gmail.com>
 <CAC41xo0BMA93jv_aqzmuaB553kxM8zCZms1M89uybxyhdjxiXg@mail.gmail.com>
In-Reply-To: <CAC41xo0BMA93jv_aqzmuaB553kxM8zCZms1M89uybxyhdjxiXg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 12:54:22 -0700
Message-ID: <CAKmqyKO5nJwN_JyvZ4vMc4rcuJD3j3uPVkBZU+uB4dEyiYUDDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Jose Martins <josemartins90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 11:57 AM Jose Martins <josemartins90@gmail.com> wrote:
>
> Reached out to Andrew Waterman. This was his response:
>
> "I think the encoding of the privileged modes is a red herring.  HS is
> inherently more privileged than VS, since it controls memory
> protection and interrupt delegation for VS.
> Certainly the intent is that HS-mode interrupts are always enabled
> while executing in VS-mode.  Otherwise, badly behaved VS-mode software
> could starve HS-mode of interrupts."

Ok, so in which case the hs_sie variable should be removed.

Alistair

>
> So my assumption was correct.
>
> Jose
>
> On Thu, 30 Apr 2020 at 22:47, Jose Martins <josemartins90@gmail.com> wrote:
> >
> > > I'm not sure HS is a higher privilege mode.
> > >
> > > HS is privilege encoding 1, which is the same as VS (VU is obviously lower).
> >
> > I just checked the spec and it doesn't actually, explicitly state that
> > HS is a higher-privilege mode than VS. I thought this was something
> > implicit, but you might be right. I'll try to reach out to the spec
> > authors to clarify this.
> >
> > Jose

