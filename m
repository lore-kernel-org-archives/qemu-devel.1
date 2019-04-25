Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E5C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 00:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DA720643
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 00:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u1MBIY9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DA720643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJSBO-0005N5-Fu
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 20:24:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <srutherford@google.com>) id 1hJS9p-0004T3-QI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 20:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <srutherford@google.com>) id 1hJS6g-0005h4-0n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 20:19:20 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <srutherford@google.com>)
	id 1hJS6e-0005gI-0m
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 20:19:16 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x71so7813320ybe.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dHmsbkXWljA4pZmnQ83ldlqpcpPuq30XxRVutF6/TWc=;
	b=u1MBIY9HVa+XgHw+7NgG2vR1LZ620c0LAbBHYI4nh0Ce2l/0U3/nt0Ke2H+lz0Ewsq
	AsVm+vAlfi+rteeNvsrLE39lughBF9DucAlIgUrVFEdm8AyYx9RdUayesPtZi4Aea5Ia
	nnsP7M1JGSuLzXElEaQ+K6ZgvLlXwJn+kVWFoHNoaJDg3+QOGSkJgESA0sOJqD2KWElC
	ptYUJnjaEwvy82ekGblXDQlGK3WNLVBHFf1hrWeeHtANX4UIE+utGVWLKbPvQrwBJuWi
	y8HWko3+TsStYFj+j+SlNPP5OuvhqjJHATYmrP095zRYR0qQ9d+tL/76ro8uWxRDKKgT
	Ow/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dHmsbkXWljA4pZmnQ83ldlqpcpPuq30XxRVutF6/TWc=;
	b=gMK7Tfm5zATYjI5TkNOFYXW+QAPyDPA8R/Gmp0ljOWJ7tAVjU5G5B0STuGrs72Nt6i
	RetxpLEv5/ThRznf8RwxSNrsJm4EBck1fHTv2d/3iFhVVLrZC1RvHrWCkMOMufeiFZV9
	mQ/2grohY+7j0oivV8sXnlC1TAtwY9m4gTOeYgOMNuY83CZkogJW+jw75s7vHOQVJHxH
	rMQhthj/gPoRtqeXnMh/xejwj7W5iVtPFACKW/aUKZ+mh7hk8/N6a89zPyFO21jQRdCN
	+jormSFng6qS1Ji0TVPVAn5J1K6wHgLK0aaWGMv7+nQa/4FpQBoGr+0TrAB6y+xm8B8g
	p9WA==
X-Gm-Message-State: APjAAAVLGEF4odwSQZXm63WjYlwRUoIFQi7FGpvg/lh7JttLdcBy9fHd
	ktw8Xj/QbtDlnN1OUnNoVzjSdTLyB05CVHcouiXhKg==
X-Google-Smtp-Source: APXvYqw3r6Xb3rjBDkF0mwqQ6rq4aukBl7vptzAKOTQIWLgnJCeEVR90WQH0K2pQcVOazmSs8cFxXoLqUkFKRih7tXw=
X-Received: by 2002:a25:df89:: with SMTP id w131mr5765992ybg.503.1556151554184;
	Wed, 24 Apr 2019 17:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
	<eee5e112-89bd-331b-6875-34c0712de4cb@amd.com>
In-Reply-To: <eee5e112-89bd-331b-6875-34c0712de4cb@amd.com>
Date: Wed, 24 Apr 2019 17:18:38 -0700
Message-ID:
 <CABayD+fy5+QNU8YWsVrfd6jyvPo3AWCBgR-V8iWKzZkWxQY=zA@mail.gmail.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC PATCH v1 00/10] Add AMD SEV guest live
 migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Steve Rutherford via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Steve Rutherford <srutherford@google.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425001838.CGQbZHjiMnMEba6ZKPsJ6EYOec6MX0HGVfJnFKMaP1Q@z>

Do you mean MiB/s, MB/s or Mb/s? Since you are talking about network
speeds, sometimes these get conflated.

I'm guessing you mean MB/s since you are also using 4kb for page size.

On Wed, Apr 24, 2019 at 2:32 PM Singh, Brijesh <brijesh.singh@amd.com>
wrote:

