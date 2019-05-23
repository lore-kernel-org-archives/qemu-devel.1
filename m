Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E485AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB51420851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yy5AbiKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB51420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTm53-0006D8-KW
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:40:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTm30-0004ug-4M
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTlwN-0003Ac-8g
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:31:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTlwN-00039j-2d
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:31:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id j187so5401534wmj.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=DfzvVWpoSYYigX0xFrut6HZ2x0qn8dYKHJAFHTqbIeI=;
	b=yy5AbiKhemIZ6jIxVQyK1hyxbmfOlOc9Nk84iNVt2+DhOc5JCcF7DFnokS2E9YbGbD
	fYT9zLswMumN+qTFTuKbqd6se67KUWEuhSdZ1xBYbWrDgScv4g2zkvqxgNrWm8oru1ON
	waIrRfpPIkbLF87Yw2Qvw6pEebZmCgtTE/LpMP9ki0oLtUF13WAadCGjdlr414MCDF5f
	jAf0JNpurENmhMFiwU8zy18JpKebsreZojh3Hhfxe1MSsVxEMEjUzTz7eewmCh8QQZs2
	eAJOA/1/G59sjeg+kWd9GCUSR2hIILePlDQsgYFGorSl1OYLU7XVT7oHL7cWHoybohgY
	xU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=DfzvVWpoSYYigX0xFrut6HZ2x0qn8dYKHJAFHTqbIeI=;
	b=s5NwEkVwpSX7CKxsyBMFMO9Pn8WWJdVzQneUxDeEQW7NxzGwbJxv2agU6GpTZzR1Kj
	cz++FnVa4K4svKhbDnmUVr71tGiu95i3fk2dlHqfAwcq7WafTGW5W397sSniqyRzMlj/
	2nj5Zuq6LNPQJGPrEulqGrqrs2t73FAIRnNABjLDZ1PUFYbgp4deHuQvykJ9vzj9YHIQ
	6xmuzW2gkFm51CKN15Gdiw3wg6tYAXq1RcN3KnXf+tF8YUxeVFGENyw2voNPGi8CwadU
	Qyl30P1z5QnrHZUuepeVyjxk6UrqgOmWBVbtxg6yhABUwb7P2y+E+aiHPbktNv5iuM08
	uWew==
X-Gm-Message-State: APjAAAVn7uWXS4FnukzSbXlRc4BjGsOHHbxfrCVfM7h+yjC5Y7wrd0iO
	hTvxVifRd/P+wStHOlP1IzQkvA==
X-Google-Smtp-Source: APXvYqxPVDXnQ4Wl2Sl/vtNkNtiHOJxWx4cXVqcWvVKyogatHORldMNOurCZzURjt4C8IZ2utWDH0w==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr11996094wmb.19.1558611077446; 
	Thu, 23 May 2019 04:31:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	m10sm9498477wmf.40.2019.05.23.04.31.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 04:31:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 716F61FF87;
	Thu, 23 May 2019 12:31:16 +0100 (BST)
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190523105440.27045-1-rkagan@virtuozzo.com>
Date: Thu, 23 May 2019 12:31:16 +0100
Message-ID: <87imu11k6z.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
	richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Roman Kagan <rkagan@virtuozzo.com> writes:

> I came across the following AB-BA deadlock:
>
>     vCPU thread                             main thread
>     -----------                             -----------
> async_safe_run_on_cpu(self,
>                       async_synic_update)
> ...                                         [cpu hot-add]
> process_queued_cpu_work()
>   qemu_mutex_unlock_iothread()
>                                             [grab BQL]
>   start_exclusive()                         cpu_list_add()
>   async_synic_update()                        finish_safe_work()
>     qemu_mutex_lock_iothread()                  cpu_exec_start()
>
> ATM async_synic_update seems to be the only async safe work item that
> grabs BQL.  However it isn't quite obvious that it shouldn't; in the
> past there were more examples of this (e.g.
> memory_region_do_invalidate_mmio_ptr).
>
> It looks like the problem is generally in the lack of the nesting rule
> for cpu-exclusive sections against BQL, so I thought I would try to
> address that.  This patchset is my feeble attempt at this; I'm not sure
> I fully comprehend all the consequences (rather, I'm sure I don't) hence
> RFC.

Hmm I think this is an area touched by:

  Subject: [PATCH v7 00/73] per-CPU locks
  Date: Mon,  4 Mar 2019 13:17:00 -0500
  Message-Id: <20190304181813.8075-1-cota@braap.org>

which has stalled on it's path into the tree. Last time I checked it
explicitly handled the concept of work that needed the BQL and work that
didn't.

How do you trigger your deadlock? Just hot-pluging CPUs?

>
> Roman Kagan (2):
>   cpus-common: nuke finish_safe_work
>   cpus-common: assert BQL nesting within cpu-exclusive sections
>
>  cpus-common.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)


--
Alex Benn=C3=A9e

