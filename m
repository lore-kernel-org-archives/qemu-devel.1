Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7635320850
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="ZJBEUzcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7635320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDuEd-0002IF-F9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 13:08:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDuDS-0001gP-Bh
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDuDQ-0006Z1-O1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDuDP-0006VO-D1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:07:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so21914325wrq.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jNiYLfvh/vDXwbCeYLQ6mL+AjMUsPn7+gBjqEeZiEow=;
	b=ZJBEUzcWut46WTDQpNtv/o3s7651330PXgGGSZuDeuoVZeKv1ETUZyKMQEZY2cp9NK
	zyOn9GsOPvjQv4zBFlBmABLxhAB99pkSs5bc0u+yXzXRK8dU3zW4YKE7Pvfl0wk/315W
	7JEtQSFml90DPA6wnIJyv+VYbpY5VzmfoZHbgHMWeOlsnL8BWXv7B4ZUMUKty/FEUdVT
	nit4IutsSR+JeM+bf2omI11c1WDPaOGniq2XXj0GMDcykpp/rH9JJGoKGKWP4dVtGH/Y
	m96m7v5IkFO/3Ix77e0y7bmrTiO/8/FRfjjSdCIM9syukqpfvQf2ye4NdDzOhYvGEzBX
	jwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jNiYLfvh/vDXwbCeYLQ6mL+AjMUsPn7+gBjqEeZiEow=;
	b=jR5CPFj1qIHFEpKQf/ikTNauh4i6pe6rMsbv6GaMnL8+m3ID6Yp+89KV9EHXHSpiXc
	9TKE9Z5/NkkqMGiRVdhdcXedQZYs327ntaqKdD1aiOTZ6s1x97EqS9UwDez4uk65MNnh
	IgtEFkzE/kWi9A89mFB7xIkS4JNpvY1TEZqLOlsxYPM5AyByvEDIoJevnMkWEjgW70IE
	4he9a5+q6ZCLB/tpcf3x93HF3muKXZ99VtVqsYw5yUqN/VPwK46g5FXSwtSTWiZqjsng
	mHw9kbzMwjzdCpAzp5eKJV5QpnPGCPoOaqNU/RldgcxGA4vs4jRvlmX4XpavnVErt8O9
	5hVg==
X-Gm-Message-State: APjAAAVmznO2tBFiguF0zArXWGplCVj2f4NJ7tU0Z7UDZCOsSp/35/Os
	hJGggdJoG0Zdw194TwzafMXkIqzCMHOXOyUfzSGxWQ==
X-Google-Smtp-Source: APXvYqzPcYCydhidtkXzb0FbvW4tZq1Jcw2H30QHfLb9f30mcLckKHpY+MRfj8ew+qopfLakezPg6Z/m+IxKW2ZvqYE=
X-Received: by 2002:adf:f68d:: with SMTP id v13mr23248844wrp.6.1554829637112; 
	Tue, 09 Apr 2019 10:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<fbe81e69-01f1-4755-49a8-e25df108a196@redhat.com>
In-Reply-To: <fbe81e69-01f1-4755-49a8-e25df108a196@redhat.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:37:05 +0530
Message-ID:
 <CAH95U0j5Ph_OZS+ZY2juM6UxvESGO=dv+cYV6uLiNAOpHVS7mw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409170705.UQ-n5vBZA2jwonHoeM4jv6L-VFzKtKtOBppN68PbcVo@z>

Thanks!

On Tue, Apr 9, 2019 at 10:36 PM, Thomas Huth <thuth@redhat.com> wrote:

> On 09/04/2019 17.56, Aruna Jayasena wrote:
> > Removed unwanted includes from cpu-common.h
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >
> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >
> > ---
> >  include/exec/cpu-common.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index cef8b88a2a..a3594f3f50 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -7,8 +7,6 @@
> >  #include "exec/hwaddr.h"
> >  #endif
> >
> > -#include "qemu/bswap.h"
> > -#include "qemu/queue.h"
> >  #include "qemu/fprintf-fn.h"
> >
> >  /**
> >
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
