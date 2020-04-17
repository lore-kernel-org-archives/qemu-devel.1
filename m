Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761CDC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BF42137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnr7fv+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BF42137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRO8-0005tN-B2
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPRNL-00054W-Au
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPRNK-00007T-5b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:49:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPRNK-00007C-2g
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587131385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/v5Tuo5D01mrVhyeGnt9r0bZED4rM9BN9Ltazs7guH4=;
 b=Xnr7fv+bhBwS2IZcViBOwCD1zpFRZnm0ALpy729ZLgDY+Efh32e1aNzBIdz8brvyZYvNZr
 eIBeAoXOlwd4ClCi54885Pqk9BmBTbjKNOR7io2IN1YEDpgqRElIk7ftn8uxQB64+h00JO
 RWXj5304YRUkQIwsESofdqi2q7dqjaE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-aMHt2IK7NVChH8wpwfUbyQ-1; Fri, 17 Apr 2020 09:49:41 -0400
X-MC-Unique: aMHt2IK7NVChH8wpwfUbyQ-1
Received: by mail-ej1-f70.google.com with SMTP id dx16so1038652ejb.10
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5V7yavyfZ0HM3zUpT1F2jPJ2A6hFO+XG3RXrFUzY6h4=;
 b=tB7f+qAe5MF6wvCzvsF5Tb8/0TfO5bFHhynp6/LWCwb1FrVX628Kte2UbF+QbZa7fz
 5AuAfTE727H4ow/0WBY9ofNaKDlKnxPbypVRcelE9JsusC+Ek5UcQHgKHQ8obbSWTgNu
 7QmNAuv3e4RPdoSHgWDM9zl4pvLfChlUsCIGTY8m4uI2Ad9isREqbz+GIzrNBBKiqICW
 9gZ2UeThW7+ThFgelPrjaY+Gc1/vIZDO2kgyW2hyiUBMXh4SQuSvB7jV9wy98Yigg2gJ
 BMMgNXrxHJwgTgpZNVr9SfDSVIJ2vylcfmNWW7K+3EpIoU3Gur3YsatfRn4CscBqCvr4
 6GCg==
X-Gm-Message-State: AGi0PuZt9Hm9tjukMw8Hp8AxenImluo1GO2sNQLPU4MAg5KwmV1R4H7M
 Mcoxi22oBbLxppnHh2ot3b3D9J8D/G9NKnwFyPpEE5HKXUJMKRkUlxOtDQF0wuB4JbCoXhVNGDR
 yofv8YoRbV6xn//g=
X-Received: by 2002:a17:907:40f2:: with SMTP id
 no2mr3110760ejb.41.1587131379849; 
 Fri, 17 Apr 2020 06:49:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWJG5ihBce3BBaxEtVPybUKWhCIqZt7Zp8ZUwDutTUNVZeNIkgEyc74VK1iOZ6HN3OeNFGkg==
X-Received: by 2002:a17:907:40f2:: with SMTP id
 no2mr3110739ejb.41.1587131379533; 
 Fri, 17 Apr 2020 06:49:39 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q1sm3420124ejf.42.2020.04.17.06.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 06:49:38 -0700 (PDT)
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
 <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
 <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d9606c9-f812-f629-e03f-d72ddbce05ee@redhat.com>
Date: Fri, 17 Apr 2020 15:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:11 PM, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 19:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> I'm not 100% sure how the system regs function under kvm.
>>
>> If they are not used at all, then we should avoid them all en masse an n=
ot
>> piecemeal like this.
>>
>> If they are used for something, then we should keep them registered and =
change
>> the writefn like so:
>>
>> #ifdef CONFIG_TCG
>>      /* existing stuff */
>> #else
>>      /* Handled by hardware accelerator. */
>>      g_assert_not_reached();
>> #endif

I ended with that patch because dccvap_writefn() calls probe_read()=20
which is an inlined call to probe_access(), which itself is only defined=20
when using TCG. So with KVM either linking fails or I get:

target/arm/helper.c: In function =E2=80=98dccvap_writefn=E2=80=99:
target/arm/helper.c:6898:13: error: implicit declaration of function=20
=E2=80=98probe_read=E2=80=99;
      haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
              ^~~~~~~~~~

I'll use your suggestion which works for me:

-- >8 --
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -330,8 +330,20 @@ static inline void=20
tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
  {
  }
  #endif
+
+#ifdef CONFIG_TCG
  void *probe_access(CPUArchState *env, target_ulong addr, int size,
                     MMUAccessType access_type, int mmu_idx, uintptr_t=20
retaddr);
+#else
+static inline void *probe_access(CPUArchState *env,
+                                 target_ulong addr, int size,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+     /* Handled by hardware accelerator. */
+     g_assert_not_reached();
+}
+#endif /* CONFIG_TCG */

  static inline void *probe_write(CPUArchState *env, target_ulong addr,=20
int size,
                                  int mmu_idx, uintptr_t retaddr)
---

>=20
> (1) for those registers where we need to know the value within
> QEMU code (notably anything involved in VA-to-PA translation,
> as this is used by gdbstub accesses, etc, but sometimes we
> want other register values too): the sysreg struct is
> what lets us map from the KVM register to the field in the
> CPU struct when we do a sync of data to/from the kernel.
>=20
> (2) for other registers, the sync lets us make the register
> visible as an r/o register in the gdbstub. (this is not
> very important, but it's nice)
>=20
> (3) Either way, the sync works via the raw_read/raw_write
> accessors (this is a big part of what they're for), which are
> supposed to just stuff the data into/out of the underlying
> CPU struct field. (But watch out because we fall back to
> using the non-raw read/writefn if there's no raw version
> provided for a particular register.) If a regdef is marked
> as NO_RAW then it means there is no raw access and we don't
> sync the value.
>=20
> (4) I think that in KVM mode we won't deliberately do
> non-raw accesses, and a quick grep through of the places
> that do 'readfn' accesses supports that.
>=20
> thanks
> -- PMM
>=20


