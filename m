Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB03C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB42E2068D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxNFfyF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB42E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfAb-0007z4-Ss
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWf9N-00074y-AA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWf9M-00025r-1g
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:24:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWf9L-00025Z-PZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:24:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id c22so18352450wmd.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JzfRpd5L2e1m2BapBhmfnzIXt6f64QiF0td+FoTUkHY=;
 b=xxNFfyF6ChX6awTGAHiwG5IvKpqM/2xbiKKfDeNR7tj3GLB1G3uu/1qyZBLiILn5C5
 2dO3VrlcpE+aj0YlMDFxTyLEzTuImnCUHkDwHYSc1ACE5rSxgmD90QAVt9jQ/jEuM1JU
 SKlqMi3CKSD8mkyzXnqUGrvglCLFCFSu/nut32MICu4lRkNmuoLEAG9w2sNeez2NjvQP
 xLoHsybg8KON1GdfBK39iW/6vwBkgMnYQMAkTClJuh0KRp9X18gYNY5KQRD5m6WLNbjB
 T7IdmD0VChdkSD5BMrif4f/M6Gbv9xh7YMebRTbhP24g/PKWZAee/qzjlNR9YS7l0Vf7
 YX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JzfRpd5L2e1m2BapBhmfnzIXt6f64QiF0td+FoTUkHY=;
 b=rSobRxxNKFhpOzphM71mhX2IDbGRvyWaOUVxVhYbYGF51+j0L0cLDJOqkFiX3mK/wn
 R1mKUCGmJ7fMe+cPVxXLy1Wl24GYE3vTOh/mO+lKwq/2jPGRyWVE1tPWq7VXS8+C2qfJ
 8342xET8HBEv6OGAhGfa6xmxbeb0vbIpPZiGh8tlJOrrh9bsRv7d1wP7uuV3putZIAXL
 TuAsNGMVYTULvjNovAl5SA65pM6Cx3Y+5nIiHIHi9GOS41C0e/zZigvnxWvNfSn8wEJZ
 ZwzPyZ81SwTNtX80/FN8b1AM2WwpO4HdzKEZDKFuKVaSuX9Jchq8EGZ1jHWW673uJ5g6
 Lpmg==
X-Gm-Message-State: APjAAAVZNil+LJLvgNMh9blxUsMyFW1G6vFoZj90Juy2dJCjwev/nUn2
 UhQT/syDlej10NzddyPASwjWjA==
X-Google-Smtp-Source: APXvYqwq02/IHlQl1sb0v1cxtW8NsEzk8g8/ydH0wfNnd3DbgqWRv9Boz0RW7tfVynyewRi8qxpOeA==
X-Received: by 2002:a05:600c:2105:: with SMTP id
 u5mr27543346wml.47.1574076294455; 
 Mon, 18 Nov 2019 03:24:54 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id k14sm23673990wrw.46.2019.11.18.03.24.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 03:24:53 -0800 (PST)
Subject: Re: [RFC PATCH 01/11] gdbstub: move allocation of GDBState to one
 place
To: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-2-alex.bennee@linaro.org>
 <9f87f9e8-ecc6-398f-62b3-05a7f9af2366@linaro.org>
 <422bfc5c-4d2d-a581-7bb2-8a2f8e113b35@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4acfb969-b6fb-89d2-c1cf-951c88d08f2a@linaro.org>
Date: Mon, 18 Nov 2019 12:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <422bfc5c-4d2d-a581-7bb2-8a2f8e113b35@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 10:19 AM, Damien Hedde wrote:
> 
> 
> On 11/18/19 8:41 AM, Richard Henderson wrote:
>> On 11/15/19 6:29 PM, Alex Bennée wrote:
>>>  
>>>  static GDBState *gdbserver_state;
>>>  
>>> +static GDBState *gdb_allocate_state(void)
>>> +{
>>> +    g_assert(!gdbserver_state);
>>> +    gdbserver_state = g_new0(GDBState, 1);
>>> +    return gdbserver_state;
>>> +}
>>> +
>>
>> Actually, if we're only going to have one, why are we allocating it
>> dynamically?  We might as well allocate it statically and drop the pointer
>> indirection.
> 
> In use_gdb_syscalls(), we check if gdbserver_state is NULL:
> | /* -semihosting-config target=auto */
> | /* On the first call check if gdb is connected and remember. */
> | if (gdb_syscall_mode == GDB_SYS_UNKNOWN) {
> | gdb_syscall_mode = (gdbserver_state ? GDB_SYS_ENABLED
> |                                     : GDB_SYS_DISABLED);
> | }
> 
> So we cannot drop the pointer or we have to add some flag to do this test.

True, but perhaps a bool gdbserver_state.in_use is a clearer way to do this?


r~

