Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF5DC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8908A21873
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908A21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzSti-00031z-Kc
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 17:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzSt7-0002cJ-NV
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzSt6-0004Tt-7P
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzSt6-0004Sl-2F
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:38:56 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56E2283F3F
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 21:38:54 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b1so4208789wru.4
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 14:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MsDepduYHA9wcTZCJt5rjCyx3Lcj8gbH+sXh1CZtCwI=;
 b=XC5vnh4lJY0FtbxLnn0/8o3Nl+TMwYysebYR1Ex7sN8jOJ466Acr9XGZY9/ooHUnOM
 gRI+IRo2UTZAwALxJyNwoI8s9lLPZZ50qW8v3a+ex4o/Knki+/vcnAap7HOwoxv+PNSJ
 qJ31FGuAj+rsXhcQVQZK3W8+YuXXPb7+KAmuTqwcWS6CY1JLPyhldAkk5XpaK1kakTis
 P3MzUPjUSmiSLLET4xZ0R4GCUuCOGKIvK2WENjsnlSb/5v6ZQXMZL6fJCARpej89Lyi6
 CBqOY3R00ez9ZdLbX9U4CwqB151l5tQvCokSZV78vWm38II12OfoavSYlshf1GJZk/qz
 VQPw==
X-Gm-Message-State: APjAAAUlb0KShQarB5d6F0XOdu/2r0u7Tcwev1uSIGgHV0S5OCpxP/lt
 Thk4zSLP7hLxFqHK1Sutc3aQWvysoLCqF+qt5+KoNC84wzficHShQn01sk8HpDh1/Lr4sBbxaqB
 a/4qRiStY0+aazc8=
X-Received: by 2002:adf:de02:: with SMTP id b2mr23212741wrm.204.1566164333158; 
 Sun, 18 Aug 2019 14:38:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBz6lB3DCxSQkMUuM4I2X30ppTGqIstBhH9TOQ4q7kdsmA2/+XHS25rDT1MwYGrA6lQJaRrA==
X-Received: by 2002:adf:de02:: with SMTP id b2mr23212735wrm.204.1566164333000; 
 Sun, 18 Aug 2019 14:38:53 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e11sm35221753wrc.4.2019.08.18.14.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 14:38:51 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190808143457.14111-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <20455728-aeee-7009-ec42-c3f5db7ff55a@redhat.com>
Date: Sun, 18 Aug 2019 23:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] net/eth: Remove duplicated tcp/udp_hdr
 structures
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On 8/8/19 4:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This is a preparatory cleanup series.
>=20
> Commit 75020a70215 introduced 4 very equivalent structures:
> - tcp_header and tcp_hdr,
> - udp_header and udp_hdr.
>=20
> Choose the most widely use in the codebase, which happens to
> provide convenient bitfields manipulation macros and is not
> endian-specific.
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/net/virtio-net: Use TCP_HEADER_FLAGS/TCP_HEADER_DATA_OFFSET macros
>   net/colo-compare: Use the tcp_header structure
>   net/filter-rewriter: Use the tcp_header structure
>   hw/net/vmxnet3: Use the tcp_header structure
>   net/eth: Remove the unused tcp_hdr structure
>   net/eth: Remove the single use of udp_hdr structure

Are you OK to take this series?

It got reviewed by Dmitry Fleytman.

Thanks,

Phil.

