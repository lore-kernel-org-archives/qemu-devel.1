Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F2C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 05:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A554F2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 05:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mj4ipAZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A554F2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTeMk-0008Sh-Ki
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 01:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTeLy-00081p-3E
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:02:02 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTeLv-00016N-Sp
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:02:01 -0400
Received: by mail-lj1-x243.google.com with SMTP id 23so671381ljv.7
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Hx7Q/ww8SNQlC+Vff55Qg1KHQPfa6zByV8YGUpfQHNk=;
 b=Mj4ipAZT8hm2EFBVYWNa/tPYN08h/c6I9aqqDDNKd/U1Gx8lY/fq6SCOLleNehgJrg
 16iTyZDjW3bOYh1hhqWtA77oKiTI+TPM4N1Keo/JnJzSrlqFLzW7RPlCSwXodHNBHioe
 60sjtbu/3EHa3YEwd0uy5df4RemUuD5LYm5H+8Y1Jz0qZOf6lUVUq/8KwhvUZ8M3r7Gw
 bWF2ycp8+cBNuu5EidPWzLVcRpMEVOSaAgokNP1gQ/Vcr6lzp6alR3rT1I0+BfHSKna1
 MUB9pFRtzc7GBqzTpgUnKrsGKvi+izpGnZj97WNgEpuknnloyOVePKBpgA5B1rIzMjOM
 A/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Hx7Q/ww8SNQlC+Vff55Qg1KHQPfa6zByV8YGUpfQHNk=;
 b=LJbPcl/iepQGhQ2XHWx8jwSEjj5/9PIG2SijcrZW9/o/YTTPj+2aTxn4tTgrA/+ACp
 EasPcTnw3FKczjM5B6fVXYm1PZgvkdj1lJQ6ZyC9Zi1ieIAmfzsPJmBzarEpJ6zVfNeX
 0eQMuC7eta4OqN8KkS7oQukjKO+T7s9wLWGF8i/IrPqWrgsbp/yMskaujpJ8NBHlslDQ
 nID0Auz66bPQ5bSf3foWMnAFbKp+kkHeHbxZMYdb9W+tA6ZOxcnpZyAzQOTzarGi6I0d
 /HMSp8Ms/+L+t6YLDVk5yBByBk9rN3kIMIIajmdryvCCvHJ8Qx+riqZkD6W3jIWXR6rX
 6tEA==
X-Gm-Message-State: AOAM5330M9YI394HkusW6T5341ha5MZrwyweyHEqhUZwhVtJBPid94Mr
 4t+gytRMLiCN0JnKVKGSPHpYlXSj1gd+G7EFZjl6dw==
X-Google-Smtp-Source: ABdhPJxCQSIczBapjLlcHFxQX22QzzHRPdqAFoK5FO3ftEN502eaH7vfcq23H3Fg7kt7YZD0VFtLi0VxAAPhKjminMo=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr2566942ljo.74.1602910917566; 
 Fri, 16 Oct 2020 22:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
In-Reply-To: <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 17 Oct 2020 07:01:31 +0200
Message-ID: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Colm MacCarthaigh <colmmacc@amazon.com>
Cc: Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, 
 Jason Donenfeld <Jason@zx2c4.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Eric Biggers <ebiggers@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable
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
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sat, Oct 17, 2020 at 6:34 AM Colm MacCarthaigh <colmmacc@amazon.com> wro=
te:
> On 16 Oct 2020, at 21:02, Jann Horn wrote:
> > On Sat, Oct 17, 2020 at 5:36 AM Willy Tarreau <w@1wt.eu> wrote:
> > But in userspace, we just need a simple counter. There's no need for
> > us to worry about anything else, like timestamps or whatever. If we
> > repeatedly fork a paused VM, the forked VMs will see the same counter
> > value, but that's totally fine, because the only thing that matters to
> > userspace is that the counter changes when the VM is forked.
>
> For user-space, even a single bit would do. We added MADVISE_WIPEONFORK
> so that userspace libraries can detect fork()/clone() robustly, for the
> same reasons. It just wipes a page as the indicator, which is
> effectively a single-bit signal, and it works well. On the user-space
> side of this, I=E2=80=99m keen to find a solution like that that we can u=
se
> fairly easily inside of portable libraries and applications. The =E2=80=
=9Chave
> I forked=E2=80=9D checks do end up in hot paths, so it=E2=80=99s nice if =
they can be
> CPU cache friendly. Comparing a whole 128-bit value wouldn=E2=80=99t be m=
y
> favorite.

I'm pretty sure a single bit is not enough if you want to have a
single page, shared across the entire system, that stores the VM
forking state; you need a counter for that.

> > And actually, since the value is a cryptographically random 128-bit
> > value, I think that we should definitely use it to help reseed the
> > kernel's RNG, and keep it secret from userspace. That way, even if the
> > VM image is public, we can ensure that going forward, the kernel RNG
> > will return securely random data.
>
> If the image is public, you need some extra new raw entropy from
> somewhere. The gen-id could be mixed in, that can=E2=80=99t do any harm a=
s
> long as rigorous cryptographic mixing with the prior state is used, but
> if that=E2=80=99s all you do then the final state is still deterministic =
and
> non-secret.

Microsoft's documentation
(http://go.microsoft.com/fwlink/?LinkId=3D260709) says that the VM
Generation ID that we get after a fork "is a 128-bit,
cryptographically random integer value". If multiple people use the
same image, it guarantees that each use of the image gets its own,
fresh ID: The table in section "How to implement virtual machine
generation ID support in a virtualization platform" says that (among
other things) "Virtual machine is imported, copied, or cloned"
generates a new generation ID.

So the RNG state after mixing in the new VM Generation ID would
contain 128 bits of secret entropy not known to anyone else, including
people with access to the VM image.

Now, 128 bits of cryptographically random data aren't _optimal_; I
think something on the order of 256 bits would be nicer from a
theoretical standpoint. But in practice I think we'll be good with the
128 bits we're getting (since the number of users who fork a VM image
is probably not going to be so large that worst-case collision
probabilities matter).

> The kernel would need to use the change as a trigger to
> measure some entropy (e.g. interrupts and RDRAND, or whatever). Our just
> define the machine contract as =E2=80=9Cthis has to be unique random data=
 and
> if it=E2=80=99s not unique, or if it=E2=80=99s pubic, you=E2=80=99re toas=
t=E2=80=9D.

As far as I can tell from Microsoft's spec, that is a guarantee we're
already getting.

