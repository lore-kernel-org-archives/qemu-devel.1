Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E272073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kz6VhfwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E272073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwY8-0000Ib-Q9
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqwXS-0007z9-QM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:33:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqwXR-0005Ks-4N
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:33:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so27553146wrv.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0uCRVeduNuwf650i2h0i7N2KoNZWZ+UGutSNwQ5wIR8=;
 b=kz6VhfwTrGLSTGh8zOLO3eGBnterYufXzOKMmYsGAVa/6cvUpccVZaf2cqYtRL2hT3
 T2DuOwnnFttqIbBR72Cvl+OaHcjjKhn+z4VrF8zii+RfKQMlqkiTHRmC9QrCMh8kVFOf
 8LlMLy+eGwwBB+U+7d0cX7NzQRoUK2TGWomNk9yR7HThKmS4JzdzD6tsldEEanxP6mm4
 HKfdUeRd5od23kHmtFNcBdx7wnxgXutL93efvtl2eafhlB1809cKXYZE8QnnCSZUtzSQ
 8DwKYxPBZJuSsquhO8zHd4qtQbHkiq35+MFBpzV7wfdpM2C9qBZgL9ixE58Cb4mYUbOF
 e/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0uCRVeduNuwf650i2h0i7N2KoNZWZ+UGutSNwQ5wIR8=;
 b=hos31PSevA0dAttZLSehSR9Te+nDCkKdxcnIFtX+jPAnbpjEp7nVv/9nJG3Qglw9s8
 0muuytAI4uCfiD7wa7VkRXFvJy3JGGf9gmvNYcQH040qWMmymJ9jbgJ8hBz6PxNxcnwb
 fRgIpV68PsQH/phJFDvxhyhudMfE3QL2qmCO+Ml4ICd1kCzI0pD7b+52z4GPlQo6sh7l
 9MzqPkJO0L5PciAgByTwZkQEt+4Bc0Xqky3pvN0k5U5CI9o2Bxmbf0RLOjwh4mXVlm4u
 EwszgBl3M+gp2UTntolFc0PiBsOac3i31ln3p/j7ouLORnv3ScKYkTXyeAgwMteXAh4g
 3A2g==
X-Gm-Message-State: AOAM531rQQ1M7oGg/EJWzyECY8EULXtH1G4s53Fd2yXu3nzExv7kW8Vw
 f7FiEft122zJzD/6vrX6DNRZ1qj2eDY=
X-Google-Smtp-Source: ABdhPJwpaTsRaeOE4+tvCEAYEYkd0Lwm7Qeqt2Dfpiw78Kal5GmuHZzC6b5jQ/J+iLbEPwapKaCW7A==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr32473825wrh.95.1593686029769; 
 Thu, 02 Jul 2020 03:33:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm9609138wmj.30.2020.07.02.03.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:33:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1579C1FF7E;
 Thu,  2 Jul 2020 11:33:48 +0100 (BST)
References: <20200701175432.18892-1-philmd@redhat.com>
 <b476ded8-fbd6-f9d5-66b7-67e7128e86fd@redhat.com>
 <34ef8d81-4559-9887-3420-c0045bb83d46@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] cpus: Move CPU code from exec.c to cpus.c
In-reply-to: <34ef8d81-4559-9887-3420-c0045bb83d46@redhat.com>
Date: Thu, 02 Jul 2020 11:33:48 +0100
Message-ID: <87wo3mp5o3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/07/20 11:38, Paolo Bonzini wrote:
>> On 01/07/20 19:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>> This code was introduced with SMP support in commit 6a00d60127,
>>> later commit 296af7c952 moved CPU parts to cpus.c but forgot this
>>> code. Move now and simplify ifdef'ry.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  cpus.c | 18 ++++++++++++++++++
>>>  exec.c | 22 ----------------------
>>>  2 files changed, 18 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 41d1c5099f..472686cbbc 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -92,6 +92,11 @@ static unsigned int throttle_percentage;
>>>  #define CPU_THROTTLE_PCT_MAX 99
>>>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>>>=20=20
>>> +CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
>>> +
>>> +/* current CPU in the current thread. It is only valid inside cpu_exec=
() */
>>> +__thread CPUState *current_cpu;
>>> +
>>>  bool cpu_is_stopped(CPUState *cpu)
>>>  {
>>>      return cpu->stopped || !runstate_is_running();
>>> @@ -134,6 +139,19 @@ static bool all_cpu_threads_idle(void)
>>>      return true;
>>>  }
>>>=20=20
>>> +CPUState *qemu_get_cpu(int index)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        if (cpu->cpu_index =3D=3D index) {
>>> +            return cpu;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>  /***********************************************************/
>>>  /* guest cycle counter */
>>>=20=20
>>> diff --git a/exec.c b/exec.c
>>> index 21926dc9c7..997b7db15f 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -98,12 +98,6 @@ AddressSpace address_space_memory;
>>>  static MemoryRegion io_mem_unassigned;
>>>  #endif
>>>=20=20
>>> -CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
>>> -
>>> -/* current CPU in the current thread. It is only valid inside
>>> -   cpu_exec() */
>>> -__thread CPUState *current_cpu;
>>> -
>>>  uintptr_t qemu_host_page_size;
>>>  intptr_t qemu_host_page_mask;
>>>=20=20
>>> @@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common =3D {
>>>      }
>>>  };
>>>=20=20
>>> -#endif
>>> -
>>> -CPUState *qemu_get_cpu(int index)
>>> -{
>>> -    CPUState *cpu;
>>> -
>>> -    CPU_FOREACH(cpu) {
>>> -        if (cpu->cpu_index =3D=3D index) {
>>> -            return cpu;
>>> -        }
>>> -    }
>>> -
>>> -    return NULL;
>>> -}
>>> -
>>> -#if !defined(CONFIG_USER_ONLY)
>>>  void cpu_address_space_init(CPUState *cpu, int asidx,
>>>                              const char *prefix, MemoryRegion *mr)
>>>  {
>>>
>>=20
>> Queued, thanks.
>>=20
>> Paolo
>>=20
>>=20
>
> Wait... this is in exec.c because cpus.c is not linked into user-mode
> emulators.

cpus-common then?

--=20
Alex Benn=C3=A9e

