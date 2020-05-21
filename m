Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33392072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHFTgG5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33392072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbp58-0000VJ-0i
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jboiW-0000Yc-Dk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:10:49 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jboiV-0003qg-1Y
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:10:48 -0400
Received: by mail-ej1-x644.google.com with SMTP id z5so9769494ejb.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hPjrgtHy8uURm67TfkXhftEFTADVwmDiYHBDxesIbEM=;
 b=IHFTgG5j4/sD60nBBqnI2g3ow5tmiOOc4JFjrb2Z72EZdKfIhoq6jdg1d/fsVi2JLC
 w2Ks9rOVOfvSmvu2KbHdF01BsFjxQD1Ur94UGz2pFPOCXD2xhdGLe1EKgoVBOD8nFiCD
 gnVb4HBrxWo2I1jYKWizXXqHdZ3HmSPVX/lX2/TVAuY26HwbaWn8oXxFmXh71FvNqP66
 yh/SVVG9hiX+lia9NF8BDef100V1d8vnC2voWRo0KY4BUlEkKM8id11XQX4l2O+aL3f1
 VV37soTse00hlnQ0XsQTXB7m1y9IygWwfsS5oEfBqjTApZ/K1WZDUCVATIGnqXups2lU
 khyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hPjrgtHy8uURm67TfkXhftEFTADVwmDiYHBDxesIbEM=;
 b=ZZfcL0F4wz1y+Bhmo/EEhrpJIiogkvxecHfZmHgwyptX84/wd+d0JgG8pFfYOxz6XD
 l3fzG+B6eM8fPrVlwDegeJ07JvNA1s+R1LWxuqrTW1BE5fuuE00w/hqpDTGYzCPn49t5
 KGMYy/eqm9J7Clzz7uGfwvcDRwAMvF10RZeOwFiWeIcV6pUXubEpIClG6Y0IDPmGfYOn
 uwkNDUhJMKRxplAZft9zohBr6Qgk7N9kVst3lj34bu90yCJ+1MZo7va7NQ3ev3O6xBFn
 VByLOgqknoqQ3uWOrR2kb1skljX2ioW++4Jm4HiQofSY+NZhqb+UCnvgh5zvyAOuJW4l
 Yosw==
X-Gm-Message-State: AOAM532wPKXHqNDDjQFutzXjhT1WXJU7O2k55RN4J6Rp1EgT4loDyHf+
 LqAytIkjo8E8luXZA7ZSGodVBg==
X-Google-Smtp-Source: ABdhPJzq9AI2lj7F5HFYHJ7CWibj5iIA9rfIhRtSz7ksunM15og28JqL9tXYRExIPcZhxAoNGXTauw==
X-Received: by 2002:a17:907:364:: with SMTP id
 rs4mr4285130ejb.311.1590081044354; 
 Thu, 21 May 2020 10:10:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id ch8sm5369336ejb.53.2020.05.21.10.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 10:10:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F3B81FF7E;
 Thu, 21 May 2020 18:10:40 +0100 (BST)
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-6-alex.bennee@linaro.org>
 <87y2pucwhi.fsf@linaro.org> <20200521175303.74faabe2@redhat.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH  v1 5/8] cpus-common: ensure auto-assigned cpu_indexes
 don't clash
In-reply-to: <20200521175303.74faabe2@redhat.com>
Date: Thu, 21 May 2020 18:10:40 +0100
Message-ID: <874ks9fc33.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 14 May 2020 17:27:53 +0100
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> a
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>> > Basing the cpu_index on the number of currently allocated vCPUs fails
>> > when vCPUs aren't removed in a LIFO manner. This is especially true
>> > when we are allocating a cpu_index for each guest thread in
>> > linux-user where there is no ordering constraint on their allocation
>> > and de-allocation.
>> >
>> > [I've dropped the assert which is there to guard against out-of-order
>> > removal as this should probably be caught higher up the stack. Maybe
>> > we could just ifdef CONFIG_SOFTTMU it?]
>
> for machines where we care about cross version migration (arm/virt,s390,x=
86,spapr),
> we do manual cpu_index assignment on keep control on its stability
> So orderining probably shouldn't matter for other softmmu boards,
> but what I'd watch for is arrays within devices where cpu_index is
> used as index

With the updated version for softmmu you should get the same indexes as
before from startup. It only gets complicated if CPU hotplug is a thing
which I think is only the case for machines that also support migration?

> (ex: would be apic emulation (but its not affected by this patch since x8=
6 control
> cpu_index assignment))

I've just noticed that the gdbstub uses the maximum cpu_index at startup
to size it's array in CONFIG_USER which is obviously wrong but it was
wrong before so I guess that's another bug to look into on my part :-/

>
>
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > Cc: Nikolay Igotti <igotti@gmail.com>
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Igor Mammedov <imammedo@redhat.com>
>> > Cc: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  cpus-common.c | 9 ++++-----
>> >  1 file changed, 4 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/cpus-common.c b/cpus-common.c
>> > index 55d5df89237..5a7d2f6132b 100644
>> > --- a/cpus-common.c
>> > +++ b/cpus-common.c
>> > @@ -61,13 +61,14 @@ static bool cpu_index_auto_assigned;
>> >  static int cpu_get_free_index(void)
>> >  {
>> >      CPUState *some_cpu;
>> > -    int cpu_index =3D 0;
>> > +    int max_cpu_index =3D 0;
>> >=20=20
>> >      cpu_index_auto_assigned =3D true;
>> >      CPU_FOREACH(some_cpu) {
>> > -        cpu_index++;
>> > +        max_cpu_index =3D MAX(some_cpu->cpu_index, max_cpu_index);
>> >      }
>> > -    return cpu_index;
>> > +    max_cpu_index++;
>> > +    return max_cpu_index;
>> >  }=20=20
>>=20
>> OK some ending up with cpu_index =3D 1 threw off devices that would do
>> qemu_get_cpu(0) so I've tweaked the algorithm to:
>>=20
>>   static int cpu_get_free_index(void)
>>   {
>>       CPUState *some_cpu;
>>       int max_cpu_index =3D 0;
>>=20
>>       cpu_index_auto_assigned =3D true;
>>       CPU_FOREACH(some_cpu) {
>>           if (some_cpu->cpu_index >=3D max_cpu_index) {
>>               max_cpu_index =3D some_cpu->cpu_index + 1;
>>           }
>>       }
>>       return max_cpu_index;
>>   }
>>=20
>> >=20=20
>> >  void cpu_list_add(CPUState *cpu)
>> > @@ -90,8 +91,6 @@ void cpu_list_remove(CPUState *cpu)
>> >          return;
>> >      }
>> >=20=20
>> > -    assert(!(cpu_index_auto_assigned && cpu !=3D QTAILQ_LAST(&cpus)));
>> > -
>> >      QTAILQ_REMOVE_RCU(&cpus, cpu, node);
>> >      cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
>> >  }=20=20
>>=20
>>=20


--=20
Alex Benn=C3=A9e

