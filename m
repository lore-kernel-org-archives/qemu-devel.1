Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D1C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1616220873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLt5lD0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1616220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoFlT-0000E1-VN
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 19:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hoFlH-0008Aa-Vv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hoFlF-0004YN-EK
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:24:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hoFlF-0004X7-5Y; Thu, 18 Jul 2019 19:24:29 -0400
Received: by mail-pf1-x443.google.com with SMTP id t16so13284061pfe.11;
 Thu, 18 Jul 2019 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=LnHu9wBel+Ug9aKfH7DnMihz3LvZmzDAd/pQJE2NSYw=;
 b=MLt5lD0r+/eFXuak7kNL3kkDKrgts4mBWckBbtD1ozj+k4XWmj1MCBDvUx9YG9iBEo
 GFWQkZ6OpmNu0k1jlVkBQiACV2sC2+YEOPpoYzEN0/YrIcHnhzteu2xAHOAbHltT8KG6
 IM1h92Q91tviR4MzUgvORyVJDdiw+Gob+TTSuFiCAXnz9S8MdTLLvkCcH8mqSqRHaO/M
 T6VeKmi7iqXZbkAPc3iqff+GDRTd7ZoZwMhUw9FvQOcBmsmnOE4eemXuIeaFQjPPGxCo
 M47VNaQyMbJEZb7CDWM7ZOkBsyO++HIZGy7PpBX42skTjFge6Tx3tRhBG1sKu4byTP4M
 C/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=LnHu9wBel+Ug9aKfH7DnMihz3LvZmzDAd/pQJE2NSYw=;
 b=kFksRez6ZuiJpte36A7XjkbOPp+lR5O5X8yY0smtsFy1EXdsx8MhUuUkOxGItXPmXg
 OafS8SiwdAOg8Qlju+5ANDHgvFgl9NvIdU/J8CVGSiVsM2oMaZEUH8ff2zZWm9TNUudz
 JNxBGrctqjST9zGji+rC8GacUNZks4PtakwkwDy+7dDVkm+L5ZpRIM88XfpCoKZJhNb5
 H64uS02sHOVT7HXX8CcmUnWWkV8UCCq/zX85FX9JT5SQ2Ok4yZnXNT1gvLNafFKPZW6N
 kIocWY9S7T5cnXqLb+vSmBkaQ9jefvUyApnxIuAlU0UUCrkT2WEmzedfZ35CMOOf5Ngl
 pt6w==
X-Gm-Message-State: APjAAAVUOHSRpMlmzMeMRxjF6yaWY1vHoVqpOmHGulrYbBPBACsKXdLv
 xSrk+zqu9ynUAOm5LAVSAxo=
X-Google-Smtp-Source: APXvYqxj7rxKTyEd6DAM8gho9zfoMIawzDKPjw0WPHdbQV1UE9A8pIQ54+Mnd3xN5X+ArH0FIoHUgg==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id
 q12mr54405042pjq.76.1563492267270; 
 Thu, 18 Jul 2019 16:24:27 -0700 (PDT)
Received: from localhost (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id s20sm31970366pfe.169.2019.07.18.16.24.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 16:24:26 -0700 (PDT)
Date: Fri, 19 Jul 2019 09:24:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20190718103951.10027-1-npiggin@gmail.com>
 <20190718103951.10027-2-npiggin@gmail.com>
 <c5e19e51-3a46-c56d-c555-691ec63dcf6e@redhat.com>
 <c697d1c9-b54a-ba0c-0952-7338b76ef01b@de.ibm.com>
In-Reply-To: <c697d1c9-b54a-ba0c-0952-7338b76ef01b@de.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563491554.u6nwg4s25n.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: don't emit the RESET event on
 wakeup
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christian Borntraeger's on July 18, 2019 9:27 pm:
>=20
>=20
> On 18.07.19 13:06, Paolo Bonzini wrote:
>> On 18/07/19 12:39, Nicholas Piggin wrote:
>>> Commit 1405819637f53 ("qmp: don't emit the RESET event on wakeup from
>>> S3") changed system wakeup to avoid calling qapi_event_send_reset.
>>> Commit 76ed4b18debfe ("s390/ipl: fix ipl with -no-reboot") appears to
>>> have inadvertently broken that logic.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>> I'm not quite sure if this patch is correct and haven't tested it, I
>>> found it by inspection. If this patch is incorrect, I will have to
>>> adjust patch 2.
>>>
>>>  vl.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/vl.c b/vl.c
>>> index 5089fce6c5..ef3c7ab8b8 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -1550,7 +1550,7 @@ void qemu_system_reset(ShutdownCause reason)
>>>      } else {
>>>          qemu_devices_reset();
>>>      }
>>> -    if (reason !=3D SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>>> +    if (reason && reason !=3D SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>>>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason=
);
>>>      }
>>>      cpu_synchronize_all_post_reset();
>>>
>>=20
>> Yes, it seems correct and I've queued it for 4.1.
>=20
> Yes makes sense.=20
> Would it be better to write out if(reason) e.g. replace "reason" with "re=
ason !=3D SHUTDOWN_CAUSE_NONE" ?

I guess it's a matter of preference so I won't weigh in :) My patch
did try to revert back to the previous form but I'm happy to change
it.

> Going even further, I am asking myself if something like
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 60bd081d3ef3..406743566869 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -577,7 +577,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_r=
eset reset_type)
>      if (reset_type =3D=3D S390_RESET_MODIFIED_CLEAR ||
>          reset_type =3D=3D S390_RESET_LOAD_NORMAL) {
>          /* ignore -no-reboot, send no event  */
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_NONE);
>      } else {
>          qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>      }
>=20
> would also work.

If that works for you, then you could take out the test in the reset
code. You would have to modify qemu_system_reset_request too of course.

But it seems a bit unsatisfactory to change the reason for the request
so as to influence behaviour. Either the requests should ask for=20
particular behaviour, or the logic for determining how to handle
the type of request should remain in the reset logic, I would say.

Thanks,
Nick
=

