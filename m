Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC78C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08061205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOe3XXuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08061205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDZcm-0004XX-VW
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZXv-0002t7-2b
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZXt-0002hP-Q0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:07:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZXt-0002Xt-GL
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:07:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id t24so8407192pgj.7
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AfrTK/b6k0acUn4IW674vAyc76w/gBDaEBHOCoRtH74=;
 b=tOe3XXuB2QWgliU9Opdz9RfD1OXqF1tgipkrV9v9NFtP22NecnEdyP3zBsS9dv7uNU
 FmTm2pnPTuXBX8RPsRtlb5hioIrWDoJKfidDtD9sGmit06pNvrEDJ8dBI+mEZte+aZjr
 nN91N+MCX0eJEunBEonVF3g+6a5Ab9JP8NKJuS1Ep0bH0ykLDfXpuCaB1EtuLCIPIJTM
 CLgw8Cky2PK0LYDLxZNSxEP3MqKuVyRMm9tMeMk6JEs/PoJb8TxY8rddHNSsIF4ZrdtX
 V2n5m7Bkp7yocw7uRoYzTIu7RRsmUhh4QkFae6gIs18h55I/9EkMzxjX+3UzLgLzVhdv
 41Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AfrTK/b6k0acUn4IW674vAyc76w/gBDaEBHOCoRtH74=;
 b=C1cFn6hsgXKETqaeuboVPYFJk4X4eBbqMm6jriaQG+4Ol3x7ZOFc913pO8ifsHoDTT
 umdmBMlnvxfZ/vs7U5nTvyJxSrks+cSHqJSilLGscSx0KiU6UOH4SJwy0FlZGJqo0Y49
 PfQaRpyGTZuoRBlMp2A0MVSa2dqiCumwjJiIqKEMblBaAAmqtfayuqfGqua/+LmMGHzu
 6N2A3YJDHF/Yu7QNtRT6bP5d6TAW3+O8pIz3oe7MtcXnH/plEK7ELbOt+1qzFkBUxvZm
 RzMxaiXsZSD2wfGywCGJpcCdyz0bEmdYz32239jutXIS0oyMc8QnuXkVg95Ch0HOY9h9
 dCTA==
X-Gm-Message-State: ANhLgQ2WR2pcxO6Q+FN5HuRNgY8UrSQmsY/CaXhoAO8+WDesHppxrbPC
 i9vhMhfBTQtwAcWlMWmeXuzjpw==
X-Google-Smtp-Source: ADFU+vsueR85ye3lPcPONMF5ThCBFNP2R9hCqzd2OsZCP01oFAPFIc7A3zZ6pvPCcmNbjyEOYngj0Q==
X-Received: by 2002:a05:6a00:c8:: with SMTP id
 e8mr21563883pfj.131.1584302856321; 
 Sun, 15 Mar 2020 13:07:36 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s25sm4460709pgv.70.2020.03.15.13.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:07:35 -0700 (PDT)
Subject: Re: [PATCH 04/14] tests/Makefile: Restrict some softmmu-only tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <942d57d6-b272-c2c6-b2df-405d81d03996@linaro.org>
Date: Sun, 15 Mar 2020 13:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> These tests fails when configured with --disable-system.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/Makefile.include | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

So... they don't currently fail check-unit.  Did you mean to say that they
*will* fail once other files are disabled?


r~

