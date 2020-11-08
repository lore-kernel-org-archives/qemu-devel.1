Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9036C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABE9206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPNf8pzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABE9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kboAV-0006q5-0P
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 12:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbo9C-0006Ha-PE
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:06:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbo9A-0001li-W7
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:06:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id h62so5828600wme.3
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X9wG/augCwD4emVIFXeAwiZAEZ7Vmh+C27gpCvPqtTQ=;
 b=bPNf8pzB6CUHIQBvgJw1vMoANhZ3HZhlEri2y+/kkMyxbFEkxvqDSLE6FLNQkgE2b1
 +hPtNkPjXSa4hWmFAE/uspQhnH7TX35ZWXUKb3BHjSsxXq7zOMo6wrcEH0y0yj3wHzJf
 F0GgTXSex+0SjdGwtn3kT0VCBC2B8u8TUxxyShe+wUsQOKDMCXej2TdZTUHjSvKRA0J5
 q2biqHznnruXY3X08lEr8fqTk5GRqXoicmGmhw3hlBa/ga7CDh3ZaVR9qR+5efPpBc8O
 EmJsH+Ep5T3Pwm8WimWNo53+ycUUdYGM3ZuQpv3TTAYmD/4S9OSe5AMtGxLrNSgoNnT5
 qszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X9wG/augCwD4emVIFXeAwiZAEZ7Vmh+C27gpCvPqtTQ=;
 b=Gkx954QofM0VRNQOliqIXLB99IJxDyzJpaB4WxTvLCMo4dE3hgkbA1NPXERBxwSVCl
 iP9u3mUv5WxYluEyE+DtBxoTbpBDosi9oMUORzPHMSltoonkZ4hsbvHYxXI/oB1wIxHQ
 uQXvc5gAQGUseuFUopUxGbT3VWF/GtgNvUX/yscVjVPa3LSw9/5ZiCUgnRtCkqHaok89
 4UoGNl22BNSVZZZ90Fzwn4Ed7HY1/DQ1+fIezGzipg4B4bXLTJCd5NaY8bUdaLQ3Wzq6
 EeFIqLFsAyuZb4SuzxHM+X024rQDRfSF75DrkJ3pI+VWgitT+QlUfWx4LRzxvOd5bUtt
 0T3Q==
X-Gm-Message-State: AOAM531b0KELV0dFcLxyGmxrU0R2h9m/JB/+KGdkal2oa2waLq3eCAkT
 vOV+bZs4P1DeZ5l2GHUV686zaT5aec8=
X-Google-Smtp-Source: ABdhPJwSxz97WTvwmjUIAX4AW/DHqAZOOxG91d43vqaI7Kni6fqBmOlZTmwfSylXBmiKP4v9n/4b3Q==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr10750005wma.154.1604855190684; 
 Sun, 08 Nov 2020 09:06:30 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id u23sm2304880wmc.32.2020.11.08.09.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 09:06:29 -0800 (PST)
Subject: Re: mmap2 is probably still broken in linux-user & other things
To: "Catherine A. Frederick" <agrecascino123@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cceb3d0d-958f-91f0-770e-4acb01fedd7f@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eea778cf-205f-cc10-bccc-ba8311949d49@amsat.org>
Date: Sun, 8 Nov 2020 18:06:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cceb3d0d-958f-91f0-770e-4acb01fedd7f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing user-mode team.

On 11/8/20 4:53 PM, Catherine A. Frederick wrote:
> Hi, I submitted a patch a while ago and then dropped off the face of the
> planet like most people do. In my journey to fix DRM/radeonsi in
> user-mode emulation I discovered a few bugs. I don't really have the
> time to write the infrastructure to make wrapping DRM IOCTLs remotely
> not-ugly, but I do want to get patches in for the last bug I encountered
> as it's kinda sneaky.
> 
> Currently(as of 6 months ago, and I doubt anyone noticed) mmap2 is
> completely broken for it's intended use(mapping pages outside the
> address limit). The value of the address input to mmap is clipped to an
> abi_ulong(4 bytes of 32 bit platforms afaik?) and because of this the
> value in pages when converted to addresses and passed to mmap on the
> host is invalid and this breaks radeonsi(and probably any other GPU
> driver in linux-user.
> 
> I don't really know how to fix this in a sane way so I'm looking for ideas.
> 
> Another thing I'm looking for ideas wrt is I'm thinking about is some
> form of automagic(opt-in, through a new type) pointer/union translation
> in IOCTLs over the guest barrier. Currently it's really ugly to wrap
> most of the IOCTLs in DRM and amdgpu because the DRM ioctls frequently
> pass pointers to the kernel and because of this I don't feel comfortable
> merging my patches(manually translating the struct to the types of the
> host sucks and feels like redundant work). On top of that AMDGPU uses a
> lot of structs where currently having one type for the call would
> corrupt the data in the return union.
> 
> Last thing: I never really got any performance benefit out of my
> scheduler, but I think that's mostly from bad implementation. Is there
> any information on TCG's performance characteristics? Thanks.
> 
> 


