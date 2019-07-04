Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617BC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C289121850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFOPBsCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C289121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2OH-0007tS-2J
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj2Ml-0006f7-Nn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj2Mk-0002dZ-SE
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj2Mk-0002cQ-Iu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:05:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id s15so6317528wmj.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=m5TZ/kS83WOeEj7wTCboUzsXHAUohD5eI+qlnwY7pCM=;
 b=UFOPBsCOXruE1bGzQSX9BArMa39CJHXraBBrW/Ex8nhEdBEDd0hM1Vki8TXkzV4MBW
 1oRda3gRIFvQ0ezLkpF06mfWgDkP+/m4dk8fWnu4HiMHxsY0iW3clI9+hV2pFIQKmKkF
 7DuwU2HgK/rFpn6Bnt4jKWARHR+JMtPViB08dxFEZmzu+3cR1Tp7SU7zyY/QqJ1yMQOo
 UswcRsTt3yLCIRQLlrjBl7VEYXOveWS6UsmMlj0fq5udpufDsHwq1VJlJAgl9wwwOFYf
 kmyjysH7k/CpMT8M4E0jzF9BqFTGRpswqCjE5Z4EaDQH2mtxBbKfy2/GIKQTYSNNCef1
 7VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=m5TZ/kS83WOeEj7wTCboUzsXHAUohD5eI+qlnwY7pCM=;
 b=O2kn5h3l/lHM2i+hQpsZu3n17HlLRU5fSIahdxMbToi0gDnVeU2MRKEBkU9zM7abwK
 yvqDLrW3H0MRk6Q2IGNXFI5CZCz/Te3HpQJeJ/kV+Qm3tWDhS611O66VDtrnQUyUOS9P
 3DMGxSVrGOesXj3cF0LTHByQLIBZp069FsEaeg743RMTSTI9CoN1jYHFm/mYoWG6Iqh7
 XUqQpJTY/WOaZsnvnlaydvJlXQfG4ELEO/7krnlOMfK4C9oqcYuhm9VnY+5LT42U/gvW
 lnNNfgo8ibaPSMr3XBob2MX3fDVl95ScpwGGWr6z9N8p9BdHGG+gSpUS1BIhjSoWVP+z
 pUkg==
X-Gm-Message-State: APjAAAXXm56Vj/U8qXQimw6z0cJ+tDhxX+aJi5xsU9eREcjekU3kt4rZ
 kAo1+mvfzhsgIpBTgb7fEMm/hg==
X-Google-Smtp-Source: APXvYqwKsmigBlWifPKWHIlw3m11/jlanPfay1fVRsIEWCVLdZ+mzMgPsBeaSvqiB+F8kT64g1fi5g==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr12278237wmj.129.1562249136698; 
 Thu, 04 Jul 2019 07:05:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p140sm5126184wme.31.2019.07.04.07.05.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 07:05:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF2C91FF87;
 Thu,  4 Jul 2019 15:05:35 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-1-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 15:05:35 +0100
Message-ID: <87a7dtx5cg.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 1/6] accel/tcg: adding structure to
 store TB statistics
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> We want to store statistics for each TB even after flushes.
> We do not want to modify or grow the TB struct.
> So we create a new struct to contain this statistics and
> we link one of it to each TB as they are generated.

Mini note, what happened to the cover letter?

--
Alex Benn=C3=A9e

