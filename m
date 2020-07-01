Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B419C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6725D206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtUFmpk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6725D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgFo-0003IV-N1
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqgFB-0002s3-Mf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:09:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqgF9-0008Hx-9T
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:09:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so24039197wmh.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZcsS3ZbExayhJN2YCVmmtE7bQcPjE7CPGpQkO/j5ARs=;
 b=dtUFmpk0eKODYMr3JGRG8GDtr7qp72YhhqvObNrCeWX3mYMRJPqopOOwULhlOSXIbm
 g350zsCJGwBIO7tJplcpiStgkI1B6pwTmmKfAIlOIye5HgX9VLd8d2EvECD5YyMhKddD
 udf7Ubii/Ybz8XLTEv64CD1ClNZ/GTqSgShCEZPnwMMktNB6z8IHbygY/BzMDzzX+RBQ
 6rpyjtzyQY2uenumpuEhDGB05nsfNdIsyw1jiRlaVWJNB4peKkV/g0K4qRvhklC3jmJO
 QVWZXxbtcZ5rheyY2E7Xakvft/TvmGInn9vuXPj/VWebM+t+yuKGasjT5rd7zcIoVzM2
 RFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZcsS3ZbExayhJN2YCVmmtE7bQcPjE7CPGpQkO/j5ARs=;
 b=O46G8jWSy9gI/QKQccFHmmHjAYHotXZ/FtLeTwVW4km2ic9Pb7iKnBBZpppcX0JbUF
 Le83itG4pDwg6g5u1HcmS08Q3H8sIehPZc0MdI4GwSBkH6/0J0SbV3laIEcaFiRqo+pO
 C5tGiOWytK82FS9UW/+WUWzXlC35SXis6gS8+tLFoG03lMklPDA7A4HC5MRfzeeYTVD1
 RylVHHnCsZdBhRrfCMFOaZpfy5sr+I0vaSWF0iquEy5FAQFprzBRXMdQqs00L8mdQqij
 uwzvamTYuAHkg+2bNQnLQIDvG8GLbcy1qxjAGKoZBHDaA50Q8aqk3BwdLwxN6UACfedj
 YrpQ==
X-Gm-Message-State: AOAM5328nrCiwearD86EDE287+iDTNdsd1ofsqfk28QhToVovc5CxV+m
 /UCm7RM+GyLr1gTaPEVkLzRPqw==
X-Google-Smtp-Source: ABdhPJz+/fT3uzi+NtKmdNpmV1NhoRiOAxkhAHwakzDj3o9kZB8cJLxydfjWfByTTybkKAXS7UrqmQ==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr28144202wmi.85.1593623392566; 
 Wed, 01 Jul 2020 10:09:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b10sm7382244wmj.30.2020.07.01.10.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 10:09:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 281D91FF7E;
 Wed,  1 Jul 2020 18:09:48 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-2-alex.bennee@linaro.org>
 <85314d31-813a-8c20-7522-5186d5f31884@redhat.com>
 <87pn9fqjcd.fsf@linaro.org>
 <838d4d01-cd9e-d74a-5cd2-b23644172c9f@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 01/40] hw/isa: check for current_cpu before
 generating IRQ
In-reply-to: <838d4d01-cd9e-d74a-5cd2-b23644172c9f@redhat.com>
Date: Wed, 01 Jul 2020 18:09:48 +0100
Message-ID: <87k0znqi03.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, "Michael S.
 Tsirkin" <mst@redhat.com>, Bug 1878645 <1878645@bugs.launchpad.net>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/1/20 6:40 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> On 7/1/20 3:56 PM, Alex Benn=C3=A9e wrote:
>>>> It's possible to trigger this function from qtest/monitor at which
>>>> point current_cpu won't point at the right place. Check it and
>>>> fall back to first_cpu if it's NULL.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Cc: Bug 1878645 <1878645@bugs.launchpad.net>
>>>> ---
>>>>  hw/isa/lpc_ich9.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>>> index cd6e169d47a..791c878eb0b 100644
>>>> --- a/hw/isa/lpc_ich9.c
>>>> +++ b/hw/isa/lpc_ich9.c
>>>> @@ -439,7 +439,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, vo=
id *arg)
>>>>                  cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>>>>              }
>>>>          } else {
>>>> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>>> +            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_=
INTERRUPT_SMI);
>>>
>>> I'm not sure this change anything, as first_cpu is NULL when using
>>> qtest accelerator or none-machine, see 508b4ecc39 ("gdbstub.c: fix
>>> GDB connection segfault caused by empty machines").
>>=20
>> Good point - anyway feel free to ignore - it shouldn't have been in this
>> series. It was just some random experimentation I was doing when looking
>> at that bug.
>
> See commit c781a2cc42 ("hw/i386/vmport: Allow QTest use without
> crashing") for a similar approach, but here I was thinking about
> a more generic fix, not very intrusive:
>
> -- >8 --
> diff --git a/hw/isa/apm.c b/hw/isa/apm.c
> index bce266b957..809afeb3e4 100644
> --- a/hw/isa/apm.c
> +++ b/hw/isa/apm.c
> @@ -40,7 +40,7 @@ static void apm_ioport_writeb(void *opaque, hwaddr
> addr, uint64_t val,
>      if (addr =3D=3D 0) {
>          apm->apmc =3D val;
>
> -        if (apm->callback) {
> +        if (apm->callback && !qtest_enabled()) {
>              (apm->callback)(val, apm->arg);
>          }

But the other failure mode reported on the bug thread was via the
monitor - so I'm not sure just checking for qtest catches that.

>      } else {
> ---


--=20
Alex Benn=C3=A9e

