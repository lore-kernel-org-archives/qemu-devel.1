Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D50C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22601206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPVLLUN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22601206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKu3-0001Kx-CX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 18:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhKtK-0000v2-4i
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:32:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhKtJ-0004J5-AA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 18:32:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id m67so9564703oif.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j1NY7PQ1sUVMOWKp9sfmCxlXmUvBRgb/5Hu7X8R39VE=;
 b=TPVLLUN6JFR2D9LZG/UP7A+SFcgaGxnHcPjPJKZPbGAtJfHFE3INdJPI/JjtENEO8D
 rKUezVELN2yRNzSjbU9pim49j+XbxRKhP2axphy/W9Msnhy8sJu+4JPSOqM4KHXB4RNu
 UHaP/pA1J5vRxX8qpvk7QpgsjPu3d8/CI02NU+c4nzucInQ/R7PxCZ5qkxIAir1FWxZ/
 r9K0Oupokhb+8eEZPGn9kyXyaKOtxDASARMOlfkhPKjGmuiIzuZWV4ZbndTgOJrE/8yi
 Ze3gWPYkgeksB5fYzf8Zyp4kRfJguUjMbpuDQYakYdCD5e7SolzbHF78yXAG7FryQIdj
 dvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j1NY7PQ1sUVMOWKp9sfmCxlXmUvBRgb/5Hu7X8R39VE=;
 b=VMTHhrPzKYCeazh1owBZfRE5FqSqoDExQxk3r8uUAD0iQdNXGBNr7p2diOHu0NTNBr
 j6mUbDgREDpiF/5cgluRNu7JTe5VEP+1kQvJzEx4umosPab8sBHOm+Hs4g4gbrDKCi5D
 uUcTnwlKjZcwoBiwcAAUnaMLSXIZ/NzJOYlFKixyHbo03+QCoq8IvDTkkjDC+cejiyCD
 3UGq1r9+xLlGr95+yeY2uLLwCu2/ylSAbvxDVD6Xbb/rW0PnxRcHQHrOFNva2GqkWT1P
 K+KJp9FUdLI1FmtIWQAC8SgNNhk2bIFZxvroVr81C6tcEkeNeca0r2CfpOVlBw2MgnEa
 RbdQ==
X-Gm-Message-State: AOAM532gWtGvdwGTNoIcI66BuhoBQZ/ByZdRjSFUVf9T+gwEMtSMtft8
 T6bGrOe0avlVfdOTTlIVAUeU6i1pv1cHAsre0cZ2wg==
X-Google-Smtp-Source: ABdhPJzLh6bQnIuA28EkuC0vd5qGDVl6/Ye9oNUzjB0XbOsP2fXDVR2yKpmbuFswJdC1un4oI+pQ0VB+MaO/cYEonHA=
X-Received: by 2002:aca:568c:: with SMTP id k134mr3098858oib.48.1591396364117; 
 Fri, 05 Jun 2020 15:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200520235349.21215-1-pauldzim@gmail.com>
 <CAFEAcA-4DuvX2jqFbMvXyqpeytj95gUn7pVnhH1b_622GgAMog@mail.gmail.com>
 <CADBGO781dmXsAUMrPzZEWNT0Y7DztO3hCt8chKy8jW-fi_CNzg@mail.gmail.com>
In-Reply-To: <CADBGO781dmXsAUMrPzZEWNT0Y7DztO3hCt8chKy8jW-fi_CNzg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 23:32:33 +0100
Message-ID: <CAFEAcA8EadhV2r_VHFhV3mMpo38Cw2h-ZQsgOWYRME_oi1XEkA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 23:14, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
>
>
> On Fri, Jun 5, 2020 at 7:28 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 21 May 2020 at 00:54, Paul Zimmerman <pauldzim@gmail.com> wrote:
>> >
>> > This verion fixes a few things pointed out by Peter, and one by
>> > Felippe.
>> >
>> > This patch series adds emulation for the dwc-hsotg USB controller,
>> > which is used on the Raspberry Pi 3 and earlier, as well as a number
>> > of other development boards. The main benefit for Raspberry Pi is that
>> > this enables networking on these boards, since the network adapter is
>> > attached via USB.
>>
>> Applied to target-arm.next, thanks.
>>
>> (Gerd, I'm assuming from the fact you put a previous version
>> of this series into a usb pullreq that you're happy with the
>> "usb: add short-packet handling to usb-storage driver" patch
>> even though you didn't provide a reviewed-by for it.)
>>
>
> Thanks Peter! Does this require an update to Maintainers and/or the release notes?

I'll add the oneliner to the release notes. I had assumed that
you'd have put in a patch in the series updating MAINTAINERS
if it was needed -- send a followup patch if you want.

thanks
-- PMM

