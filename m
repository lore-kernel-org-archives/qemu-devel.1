Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE16C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CAC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiXk6O4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CAC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTzD-0008Qd-Nd
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:43:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGTyJ-00081p-G1
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hGTyI-0000mV-JJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:23 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:46565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hGTyI-0000m7-Cq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:42:22 -0400
Received: by mail-yw1-xc29.google.com with SMTP id v127so7744939ywe.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dYtbdSGOqiGlfxfqfzaHC9pMlKcxBW5iZMcOfDr3bpQ=;
	b=jiXk6O4x3NiN23LLrSGo/BsA0mSpR6PuKfeKyYL/PikPq74LVBKce+dczy5Cevj9SY
	2sHx2IMjz0FxBuch38ID+8H0AsBRGjhCkXm/PCaQflJhvrJimMedwumXEDT/6Vv914wC
	gYIarqtaix9TCAKioPNOjIDMpgrwCs4+4gN/u/RobYrYI9LXfAEoyfiyRf6K3X9gmcQu
	k2J5LDIW7NNo7EBGxz/eghGQJsUbBtmoVsoGA7pPiz64TDlg4XHIuPTiPLRKgHURTwht
	8Ro2QkZkgRcSxrkt8But+9YhauepIsRTIpKDzUzH9HIPsb6MOrCNzNCh4VHXVT1ZgbkJ
	yWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dYtbdSGOqiGlfxfqfzaHC9pMlKcxBW5iZMcOfDr3bpQ=;
	b=dnWfBGaOL9V2yqttsIfMRXq7+cC9llwlYp1ZihhF2Q5di5gpRAaGIqwAWUpIJuaT8W
	hjXbsLlCvJ1sHpN8hl8gRLg+6DSSsqPqC+o2Ikbjup22TfRWUbxTOP1WPBJ9OHbEochL
	NpqUM4TB1ILdIj3mEbMxirUjRrlL8y2HjgL+tRmwisB6YBvpdFDtnbRPjzKdwM6hgUPv
	aVKBKjj/bhlVk0gjfUeBGxFinUgSQVtSIZakmVJoPOXSlsbRa9Sji2JHxWo7koiakvSr
	HYP6SdsFscmx+r/Ca0ofGkHl3Sk2tvAdx+PCtF8ts7TqwfdXgrs4Cb9+tgsygIvforyG
	2BdA==
X-Gm-Message-State: APjAAAXuDP2M9AqI5iYzCEwvboR7kaYBhy5zUZYtyY5DeB4tbO11zpG7
	w8vRBonQQeq3m4mxuJ90/1eUQlfEiSNPRcjA8H4=
X-Google-Smtp-Source: APXvYqzfEPypYiwGbvQBOK8DkoGEnJSB7E8PtIt6ARvKYp/XNwWvNVE6FBvbFKKnC/n5v0iPmnSrfoVZwdfEvc7LyUc=
X-Received: by 2002:a0d:ea84:: with SMTP id
	t126mr66434640ywe.114.1555443741554; 
	Tue, 16 Apr 2019 12:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
	<20190416074135.qo4l3vra2g6n2rts@steredhat.homenet.telecomitalia.it>
	<06b923b2-8406-b599-f3b8-a300bb6a22a5@weilnetz.de>
In-Reply-To: <06b923b2-8406-b599-f3b8-a300bb6a22a5@weilnetz.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 16 Apr 2019 12:42:09 -0700
Message-ID:
 <CAMo8BfLjo0HJM5KhLX6rgyC-7m266DMte8bqk=tWFVZQOH+91Q@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c29
Subject: Re: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416194209.YdDOUOr7LJuE5RpjpPbhL3ryj9iY3sOJFlnUKOzHd9A@z>

On Tue, Apr 16, 2019 at 9:13 AM Stefan Weil <sw@weilnetz.de> wrote:
> On 16.04.19 09:41, Stefano Garzarella wrote:
> > there was an issue when we introduced PVH support and we fixed it. [1]
> > Maybe the build that you used (20190218) was compiled before the merge of
> > that fix (20190311).
>
> The build of qemu-w64-setup-20190218.exe only contains patches merged up
> to that date, so the fix is missing.
>
> The next release of the installer will include the fix.

Thank you both, that explains what I see. I'll wait for the next windows build,
am not a fan of building for that platform.

-- 
Thanks.
-- Max

