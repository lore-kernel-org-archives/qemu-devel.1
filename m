Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F16C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CB720748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL5Ug13s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CB720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXfYN-000617-QF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 01:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXfXb-0005Zu-0t
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXfXZ-0004HJ-Vq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:02:06 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXfXZ-0004Gq-PX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:02:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id 94so1893760oty.8
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 22:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QCB6AXmAwg8KYj53o4iuV+uiVAQ8eXnsOMca49rJlfQ=;
 b=lL5Ug13sT1IvRDCPySrSNXKKEDb6oPfPNepwmKFQB5kDYpuqUSDKV4HHwPoIs5IUQU
 bUneJdF9lc4YorGRualZKijz8MH+/p9Z+040NYv34DL2QGbhdDpGlZrN51flaj1AEMLX
 Ez37k9B5MfcF0INY/h772coutxsfxHqiW1uBoiL2C25TWWo/nmC8Isq1UYPGHPRiwq6w
 64CZ6pdTNxFsNqiPgzKUycsv+cVMhErZBDA1jpygLT8TEtfIwWYZ/65zP1krcWswVZPe
 6UIBKeHXM1Opxe5ER9KWLmgqaSzydQmfoyP4MCYkZcpZEJiv7Tn5V2Onmaa1Ofv8pNcl
 oWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QCB6AXmAwg8KYj53o4iuV+uiVAQ8eXnsOMca49rJlfQ=;
 b=Toe8P2IxRipBD1rMschCfYhYCZUVLK2VxwjxXPDImHTxZJTtvfAzGj9y9XiPrCsEAN
 EjpmAsvv9m5sGhGoJ1s3lVX58RavFlXLsbquEcir4b2cUatwDU7xDa3BzFWL4zwD0MIZ
 TdX9GQzVNmO6T+ZPc+pb4urCE1ian6UKdH8kl1OlFTEOnOfZbUdayCD2XqZlTVuy20jX
 VUSxio+GeHSJ8h6P0iVcfhJ6pLEo5rrI1TCWNQXErwMoppzAtCBSAtAiy+fQlz7PHpkJ
 /PJbGji2gwDM+144JLOvJnfjVsKG5mGBbBz+8+fw/MY/ATUjmQZbDYHxZq+VhOrLe1VJ
 ejGA==
X-Gm-Message-State: APjAAAVdJ8e/KRHXL2Ka7wKgwKXyZbbHv/+4QipFFlwVc+CT8GEpcd0V
 WEY1ealUSfZiiEn9FIm6m26ccTK6Z3zMbn2ej1k=
X-Google-Smtp-Source: APXvYqzCHn0HZWRi4I0VehZUDw9KScoGm7h5srZN8+sjEJjZ1ypT8mNr+WFHokt2Lubv/sdzbyhNtiWSSNAWykBCZkU=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr5101633otq.306.1574316124430; 
 Wed, 20 Nov 2019 22:02:04 -0800 (PST)
MIME-Version: 1.0
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
 <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
 <59c88efa-999b-9edf-7e34-f283ac8c802e@linaro.org>
In-Reply-To: <59c88efa-999b-9edf-7e34-f283ac8c802e@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 07:01:52 +0100
Message-ID: <CAL1e-=ihiBw-4beEUEUqbFNUZGrG7DsLgKe6y4Sc1h3W4Ze=Vw@mail.gmail.com>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 8:49 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>

> How's that?  He has been asked to split the linux-user stuff from the target
> skeleton stuff.

...

> This argument would make more sense if there were more present here than a
> skeleton.

Speaking about anatomy, I am opposed to upstreaming any "skeletons".
The other month, another community was dead serious wanting to
upstream code based on "proposal of the draft" (or was it "draft of
the proposal"), and now we want to upstream "skeletons"??

And even that "skeleton" can't be regularly built stage by stage, but
must resort to "enable configure at the end" cheap tricks?

What happened to QEMU upstream?

If this is really just a skeleton that can't be organized in a decent
patch series that actually builds, my recommendation to Taylor is
simply to postpone upstreaming until the skeleton is made stronger,
all bones are in their right place, and the full body is ready - what
is the point/purpose of having such a skeleton in QEMU upstream?

I am slightly disappointed that after a slick presentation on KVM
Forum, we now talk about a "skeleton".

Yours,
Aleksandar

