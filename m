Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC8C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2411E20651
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhcFZvW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2411E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJh5K-0003a8-Qx
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:18:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJh1q-0008L2-M2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJh1p-0008Cr-UI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:18 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJh1p-0008BG-N0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id y13so134679pfm.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7mbYizEmUBiE4p7G0c1ojVSDGX1keCabGEKT8GbczDw=;
	b=mhcFZvW59E7OrZbqja73JGhbUEsgsNTyhxY6FYiZLYCFTmA11+dnq3oy8eOXOOmtHe
	6TNgFyRvSAY1e/1PLkNdQ/HzOgKLsPxV5w2JSjUU0GakyWwqT50eT078r0Uql2b/Je/i
	Bgvxxar/iGLZ3A17/r5h6kNku6HJs+HAi0Vc2V0nKLgZGaLYfr/VWRG5voNzXklQO66g
	w2SZOPRONIUTXVNAhtPY7+geffZFPdyK8vLk9zRi1Frm3iNxnC2WPBmY+3lxhemBBxSa
	HcYIUm/sopBvg49I4qBQ5t+9qlMOiOzitS9c4/MKBT2jVDA8fU1kQeFebhhoeSWEshWA
	JjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7mbYizEmUBiE4p7G0c1ojVSDGX1keCabGEKT8GbczDw=;
	b=sXXb2FxPNQukSqe2NuK8n8GdH7YxpKfpF8BPW1xJWxk35AGd9jnJ2icwX7S/m6hYR7
	X4VIPmOZ+Cxnu7tB/cCGKuuCxaYDoF86nGjnZ2EtME5Q5fchdrzA/J2mR8MvsIUTtpZX
	pg9DqTbC7+Jx6IK+M4EdOS519hEpOZUrENcAV2JgsB6pb9HQ4/U8bvE9tdZN3yQEe1pj
	m4eeKYTjey/A+IrKVswW287Ij4teeXdsQh/1oSqV+jcpGq7u/fJCfwIhyVKdfnG1Dc0D
	Sb9QF4GC301NRCs/bRJV42++VaFBS70XYLZgpwPhIqnbDh1zfwxg/F5bufRnvZ5VypHJ
	pinA==
X-Gm-Message-State: APjAAAWawJ8wN9Vh6W4HHXdCyAKZoXjnHPUbk8E0EEIDc4PsZpV5tK8G
	cvaZgg4smavpkc2GOzPBT3WSAw==
X-Google-Smtp-Source: APXvYqzugL2NbhFhMIY0fcA85B6PFVrNCHtp/wpSBld+va70aJaEmgSszjVagRy4b93Y2vCJECnXnA==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr37529685pgk.44.1556208915937; 
	Thu, 25 Apr 2019 09:15:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	g63sm35484217pfc.127.2019.04.25.09.15.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:15:15 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-3e3866ac-838d-4c70-8dd4-880201b74b8a@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c20ee4b9-d6c0-9bce-219b-24d3496cd460@linaro.org>
Date: Thu, 25 Apr 2019 09:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-3e3866ac-838d-4c70-8dd4-880201b74b8a@palmer-si-x1e>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425161513.ux5AqFfSneB9ow54cigd98pzlU2Bi_5h6vJfFdFxQl4@z>

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
> c.lwsp with rd=0 should be an illegal instruction, but it's not.  We'd need to
> re-introduce the shim to handle that quirk, but since it's not actually a new
> bug I'm OK taking the patch set and fixing that later.

That should be fixable in the decode file, without a shim.
See patch 5, where I introduce trans_illegal, for doing
exactly this for c.addi4spn.


r~

