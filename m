Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8FBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7170206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RosdJR2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7170206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvBV-0001Qw-3M
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHuzx-0004GF-JT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHuzt-0007Pf-Qy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:18:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHuzs-0007ON-Hi
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:18:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id p14so19773590wro.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r1RlX5aZ21y+fApXWu4LFYQoo38ILKjQ+uwyiWzdwTQ=;
 b=RosdJR2xgz2qBxkKi6FeUyZq05/bIoRtBgrbhpYsDxho5YdSYagBpbpfB6eM5rMAMy
 RxsY/gXKD00OdygnX6R4m5zJPrufFUoP+IgF1PX8Q39fB7R8NQHUqjqMbzgiFT81/rVA
 JR54cOvIpp1wA8+V5c4oAcf6Sl5gaIQOkgZ/8OSZKDY0hty76Rab0Y+SIF48pshiJygv
 iMf2VmG0fNzMwIEg+35JkLoDsdYw3sefYCmxq0AHqIViPKl+G2ElNTfF+TI1CYIOgWxt
 Ar0E7PSdIhxpr+nGnSc3MeKdb90CEoZs5+Jq8flb0QreCHQxuHACpnEJYYHGvlDPIIBm
 8FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r1RlX5aZ21y+fApXWu4LFYQoo38ILKjQ+uwyiWzdwTQ=;
 b=NW8kJUPH9frj0Xcqfaxk6/eWgKZd+vXlW5XDTSXd1t+C53jPkTrQMsxx7Ky10ztiCE
 3lYXQmuxTv6LHclpJxvs/t2Mzg9CfZOBV29Vt/egrQd2xv9O+9ZfEkaWvEAThu9tfmib
 pkirv86EDAY290SuVSSpN8mQNzDCy2IaYc8LssubxucdDzXrQV3szrAFZykO5X1qQeNg
 S6ksL6lW9QrvbEo9jUnBG2Lia3/29xw2tLccQd+Fh/a4Jx/Lh2HVpWxF3BZwCHUWACcB
 doMXPY2pwX/81NPmKfsBHeVC/12JyNntvwBVgG2m3qgP4tAEFda4GtTSQCYpJlV7Rt8V
 97uw==
X-Gm-Message-State: APjAAAXIfq/aLMa3EewtGIs2P6EYYtRZZLyYGM9L9WfQ/wGe07DnMwKz
 ajgid9OFEVTEpEdUrX54jGdLDQ==
X-Google-Smtp-Source: APXvYqylBI2+spFfz0h6z3pqpIbl+Vo8DDLX2zaK8fKWvT/FeDmPuG4TU+g8mHIhxDUy+R8CT/WgnA==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr27674879wre.39.1570562289710; 
 Tue, 08 Oct 2019 12:18:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r18sm5530016wme.48.2019.10.08.12.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 12:18:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E60A1FF87;
 Tue,  8 Oct 2019 20:18:08 +0100 (BST)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-9-alex.bennee@linaro.org>
 <71068164-f2fb-571c-e7d8-6b600bd9fb2d@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 08/13] tb-stats: reset the tracked TBs on a tb_flush
In-reply-to: <71068164-f2fb-571c-e7d8-6b600bd9fb2d@linaro.org>
Date: Tue, 08 Oct 2019 20:18:08 +0100
Message-ID: <87ftk3hwr3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> We keep track of translations but can only do so up until the
>> translation cache is flushed. At that point we really have no idea if
>> we can re-create a translation because all the active tracking
>> information has been reset.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/tb-stats.c      | 19 +++++++++++++++++++
>>  accel/tcg/translate-all.c |  2 +-
>>  include/exec/tb-stats.h   |  8 ++++++++
>>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> I still don't understand what the tbs array is for,
> but resetting it at flush is fine.

In Vanderson's original patch he kept a reference to the last translated
tb which was incorrect - I changed it to track all the TBs associated
with the stats entry. However the coverset and cfg commands aren't in
this series which needed to iterate down through the TBs to their jump
targets to build the full hot block. I suspect for now we can just drop
the entry.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e

