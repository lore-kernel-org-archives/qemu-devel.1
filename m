Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803CDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33742074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGNsHsq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33742074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTlyR-0008TS-PW
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTlxs-00083d-NJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:09:40 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:43012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTlxq-00061f-DV
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:09:40 -0400
Received: by mail-ej1-x62b.google.com with SMTP id md26so7385005ejb.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rYiZS+eBAD2rIdeuwYSdQ/13f6TXcVpEIjBf8+JIFgs=;
 b=gGNsHsq9RAq0DA8qBFI7/VNH8dmfebfnibb2i2eBNrahX6RtdIZHN1iBVfkgtFktmU
 e35foAwO6b38uI1NDRQG+dxf29VvD59YVq/u3dkUkgqrlQMuHaHBjnTzN8MLI1dKs/xA
 GyG8WAF7gQOaDTB/jBcmf7xr0hEBd0QAUZVSyZRJf+1jm2blISutyBFszUHmPZQQ0y8n
 kxbjAD9n38+canNXFEfdS/bPfvfhBybxNApPhKB8UMgd/XraUq8DrTYFsMDnnVHvBUqw
 rb/q1dT9NBlmGvVZ1IMHoJEq4ikAaqk6FxMpqcUPI45ZCoEm+CzHa9s/2fWg31/zeVDt
 veZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rYiZS+eBAD2rIdeuwYSdQ/13f6TXcVpEIjBf8+JIFgs=;
 b=HPhheN+yELdagulCztJik0Q2gfTp/r7i72zak55OJDSY5oAG8vm7foTBXHX3sFQhUX
 CJJVXwb/3Fm5YPqOeBJ4xWRiSSA2KgTGV29w/O/C3t3ayt7p/3mD97VcL9jP/zTVhXJt
 RTZj0Z0FUIyqm/QU4/isHrGOjRoJr53G7bP0d6G11k+2FjHJ8+uViOMddqz40m1f/Keh
 G4/U2XPUlHMQtU82Q3Hzz33/6RpXMGg720VwYMapuZgUNvGigfsovP4Lisdzun/RDyR4
 3N/4XJnTKFLUyu3fOf/MH23589U0VqnWbLsEuG9ZFX2WZNb+2QPVLTmcHZho7b1gC4Aw
 8gDg==
X-Gm-Message-State: AOAM533lowzLRw+K3MjjZr7J6nc25DhYhp4U61yeAKvyeZA0dwAsZ7mp
 ibhZ889rrsnROKmDfZ/50wAVIepR+bAScUZVwgdKXQ==
X-Google-Smtp-Source: ABdhPJzqGdjm20+KuJZoTSgIV83uCLeGJPqEz+/RazNGQSqstXhcdw2/MQafTLVB1EOfZWq87fQHIuztT0TomMjhNgU=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr8663483ejd.250.1602940175968; 
 Sat, 17 Oct 2020 06:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201016155331.1613089-1-pbonzini@redhat.com>
In-Reply-To: <20201016155331.1613089-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 14:09:24 +0100
Message-ID: <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 at 16:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3e40748834923798aa57e3751db13a069e2c617b:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-mb-20201014' into staging (2020-10-15 20:30:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 61f6bb4b9b3b33d0371e5f76d756838df372f2ec:
>
>   ci: include configure and meson logs in all jobs if configure fails (2020-10-16 10:01:43 -0400)
>
> ----------------------------------------------------------------
> * Drop ninjatool and just require ninja (Paolo)
> * Fix docs build under msys2 (Yonggang)
> * HAX snafu fix (Claudio)
> * Disable signal handlers during fuzzing (Alex)
> * Miscellaneous fixes (Bruce, Greg)

Half my build hosts fail with a weird backtrace from mtest2make:
Traceback (most recent call last):
  File "scripts/mtest2make.py", line 37, in <module>
    introspect = json.load(sys.stdin)
  File "/usr/lib/python3.6/json/__init__.py", line 299, in load
    parse_constant=parse_constant, object_pairs_hook=object_pairs_hook, **kw)
  File "/usr/lib/python3.6/json/__init__.py", line 354, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python3.6/json/decoder.py", line 339, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib/python3.6/json/decoder.py", line 357, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make: *** Deleting file 'Makefile.mtest'

followed by:

ERROR: Cannot find Ninja

If you're going to introduce a new build-dependency not satisfied
by a submodule, it would be nice to mention it in the pullrequest
cover letter...

-- PMM

