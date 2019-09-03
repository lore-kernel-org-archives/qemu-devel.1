Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3910C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9A72087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbpD4uFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9A72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i561s-0003PO-RR
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i560Q-0002VJ-TP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i560M-0001e8-4n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:25:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i560L-0001dP-WE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:25:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so16164574ota.8
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wrLda6CkJGVbYigl3YrxHXHPYa2bBy5MGfdKFA2GJ5g=;
 b=lbpD4uFeD79mVNr7db0BKg7jtU1dpuybJhw5DKbzmZah7//F/wre2zVG8HoEDF5A9k
 MxLkxX0JWttALsjJcqNIOvGaGx66St2blZQIg7zCYH/fcj+BrFzZcL1rWTAnLuHLnbUA
 ETxT3/LeODJVIxCzYG3RS0h2pu+EcaSlhVfUElLZ6Kjq0bR8TATm8M9ZzKsdlU8Vlz+s
 bOj+HKo3/cC0DpPX5hTHfhJogkO1L+6Dle2gq0gPBCnkpvQPDfm6b9E7r0HcsUffH6+g
 u5t8s2Kpnno92tBE1/a663ZlDkgykI3bhfHPMDV1XuWcHXvJW6MdalZiN81iX4IY10NI
 Uvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wrLda6CkJGVbYigl3YrxHXHPYa2bBy5MGfdKFA2GJ5g=;
 b=IVdzOzS/cy2m+bDsvURukM5jlqz41yRPRkCBlhLDF6Pp0ooIAs9i9aQdX2zs248HX0
 K2I57yDsuzJ987VPR6Kzfc0XfLLZ2ozpZyigD+lHVZZ24VVGiN2hqTubAxh05BtPdEUk
 MdFEhz9B5Jic0h444ErryVCkVmdbJvLAe3IpndXAzYFGGsTE7cx6jt2DzFlDtcl8VANr
 B36P9eQT8SZHJEZIpHp/+MKS5MgFjRDo5cdr7VHuLpZoH7BVJyUPe4ONw6nDQ9HEBAy7
 VNS7eU15OotsyJ1WvGZSNMhLyus8zmogttQjqmLYOf3NnlWuQgr/CK6PL2Y0vJN4A8L8
 m1kg==
X-Gm-Message-State: APjAAAXTza9emfLgg2OpH5k+joKyLdtVhnSWQWqDhqKUx+egsHaBsteB
 r2xNBzpcwVSgL4HFzwGpKa2slKowPuukJnI8oV7H6w==
X-Google-Smtp-Source: APXvYqxp4NyBJuYPBMTX9bfwl2xPbjWX54UVTSBo5HZSDNSMg0T5LBB8ziO7+8n0qYk+8qsWWsKBP143gcVMDhOEyLg=
X-Received: by 2002:a05:6830:1bc3:: with SMTP id
 v3mr8666847ota.97.1567506339602; 
 Tue, 03 Sep 2019 03:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190902012647.1761-1-tony.nguyen@bt.com>
In-Reply-To: <20190902012647.1761-1-tony.nguyen@bt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 11:25:28 +0100
Message-ID: <CAFEAcA-4Tpa4qTCBXMTX+1n3fDK48d3ZFYn5CckOD7weqAWrcA@mail.gmail.com>
To: Tony Nguyen <tony.nguyen@bt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Sep 2019 at 02:36, Tony Nguyen <tony.nguyen@bt.com> wrote:
>
> Existing read rejecting validator was mistakenly cleared.
>
> Reads dispatched to io_mem_notdirty then segfaults as there is no read
> handler.

Do you have the commit hash for where we introduced the
bug that this is fixing?

thanks
-- PMM

