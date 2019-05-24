Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AFC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2382A2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CkiQiF90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2382A2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUDdq-00023j-NO
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:06:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkir@google.com>) id 1hUDc8-0000v2-3N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkir@google.com>) id 1hUDYg-0004fO-Lh
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:00:43 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rkir@google.com>) id 1hUDYg-0004ew-BC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:00:42 -0400
Received: by mail-lj1-x244.google.com with SMTP id a10so9281244ljf.6
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=KmzQXMSYstW2eGNHW8luFQ0O7XKycvd0c+TB+pDYNM4=;
	b=CkiQiF90S1s3DQjJPg/nbjUjfTxAa48KZ2gesonrzdRmD59SFYOAKtuIuxsdTabNDv
	655PsOjifMVySw7d/oPeV7pGMAe5skuNYRsj66RCW3MY77pTgCuiEIHjStei3dnZCyqC
	nkKlt7vXSo3SsxQxSjZjhU6hJkPbqwDkCaRMRHre7e03lmfzHOUMhEq+9mjM1IxD3XXM
	X/SVweHhkHEi3kJfeG1krLAXRrv4TpahSq+LANu3iO9Vrb4FAsMUEfaermnLLP/zdYXh
	jHoL5uQ008nEK47kOOkfJpm7jut31lyh8wwBt6SSBwW00nBF7FpBuLf20P+n2OJfQaJK
	3h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KmzQXMSYstW2eGNHW8luFQ0O7XKycvd0c+TB+pDYNM4=;
	b=O4WqLxNobN4OooXYl9Yi5LFOib/bRs+wJZBZt2+TcmCRH5uvZINMiYTH5RvZqEX3e9
	dtd9Z2r+HBf5Xl0KpBoyuNpgRh6VebFCvb3ugr1nHUCE0xei2Gd0Rd2he1Kb/wlRAd92
	1q/6veEcvGpM47T3zXQ8BUqfHZbZ2csHoGzSyZmNOPH0LEtQHSIJpBSXifu4SJ5kE624
	y65iC46ckcjoPikiwHAezr0nd7hKtyupUAjcBPr8cXLvuPUdaUHnslr5hOBdZJCKpqci
	Jr/9sChrWkgKEcZloLjM1Fe44cKNqEZ7ge3I8xupjGgo/y3TbJBfvm3OhKH0pi8og9LS
	v9cQ==
X-Gm-Message-State: APjAAAVUOcYzQPsyvWmVDjnZ6rhJJv/0ck09vitS7FjTzUE5GaLdai6T
	+n9boBGZ20mxZxNbw+Z3EEKToxDc9qqDSkTF02ZGKw==
X-Google-Smtp-Source: APXvYqx110Fif9R8WZW9d7oV3SqIut14d1UBce3Vvd8Z0ubxsJCBf3KJGe6b3YmAzp9Zd9PuNsGAgR/lyXDPHydBKP8=
X-Received: by 2002:a2e:9496:: with SMTP id c22mr6363718ljh.71.1558717240304; 
	Fri, 24 May 2019 10:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190522222224.244714-1-rkir@google.com>
	<20190523102225.GA2994@work-vm>
	<CAOGAQerwpqaP=DKxC+WVdJcGpxnAayfMrwoPP=bBJBBG5Vn87g@mail.gmail.com>
	<CAFEAcA9bKQukg7_HcGKWAFmoaX+DG0NhSctzwg7mpVJ_AOO09g@mail.gmail.com>
In-Reply-To: <CAFEAcA9bKQukg7_HcGKWAFmoaX+DG0NhSctzwg7mpVJ_AOO09g@mail.gmail.com>
Date: Fri, 24 May 2019 10:00:28 -0700
Message-ID: <CAOGAQeqEuc9T-gDWoGPmgZgOoNLA9V_h6Rwz5+PBinZe1XwfmQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] vmstate: Add VMSTATE_OPAQUE to save/load
 complex data structures
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
From: Roman Kiryanov via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Roman Kiryanov <rkir@google.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

> In any case, migration state on the wire needs to be
> architecture/endianness/

Could you please point how the proposed change is
architecture/endianness/ dependent?

> implementation-independent,

Could you please elaborate, what "implementation"
you mean here?

> so you can't just send raw complex data structures

Do we need to serialize (in pre_save and then release in
post_save) our state into a buffer and to write it as one
piece using the existing macro? This looks ok, but how
is this different from what we are doing?

Regards,
Roman.

