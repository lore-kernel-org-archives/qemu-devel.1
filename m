Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CFC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E05220658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCw/y4Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E05220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9mt-00069N-H7
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9kj-0003jv-QQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9ki-0000hr-7u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9ki-0000Tm-2R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584442034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOFa0QkNgttDsW6uWI5I7ymnkTRXnXuBlAOmrcaUR8g=;
 b=gCw/y4SiSCfZ0gEb6sCZNxe1h1bRBfBaWvd/i+WWfpf/WiNzAvEfEfMo0bSkHwnC7vP14x
 L+Wj5jzMGghXAix6A3lbGr+RUW/2ga5lS0KyNxLnH83q9TuhpGoyqBkpXilaDbIQ9gl/Bh
 CI2TSPoXYvrPBKrnq2M2pXg74v2kWIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-zRZY0vlPPz6FqBsQuY-tYw-1; Tue, 17 Mar 2020 06:47:10 -0400
X-MC-Unique: zRZY0vlPPz6FqBsQuY-tYw-1
Received: by mail-wm1-f70.google.com with SMTP id g26so5568357wmk.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BVKKzGOrmX0AKRh5Gyr6rnvTXSip4bHXX6R/JGyx4N4=;
 b=VDL/zJdziKcLBTP0Ew04UBdLRBkyYBwnjsSCjaaUs4nnsDABNAYGSieKaECk8EMD1Q
 acZKZt0yJR/05fx7UPTvEXqTBSay00MTAle1gfIK6yqVbgUodmKukpvS79cTZkchTtNT
 KUEH5JCQxEzQmWTfIhol7fpNVEfsOFZLnqKU+BaYsi/MkwtMOSoh11RadCgvpO/NAp1e
 LfHLmAl96k7TiqCJvvPrJBe/lFO2+c7Fcd1ReAY9HUgDS6x/Ioe859xwTVXR+iHc+m4z
 3Acx5KjWr11WfHEasi36plrnR2YmeasWP0/nV0h0n62aiXxOusHcatXHGiHJOlD8Is8m
 EF8Q==
X-Gm-Message-State: ANhLgQ3TkQgWwNLgmbJvJnOqcvjQ3asUqDcU5/5IS5AH4/JWAfxeRMcM
 94JVlOaxawMTG9tBfs2BlybqqcipH1QbKZo2Gma+50j89QBQjVjtKfZodEFqTPtVndtdrIc7r2R
 ycVLTFoAAZ2QqY7M=
X-Received: by 2002:a5d:440a:: with SMTP id z10mr5451497wrq.177.1584442029429; 
 Tue, 17 Mar 2020 03:47:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuOo47gqd8facNWdWVH62fj8EonQ28w+FY4ciBffpODbxxK9iNtlPPUvg7o65YJp9ch6Op7qA==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr5451468wrq.177.1584442029195; 
 Tue, 17 Mar 2020 03:47:09 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id u25sm3400281wml.17.2020.03.17.03.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:47:08 -0700 (PDT)
Subject: Re: [PATCH 0/6] hw/net: Make Net/CanBus can_receive() handlers return
 a boolean
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20200305175651.4563-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74bab3ca-fd8c-5c27-0376-2c3728cb18e4@redhat.com>
Date: Tue, 17 Mar 2020 11:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305175651.4563-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

This series is fully reviewed.

On 3/5/20 6:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The Net/CanBus can_receive() handlers return whether
> the network device can or can not receive new data.
> Make it obvious by returning a boolean type
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>    hw/net/e1000e_core: Let e1000e_can_receive() return a boolean
>    hw/net/smc91c111: Let smc91c111_can_receive() return a boolean
>    hw/net/rtl8139: Simplify if/else statement
>    hw/net/rtl8139: Update coding style to make checkpatch.pl happy
>    hw/net: Make NetCanReceive() return a boolean
>    hw/net/can: Make CanBusClientInfo::can_receive() return a boolean
>=20
>   hw/net/can/can_sja1000.h |  2 +-
>   hw/net/e1000e_core.h     |  2 +-
>   hw/net/i82596.h          |  2 +-
>   include/net/can_emu.h    |  2 +-
>   include/net/net.h        |  2 +-
>   hw/net/allwinner_emac.c  |  2 +-
>   hw/net/cadence_gem.c     |  8 ++++----
>   hw/net/can/can_sja1000.c |  8 ++++----
>   hw/net/dp8393x.c         |  8 +++-----
>   hw/net/e1000.c           |  2 +-
>   hw/net/e1000e.c          |  2 +-
>   hw/net/e1000e_core.c     |  2 +-
>   hw/net/ftgmac100.c       |  6 +++---
>   hw/net/i82596.c          | 10 +++++-----
>   hw/net/imx_fec.c         |  2 +-
>   hw/net/opencores_eth.c   |  5 ++---
>   hw/net/rtl8139.c         | 22 ++++++++++++----------
>   hw/net/smc91c111.c       | 10 +++++-----
>   hw/net/spapr_llan.c      |  4 ++--
>   hw/net/sungem.c          |  6 +++---
>   hw/net/sunhme.c          |  4 ++--
>   hw/net/virtio-net.c      | 10 +++++-----
>   hw/net/xilinx_ethlite.c  |  2 +-
>   net/can/can_socketcan.c  |  4 ++--
>   net/filter-buffer.c      |  2 +-
>   net/hub.c                |  6 +++---
>   26 files changed, 67 insertions(+), 68 deletions(-)
>=20


