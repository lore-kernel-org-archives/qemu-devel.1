Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E0C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F22B2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DblV9ggG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F22B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9Ug-0007lj-7R
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jH9U0-0007MG-Gn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jH9Ty-000786-Sh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:06:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jH9Ty-00077U-PT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585155981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6MZTLUVdzjB9KzFwTpQPyOT21rUs2UBLLOryw7w4hQ=;
 b=DblV9ggGcRrUr/ZaJMhSMR3irs7+NnTl5620N6i59EN+Tl7x+Q1vQQ+kzx5V8H++25BP8q
 ZlpVLbhu0yZaz37o/xw1Zek8PxG8moq/2QBj6c2YWpkHzaaR70TIhpgqVcrKs2sX7IV5cH
 BNryO44AbVHuVSVTbY5XK0+WI6BEh4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-hI69kycDNiO2_MsFz0-RAQ-1; Wed, 25 Mar 2020 13:06:20 -0400
X-MC-Unique: hI69kycDNiO2_MsFz0-RAQ-1
Received: by mail-wr1-f69.google.com with SMTP id v6so1417933wrg.22
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pwT4L0xQEq0vVd2SKs/7n542AYUEOH6wbOQLpPWXPUU=;
 b=PbHsMfredpHB7JJ7nld7zfPWrzKl8hF80ZTdESFfnvKjpFSQURbS4/0AKDr2xF2UYX
 0j7ge5pNtf7N/1XrgU9Wbjf0saO0qNr0yvLqzc150LOL5h4qEplPNNEdBxeUzv1Mb2gL
 GdcNV8pcBv7gFG7J+uIKx1FnCBwhXSQicCoCagSOzN4V86auaoc1cuM7/abjyM9HNzcH
 YnOb+RRZDh1vwjPEmEAdbOXfmESUMOOMnqVFM1pS5DgLsKNBeReu1fOoocrYt3v8BneB
 qzZAC5jlwiRbzzcP3igUWGPSpwG0EaCAMu1Bq47yPcKi+IHx1mTwIz7QZyaN5COHqLzq
 QMZA==
X-Gm-Message-State: ANhLgQ0DaT3aE3MY4gINmAWbLUjnPAG9Fx9DoBlLRb0Ql4f61atNua/e
 9G6Yjp8CEkOs5el/Dva2bbP7h9K+JxWwZns8RHu3J88f28LOLVH1OMRUedBrIKzvyc1C71IB84I
 O5naR8NvA1kR/iIg=
X-Received: by 2002:adf:ee52:: with SMTP id w18mr4409061wro.245.1585155978844; 
 Wed, 25 Mar 2020 10:06:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtnMpTem0YSaUUP4LajzNrRho/q4mZgXjksdRCkU+m9beceoLSlp/PGv7hJE3Y4Ui4lCyYaJg==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr4409038wro.245.1585155978558; 
 Wed, 25 Mar 2020 10:06:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc?
 ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
 by smtp.gmail.com with ESMTPSA id r17sm5880306wrx.46.2020.03.25.10.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 10:06:17 -0700 (PDT)
Subject: Re: [PATCH v3] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
To: Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200325064736.22416-1-olaf@aepfle.de>
 <9123dcfd-862f-8986-b728-f4b3d806aea6@redhat.com>
 <20200325164522.39869e56.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce1dd710-7818-3883-183e-73e7cfbf22d5@redhat.com>
Date: Wed, 25 Mar 2020 18:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325164522.39869e56.olaf@aepfle.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/03/20 16:45, Olaf Hering wrote:
>> hw_compat_3_1 and pc_compat_3_1
> I have asked about this earlier, so again:
>=20
> What do all these arrays do in the context of 'xenfv' to the emulated sys=
tem?

They change the hardware and CPU features that is presented to the VMs,
if the respective devices are included in the virtual machine.  For
example USB devices will have a different serial number on 3.1 and 5.0,
and VGA devices present EDID information on 4.1+.

Paolo


