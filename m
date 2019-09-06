Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3A7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F632214DE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDWTqJdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F632214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6D0Z-0001l5-8M
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Czl-00016N-2w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Czj-0006zI-OV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:05:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Czj-0006yf-G3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:05:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id g207so6227137wmg.5
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PKaq9aYEPNk74e8hjoIbfDyHl7tRTrakIeUd3w1Ns4A=;
 b=ZDWTqJdw3YLYe5R43DJUjcaX0nw1W7OsUfoQcU5fmbzLkLGpgzDf6aPCwLTr4PiUQE
 YWNaT6MGJ9cM4+ekwWHNK10D2psZfmHN74TSiSf7RWigRrhxOnaKyXblis4nB9MAyH4w
 mT3EJDXoDe8KSUYNyFJfv/GP7DXZtuTjkfkEDIBcyzmzbSazKEWDlWEWFr+Fb91xHZhg
 +A/UMPnqVmkKAkyB0NNh4UrwLoXJlTH4isHEt7rE+wuW9X5Mj665fh9Z1lwdjuMWo1ob
 /K5EeDPflBUoh2USzCZYvFx+VWdlsKvZT1f+osHnLgeuLSpfkiaQOnx+SZQoxDaUaapN
 vj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PKaq9aYEPNk74e8hjoIbfDyHl7tRTrakIeUd3w1Ns4A=;
 b=rQ3YA7A1yamhiYCd4um1EUIZktORu6iiwrrzdAbrFhpvaeai2XQnRaLC1p2RX1/DhN
 V3bg4sUNOG/eZs4vKBGyNryQyONEOkH2NR/Tu9BnylKVsDEAlVH09RJDfz29fjtc9tN/
 wwNCKphg5M3BSMvqHToDxwppJSHpXjgaNn0RGsgCxzCIl/T2WPrwXEXUceE5voVlq5Vo
 vPmtx/a1dLIP0s5K6KjIOywi3CZGl67fQi2opp+Tcj8zXgtU9mLy5tdb1Bj8WsfwGmWr
 0ZYOuCRn3KgX5QsZZFY4Zu3H1T8y1nygvzZR1zjsh0SQ7SsGhnA0gHJHTdWppBBBs802
 PWMg==
X-Gm-Message-State: APjAAAWuGnEyMkyA/tQRlFLsmmTuIjt03fvwwkZTSi8oL5DWwxyybKA1
 C7Wlz2QX0fDcy2NMa5TsFXWH+w==
X-Google-Smtp-Source: APXvYqyP052MnoCIt9otbEFHJpS8ESKMTcsfW83K3aS+0flKo420kq7/T9BUGd9gxoplW68N5+EqxA==
X-Received: by 2002:a1c:be02:: with SMTP id o2mr6560501wmf.109.1567771538215; 
 Fri, 06 Sep 2019 05:05:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm10356085wrd.7.2019.09.06.05.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 05:05:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE00E1FF87;
 Fri,  6 Sep 2019 13:05:36 +0100 (BST)
References: <20190905113346.2473-1-thuth@redhat.com>
 <20190905140701.6cc679ee@bahia.lan>
 <fc82454c-ee11-c7a3-cccb-eeb51df35897@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <fc82454c-ee11-c7a3-cccb-eeb51df35897@redhat.com>
Date: Fri, 06 Sep 2019 13:05:36 +0100
Message-ID: <87blvxzl2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] travis.yml: Install libcap-dev for testing
 virito-9p
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 05/09/2019 14.07, Greg Kurz wrote:
>> On Thu,  5 Sep 2019 13:33:46 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> So far we were not testing virtio-9p in Travis yet, since we forgot to
>>> install libcap-devel. Do it now to get some more test coverage.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>
>> Acked-by: Greg Kurz <groug@kaod.org>
>>
>> and
>>
>> Tested-by: Greg Kurz <groug@kaod.org>
>>
>> Whose tree is this going through BTW ?
>
> According to MAINTAINERS, .travis.yml is taken care of by Alex and Fam,
> so I hope they will pick this patch up. Otherwise, I think it could also
> go via trivial (now on CC: ), since it's just a one-liner.

Sure I'll grab it for the next iteration of testing/next - the queue is
quite full at the moment.


--
Alex Benn=C3=A9e

