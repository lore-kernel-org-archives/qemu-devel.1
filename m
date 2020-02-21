Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3843C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749B8206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaSRGewt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749B8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Bjn-0004rJ-Ld
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5Bie-00046U-R9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5Bic-00036o-Ut
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:04:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5Bic-00036Q-P0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582304641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX904CXCbNfrJ62hza0z8cHuALO+kzUybxRNMs+DziA=;
 b=FaSRGewtC6DwRox9fa1IMb5613VH1s4KDqDjEPcFPMA6cU0uog2eb7WresZ7hOJPvFlRap
 LUmYDLLDLwHTX4jlt83adeYmeTUOQzzvagUamLJXJXFWp6eFPOqOgMXTxiRclpHykcn30s
 oTzb6TNzJVPDjxXc2J1yqeM/xXTyaAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-g1brqEVQM8qKnW7mlZfJ9A-1; Fri, 21 Feb 2020 12:03:59 -0500
X-MC-Unique: g1brqEVQM8qKnW7mlZfJ9A-1
Received: by mail-wm1-f69.google.com with SMTP id p26so868834wmg.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8G8BZBouM/mQbwFQpvSrCjCl8B0n5IMFrewnfRa7ZHQ=;
 b=PLrFsEk6PoUzHVdg1JxYXe62FtmDYwm8ow0tDn8cWAY/5YeqyWZg31HN2hm+21n8Y5
 5IyCkd8DTNd8Ykn9lpkGuM+vJ+lkm3/zdwD2HItNdnO/7XgbXaywdtE7OtA4pmAD/trA
 h2ijvQrT5dJI+/7QaLMHhR+hiSmL7JgWqHNXB2q006W6WKlNvdcGRrlO7ztBzfNru3km
 Wod3O1HC3V8Dwtev0sKtriTJZwouxOa8W77aKm3MzVwjLkXW6RuttKGNw8unXJUQjL3b
 RJmFFV+qS80oa2xQeihQ6JtfqMDqBbEV3DGlE4jXO3tQRW5Pjpz/6w6ceoabYisGb23f
 ly/w==
X-Gm-Message-State: APjAAAWYrr8uhVfqe0nNO/tIuDH2gPlAZSGN/YmsZqtQB6cLiBVdw5aF
 uU9VIAd38nHTWFuxWn+4N6YEFf/8ZjWOU8RTSvzB5BUjJZFMYX3rPZylBeDVJEY+b4DP3sxS6kh
 IzjAGyUflFi20j6w=
X-Received: by 2002:adf:f304:: with SMTP id i4mr21262859wro.379.1582304638149; 
 Fri, 21 Feb 2020 09:03:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqycqGQ/vXL+GcFTL84DXzdJhPFJsCbwR2zdeMb+niCcvVPE6dnEi0QtYrhmWkPHfR0VCvR2rA==
X-Received: by 2002:adf:f304:: with SMTP id i4mr21262835wro.379.1582304637816; 
 Fri, 21 Feb 2020 09:03:57 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id k8sm4768060wrq.67.2020.02.21.09.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 09:03:57 -0800 (PST)
Subject: Re: [PATCH] accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION) return
 value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200221163336.2362-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6d29e18-722c-77d1-ca56-220b3b02ae00@redhat.com>
Date: Fri, 21 Feb 2020 18:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221163336.2362-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 17:33, Philippe Mathieu-Daud=C3=A9 wrote:
> kvm_vm_ioctl() can fail, check its return value, and log an error
> when it failed. This fixes Coverity CID 1412229:
>=20
>   Unchecked return value (CHECKED_RETURN)
>=20
>   check_return: Calling kvm_vm_ioctl without checking return value
>=20
> Reported-by: Coverity (CID 1412229)
> Fixes: 235e8982ad3 ("support using KVM_MEM_READONLY flag for regions")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c111312dfd..6df3a4d030 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -308,13 +308,23 @@ static int kvm_set_user_memory_region(KVMMemoryList=
ener *kml, KVMSlot *slot, boo
>          /* Set the slot size to 0 before setting the slot to the desired
>           * value. This is needed based on KVM commit 75d61fbc. */
>          mem.memory_size =3D 0;
> -        kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +        ret =3D kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +        if (ret < 0) {
> +            goto err;
> +        }
>      }
>      mem.memory_size =3D slot->memory_size;
>      ret =3D kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>      slot->old_flags =3D mem.flags;
> +err:
>      trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
>                                mem.memory_size, mem.userspace_addr, ret);
> +    if (ret < 0) {
> +        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=3D%d,"
> +                     " start=3D0x%" PRIx64 ", size=3D0x%" PRIx64 ": %s",
> +                     __func__, mem.slot, slot->start_addr,
> +                     (uint64_t)mem.memory_size, strerror(errno));
> +    }
>      return ret;
>  }
> =20
>=20

Queued, thanks.

Paolo


