Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44222C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB062077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0CGXUH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB062077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGyf-0000jJ-8D
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieGxh-0000Fs-Lf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieGxg-0001Im-Lm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:12:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieGxg-0001Ig-Id
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575889940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pQqMcPghEuLFfV5NKXopVjLWDB5vqNv90PorO/Wpg4=;
 b=T0CGXUH8XLNByciSWmWWQEPzYvapBYQFylLGuU9Di0R5OrBJdfgx9el+dYCgBOYG17cje2
 txNxOI6wV8mIW/6JKEmuiq+34R1s9W0sbK5m3AfZhNfQ4sT2kzF8nQELzog5FJnQ40ygKa
 aSFQIhqYXvgQEPa4f10JqucwoIzg+S0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-RlDwfRTwOImBNuwaEC_phA-1; Mon, 09 Dec 2019 06:12:18 -0500
Received: by mail-wm1-f70.google.com with SMTP id q21so3725759wmc.7
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 03:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q2AkEEairzhIRLX8Oc4uPMdpQ5LKLsnerB8OJhz403k=;
 b=Z9cUSrAAni2eEXDMbaa9Rr13C4c1lCiLfc6BUkn8FE+NZH3Uc1b/9+NO+ISGAMLdrl
 7QvW4M+wZxpz7qgdas210Df+lTryMjaY2xiQmP8JXJX0J0qMwkn0KjJLNdnrs2CBeLhT
 /qLy9TDvPNq8hOhPWzXUC9hthrlmQbSVEq3vDEchy1WpEx9gRVeDVR37f+lGmWsK9ZNE
 ZH69cCPP+iOCc4EnAgKItr46j4W/NZ86Adqm4ba7RGdn/ZdRCJgSYljKPDxrV0W9ProH
 4TxEQt8YfBCCgPqvOP3EWrV6JHo1UChiY+BL6v5+U/JnhsekTbHYA4KX5H6xqX3dGfvn
 pLsQ==
X-Gm-Message-State: APjAAAW4wfoLJYSdeHW/QgSE101M6Z2HE2ZJijdDPd6n6tN6XyBIii9T
 54AC7z5solpTCeaRJxtDzdTnrP3sSDYgTYvWu9pHCz5HtyfTfaVUO4LwKzF58FdisIGRyu8HEgt
 bi9fLxYrNh/5ocXw=
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr24277637wmg.163.1575889937867; 
 Mon, 09 Dec 2019 03:12:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx38FtLGCz+MeszshBT05od+gqa5subISC/n3ShalHtJG341TPVUT92Qf1WZH4KDdzW1DEvxg==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr24277605wmg.163.1575889937628; 
 Mon, 09 Dec 2019 03:12:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id f9sm4530796wmb.4.2019.12.09.03.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 03:12:16 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH-for-5.0 v3 6/6] hw/pci-host: Add Kconfig entry
 to select the IGD Passthrough Host Bridge
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Durrant, Paul" <pdurrant@amazon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-7-philmd@redhat.com>
 <3f1702b0765841b19328366af11fd3ed@EX13D32EUC003.ant.amazon.com>
 <083d0d7f-766d-9e72-5395-b4e82858ef4d@redhat.com>
 <4e9dee3e-05b5-640d-33df-4341c2e01b8b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dea9aca-5445-9c53-e1c4-c5f73c2af243@redhat.com>
Date: Mon, 9 Dec 2019 12:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4e9dee3e-05b5-640d-33df-4341c2e01b8b@redhat.com>
Content-Language: en-US
X-MC-Unique: RlDwfRTwOImBNuwaEC_phA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 11:56, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> I think so, but with PC_I440FX -> PCI_I440FX ;)
>=20
> It would be cleaner to pass the CONFIG_XEN_PCI_PASSTHROUGH variable to
> Kconfig and use it (use 'depends on XEN_PCI_PASSTHROUGH').
>=20
> This can be another step, so if this series looks OK to you so far, do
> you mind fixing this and the comment in the previous patch noticed by
> Thomas:
>=20
> - Extract it into a new file, 'hw/pci-host/igd_pt.c'.
> + Extract it into a new file, 'hw/pci-host/xen_igd_pt.c'.

Sure.

Paolo


