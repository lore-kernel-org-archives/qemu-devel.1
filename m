Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE9320705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qdt5vaaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE9320705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8EI-0003Az-3G
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ip8D8-0002Vr-KD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ip8D7-0004UA-Mq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:05:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ip8D7-0004Sf-8R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578477908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OXhY2juLXEUmJFsKhbFjk7B63NdyD+ZJIoganYW2EY=;
 b=Qdt5vaaP9QGsZ/LWPqV4lUorBI8rj9zo2Fy+cTPTTnR5eL0X28wBE3m9S77JdMSShRysqs
 lT6jnVYKLt7szM+le+SPTMST7uCYlkPBhVyOlDFx+VAhH+6OvqoWIMqKf/tR7VF6N4gZOf
 Od6pcV6Fa0s6UXDz2rGTx70eH8PIKVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-X4LERW42PcCt2UmvHSN6jw-1; Wed, 08 Jan 2020 05:05:05 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so1240817wru.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U4beEKrqHATjYJuEXNr0cR9Rg2zzgVL9SSX9UcNxrak=;
 b=Qg4JynnzQmLMHQOdffgjoCKygrZqrdK0TK1jRDm1Lb7oefto+tQZ5H13NrkYoFTZH8
 JrRbTlbg/XRB7LZlgpDAzFOJI33BcrvLDKZILz4uqJLJwcHE0kZJ9Mh6TSeIikrA59pK
 VcSNgBuDD7c9FweAz5zM5f/59f8OFPDZ4wDIF0rCG1OISMlBajxSMcjSTARTxGzkhScx
 3lwmgbZRFT1/UjZu6ayjPq6mlfl1/+r2QWoB53t6t9JJTh+umn2Wj5WKuiAG5LuMcxro
 oNI/KZVBiMOmaJN+q8wiTRJu2iXb6VNZVTLL81+1zdkeP43z5NiFDUrV4rC2/Vl0O2FP
 1tuQ==
X-Gm-Message-State: APjAAAVNKS0HOwN4GDx2bCo3XZFSePPjqZHhRF9S4b3fiuA2igjyi0R5
 X5hHVWZ9V+WF7G9iKH5zN69+jcW76p010OuS3Gte4wBsYyyCd7THzGJBJ6mqGSP2WFgf+C0fPQ5
 hSA9gUSFjwZFhX8Q=
X-Received: by 2002:a7b:c957:: with SMTP id i23mr2891757wml.49.1578477904198; 
 Wed, 08 Jan 2020 02:05:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqziUmw9W8yhAHlahv30N0G04pKPNxtKR0xm2qkfb8M/Sag2dfhARGjmDQ8cmE+BiUuVDFCc+g==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr2891730wml.49.1578477904019; 
 Wed, 08 Jan 2020 02:05:04 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm3045679wmj.38.2020.01.08.02.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 02:05:03 -0800 (PST)
Subject: Re: discuss about pvpanic
To: Michal Privoznik <mprivozn@redhat.com>,
 zhenwei pi <pizhenwei@bytedance.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
 <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
Date: Wed, 8 Jan 2020 11:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
Content-Language: en-US
X-MC-Unique: X4LERW42PcCt2UmvHSN6jw-1
X-Mimecast-Spam-Score: 0
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, "yelu@bytedance.com" <yelu@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 10:58, Michal Privoznik wrote:
>> the kernel-side patch certainly makes sense.=C2=A0 I assume that you wan=
t the
>> event to propagate up from QEMU to Libvirt and so on?=C2=A0 The QEMU pat=
ch
>> would need to declare a new event (qapi/misc.json) and send it in
>> handle_event (hw/misc/pvpanic.c).=C2=A0 For Libvirt I'm not familiar, so=
 I'm
>> adding the respective list.
>=20
> Adding an event is fairly easy, if everything you want libvirt to do is
> report the event to upper layers. I volunteer to do it. Question is, how
> qemu is going to report this, whether some attributes to GUEST_PANICKED
> event or some new event.

I think it should be a new event, using GUEST_PANICKED could cause upper
layers to react by shutting down or rebooting the guest.

Thanks,

Paolo


