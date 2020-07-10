Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5112BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198A520767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyCxCADQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198A520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtplH-0007JB-Db
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtpkH-0006R5-JX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:55:05 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtpkF-0007Tw-Vd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:55:05 -0400
Received: by mail-io1-xd44.google.com with SMTP id v6so5413260iob.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XcFfyRIdSzGpKZsVcFcRMyTCSfJtv7m/wHeCSk3v+mY=;
 b=YyCxCADQ11CocgYHpPrZ7caUgA7/R1Crw2jFixKnAjF6B9Fx/zxHhmNem+TLCaplY0
 mPv+k8TmwNcI1iphga7daxl/oziVlEBVnI8HdDXhOpQrerFjWCZ4VNk9PqySBpYFhfMV
 LNC6OGrcD2Gy8G5qAul1daOB1rtrgDJf13tMoQnneLNXWXBpbYnkMiPGU27Oxu7kyKqN
 utOmhKbGJFFZjhaKn6fMHnA0qv6l4aHg1sIi3aY4CUR/2Wjh31s11PA9zJHa4GAT+h6X
 b7l761TfUmp5Jlb+gcBetFLxNAy8loYzm3+jPqTiZfMok1u9SqeHdoou6xb4/TfalIlt
 /nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XcFfyRIdSzGpKZsVcFcRMyTCSfJtv7m/wHeCSk3v+mY=;
 b=r59ZMFCBnVRCt3zzLxVv0hZpO7BL5KDy/iT3SpNBRBqn8WDohA83dXclyJSnWi9IPP
 TTjH7Z+e0G6tgdqcS+2TJDTzj1HQiaaGWvhODF951p14OdsCzdPxjGvHxRgY1tnrKMPz
 M8gGkahpAgPT/njDK8V2E1Gtmrf/TzPSZnX8ZzPsie5za5+upUv1QTyYeqRFz1MSzJHE
 fOazwb5l0/FOCL5aSHYH4UJCnuTSuytnQXBEsx5VO7bXzZueMCFXbSX+CwUXPfoS5aE8
 +8NaKX5wUUpyvac0hW7HwH1NkPusbv/+NVVA/PwJRS8KByeikqzg9M2A+W3Ub1C9G9D7
 u1QA==
X-Gm-Message-State: AOAM531KqLrBAmclFAJVWi5czg1CMqDs/E6eoYbthmmH9B8WgaipfmhN
 gREo53p/WuSbPERbhZXhc9B8ij1OVg7IeNiX+nn7NQ==
X-Google-Smtp-Source: ABdhPJysYIIdRCBVDsxlAXkz3Dq0pBB7t2u2X0VTvU9XpZOf41lh0WQuEhEbhWgi1A3tcgLGQz1sqW8/mESMdbo8CFY=
X-Received: by 2002:a02:cb92:: with SMTP id u18mr54773697jap.143.1594374902819; 
 Fri, 10 Jul 2020 02:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
 <f263f4aa-eb94-8760-6fc4-a1d46c15d099@amsat.org>
 <CAKmqyKM1h37fKNs-_jh+9Yr6EGvQ+hdbSQHHSnOoePHdLyf1Zw@mail.gmail.com>
In-Reply-To: <CAKmqyKM1h37fKNs-_jh+9Yr6EGvQ+hdbSQHHSnOoePHdLyf1Zw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:54:51 +0100
Message-ID: <CAFEAcA9XiaGqCwVMOuSgZvKPzH_iZetj62cAM6S6sGCMCW2H1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=peter.maydell@linaro.org; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 17:27, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 7:35 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > On 7/9/20 4:15 PM, Peter Maydell wrote:
> > > The only chance you have of something that's actually
> > > generic would probably involve "qemu-img resize". But I'm a bit
> > > wary of having an error message that recommends that, because
> > > what if we got it wrong?
> >
> > I am not sure what to recommend then.
> >
> > Would that work as hint?
> >
> >   qemu-system-arm -M raspi2 -sd ./buster-lite-armhf.img
> >   qemu-system-arm: Invalid SD card size: 1.73 GiB
> >   SD card size has to be a power of 2, e.g. 2GiB.
>
> That sounds good to me. That's enough for a user to figure out the next s=
tep.
>
> If you want you could also add: "qemu-img might be able to help." or
> something like that.

Thinking about it a bit and talking to Philippe on IRC, I think
we can usefully have the message recommend "qemu-img resize" to the
user; I think we should avoid printing out an exact-cut-n-paste
command line just in case it's wrong, but something like:
 qemu-system-arm: Invalid SD card size: 1.73 GiB
 SD card size has to be a power of 2, e.g. 2GiB.
 You can resize disk images with 'qemu-img resize <imagefile> <new-size>'
 (note that this will lose data if you make the image smaller than it
currently is)

I think is a reasonable balance between pointing the user in
the right direction and cautioning them to check what they're
doing before they blithely perform the resize...

thanks
-- PMM

