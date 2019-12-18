Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6600206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFKeG5MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6600206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iheuG-0005wR-3d
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihetP-0005Ki-J6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihetN-0004Ts-W1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:21:55 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihetL-0004N6-W7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:21:53 -0500
Received: by mail-pj1-x1042.google.com with SMTP id l35so1329039pje.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SSfkhnxOLJVq8D0VuMw3m1Nkq1JpB7CQgyG5iwWZ6DU=;
 b=gFKeG5MMjtr4xilgNcvrs1xT4Pi8O4ut37IDtsKysAqmVcEGnMbU4r2e3+CWiDiruL
 uoTZ94zxMexRSxa0eqFseDU/6VJGmZatSkjw85IboBrIj7jaKs2aDJK3qQ4Scc9kGdEV
 M6O2IEcXgXEp8tyXcQTbpMLRjkX12BRzAJmXCUx14hgGChlM+YrxbTamJdk39pW/uJrM
 pHRxiCcCESUbyRtGath1B3J1JDWsDac5oLba8ZJ49Bzfp8wCdvI6lJ0Umyz4k45QkzIR
 5DsaEKrUdLnyedayd/D7EzhmcMEv+1Pc5105COCmnCWsbXV/6SaeTrGZM8FiAuU3z2vp
 zUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SSfkhnxOLJVq8D0VuMw3m1Nkq1JpB7CQgyG5iwWZ6DU=;
 b=VqfwLN7RDTklMpfDIUtGnFuit6R9vaAgs8dLS+d0y9MPatYkqjTHPvdL/nIc/TrzlC
 Vw+Q8jcWsC/vQdJIs8gTnTNBipdZX7Kb6SUufSzkGa3TUnc1wggvWPauviYCb7qd4/ij
 cvdpMEblG8XuJSNMvnVNsMG/2IfTl+aQvssK0VYfmo2FFfZaWJQYqv0FqBe8k7YAJFel
 WaDyskf7Ykf/xUv9QVCm2WWkb2Leqqe3hueYt6x2GWLUwiv1WNbv8sSDe0NoJz1+NCgy
 V0Pf/lyRFDGVOwvSr4PzJgBbxn3wyxjhXJqkBqsZ252oLQfFIDqmqQaMs1PsDHx2mqmX
 9pgQ==
X-Gm-Message-State: APjAAAWokPo2P3Mqt2h00sKLwiBAEcz4lJ9wB3b6zDxs8abq6BBiKMzW
 Q+sJbtyyD9EH+nW9fLd/1hbxKQ==
X-Google-Smtp-Source: APXvYqxvA4SLKaxmKmY6tZcVUVgiDaYR1galGEj7E9qMyEgcQzEn/Fx/+6h0W8pPyyj4vlN/EX95Zg==
X-Received: by 2002:a17:902:8d95:: with SMTP id
 v21mr4619711plo.61.1576696908969; 
 Wed, 18 Dec 2019 11:21:48 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j125sm4264198pfg.160.2019.12.18.11.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:21:48 -0800 (PST)
Subject: Re: [PATCH 6/6] qemu-io-cmds: Silent GCC9 format-overflow warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-7-philmd@redhat.com>
 <0bd64884-03fd-68e1-a790-c9ceb7710fd9@linaro.org>
 <ac01ca89-ad58-a6f4-e33f-c1dcc4e0ad90@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eeb1a68a-82cc-00ea-5a42-20fb260500af@linaro.org>
Date: Wed, 18 Dec 2019 09:21:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ac01ca89-ad58-a6f4-e33f-c1dcc4e0ad90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 7:45 AM, Philippe Mathieu-Daudé wrote:
> On 12/18/19 5:15 AM, Richard Henderson wrote:
>> On 12/17/19 7:34 AM, Philippe Mathieu-Daudé wrote:
>>> GCC9 is confused when building with CFLAG -O3:
>>>
>>>    In function ‘help_oneline’,
>>>        inlined from ‘help_all’ at qemu-io-cmds.c:2414:9,
>>>        inlined from ‘help_f’ at qemu-io-cmds.c:2424:9:
>>>    qemu-io-cmds.c:2389:9: error: ‘%s’ directive argument is null
>>> [-Werror=format-overflow=]
>>>     2389 |         printf("%s ", ct->name);
>>>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Audit shows this can't happen. Give a hint to GCC adding an
>>> assert() call.
>>
>> This deserves more investigation.  From my glance it appears you are right --
>> and moreover impossible for gcc to have come to this conclusion.  Which begs
>> the question of how that is.
> 
> New entries are added to cmdtab[] in qemuio_add_command() which is public (also
> called in qemu-io.c). So you can insert a cmdinfo_t with a name being NULL.
> This is why I thought GCC was correct first, and I tried:
> 
> -- >8 --
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -42,6 +42,7 @@ void qemuio_add_command(const cmdinfo_t *ci)
>       * Catch it now rather than letting it manifest as a crash if a
>       * particular set of command line options are used.
>       */
> +    assert(ci->name);
>      assert(ci->perm == 0 ||
>             (ci->flags & (CMD_FLAG_GLOBAL | CMD_NOFILE_OK)) == 0);
>      cmdtab = g_renew(cmdinfo_t, cmdtab, ++ncmds);
> ---
> 
> But this didn't fix the warning... So I moved the assert() in the other location.
> 
>>
>> Did you file a gcc bug report?
> 
> No because I'm not sure this is a bug, but if you confirm I'll file one :)

The error message is not saying the value *might* be null, but that it *is*
null.  That is, the compiler thinks that it has proven the value can be no
other value than null.

Can I assume that you've tested this particular code path, rather than merely
removed the Werror?

If the compiler really is "proving" that the value must be null, then the
assert should be transformed to assert(false), and qemu will abort at runtime.
 In this case, the reason why the Werror  went away is that the printf is
removed as unreachable beforehand.

But of course the value assigned in qemuio_add_command is truly variable, and
since -O3 does not imply -flto the compiler cannot have proven to see all
callers.  So it follows that the compiler should not have proven that the value
is null.

So there *must* be a compiler bug.  The only question is whether it is isolated
to the printf warning or if it goes further into value propagation and wrong
code generation.


r~

