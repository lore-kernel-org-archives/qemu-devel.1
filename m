Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2BBC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87DF20409
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky/7uPyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87DF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBl0-0001Wb-Dd
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVBhk-0007jC-KV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVBhg-0004PX-CD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:46:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVBhe-0004Oc-T6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573724774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zICw5eLZfmIB3BUjXqdb65ADKqKmDwiMxhfFqAFOq8Q=;
 b=Ky/7uPyN1dv0uxrei298b0f0hcQZf8wQx/LXb/AZ4pLIo9ezySJu8rIwwTyyCh6IC2l1E8
 yOmQj0q3D0mRS3y9ts0dfgQb9lRwZIiN/5E0Wy3HNGT5ANnyG/dZQFqIuXSAwcGEP0Dx5F
 MB/fNr6hDKSwTekMEGi01ErkIslZHzo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-v9vXbkH0On-MnrcmxItfkA-1; Thu, 14 Nov 2019 04:46:12 -0500
Received: by mail-wr1-f70.google.com with SMTP id u2so4088153wrm.7
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xmihgrI/kHFhHndcbN1Or8vYbgGOUUeRxmw/Wa1VIQw=;
 b=WJ4yp0JuUP7bBfz3OszeooIzc3OgBxWzovgmWSVSKf8sRF26XfSRdCaJsgd0qmB9iY
 gP5FahYIsyCzYkw2pRUrJo6Fcyy0ev/UeijeGVjJtdxxIrG1gK3rdP5a2tOnC14yRneN
 gTr3eWTvs5cKmBPvGVOLXJJkIPlaY+F9Of3ERWlSBCmXx7AV+OBMFWLKT2gWBDzm/MTw
 ABNBkdCZMcs+s8D3RSH5hXsPSi+258sRPybrPjK/En5OlLDVDAB10L8dVr+TV0Xk9zYM
 CT7uLG2c63BbrhMAYbq2wRm690oGX6o8pymOYPAczS+xeoZ1wxII2QwdP7y6cWWTl5mw
 Zsyw==
X-Gm-Message-State: APjAAAU8zeb5lYiDQIGVXAgqprAxnn0/Xyp9BLVYF2pEX9gL5b3loyOJ
 VaJVg+gTgpprt/2H+MJgbMIfsDYC3SslVRNvtQqxajRbJgFJSFaUxLLt6Edx+UxmkvTq7pIChHS
 AoDgZ03GlyHezqtY=
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr6894049wrp.255.1573724771705; 
 Thu, 14 Nov 2019 01:46:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2BoF8QhxxWDlFMu/4XxFT1+WM5WT+SPQrO2TTY+PXKiWYaIqcfvftV/J1fIsgP+nUryGhtA==
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr6894025wrp.255.1573724771418; 
 Thu, 14 Nov 2019 01:46:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id i13sm6189405wrp.12.2019.11.14.01.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 01:46:11 -0800 (PST)
Subject: Re: [PATCH 05/16] vl: introduce object_parse_property_opt
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-6-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CL=m8WfLW2vJ73UTGNpbXBdww7zEtRGt+ri+TjoPd4auA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c6bfdc22-56b8-b3d7-a402-9f4659e49742@redhat.com>
Date: Thu, 14 Nov 2019 10:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL=m8WfLW2vJ73UTGNpbXBdww7zEtRGt+ri+TjoPd4auA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: v9vXbkH0On-MnrcmxItfkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 09:23, Marc-Andr=C3=A9 Lureau wrote:
>> +{
>> +    char *qom_name =3D g_strdup(name);
> Could use g_autofree, and thus return directly without r.

And avoid a bunch of memory leaks in the rest of the series.

Paolo


