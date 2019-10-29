Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42791CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6B820679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPsdiRbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6B820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPW9O-0000WA-5x
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 14:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPW7y-0007dJ-QI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPW7t-0002xV-Rk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:21:58 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPW7t-0002xB-Lu
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:21:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id b16so10596250otk.9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1BkCVZgYyu3JQABHzphuzW2ReybtOVTmgexcptDfn4o=;
 b=RPsdiRbmg0FO+db30sdg/gyaBbcCX2zMixMnzUnQ7XciCTB45Tn1km2t1zYa5r5KHw
 Cl/AiXczsWQGOjUxWPB70Ie+x40hdgwoZtOaG74/2Y+XZc3lg7WPi+eGdpOctH1sqOid
 SqMtClP7++SYF96f1KX7Z5zzMtsnmcJRMBCA8GJxNYGbERWRTbGBhQ0XquT5dNEz84uZ
 /11tWIjv0GcnoxWTs+5VKjw6BeYufuMjTJ78Biy3SU0h2eB9AwqrvMAptumXFFc+EOj3
 oGtp64fDCCR3OFeaXXI0Gs6E8+QjOQ712uyAnUQK6cBJtcIk3b3xC0EMoPmf4TlEAtD7
 iScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1BkCVZgYyu3JQABHzphuzW2ReybtOVTmgexcptDfn4o=;
 b=fhVl+u1Nf6bO/7KyO36QEAeB7vEueKmyrC7BAMQPzUlo2uOBW9XTlJm9uQWbt6U0EX
 UpdqzEfPK3wtw1l1L0I58gOagVLkLyYzJUY40U81f+3RMXASbbHxEGrpmXIqIyFpThFB
 44BlnkJKtu61ou+oedrPcyWOermKkpmDcvG/RD7PU/MQXdjldm20v6reWhMwU3kui2UE
 7FI0UBYKP0M4D+y1TExPm/9ciQjhjScqBGQnczQMhpt8bwhkPlYmjNdYEPk7NNAknngQ
 yAfGVa+uR0UvL5fpjQJlziHyAl6OC6psfdUATzpWK2A+JUDQFBqWMC9MmVK8T8NeXRjw
 mfpQ==
X-Gm-Message-State: APjAAAW3vXN5baG0yjjOOXMaH5LeYS5SRrSPNjFwDGlikzjRUWOQkS4M
 PoWlu2JGwXVK9FIBI90isBj9Mc9FaqMUaqul7nPReA==
X-Google-Smtp-Source: APXvYqz5nQhOT8L0naWWNe7UaFsb06NZ7PeFu//2UCblJVEhi5JtXvYeU6XBsOC6lnqbgCYYtOIMC8si+tkAF32bs6g=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr5162190otd.232.1572373312817; 
 Tue, 29 Oct 2019 11:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191029162248.13383-1-pbonzini@redhat.com>
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 18:21:55 +0000
Message-ID: <CAFEAcA9nT0AfDPmQ2_SDec7_z3+wGS=XQJnSiQwrWCydLgv83Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] docs: integrate doc comments with Sphinx build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 29 Oct 2019 at 16:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Hello,
>
> this is an attempt at including kernel-doc, with small tweaks (see patch
> 2) to support QEMU's doc comment format, in the Sphinx documentation pipeline.
>
> The ugly part is patch 3, which disables Sphinx's "nitpicking" (warn on
> invalid cross-reference) mode.  It would probably be possible to use
> the nitpick_ignore configuration entry instead.
>
> Paolo
>
> Paolo Bonzini (6):
>   docs: import Linux kernel-doc script and extension
>   docs: tweak kernel-doc for QEMU coding standards
>   docs: disable sphinx warning about missing cross references
>   memory: adjust API documentation to (modified) kerneldoc format
>   docs: add memory API reference
>   memory: include MemoryListener documentation and some missing function
>     parameters

Could you briefly describe the differences between this patchset
and the RFC I sent a while back:
https://patchew.org/QEMU/20190521122519.12573-1-peter.maydell@linaro.org/
please?

thanks
-- PMM

