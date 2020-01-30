Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D88C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916DB20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KP2hJQuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916DB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCpp-0007ji-Nk
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixClC-0008OO-0K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixClA-0008Dh-KP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixClA-00087J-DM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580402016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNEA1GIzWXT/wo5gy6Vd0WcfjAAmLoSs3VyTc5jGVMc=;
 b=KP2hJQuOF/7RDPGU4mNGUQo2eji/AejB0BnUXHziWsQDMHT4OHGvy+7cgyWIQtFMYgQKdI
 qc9iD/W7JwrDoGIBLnmyx9dDgRhaWdx3347T5xdC7V14k1CvYuZVE30tqfxS3NgF+DP9PM
 r/kqctMEa7vWKsdv1o9Y/Nc1Pgmz7sY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-K6h2-M0dNVWP2GdXuXfJRw-1; Thu, 30 Jan 2020 11:33:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so1981354wru.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Idgu1ovbdhEjBDTiMNMMknYRQxAZFr079uqbL8FDl/A=;
 b=bPfMMxT3vNWiw2NcyRe9+0VAgycqYNpXDne+0LFPUYMuBEyO/lOVq8IQqKD7flFNLq
 OKDGOkvyJPy5Yz2zlodyfuTYahPenk6Ncz+32wKbW5wnrkrmfBBZ3DhRWkcymB6rdd79
 u5/70XLZAQByOg4L5+f4+QXsT/YYdRDKXurqgJyAZrkILV2MGEb+vKBXIw26yTd1Gxdd
 bjMuBuUS4IOxjx7teFBRj8jdST9ppLJXGWF8UM1sJ56uYqcA9uYt1amAREy2f+RKmMr2
 qypziO16o4YW89UY6ZXm9ueBWtsycP7RzhNHbjzq/09Z8DzykuDUubzRNJbY6MPTklPw
 ulJA==
X-Gm-Message-State: APjAAAW0svROoj8/WK/uDeeQlButeEOIFDfEIikaljg+NOHRXL0HdzzZ
 r87tdemFGFtMq5IgY1u1qnI5ZYTaKnl6xV2E/IfGjPGRwTQraxxbj6Kf+az1RRc0M48uhPW84yI
 QY2FkxgqpXKaGeCY=
X-Received: by 2002:adf:f850:: with SMTP id d16mr6349213wrq.161.1580402010932; 
 Thu, 30 Jan 2020 08:33:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxedRCAD9LhGhFv/4AuZTMcHCAKEPcEd5gnPV6geTOku9onKmvBNZj9e1VHSmvjt1b2TTq36g==
X-Received: by 2002:adf:f850:: with SMTP id d16mr6349193wrq.161.1580402010715; 
 Thu, 30 Jan 2020 08:33:30 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id c9sm7099750wme.41.2020.01.30.08.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 08:33:29 -0800 (PST)
Subject: Re: [PATCH v2] hw/*/Makefile.objs: Move many .o files to common-objs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20200130133841.10779-1-thuth@redhat.com>
 <871rrh9fkc.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8077a146-f190-a584-9700-e2931a2a3beb@redhat.com>
Date: Thu, 30 Jan 2020 17:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <871rrh9fkc.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: K6h2-M0dNVWP2GdXuXfJRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/20 15:36, Alex Benn=C3=A9e wrote:
>=20
>> We have many files that apparently do not depend on the target CPU
>> configuration, i.e. which can be put into common-obj-y instead of
>> obj-y.
> While common-obj-y is still shared by linux-user this will also add
> slightly to user-only build times.

It won't, all the directories that Thomas is touching are under ifeq
($(CONFIG_SOFTMMU), y)...endif in hw/Makefile.objs.

> I'd like to see some separation of:
>=20
>  common-user-obj
>  common-sys-obj

That actually is done in the Meson conversion, where they are called
respectively user_ss and softmmu_ss ("ss" stands for sourceset).  They
are added like so to common_ss:

common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)

> and I guess the stuff already common to everything is already in
> libqemuutil.a

In my meson-poc branch, the only files that are added directly to
common_ss rather than softmmu_ss or user_ss are the files in hw/core and
the disassemblers.

Paolo


