Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E2C004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D722082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POuQmkAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D722082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hko8y-0007VM-Gi
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hko5u-0006i1-K8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hko5t-0003iq-Nx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:15:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hko5t-0003hZ-GY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:15:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id m202so15073857oig.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DjSx+iSjEhholteWx+ERsVBywEY9c+r6bXoJKHrx5q0=;
 b=POuQmkAZWq7FDHrmP3MFDr1AcbBO9g+l0CxsuklTXuTkfJoLzF5PkihXFYeXsXsKZu
 rBpkcWIkuiNpNkzyODCxdEdNeyYHPBHH6pbZZt3HRj2OZ4v10i614139BxPAnVR8/TB4
 FqN7Ok+OL5DCn2PakkoMAifU2nXd4WV/30ZFPSMaxyAKituZRUYAHRCZEEcvnCsFyZNc
 e49cDto4NLqjEFNL9eecsyEYFq6eI6PMx7QNgn1drILQNZZXhJejOQJ5jv8RCfGp1v6g
 nRlqW0lS+nD2eff9BhzqSonu367nmZ62+cPViTuCX6b4vFSzP6R4Vsd004Khctn6Dub+
 Bk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DjSx+iSjEhholteWx+ERsVBywEY9c+r6bXoJKHrx5q0=;
 b=enOiB9JAqWoxohtdtvPYgjYwVPsDOOwtxGgpaPzPitrgxo7ic+GqG1dGBJi124YC9G
 ljzaZgqXpov67y4XVTpyD95NjygegAWQTQHQBR708Tvw7Xjb61mNZ2KKHeqfaGsPuT6V
 iKwI/NwDjFQbGBVeu/RPpQANXGgMJvjCFbGRjPpCieq8aKE0IMC4J2kjJH+Nf8ykIR+O
 Q91zmsCR13XbtdFeVfXjAsC2pY07AnnNooN0bCm3XX9FyvmJbFdG0obTjxfwGP9UUsys
 OjFVJWEBVlKSPEhJsUSOkZU5lhI+FcVSvwpBlm2mtEPk7lLKoRoQhTxpTVrUugPoTqTB
 8nHQ==
X-Gm-Message-State: APjAAAVXwD7Jumegr2y2ZnGl9lX5ROvCAtDQs4QuWRtNlMV7UUnen8nv
 7cFR9gz2W52JiRXolsQlGfB+fzIir4gxaUaPl+ZZqA==
X-Google-Smtp-Source: APXvYqw5MJie3H3oipZE46lsaptg5cw8WiFZYn+LHRlVZMQ1Wg3KYZSQNVlZjoOEsOTRBRIswQrrxE7K0LhabrrC3Ic=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1298906oie.48.1562670932806; 
 Tue, 09 Jul 2019 04:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-4-philmd@redhat.com>
 <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
 <41f075ef-9b80-cb66-0fb1-d03079cd93a4@redhat.com>
 <20190708160335.u3zamevyrbnx6nvb@fralle-msi>
 <19334c43-22eb-8476-4f6b-59f5ca347958@redhat.com>
In-Reply-To: <19334c43-22eb-8476-4f6b-59f5ca347958@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 12:15:22 +0100
Message-ID: <CAFEAcA_tZdi88aV6z73eJ8pyPMQdh_DRXQNUdxde2Xx5PhpqGA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 3/3] hw/ssi/xilinx_spips: Avoid
 out-of-bound access to lqspi_buf[]
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
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 11:58, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Are you OK to take this series via your ARM tree?
>
> If so, do you want me to respin fixing the comment and adding Francisco
> tags?

Yes, and yes please.

thanks
-- PMM

