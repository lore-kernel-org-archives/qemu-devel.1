Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA5920867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfQi1quu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA5920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO37c-0003Lt-KO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iO2jc-0006ia-Uy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iO2jc-0002lw-2w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:46:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iO2jb-0002lc-SQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:46:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id 41so2464224oti.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HNMzGhb+77/LFb9dPb0tM3vUy136arTpLULZsR6/sOc=;
 b=JfQi1quuJBofV7g3v34BL0/ofhZoqEOzxaXVUTNDKF6sdiYFk/LlqJWUeEqZ8onZmY
 ET4JX6Rg8+02IOrALYz5eFmltuJ/Jmaao5mhgsAPY55xlHqI+ndj2XQyKWgznX55Cmsp
 yGpe9ye4Vs1IJIGOvUUdX6jNvOkwkJ7fLvVgwtvcc3EKs5L+BwT8HpBGObzMUwQO/6Aa
 lAKqOB+oumfCzJzUtQKJL1fiv/fjqJ+nZFVot12woWE/LISeogrsG3S98GVNVC2jmEmn
 JQi9mXAzlCt9L+vttHSvVwbZN4lQd7t4D5euNPbLLE5X2Ks9+sVp+bFOGL27O43E6hOJ
 DOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HNMzGhb+77/LFb9dPb0tM3vUy136arTpLULZsR6/sOc=;
 b=Rtjy76K43rHo/+m4qz5TQuy81Z96M2LfZcS7QuQ/a/RvnsDNN/VUIBthekbHTHQQ9I
 x1EqxtcSKwdiztDjBUivS23Y2ow6d3D4+H6YhxGf9/YuJtH+OVjBLytwcp+zQvH+h9m3
 d1R7E0CKPUk6pWUat4PMm6pX9Ob8b9Y2spntAqd8BquFk65xKIV3EgSo7lFrTb/ToMFZ
 wuy2RZ4SQ8Xa0x8w4cy6w7tYOh+pDPAf64qox7UxYVR160j5YOZJf83FK1PoDD1h8BnZ
 hM2463+LBQI0L8HbA3R65+UuhjbCIMjxRjAjN4r1kZ70IIgPXV4LKePcPflzE6pRNWBX
 gwcA==
X-Gm-Message-State: APjAAAVNPZOe79fnJdXryTXZ+w8bkjWIwYu6ix5rdILav0YdTDLS2Tbp
 fskMJUJuBVIdUi8PUg2Q7dvkmjaPFDMurSnHOt4=
X-Google-Smtp-Source: APXvYqw+/gW6R2NFDhcIRQ1tyInzKpvZ4JPVFviCiTuah0Y7Hv+djh7WqT8XD5G0y/vSvpvyihKyiuzi/Y5MqvZTWBY=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr3603356oth.306.1572022002773; 
 Fri, 25 Oct 2019 09:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191019153437.9820-1-f4bug@amsat.org>
 <CAL1e-=hMJmmRzD8iQdKji__RKPbGrV0fGNciz2bgLjkhmC2v6Q@mail.gmail.com>
In-Reply-To: <CAL1e-=hMJmmRzD8iQdKji__RKPbGrV0fGNciz2bgLjkhmC2v6Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 25 Oct 2019 18:46:31 +0200
Message-ID: <CAL1e-=g+bayWb81M1r0kxf-RU6H=WxKSvXT5TxyuDpVMbuG-KQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] tests/acceptance: Fix 64-bit MIPS target tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 11:23 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> ping for Cleber and Eduardo
>

I applied patches 7, 8, 9, 10, and 11 to MIPS queue.

Thanks for all involved!
Aleksandar

