Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A10FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242BF2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmfMoLDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242BF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzS1-0007n9-FE
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:56:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOzQx-0006rX-Kw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOzQw-0006a6-On
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:55:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOzQw-0006ZY-IQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:55:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so2089334wmj.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=VEPt2+y5np+/H92Mis5IRgWKmtWBIk/T2lX4XEV17Bc=;
	b=bmfMoLDH3Pr4ppchKOCuUyz+r25s5r9nPC5C2k3Ii5+RTwjyUt9CwXgB9iZX8mXUP+
	W5bDDqoWZAMk2R/akDCWWigMWtxgBJaLfoyboBdrwBN02eE1Icy8nW74lJO93XZtS3lY
	s1xpq0aoYnPLlXUHD1/nDgBmdHVp0CEk8BtVr8okxtp6oZdC4/ymjJUy/wiXliA4T2BZ
	bxjlgUNWmtBXMM+VATEE9hiz4/QAT0jq6M6SGugPTVBMbPmkCADj2FgTvhhvP5/dNWBl
	NIX3kox/GAEX3+t7o5/sM3tDhY2jUIvpULQcE2OqorsS/ebHeGBtrU8vMQkHsw2QEBzv
	6JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=VEPt2+y5np+/H92Mis5IRgWKmtWBIk/T2lX4XEV17Bc=;
	b=INgjX7aRE/FV0ijeeD5nwgSm6Rt77FriP7uSU5kQDffv8FoT6/1TgrpFjSoyEX0j5B
	gi3ECA8ff0biyx8iGuD+h/v24WSQ/wo888w2CsssgjIEJZNfrYui+p2wlk7pLOQ4aBul
	El/wZqiMnB8tI3ZiO0PUcLiH7tlO2+bHJX/kH+2j3sUIN8SRHUZIeQI6CJEaWpcUOts0
	JjcFf4HnDrSzv71hQK2x1AnnwZJXfOmQXgEeNJc5am19T8zLOiTnasjsIrap5juN7K1A
	si816ia5Q+Ex6HXZWCU8oJIxdUlZCUBpGwBOUluX6ocpp6bi/UnplAAEBtgN8RZCP+ma
	hJtQ==
X-Gm-Message-State: APjAAAUTAYNR2PQE89rOZAHwzvpH57UTNPT0MIo9IHE3bNoCoiSM/+vV
	BFuY2bLATJEVKiyCEqdbRIKBOQ==
X-Google-Smtp-Source: APXvYqzcAG1Tb9a2K1/yThKPJUh9CfyxdB8c2i4AeTDYZIcRNtlaKy5ZOq7h4hiUGQsBwkQ5Du0g+w==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr5751377wmb.58.1557471305070; 
	Thu, 09 May 2019 23:55:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j46sm10386129wre.54.2019.05.09.23.55.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 23:55:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 00FE01FF87;
	Fri, 10 May 2019 07:55:03 +0100 (BST)
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
Date: Fri, 10 May 2019 07:55:03 +0100
Message-ID: <87pnoq4x4o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/9/19 9:58 AM, Alex Benn=C3=A9e wrote:
>> @@ -51,12 +51,18 @@ static inline const char *semihosting_get_cmdline(vo=
id)
>>  {
>>      return NULL;
>>  }
>> +
>> +static inline Chardev *semihosting_get_chardev(void)
>> +{
>> +    return NULL;
>> +}
>
> Isn't the point of this function to avoid...

Yes... but...

>
>> -                return write(STDERR_FILENO, &c, 1);
>> +#ifdef CONFIG_SOFTMMU
>> +              Chardev *chardev =3D semihosting_get_chardev();
>> +              if (chardev) {
>> +                  return qemu_chr_write_all(chardev, (uint8_t *) &c,
>1);

The qemu_chr device stuff doesn't have such stubs and is softmmu only as
well. *sigh*

I guess stub it out in the header as well?

>> +              } else
>> +#endif
>> +              {
>> +                  return write(STDERR_FILENO, &c, 1);
>> +              }
>
> ... this ifdef?
>
> Better to change
>
> - char c;
> + uint8_t c;
>
> above to avoid the cast in the call to qemu_chr_write_all?
> Or perhaps we should adjust qemu_chr_write_all to take void*?
>
>
> r~


--
Alex Benn=C3=A9e