>
>
> On 4/24/19 2:15 PM, Steve Rutherford wrote:
> > On Wed, Apr 24, 2019 at 9:10 AM Singh, Brijesh <brijesh.singh@amd.com>
> wrote:
> >>
> >> The series add support for AMD SEV guest live migration commands. To
> protect the
> >> confidentiality of an SEV protected guest memory while in transit we
> need to
> >> use the SEV commands defined in SEV API spec [1].
> >>
> >> SEV guest VMs have the concept of private and shared memory. Private
> memory
> >> is encrypted with the guest-specific key, while shared memory may be
> encrypted
> >> with hypervisor key. The commands provided by the SEV FW are meant to
> be used
> >> for the private memory only. The patch series introduces a new
> hypercall.
> >> The guest OS can use this hypercall to notify the page encryption
> status.
> >> If the page is encrypted with guest specific-key then we use SEV
> command during
> >> the migration. If page is not encrypted then fallback to default.
> >>
> >> The patch adds a new ioctl KVM_GET_PAGE_ENC_BITMAP. The ioctl can be
> used
> >> by the qemu to get the page encrypted bitmap. Qemu can consult this
> bitmap
> >> during the migration to know whether the page is encrypted.
> >>
> >> [1] https://developer.amd.com/wp-content/resources/55766.PDF
> >>
> >> The series is tested with the Qemu, I am in process of cleaning
> >> up the Qemu code and will submit soon.
> >>
> >> While implementing the migration I stumbled on the follow question:
> >>
> >> - Since there is a guest OS changes required to support the migration,
> >>    so how do we know whether guest OS is updated? Should we extend KVM
> >>    capabilities/feature bits to check this?
> >>
> >> TODO:
> >>   - add an ioctl to build encryption bitmap. The encryption bitmap is
> built during
> >>     the guest bootup/execution. We should provide an ioctl so that
> destination
> >>     can build the bitmap as it receives the pages.
> >>   - reset the bitmap on guest reboot.
> >>
> >> The complete tree with patch is available at:
> >> https://github.com/codomania/kvm/tree/sev-migration-rfc-v1
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> >> Cc: Joerg Roedel <joro@8bytes.org>
> >> Cc: Borislav Petkov <bp@suse.de>
> >> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> >> Cc: x86@kernel.org
> >> Cc: kvm@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >>
> >> Brijesh Singh (10):
> >>    KVM: SVM: Add KVM_SEV SEND_START command
> >>    KVM: SVM: Add KVM_SEND_UPDATE_DATA command
> >>    KVM: SVM: Add KVM_SEV_SEND_FINISH command
> >>    KVM: SVM: Add support for KVM_SEV_RECEIVE_START command
> >>    KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command
> >>    KVM: SVM: Add KVM_SEV_RECEIVE_FINISH command
> >>    KVM: x86: Add AMD SEV specific Hypercall3
> >>    KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS hypercall
> >>    KVM: x86: Introduce KVM_GET_PAGE_ENC_BITMAP ioctl
> >>    mm: x86: Invoke hypercall when page encryption status is changed
> >>
> >>   .../virtual/kvm/amd-memory-encryption.rst     | 116 ++++
> >>   Documentation/virtual/kvm/hypercalls.txt      |  14 +
> >>   arch/x86/include/asm/kvm_host.h               |   3 +
> >>   arch/x86/include/asm/kvm_para.h               |  12 +
> >>   arch/x86/include/asm/mem_encrypt.h            |   3 +
> >>   arch/x86/kvm/svm.c                            | 560 ++++++++++++++++=
+-
> >>   arch/x86/kvm/vmx/vmx.c                        |   1 +
> >>   arch/x86/kvm/x86.c                            |  17 +
> >>   arch/x86/mm/mem_encrypt.c                     |  45 +-
> >>   arch/x86/mm/pageattr.c                        |  15 +
> >>   include/uapi/linux/kvm.h                      |  51 ++
> >>   include/uapi/linux/kvm_para.h                 |   1 +
> >>   12 files changed, 834 insertions(+), 4 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> >
> > What's the back-of-the-envelope marginal cost of transferring a 16kB
> > region from one host to another? I'm interested in what the end to end
> > migration perf changes look like for this. If you have measured
> > migration perf, I'm interested in that also.
> >
>
> I have not done a complete performance analysis yet! From the qemu
> QMP prompt (query-migration) I am getting ~8mbps throughput from
> one host to another (this is with 4kb regions). I have been told
> that increasing the transfer size from 4kb -> 16kb may not give a
> huge performance gain because at FW level they still operating
> on 4kb blocks. There is possibility that future FW updates may
> give a bit better performance on 16kb size.
>
> -Brijesh
>
