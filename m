Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1873C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B942253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXhK4c8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B942253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkO0-0001kP-RM
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 22:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1itkNP-0001K9-Ox
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1itkNO-0002hG-H2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:38:51 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1itkNO-0002gm-Af
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:38:50 -0500
Received: by mail-pf1-x444.google.com with SMTP id 4so740486pfz.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 19:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YLXwvupBswSIKudTd7Mnu96UA7e6TW+2CtCL61xNbkA=;
 b=jXhK4c8wRrjCru9EpK0BjYgzVUTxkeq39PYmpdbIoZVY2ZC/B4/6U3SeplLv6TNaGa
 kr9EgwBb7N8x5mYpnnGi+WueIes/PMWss0KioD3iNBh1RCt9CYuCNMX9w3a0OBsogR7t
 ka3nN/iA0diaNaF2sUzsXwdvP7wNkn1BQ9AHepaZvrpY+a/4qEMEXt3wkOes1Ca0WDE2
 1pQEZCLIJcTo/hfH5jnaX4H/iggvYbUiXz2/Es10/mf8G6eRzq444/hw6xJ8bAvhtrpA
 8FlxQ6KZMucRLvfdHOv/41fmtHZQz9CR+15UAkd9YbqRoqxRDTJsBOJOsNMDYEhy6NEs
 3OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YLXwvupBswSIKudTd7Mnu96UA7e6TW+2CtCL61xNbkA=;
 b=ccg0v6PAcT5sa7bM4b/2p54l4/InQ41gM51FusRQ7/ilwud5EYLnfh7Vwcky1HRUiB
 8nbQ2TISHo5rkadDKY+yeXyb777tPT7kRoNazSWhslTpCQ64cTODYq6vQxEaEQ+YANQX
 xG6ryCpleH1p00ZlE8McJRdYMFWRMKkiK5tnRTzToeMNl6zT1MYUVLT83Ao9F7eIst3Y
 qSK6u427tLGsVEXZjOdUFBXZ/SJ5irvs9i2sQ8cR9qGyyj2XuWN97bcvtNDHhdZarlzc
 PhKo+63sCfkM1D+bIqkS26qYLNptAw/z6MgGx3vLa24/2e5YioksCnyy4MRHH4UGpBI8
 OJZQ==
X-Gm-Message-State: APjAAAUJIq8yEsfNP3t3ChvOuMyclNoMjECvHIbDvAbylP4+m6lwSoz2
 nS6KWTdH3YNeASzxsLqXQK0ttQ==
X-Google-Smtp-Source: APXvYqzS/SWEfFOiNzwgPEqZDeILKGV3I/ftKBW4Rb2D1TMVhKmAEsIV+giVHYGknPxIyYjME/iSNA==
X-Received: by 2002:a63:f551:: with SMTP id e17mr3148267pgk.162.1579577928850; 
 Mon, 20 Jan 2020 19:38:48 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id n24sm41053855pff.12.2020.01.20.19.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 19:38:47 -0800 (PST)
Subject: Re: [PATCH v2 3/5] linux-user/i386: Emulate x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-4-richard.henderson@linaro.org>
 <87v9p62vt5.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e384935c-7fc2-77eb-352d-90aa95ba89a9@linaro.org>
Date: Mon, 20 Jan 2020 17:38:42 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87v9p62vt5.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 1:48 AM, Alex Bennée wrote:
>> +    default:
>> +    sigsegv:
> 
> this label looks a little extraneous.
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

Look a little further down:

> +    default:
> +    sigsegv:
> +        /* Like force_sig(SIGSEGV).  */
> +        gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
> +        return;
> +    }
> +
> +    /*
> +     * Validate the return address.
> +     * Note that the kernel treats this the same as an invalid entry point.
> +     */
> +    if (get_user_u64(caller, env->regs[R_ESP])) {
> +        goto sigsegv;
> +    }


r~

