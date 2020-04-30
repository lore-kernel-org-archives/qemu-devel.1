Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44FC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7647A2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqCdbrfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7647A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4J6-0000pB-MN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jU4IQ-0000Gq-Tn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jU4IP-0002sk-Qj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:11:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jU4IP-0002rx-5X
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:11:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id x25so800462wmc.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RDxNiPlBsS20nSfiC3XgBEgxNQ3U5ugDvHJh3p9ybAo=;
 b=GqCdbrfIVRhgSLMFUe7TlGbxdoV2iaGvBbpnv27T98BTEvlPcuvCx9P0rMNOXLswzN
 ljxP1gq6BuY4BfFrwvk/ZpMVWhCuV7SVl88MUej8Pe1xAUFLMPWg6uWovkBHit57VCJe
 1WyLFGNFwR9foGqzi4/csCu0oI/G8YpwzLOKZ2++TAQRepeamthchDPpf98XkpVNd3w4
 DN6c6ue0l3r1XakzLlfGoXcFC+4CkqcmtBVpLsth2ia9qHjBJcsJXN8zY/Ukvrkqtd7j
 8JCWT8gSbYw+1vd4iKYV0rusxOB1kzkusexNHLNhE1ieRf+4UYK73p3PUrFW2ma82RMe
 I/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RDxNiPlBsS20nSfiC3XgBEgxNQ3U5ugDvHJh3p9ybAo=;
 b=sgdYTBfhjMuznqKPngOy7vR5q65ZlC76hqZRxs8abK4nc+KD7MDtKg6tJ2yTdYPsi4
 XdTrawgMMsXBM3sF5j8MmDoUNSvGiSISdPMP+fvobjmq8IEWbvUfsO26dg3NamZ7NbXd
 0QWeh4vUAXeHNnO2QPYKORMkqU14ra9UMX8Cc3sjtim3LC1w/yEts0GApfgK18RSCeLz
 JnJZ4a6fFUu6Vnfo/Av5BttM7J7/brmUF4URwl7LXG/NB/ozwfmPc0JpgqdR9fe/Rp63
 NqBYdwmbS+FrSfJt12oMWgjJN9tOkxOU71cncxRxQIrDjY3WzKREIo5u2K9WWOOo8CW0
 43UQ==
X-Gm-Message-State: AGi0PuaTt53Yf7kd2c+QGuqMhYFnTDV3KQJ8lFDl27ZQTaDt1l+sPv8r
 xQlpzgRlo1spK4giEq+nzqujsQ==
X-Google-Smtp-Source: APiQypKN3y5319yH5HczQT73bYPZ+I9+hfacK1jGYI/uBjuL5MDa/wH4ClkYgGj2VwDI9y/rbgLm/g==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr1606436wmh.39.1588234307328; 
 Thu, 30 Apr 2020 01:11:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c20sm11776738wmd.36.2020.04.30.01.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 01:11:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 51D8C1FF7E;
 Thu, 30 Apr 2020 09:11:45 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-MM6AR8fmExnst7o9wL4Q_nZkw=gyemMJmZSdPd_ydmg@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: R: R: About hardfloat in ppc
In-reply-to: <CAE2XoE-MM6AR8fmExnst7o9wL4Q_nZkw=gyemMJmZSdPd_ydmg@mail.gmail.com>
Date: Thu, 30 Apr 2020 09:11:45 +0100
Message-ID: <87lfmdjsu6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Thu, Apr 30, 2020 at 10:18 AM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 4/29/20 5:20 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> > Question, in hard-float, if we don't want to read the fp register.
>> > for example: If we wanna compute c =3D a + b in fp32
>> > if c =3D a + b In hard float
>> > and if b1 =3D c - a in hard float
>> > if b1 !=3D b at bitwise level, the we se the inexat to 1, otherwsie
>> > we set inexat bit to 0? are this valid?
>> >
>> > we can also do it for a * b, a - b, a / b.
>> >
>>
>> That does seem plausible, for all of the normal values for which we would
>> apply
>> the hard-float optimization anyway.  But we already check for the
>> exceptional
>> cases:
>>
>>     if (unlikely(f32_is_inf(ur))) {
>>         s->float_exception_flags |=3D float_flag_overflow;
>>     } else if (unlikely(fabsf(ur.h) <=3D FLT_MIN)) {
>>         if (post =3D=3D NULL || post(ua, ub)) {
>>             goto soft;
>>         }
>>     }
>>
> I means remove of all thse exceptional cases, and detecting float
> exception by hard float operation.

When this was originally done it was found to be faster testing for the
float conditions in software (which are basically bitops) than reading
the FP exception register which can be a high latency operation.

--=20
Alex Benn=C3=A9e

