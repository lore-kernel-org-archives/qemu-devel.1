Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE40C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C19B218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="vwCpkrMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19B218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Rt-00068a-Cf
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG5Na-0005b1-5g
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:03:38 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:36645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG5NY-0001uf-Cg
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:03:37 -0400
Received: by mail-ej1-x635.google.com with SMTP id e23so5139273eja.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=W00qVUsVR5dYIJoUQxX8/8Tc9YOvKTwyTrX5cIiorek=;
 b=vwCpkrMdmXVQi+SR7NIzoq+DljNNpKoOUJxCo7AvOu4viGBRTLXAsZYvUqOsQwOqv5
 VQeik5whIdhvSjyORNKUiVZwJ+TXdfxug/5eUUmxTfO7XTruk6RwJOKVad1qSav6sCQ/
 l4YcVpMRqI95lEnSRTzazQ4ADDVshaZjH/VcQXC/p7Di19GMMqnof/oElPMAHzQ/ev1H
 jbb6AVrAMf1KcfbPPXFzwX4OjzZx8r0dZuZ9pUtU8T5sUnVs7rA+QE1WUgkk8RS+SmLP
 XOFkeSlJ8JiE1Kxsq4aPloYm00mK4Hmg+a4O1cVt7Ok6LlMxvbrtwPVPYV95ST+gRGi3
 xM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=W00qVUsVR5dYIJoUQxX8/8Tc9YOvKTwyTrX5cIiorek=;
 b=PxKSKS3V5J0YtxQ2AaOn4SWtnry79+7voEgIJr3Emcw5ISFY1H430sZVsaeLPr273P
 MYhX5iqjfl/s7DbV3EFt1SJwvJkFDJVXPZM5RQ3U5NoPlmdthEpVBXOGpANKZ8oSPH73
 h1J06LfFbhcsgDIofHHSEd4QwSQPsBa8TP+u+sbp+dt6hKF/5L20lJRPsKHwX+HLggwN
 8CFuaitVglshIfSosy1xfVeFN+LEfyo7IVx5JyMIFPqFWW4xpPu7fV69K2gXuuXochWh
 WJBuIo6Fv+d8VSlRjFQUQRI0jzBn5sgL7QLppKMGWqd8DLKaGTzD27beplNLenWNZr0l
 nenw==
X-Gm-Message-State: AOAM530sOyGncoD/QnJH327YeuLZI6ax7oRb/9z6x1X7ju93qzC9Jq22
 mcV+aMmNoyLL+c4aVX0f2LCjaA==
X-Google-Smtp-Source: ABdhPJxIqdx3b9oHO6fnv2cPE8dfaFizA/8JaOkiVwgJoKCnF5yeUrM+rUZllEzdCoMm5x2EhMO0yA==
X-Received: by 2002:a17:906:660f:: with SMTP id
 b15mr5368702ejp.333.1599678214791; 
 Wed, 09 Sep 2020 12:03:34 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id e15sm3449635eds.5.2020.09.09.12.03.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 12:03:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <1695914.5EixHECA2G@silver>
Date: Wed, 9 Sep 2020 22:03:32 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <508327A7-58A6-42FC-8BDC-F1D4FE1F43C6@livius.net>
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=ilg@livius.net; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 9 Sep 2020, at 21:56, Christian Schoenebeck =
<qemu_oss@crudebyte.com> wrote:
>=20
> ... However you would=20
> still be opted out from (4.) all those Xcode IDE features that make=20
> development such efficient.

Could you elaborate?

I thought that a standalone meson can be used with any environment, it =
just reduces the dependency on Python and possibly other system =
libraries, otherwise it provides the same functionality. You unpack the =
archive anywhere, place that location in the path and use it as usual.

Why would it be opted out for Xcode?


Thank you,

Liviu



