Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A61C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E045D206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ubaMx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwKc-0002Pg-VT
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itwJ9-0001Hf-Q0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itwJ7-0000at-G5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:23:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itwJ7-0000aM-CX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579623791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eABF4h/JWivXwj989Q0zud9s05ydmL3aoi8AS2wP2/A=;
 b=Y6ubaMx4g+OMtlG4GQwpqvCXgzrHgYmqrk3xghVzD2mT1atqmGL28y9WCIjMEL/xaUNT6a
 3D5UR7lydLk2lZaOBtEODxo6Bp7Psix31VQVYlqnU6IhAtZgJCy4YXLYjoNowvXxZZyPAm
 SjyB6wsAcsqURY5YkQ/I47oD2TSF8sY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-H-Wsw0PcPY-Dw9b2uaXz7Q-1; Tue, 21 Jan 2020 11:23:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so1568974wrs.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VI3ssdiF2GcYdQakqozaGowQIGSfBILeuJMFPXZTCHk=;
 b=l59scnQ953mr3Hbk2o4yhl+nHx31CjkW/7rkdUNiT+E5w/EqVAqv7RmEm7Qy77Zmty
 onR/ZGPlL4gD50NBgiAFMBzxG95tLmhM8W5KDR/ip72TZ+4FCd0x175lU84ySGQy20f/
 OdvgXgOm870GDpBbtpO1jx+Bdr/v/0WGxxkTtDj+HBIVi+lDcqKKFYLyjV1jkR6AVGQ1
 t6N8ym7gf8VNmr8gEmVgMrBkl3d5PVyV5RLpVpULPnHl+8WjlKCEBEZTa07zbk5epLjk
 ebfSmNTp8za4b6vHJW4cQgfd/thjcP0hosKB1GbXUX3xOpTSTu6umGtfIi9DmKmzCycW
 4OFg==
X-Gm-Message-State: APjAAAWIzIjCzb1ytXo0uF6bEos3p+Gk/HPHURm8CP10Qpt28y3cIIda
 z+CUEPcwQ5Da1WHFK5pGHhOpMV4iJYqbWLZuy0Pnm8cAyBZU/M3iHkkToixfK5PDpFwD4OTS3KQ
 dHs7OXBahtpZ2nRM=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr4958790wmf.113.1579623788405; 
 Tue, 21 Jan 2020 08:23:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqydDyRaybxt2bHjsURlXsF8yxmXqCpy5EbgUxaTIRIGXLqSZkR7maQzNp/bHHuXmtxh0YAu2Q==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr4958762wmf.113.1579623788084; 
 Tue, 21 Jan 2020 08:23:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id s1sm4924302wmc.23.2020.01.21.08.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 08:23:07 -0800 (PST)
Subject: Re: [PATCH v2 3/5] linux-user/i386: Emulate x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-4-richard.henderson@linaro.org>
 <87v9p62vt5.fsf@linaro.org> <e384935c-7fc2-77eb-352d-90aa95ba89a9@linaro.org>
 <87r1zt15jg.fsf@linaro.org> <e383d1d6-7c08-ba3c-6e8b-971d62a9d2cb@linaro.org>
 <87a76g23b8.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b416ed2-cb2b-42c5-9563-9c37c0f4ba78@redhat.com>
Date: Tue, 21 Jan 2020 17:23:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87a76g23b8.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: H-Wsw0PcPY-Dw9b2uaXz7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/20 17:15, Alex Benn=C3=A9e wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
>> On 1/21/20 12:13 AM, Alex Benn=C3=A9e wrote:
>>>
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> On 1/20/20 1:48 AM, Alex Benn=C3=A9e wrote:
>>>>>> +    default:
>>>>>> +    sigsegv:
>>>>>
>>>>> this label looks a little extraneous.
>>>>>
>>>>> Otherwise:
>>>>>
>>>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>
>>>>
>>>> Look a little further down:
>>>>
>>>>> +    default:
>>>>> +    sigsegv:
>>>>> +        /* Like force_sig(SIGSEGV).  */
>>>>> +        gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Validate the return address.
>>>>> +     * Note that the kernel treats this the same as an invalid entry=
 point.
>>>>> +     */
>>>>> +    if (get_user_u64(caller, env->regs[R_ESP])) {
>>>>> +        goto sigsegv;
>>>>> +    }
>>>
>>> Wouldn't this read better:
>>>
>>>     /*
>>>      * Validate the entry point.  We have already validated the page
>>>      * during translation, now verify the offset.
>>>      */
>>>     switch (env->eip & ~TARGET_PAGE_MASK) {
>>>     case 0x000:
>>>         syscall =3D TARGET_NR_gettimeofday;
>>>         break;
>>>     case 0x400:
>>>         syscall =3D TARGET_NR_time;
>>>         break;
>>>     case 0x800:
>>>         syscall =3D TARGET_NR_getcpu;
>>>         break;
>>>     default:
>>>         syscall =3D -1;
>>>         break;
>>>     }
>>>
>>>     /*
>>>      * If we have an invalid entry point or an invalid return address w=
e
>>>      * generate a SIGSEG.
>>>      */
>>>     if (syscall < 0 || get_user_u64(caller, env->regs[R_ESP])) {
>>>         gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>>>         return;
>>>     }
>>>
>>
>> Only if you have a violent goto allergy.
>=20
> gotos have their place but jumping backwards is confusing to eye. If the
> compiler want to mess with layout after then it is free to do so.

I agree, if anything I'd place the sigsegv label at the end of the
function but Alex's version is just fine too.

Paolo


