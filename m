Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D267EC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936A720835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke0y8yBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcKk-0005rK-Ph
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:38:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcK1-0005XP-PL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcK0-0001j0-Rw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcK0-0001iI-Fd
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:20 -0400
Received: by mail-pf1-x442.google.com with SMTP id c8so11459478pfd.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tv3epx1yFJh2+gasLU7AVdKg/iLUa4uNfG6k049cUs4=;
	b=Ke0y8yBMcgbAEIaxVe6ACA7WIBiS3ESbRGP5UxPCLLQlqUncp/iSbF+FVP3NeH311w
	CDokL/ncA1IHXnqN2X+CZ2lCZ5iH6nFrHYIHXFhsRZkvc0nJPMzWB+Ibvj9SesODUXNw
	vH5rHLwbsCjeicH6OkTzKrOp1svQrVB32fI9SOLN/97G0cBCTinWVAJ364MC+vEmtrsN
	seJm24saknoNjeniPf4fOE6Kr638hauZ+cUoH5D9ADdFOoOqk1ln9zzmdCFvfD34f8Eb
	u/Mvtrao3o73WfkNYgQr53mrItsTdvqFNKn3o3CKsnxs6LAgK+YWHavE9CRgII5S2A63
	AMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tv3epx1yFJh2+gasLU7AVdKg/iLUa4uNfG6k049cUs4=;
	b=tB1UVnDPMTgWWlrPqYWokLU21ERVyj8ExbigLGcW3V00s5lf17dqu+0gsBudZSPPJw
	0yowj5BRrI7uNyYrmAdXmm2Scm1S/L5tjcTCedNe6co1uaOL8dyaCiZ+CprHabW2BzRp
	mUIZ+hi5doW9DlYhMRNvpFbf8uSwIJozRPYEoWIl8ox/5gunMxAdT+ZyK66IdLP/x2lK
	6vP/+8oUAGemc8lKoY/tD+NNeDZFIo3mvqB84fhL0hKHfxF6IBf80Ysbynkg2+HG/VHd
	rr/WPUnzxGj2C4Ze6djR1v/9De3qy86zpvo9bA8Lo8BihBL3wZyVu4kgF8r+bAxduu+6
	nr2Q==
X-Gm-Message-State: APjAAAVjwiJuOjgDcfkXvW6HbHtk8fbiqwuNnktxIpd4treEWsmqKmZH
	RcKr9273vTn3i6jrQypSqGE0Mw==
X-Google-Smtp-Source: APXvYqy8AOrWT+DRNn4xYHGB+YOatsBH7TY00xnaPxz+YdcrIAwCvc6b33qj0XP7I4rhzAYIx8jTKA==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr71910874pgs.258.1555475839145;
	Tue, 16 Apr 2019 21:37:19 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	p9sm23497012pfi.186.2019.04.16.21.37.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:37:18 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d00846cc-9571-484e-58ab-7dc78a8bc8d0@linaro.org>
Date: Tue, 16 Apr 2019 18:37:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-6-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 05/41] s390x/tcg: Implement VECTOR ADD
 WITH CARRY COMPUTE CARRY
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417043715.E6y_GQ9xZVm146dTOllgUWCS-dlg7b2DQTP9vGQDJco@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Similar to VECTOR ADD COMPUTE CARRY, however 128-bit handling only.
> Courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


