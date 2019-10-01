Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E510C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0881420700
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL7ZUuVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0881420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEIx-0006j3-CJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFEH7-0005vL-Mv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFEH5-0004a1-S4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:16:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFEH1-0004Yb-Mz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569921406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nERaDWaCQo3ceDX41FSXNOobr8KmgYLzCIVN9dk2Kj4=;
 b=YL7ZUuVtVgerGQKDdjWGsmNGn9wl4VIN0z+WJXsIxCUnD8l1XCU/bgEEASLEBIY7WFlpv+
 U4b2gbNa6SYgZKtP4ICbG524M7ZZdplkMtRVOp6HWxoFUe+dIg2b/xtRClBI8v7HFZ1Stb
 56P4PVoI6O4/YfuPGBDXo/etomx2W44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-giurjl0AM06HzFhs3q4taQ-1; Tue, 01 Oct 2019 05:16:45 -0400
Received: by mail-wm1-f70.google.com with SMTP id m16so641443wmg.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sIX7+DL64TBK8m0/JZ3UbYBsPYM7mgg48MPu+AyBQxY=;
 b=jcencsUFzpmXLiXUlYb2HzEqTMtNUCHEMfYwzIZhivQ7m2NcSkqf1kmpeFZmNFiZTI
 Dx2ncqoeRw7v7/J7G4ks7kUeuBiwhAKLuRho5VPJ/YYMZiiWte4XInd/HFw0WT7HbXr4
 JBYYtQ57T+/SLnxzsmkDULN4YGSuqCzXPn8ayGug5WetHeCr3dZ58t+fnUS/0+o1jNSo
 2VmRjQ+onYOVVogFa8NOjnKHht+r/joGHAx7dhNThv356e3zhGFZ9KTl8VRnmTdnTjdN
 Omrvkir1GHhmzJeadWhEgM2juYCdfPDenuqDSf0A1fVB9fs7gBX+C+8elgzuQh0ydSId
 Cm5g==
X-Gm-Message-State: APjAAAVoRFahIQRnPzYLUDp6VW82gfQmSDME3v83KpQA/LkMKGwRYXAp
 MLi1VCHrnBJ7HB2dHms/yeRax64KjucJ1w7ABll33Oc7tBHtHQbcLJfz/KwHg74DJR4bFrDuAqo
 6zmA2QqWng+n2Cpk=
X-Received: by 2002:a05:600c:2052:: with SMTP id
 p18mr2752373wmg.13.1569921403922; 
 Tue, 01 Oct 2019 02:16:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAs1Z7jG3TvymFDPmzht/7ESHGyazSfij4Mb2XP4gFgCIgj0PwaaKMsrofIYagheUTkG9+jA==
X-Received: by 2002:a05:600c:2052:: with SMTP id
 p18mr2752348wmg.13.1569921403640; 
 Tue, 01 Oct 2019 02:16:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id s12sm34203385wra.82.2019.10.01.02.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:16:43 -0700 (PDT)
Subject: Re: Lockup with --accel tcg,thread=single
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com> <87ftkdlhet.fsf@linaro.org>
 <9cdb8f02-0aa4-f0ec-d482-244e346bfc96@redhat.com> <87eezwluvg.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e84bb7eb-07df-1c84-c4d7-285c40436751@redhat.com>
Date: Tue, 1 Oct 2019 11:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87eezwluvg.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: giurjl0AM06HzFhs3q4taQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 10:42, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 30/09/19 21:20, Alex Benn=C3=A9e wrote:
>>> Does seem to imply the vCPU CPUState is where the queue is. That's not
>>> to say there shouldn't be a single work queue for thread=3Dsingle.
>>
>> Indeed it doesn't.  I confused this with commit a8efa60633 ("cpus: run
>> work items for all vCPUs if single-threaded", 2018-11-27).
>>
>> Are you going to make a patch to have a single work queue, or should
>> I?
>=20
> What's the neatest way to do it? Are you thinking just special case
> queue_work_on_cpu to special case first_cpu when mttcg is not enabled?

Yes, I cannot think of anything better.

Paolo


