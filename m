Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEDC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE70E266BA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70E266BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdlv-0006Lk-Ua
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:24:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hWdkc-0005Ta-Mh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hWdkb-0005bE-HB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:23:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hWdkb-0005a3-Ai
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:23:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so5982521wru.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
	:message-id:mime-version;
	bh=YPgJ7SvnBgZ2L6ZOs2ea8PQjIIaX51OxPiUdgc9Y+F8=;
	b=EWrgjkayQVpTXC7S7VlQHpsrFaC9uCzzZFEKlL1+9wD/lIBavhe53U25PFg8feNMlR
	WGmQAbmlzvajfKqZFuG4fHoxrM9wkq4av3gb/nP+gmVGXQG6fOoJoqJ6RE1A6XZO2cAO
	7SKaeFz06zbcHotcjbzBUPlypF4nw2vEzCwee06vrMenCm0gmfU8luyBC0mUnKHnTjFv
	g876yaddnI7Zi6NXQnXd8OypOiA7OTqMecdX66XOGhHuV4JiyZKsz+FCT7ETJcici9Tq
	qne9Ua1ax9C2e0HujMjORVS3mDxeIlKvI7NiiIT57wmOEXB0USkQiFt7ECVSdT/Yc2bu
	SpjA==
X-Gm-Message-State: APjAAAVoHHAF3Md7cEWVIs/Txl+a2j9w5IWZ39GIuNQx3367Z48m6m0M
	mjgb8xhJiwZP6FSaO3NLhE/odQ==
X-Google-Smtp-Source: APXvYqzTc3NleWfF2pbXBKChqqY3QfFFRZhjpmylJS9JJPy+8b++2r95SSLevPj9jGaF95vJ7N7N9Q==
X-Received: by 2002:adf:f743:: with SMTP id z3mr5692121wrp.129.1559294579401; 
	Fri, 31 May 2019 02:22:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
	[213.175.37.10])
	by smtp.gmail.com with ESMTPSA id 6sm9654615wrd.51.2019.05.31.02.22.58
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 02:22:58 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
In-Reply-To: <20190530175511.GA13965@rkaganb.sw.ru>
References: <20190517141924.19024-1-vkuznets@redhat.com>
	<20190517141924.19024-3-vkuznets@redhat.com>
	<20190527155231.GB2362@rkaganb.sw.ru>
	<87h89fn95y.fsf@vitty.brq.redhat.com>
	<20190530175511.GA13965@rkaganb.sw.ru>
Date: Fri, 31 May 2019 11:22:57 +0200
Message-ID: <87a7f3kmfi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/9] i386/kvm: add support for
 KVM_GET_SUPPORTED_HV_CPUID
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
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, May 27, 2019 at 06:39:53PM +0200, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> > On Fri, May 17, 2019 at 04:19:17PM +0200, Vitaly Kuznetsov wrote:
>> >> +static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
>> >> +{
>> >> +    struct kvm_cpuid2 *cpuid;
>> >> +    int r, size;
>> >> +
>> >> +    size = sizeof(*cpuid) + max * sizeof(*cpuid->entries);
>> >> +    cpuid = g_malloc0(size);
>> >> +    cpuid->nent = max;
>> >> +
>> >> +    r = kvm_vcpu_ioctl(cs, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
>> >> +    if (r == 0 && cpuid->nent >= max) {
>> >> +        r = -E2BIG;
>> >> +    }
>> >> +    if (r < 0) {
>> >> +        if (r == -E2BIG) {
>> >> +            g_free(cpuid);
>> >> +            return NULL;
>> >> +        } else {
>> >> +            fprintf(stderr, "KVM_GET_SUPPORTED_HV_CPUID failed: %s\n",
>> >> +                    strerror(-r));
>> >> +            exit(1);
>> >> +        }
>> >> +    }
>> >> +    return cpuid;
>> >> +}
>> >> +
>> >> +/*
>> >> + * Run KVM_GET_SUPPORTED_HV_CPUID ioctl(), allocating a buffer large enough
>> >> + * for all entries.
>> >> + */
>> >> +static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
>> >> +{
>> >> +    struct kvm_cpuid2 *cpuid;
>> >> +    int max = 7; /* 0x40000000..0x40000005, 0x4000000A */
>> >> +
>> >> +    /*
>> >> +     * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails with
>> >> +     * -E2BIG, however, it doesn't report back the right size. Keep increasing
>> >> +     * it and re-trying until we succeed.
>> >> +     */
>> >
>> > I'm still missing the idea of reiterating more than once: the ioctl
>> > returns the actual size of the array.
>> 
>> Hm, I think I checked that and it doesn't seem to be the case.
>> 
>> The code in kvm_vcpu_ioctl_get_hv_cpuid():
>> 
>> 	if (cpuid->nent < nent)
>> 		return -E2BIG;
>> 
>> 	if (cpuid->nent > nent)
>> 		cpuid->nent = nent;
>> 
>> (I think I even ran a test after your comment on v1 and it it
>> confirmed nent is not set on E2BIG). Am I missing something obvious?
>
> Indeed, I saw kvm_vcpu_ioctl_get_cpuid2() always setting ->nent on
> return and assumed so did kvm_vcpu_ioctl_get_hv_cpuid().  I stand
> corrected, please disregard this comment.

No problem at all!

> (What was the reason for not following this pattern in
> kvm_vcpu_ioctl_get_hv_cpuid BTW?)

The opportunity to set nent in E2BIG case was probabbly overlooked. I
was looking at QEMU's get_supported_cpuid() implementation which
iterates trying to find the right number and used this as a pattern.

While setting nent in E2BIG case seems to be very convenient, this is an
unobvious side-effect: usually, where the return value indicates an
error we don't inspect the payload. I'm, however, not at all against
changing kvm_vcpu_ioctl_get_hv_cpuid(). Unfortunately, this won't help
QEMU and we'll still have to iterate to support legacy kernels.

-- 
Vitaly

