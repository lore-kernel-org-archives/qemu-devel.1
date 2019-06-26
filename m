Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB8C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DE120663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGtEbPMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DE120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCur-0006tt-8K
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfh-0001dD-Ny
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCff-00087Z-Pg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCff-000868-Er
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so3112484wmj.5
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6/MbOA1xCDJwm6PMhIwJdefvlJygKmDk3Z/HdE1idV4=;
 b=xGtEbPMwG3juWxUQgUWJqmRo7GE5amDHhIK/tlIRQN+6BFpdq4TuFxpv6xyTZvdSwo
 yQH9Ch3Ve6OcFsKTomuLf1XmQlGOde4f0b4FEJYHyaDDutCnD+ZsoGaoRbp1rzCk1uh9
 3D70rTZsJtJgthdh7MRNtadVuxpywP2c6MLr1VMjz5kvzgdeNTvTo8BMSR4TV0YUQWr7
 dfY9XwktSPUFlisgspLawFhvTylBy2ZzJoYjoX8aYNKpAHIC54wgRT4eBQeQZZkXBOFd
 TAafMiYfMjvn7GnlNFWeBZpXu7xOvo5uMvkqQkmzbHuf3Po/wYqkm0vqniIfnj4RWr5V
 p2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6/MbOA1xCDJwm6PMhIwJdefvlJygKmDk3Z/HdE1idV4=;
 b=LogDh18EFqsn392DAGZ3ASchG9Ofe7IwYLrE0GBzAwwSYHnqaEyNhaGX6ItcYpdwJQ
 jsjha1kM9rp4meOzegbMh0WF7KXpSW4G7188dEzxKnMyhgYjH8lXWuW/EuIW/d9Apxzx
 24E9mSABHk9JlL8YNEpD+OA90TJanIL5L8SpO73/3KY5dwHomX8xO9sFY6uNrtJhjwmD
 C5hod/OGcpzC6uT0fZEPqhbzpx6c7nsmyxgXfJKTOdTQmVYZkXL49oHlm1TDXe7tNWDk
 dXBbLCl8ev/+WuZP6cOENolG1CWn2TuzSVUAtXYV/Zxes4gppMtmx++2RiGw0VEgd328
 DwUA==
X-Gm-Message-State: APjAAAWxefc1g01a2a7eQvuKKHAONzxO5vFupSLyaiFHb3xk0D4OCO75
 1/EIEpbUhOEnCO1iVOQGdvB+gg+6sccSdw==
X-Google-Smtp-Source: APXvYqw2IVtHHjUnOLYc/rD6df64d4gsPVtfQCJiKh5V0C2cOam8JefPGyHt5p607bLOHPTr3e4IXA==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr241248wmf.111.1561573765927;
 Wed, 26 Jun 2019 11:29:25 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id o6sm4200007wmc.15.2019.06.26.11.29.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:25 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560942225-24728-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1560942225-24728-7-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e35eb094-83e1-24a7-4201-177682081c67@linaro.org>
Date: Wed, 26 Jun 2019 17:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560942225-24728-7-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 6/8] target/ppc: Optimize emulation of
 vclzw instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 1:03 PM, Stefan Brankovic wrote:
> Optimize Altivec instruction vclzw (Vector Count Leading Zeros Word).
> This instruction counts the number of leading zeros of each word element
> in source register and places result in the appropriate word element of
> destination register.
> 
> Counting is to be performed in four iterations of for loop(one for each
> word elemnt of source register vB). Every iteration consists of loading
> appropriate word element from source register, counting leading zeros
> with tcg_gen_clzi_i32, and saving the result in appropriate word element
> of destination register.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |  1 -
>  target/ppc/int_helper.c             |  3 ---
>  target/ppc/translate/vmx-impl.inc.c | 28 +++++++++++++++++++++++++++-
>  3 files changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


