Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16807C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D350E2184E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCSN/8Ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350E2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyLL-0007o0-2g
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hpyLA-0007P4-Vz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hpyL9-00059g-RH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:12:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hpyL9-00058b-Ln; Tue, 23 Jul 2019 13:12:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so32863963oie.9;
 Tue, 23 Jul 2019 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=khHJxeGj+Xx3ZZhBP1J4VYbdLqh1MuCSzpDacycUK9s=;
 b=JCSN/8CtNORTBTMKVKvJn7wia6TuGfSJvO4jshF+qYeJFC8xWSUk2pIZjUUjQUS3pY
 dWBrlaBnQgBmvZEirNh59iKWud2jo4v3Iz1YejL7PIKBEOyqGjDGLsDrLIwchQKLrseE
 zG12kvYpT/AoI4qdN370wzYUnkFJ79/fx8GY+eiV6zNk70mRBvx8w+OFC5q4jIpuXm7J
 xQWD03ZiCovYbAWqRmXzz0qLM7wW3LZctjPiSbfMPpRFIw0GSTC9sh2Q1izANpYA4elt
 GKF1+6bCyOUkiSJkW0DL7riSh2bx0EZwmvI6wAajYUafpjWhIOuLtygo4kWejYan2QAr
 y6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=khHJxeGj+Xx3ZZhBP1J4VYbdLqh1MuCSzpDacycUK9s=;
 b=am7/1AXzICuS0S/CTV+yuwqWsTYJAHLdnQzNJuuaXP+MQcALoTzgD7oNKyM3J3O+oR
 V3BDU76qZQm9jbOdBJJYNdxbmrC9ptRIK+bRbYahMfieaHbN9pSATK/PZ67SJjTTocBC
 WPAULbmMNIyZF06kCBoEru5u0NgAXQa7FlPwV6RNpxp7ZqK83voxQVmYz4H/M3sWCW8K
 oQ59yIPA8urYbqayTm/A899bA5os7QYD/K6Gi9YZ9jZna9or4roLHrY+uoODz3p8EtKP
 og81/igjnhCUoCe1fmRh8hvdJ+FYSN28l7uU+OBIuWv0jUZqXKZeB70Cb8wzKOtxZEW5
 eCXw==
X-Gm-Message-State: APjAAAVNAXtX1C2ztTGfHcOpijUWXSreESEEmyuN8wravtBMUxkehh7V
 4NKX1XyOlXskNmkwtNrwUs4d2FOworPuXnEFuaE=
X-Google-Smtp-Source: APXvYqzd4k4BcbMMpp9Bi60S+bZr5t1BX6ygtvFp5EEhdjpPiYUngLL7a1IS1wePVP3i4lhXRLFgb6Jd6pSDZNpVCUs=
X-Received: by 2002:a54:4619:: with SMTP id p25mr14880852oip.62.1563901958644; 
 Tue, 23 Jul 2019 10:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 23 Jul 2019 19:12:27 +0200
Message-ID: <CAL1e-=hp2dAkCki=sewqvMTkFTL_XoChyKOgiWur_q1f4YHAFg@mail.gmail.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 00/36] Patch Round-up for stable 3.1.1,
 freeze on 2019-07-29
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 7:04 PM Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Hi everyone,
>
>
> The following new patches are queued for QEMU stable v3.1.1:
>
>   https://github.com/mdroth/qemu/commits/stable-3.1-staging
>
>
Hello, Michael.

There is usually a breakdown by modified files within a cover letter.

Why is it not present here?

Sincerely,
Aleksandar



> The release is planned for 2019-08-01:
>
>   https://wiki.qemu.org/Planning/3.1
>
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being released now since it was
> delayed from its intended release date.
>
> Thanks!
>
>
>
>
