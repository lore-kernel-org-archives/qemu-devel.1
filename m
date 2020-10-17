Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A1C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 05:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCBC20709
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 05:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amsP3PlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCBC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTfAE-0002IO-9e
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 01:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTf9d-0001qZ-H2
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:53:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTf9Z-0001n5-6v
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:53:21 -0400
Received: by mail-lj1-x243.google.com with SMTP id a5so5028815ljj.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M3YB82PP3WUpBHFEbh3oPhQQSux8Pw6AFe+SN7DiJGw=;
 b=amsP3PlI3ZycdlVxgLx5tS3RcZ/aE2JugXN/de8WjJzEbbWQfg5yay9mu9yMNOTQEG
 zDGufeyQG0D8nAwfy0A+eh+5b93z85bXUL2cX8T/4mhVh2wiIWZNqlk28ZRb4QzNB/dh
 AIBnGWL+ksEigCgQdVu62IDy26gLVIDUnczpRvNend8MTTwuaCQtont43SmFPbW4CRcT
 cmRIzAt2jsd2hPhc8PRzFfChw9wh+qGJaBiAl8a3e2bI5TkwKjB9tCNO3N3jC/SV0wIn
 USEp5Yt0/QCw/q0JJrWcSGJN2B9ryqMiiGMVPf4OXy69UAR96sfkVVyhw3En3TdcYtr6
 S+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M3YB82PP3WUpBHFEbh3oPhQQSux8Pw6AFe+SN7DiJGw=;
 b=ChwtYIFdbsXd86WalCWtB12BnLB7dOQ+Dy2j41NXeEF4I/CcpZMarc533Z5jxq1r9b
 uxbHYdyTlFqrjKVJGjpHjQmG7G7Q1kE+cyiDd8he4xsg66WXk7jDVvtF+EM81P2y6HHx
 5tuxB/nhCOhReZ2ciEMcnVTaUnhng3iRU0k4f94qSuwZ4NOVB6ZXQZ1fd/fSWSQgj3z5
 es4vf4ytkqWnVakPQMke1HcZhV4wEkyCJCsP61WTvzkBopOv2RvRvFqUeDu2oZczq2er
 vHiANKu/oX0nJHqvERT1613tglnQ7RcDRlQijk83/LRozFvjBjpHTC7mTuhlRHD8zIiJ
 RJfw==
X-Gm-Message-State: AOAM533cYDY+Ou8VqLUM9aa9+MaZribOLSSDnEiz3YSoEpeOaMM6dKMn
 ZDYpSdWz9abOADxjv5Mk3kLyBVcyye8A8xfXLbxTYQ==
X-Google-Smtp-Source: ABdhPJyqRwgfzaNO4k6jC4+ngiz4xp94h1rvkVA6jI+YkhoWwbWi6nRJWMl5uQZtM/9C6Yz+umn28GEOA1tFiD8OGAE=
X-Received: by 2002:a2e:504b:: with SMTP id v11mr2673538ljd.138.1602913994976; 
 Fri, 16 Oct 2020 22:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
In-Reply-To: <20201017053712.GA14105@1wt.eu>
From: Jann Horn <jannh@google.com>
Date: Sat, 17 Oct 2020 07:52:48 +0200
Message-ID: <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Willy Tarreau <w@1wt.eu>
Cc: Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, 
 Andy Lutomirski <luto@kernel.org>, Jason Donenfeld <Jason@zx2c4.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 kernel list <linux-kernel@vger.kernel.org>, 
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, 
 "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, bonzini@gnu.org, 
 "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>,
 oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=jannh@google.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 7:37 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 07:01:31AM +0200, Jann Horn wrote:
> > Microsoft's documentation
> > (http://go.microsoft.com/fwlink/?LinkId=260709) says that the VM
> > Generation ID that we get after a fork "is a 128-bit,
> > cryptographically random integer value". If multiple people use the
> > same image, it guarantees that each use of the image gets its own,
> > fresh ID:
>
> No. It cannot be more unique than the source that feeds that cryptographic
> transformation. All it guarantees is that the entropy source is protected
> from being guessed based on the output. Applying cryptography on a simple
> counter provides apparently random numbers that will be unique for a long
> period for the same source, but as soon as you duplicate that code between
> users and they start from the same counter they'll get the same IDs.
>
> This is why I think that using a counter is better if you really need something
> unique. Randoms only reduce predictability which helps avoiding collisions.

Microsoft's spec tells us that they're giving us cryptographically
random numbers. Where they're getting those from is not our problem.
(And if even the hypervisor is not able to collect enough entropy to
securely generate random numbers, worrying about RNG reseeding in the
guest would be kinda pointless, we'd be fairly screwed anyway.)

Also note that we don't actually need to *always* reinitialize RNG
state on forks for functional correctness; it is fine if that fails
with a probability of 2^-128, because functionally everything will be
fine, and an attacker who is that lucky could also just guess an AES
key (which has the same probability of being successful). (And also
2^-128 is such a tiny number that it doesn't matter anyway.)

> And I'm saying this as someone who had on his external gateway the same SSH
> host key as 89 other hosts on the net, each of them using randoms to provide
> a universally unique one...

If your SSH host key was shared with 89 other hosts, it evidently
wasn't generated from cryptographically random numbers. :P Either
because the key generator was not properly hooked up to the system's
entropy pool (if you're talking about the Debian fiasco), or because
the system simply did not have enough entropy available. (Or because
the key generator is broken, but I don't think that ever happened with
OpenSSH?)

