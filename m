Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F89C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECFF207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMSGVF+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECFF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrCT-0005Qp-0j
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itrBc-0004Rf-DG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itrBY-00064f-Im
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:55:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itrBY-00064U-Fe
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW8aWvX/Z1kK4cQM6xxhih1FlYCfHIQz4ZOcjobmqqw=;
 b=jMSGVF+DxVOfcWy6kj7B/cgolyAR0FGjGi+I03nWoCbQmLSQauezhMlXTp2e5pjf1jd3FZ
 RuigyaPmR+lxa0NZY8+vIzzY1Ssvy92+teREXn3xA5P6P7YTTQn3ElHvQQRDV7UHEoE79+
 z4/T7ttv0ZMbgYIx9rybrGnjR2Qh8bk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-kO2okgfGMaaZdfpSCNVGLw-1; Tue, 21 Jan 2020 05:54:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so1130564wrr.20
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=77J6e9vlij65iYQBSxfKPmt32wnoe+T2a2HETQYQ+6M=;
 b=l1hWMEq6OhtMjRSU4UMj2+Fo9OayRZ+1g9APjwl7kCgRZ/2poDD+vO3NvY6TEEYX1p
 pdXdhg5fpRyJ2xVy9/KXu9qpdMsHnKY0aL7+NmS4mSHSr4StdjZ1rpPJKMxoB8D/nHux
 tpi8unIKnVFFvRr7sdB44Xqd9U/uU/PoHBplurAk6pvGFGsyY+w00EdDijgHFA2Hp9lD
 d6xKqzedQPAckwBZVj3M2pofNRKnSO3istidjHk01fU1r456kUmlTWkUixOzgpYeg9Co
 17riBVzyw1J3l/BT0SEFNtVs9u662r5d7fccP4E8W8+h0OPvANN9NDxKaz90pykiU5l0
 D9nw==
X-Gm-Message-State: APjAAAW+be48rfgfL7Z4oY2Y0Qcw1AT1CBqN0i2S15nNnOGv5e9wXLPh
 3sxqqbysCjTzC5FAbMEohs2xuam6GEjW2hGKnkagiAA0SEqNZ3GZTVbSx/BOccx3r180qT25zcu
 pnLQmkW55gDa0K1g=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr3900366wme.121.1579604089510; 
 Tue, 21 Jan 2020 02:54:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzURsseDDm3awqnL5CGeLJ/TCFFBuuL5xZv0JqdImgYKi3Lc3GbIDbgltNMQtVcFajDEu9+g==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr3900354wme.121.1579604089219; 
 Tue, 21 Jan 2020 02:54:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id j2sm3432524wmk.23.2020.01.21.02.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 02:54:48 -0800 (PST)
Subject: Re: [PATCH v2 0/6] buildsys: Build faster (mostly tools and
 linux-user)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20200118140619.26333-1-philmd@redhat.com>
 <4b4dfacf-47d2-65f2-c6cf-5e9d540bc239@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7dec8acf-73fe-f84f-b924-49014053eb2f@redhat.com>
Date: Tue, 21 Jan 2020 11:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4b4dfacf-47d2-65f2-c6cf-5e9d540bc239@redhat.com>
Content-Language: en-US
X-MC-Unique: kO2okgfGMaaZdfpSCNVGLw-1
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/01/20 15:22, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> Supersedes: <20200109153939.27173-1-philmd@redhat.com>
>=20
> =C2=A0 ^ testing latest patchew feature, v2 has different subject name
> =C2=A0=C2=A0=C2=A0 than v1, but patchew successfully linked them :)

Appreciated!  You've now demonstrated the case where the header is
included in the cover letter rather than a separate message.  :)

Series queued, thanks.

Paolo

> See "Diff against v1" in v2:
> https://patchew.org/QEMU/20200118140619.26333-1-philmd@redhat.com/
>=20
> https://patchew.org/QEMU/20200109153939.27173-1-philmd@redhat.com/diff/20=
200118140619.26333-1-philmd@redhat.com/
>=20
>=20
> Thanks Kevin & Paolo for this feature :)


