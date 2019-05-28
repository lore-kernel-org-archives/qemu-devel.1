Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2599C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45CE20989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMOtXxsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45CE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgfw-0007FQ-0T
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:18:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVget-0006wa-VM
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVges-0002Ay-So
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:17:11 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hVges-000276-Mk
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:17:10 -0400
Received: by mail-oi1-x242.google.com with SMTP id w9so15028607oic.9
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=bs/CzvG3DZ0LNQbsdPRMu6RQXmPTj15Z/DO4Yr2CwwE=;
	b=kMOtXxsgPwwo9fX1DUVyOAvK2DtxUllnsZhS8avaisx78g0mphOon11OmeJPwWLm2s
	oV2iolPUuIDFNu4lOxEVP82TQSXatHDG3w8fZBIZxUV1frPZZup6ai6pu3zoquSq1Cgg
	s8LTIk1ADaEgmVWBOIsCfOp0rP95m7e6sjZo1OjevJjZ8KwhHfHWkrXMD2e1vajpeAzW
	4DXX3McTPFWO3Yn9Q9ku5Tk1Y3FByrhJcvwZG4WP3drKDRZGo7rGfjKf7BhRkh6BZAE/
	izTSLInM7KKntjqTZcQxM2M5sDw1b3qp4Y3OucDZ93QNKPwgccwoBurQ/6k3GLgYNxOf
	cp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=bs/CzvG3DZ0LNQbsdPRMu6RQXmPTj15Z/DO4Yr2CwwE=;
	b=CZWwWLRE9usRH6filiB3zoCJ5sA8ODKJ5D+OV+gDeSf99gwM+OAPoddHFdntM+1OnV
	4atQh4Wsm1qVQ12UnLCH2O7FBd6bhKhTcXkNA6q7Vr/iomfAQ8dfWtXDfSKZLHj32tvZ
	vx5fTbj37hG9itRQPMfxuPgkwlJnoWM4I5IRKz5ZsF6bX9/AHB05e7RZ8kcVUYEa83Cg
	GwaveA0VEF2heOBycdvLYjyry5e2wNPso+cE7AkZiZm0dbM+k/Gfu/NJem8Ct0W2/RP8
	4p+qpt9TmBcqdmpC3iRGchEwGWc/HmgQhG6pv4WMEfCYh0d9T2I8dYIv8FlGlDzr4Vvp
	dPZQ==
X-Gm-Message-State: APjAAAW++hmVxBHv9h4Xy1q5UJk58GCT0wv/9iMLssbz5G/DZ1X71Rjp
	mbjipwN097BnTVz9t4Bg0l4d+7JFCeY6nyl8+9k=
X-Google-Smtp-Source: APXvYqweERGw/Bke1yOHCy1krdUn8aERA8wc+W6JeO8+ohLvt2WL0nbxKg9cUJj0tEm4auna2yn/5wNmzt0HXvuvHaE=
X-Received: by 2002:aca:1916:: with SMTP id l22mr3597569oii.136.1559067424962; 
	Tue, 28 May 2019 11:17:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 28 May 2019 11:17:04
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 28 May 2019 11:17:04
	-0700 (PDT)
In-Reply-To: <c0a61d30-ff62-a70c-67fd-49db6ddc03f5@vivier.eu>
References: <20190523175413.14448-1-laurent@vivier.eu>
	<c0a61d30-ff62-a70c-67fd-49db6ddc03f5@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 May 2019 20:17:04 +0200
Message-ID: <CAL1e-=h5mM2u845tzGHWYTDRCpOw-EfXMzYGirdLfUHkPO15bA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 28, 2019 6:25 PM, "Laurent Vivier" <laurent@vivier.eu> wrote:
>
> On 23/05/2019 19:54, Laurent Vivier wrote:
>>
>> In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
>> defined if __NR_msgsnd is defined.
>>
>> But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
>> __NR_semtimedop and it breaks the QEMU build.
>>
>> __NR_semtimedop is defined in asm-mips/unistd_n64.h and
asm-mips/unistd_n32.h
>> but not in asm-mips/unistd_o32.h.
>>
>> Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
>> updated asm-mips/unistd_o32.h and added __NR_msgsnd but not
__NR_semtimedop.
>> It introduces __NR_semtimedop_time64 instead.
>>
>> This patch fixes the problem by checking for each __NR_XXX symbol
>> before defining the corresponding syscall.
>>
>> Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
>> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   linux-user/syscall.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>
>
> This only fixes the problem at build time, but the changes in the kernel
headers introduce also a regression at execution time:
>
> if the host kernel doesn't implement the syscall, the syscall fails
(ENOSYS) whereas it was working before because it was using ipc() instead.
I have this problem with a Fedora 28 on ppc64 (5.0.16-100.fc28.ppc64) (LTP
test msgctl07).
>
> I'm preparing a fix.
>

OK, great that you found this behavior, thanks. Just want to tell you that
meanwhile the original code of this patch got integrated into main source
tree.

Regards,
Aleksandar

> Thanks,
> Laurent
