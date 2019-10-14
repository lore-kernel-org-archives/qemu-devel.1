Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6864120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGXzwkNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6864120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3wt-0002Yp-0o
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3Iy-0008L9-Ih
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK3Ix-000393-3g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:34:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK3Iw-00038F-S9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:34:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so17401121wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ik95fVYdD47/7Dk3d56p0k6mLzXbz8+4Xb9HZ2UclXk=;
 b=UGXzwkNVoGHAMGNwbZ8EQvMsLZZd9WzX/hf6ViMRKuSrWe2hTNPQIl2OtqZyynhzoE
 EPgR1EMe41Y7tc2QPrJOasXzhHfXZRuOfdxfmEcAzzzKG8IudyUVqX8v3Qd1KTUc0hyS
 I+k25VZ/UP9lrzNQNbOTPfZEoJFtWSNDXdBB8TCGVHhDlo7yqST1tGDpRRfbbhMZFmlP
 k/asDHJ033TDuH6RtYBbK+rRAalG7G4g0eYPKfGYj6urpldtlVHGid5CWMka9zxyCwdA
 rs0mcckJLywug31i9TPOYOJq9lLGTh2v0PCbul8H+s+hbjR0CzqTVeD5aVa9J0fr+nvP
 qbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ik95fVYdD47/7Dk3d56p0k6mLzXbz8+4Xb9HZ2UclXk=;
 b=NyNWwdDwJhc58jfO54vZol+XtVmWciPHtVDErVtkYq/LrK5bs7n1VIAQePGQNyZq3g
 nLmLDXW+2R+eQJQqlu+UfmkPF4IB5aoH+vk1QgFLbHoQOqRMy46HPQR/Q0KZiAhixmYC
 ZkkI28CTaPP1LXDwd3ljDOfdzcD3UqLvuyccrdwZ3FPZFty9Z4TBuSblIcXivplZTLtk
 ryXAruDTrFy326KHioYHVg4moLusIi1Fr2eoV25oTT3sSvdx7dfnSvIUSWAFwZhXxjtF
 FrdKL6oGQwqUYmuMd6UkOeJ9LCljVSHrIzTzf5OKwOy14blmHwef1EjcgqAkD8GyeUOq
 qLag==
X-Gm-Message-State: APjAAAWpieEPNdPSdkEMVDhVMx8kYPFzP8gF3De4JGr+k693PL/b6mOf
 e6z2FFQ54bmx73SSarKro1n3og==
X-Google-Smtp-Source: APXvYqxqX2aV4t4rAhuoPWTX19R69hoe7bEhpBlGjQZ6igl5ttMtm149BxDzhk7LHZFKj4YH/hW+ng==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr16842055wme.80.1571070880839; 
 Mon, 14 Oct 2019 09:34:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l11sm20875433wmh.34.2019.10.14.09.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:34:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77A001FF87;
 Mon, 14 Oct 2019 17:34:39 +0100 (BST)
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-18-alex.bennee@linaro.org>
 <CAFEAcA8u3Srp_Lsucxh0-EaXW5UbETLOPA_KdpzONCaTob0GVA@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 17/55] plugins: implement helpers for resolving hwaddr
In-reply-to: <CAFEAcA8u3Srp_Lsucxh0-EaXW5UbETLOPA_KdpzONCaTob0GVA@mail.gmail.com>
Date: Mon, 14 Oct 2019 17:34:39 +0100
Message-ID: <87lftnmgkg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: robert.foley@futurewei.com, QEMU Developers <qemu-devel@nongnu.org>,
 peter.puhov@futurewei.com, Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Oct 2019 at 12:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> We need to keep a local per-cpu copy of the data as other threads may
>> be running. We use a automatically growing array and re-use the space
>> for subsequent queries.
>>
>
>
>> +#ifdef CONFIG_SOFTMMU
>> +static __thread struct qemu_plugin_hwaddr hwaddr_info;
>> +
>> +struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t=
 info,
>> +                                                  uint64_t vaddr)
>> +{
>> +    CPUState *cpu =3D current_cpu;
>> +    unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
>> +
>> +    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
>> +                           info & TRACE_MEM_ST, &hwaddr_info)) {
>> +        error_report("invalid use of qemu_plugin_get_hwaddr");
>> +        return NULL;
>> +    }
>> +
>> +    return &hwaddr_info;
>> +}
>
> Apologies for dropping into the middle of this patchset, but
> this API looks a bit odd. A hwaddr alone isn't a complete
> definition of an access -- you need an (AddressSpace, hwaddr)
> tuple for that. So this API looks like it doesn't really cope
> with things like TrustZone ?

Aren't hwaddr's unique across the bus? Or is this because you would have
two address buses (secure and non-secure) with different address lines to
different chips?

But surely we have all the information we need because we've hooked the
two things that QEMU's softmmu code knows. The mmu_idx and the vaddr
with which the slow path can figure out what it needs.

>>  uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *h=
addr)
>>  {
>> +#ifdef CONFIG_SOFTMMU
>> +    ram_addr_t ram_addr =3D 0;
>> +
>> +    if (haddr && !haddr->is_io) {
>> +        ram_addr =3D qemu_ram_addr_from_host((void *) haddr->hostaddr);
>> +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
>> +            error_report("Bad ram pointer %"PRIx64"", haddr->hostaddr);
>> +            abort();
>> +        }
>> +    }
>> +    return ram_addr;
>> +#else
>>      return 0;
>> +#endif
>>  }
>
> This looks odd to see in the plugin API -- ramaddrs should
> be a QEMU internal concept, shouldn't they?

Hmm maybe.. I guess it's a special case of device offset. Do you want to
drop this part for now?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

