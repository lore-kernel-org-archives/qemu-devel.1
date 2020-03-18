Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA4C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57C92076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoFH9qmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57C92076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEU1h-000648-VJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEU10-0005T7-7V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEU0x-0000gK-Oq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEU0x-0000cw-Ki
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584519923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avh5LzmcdY0AcCSxNo0inPtDDG/zdr5LY3f3LiDAM08=;
 b=BoFH9qmvmPxIRYjw2Aob6ngJmLqozWeoRzjPRT1OYEXH51z9lMbwofTBxADpH2y4vOmsPT
 DKNG6182ja49xUpGNEccYmba+N1+XhVYsfpE6znP74Gs9y611H/Ha3bQwDqbeCWL68v0eu
 UuuiifoB4SMvVEhwREwFSsclRYtJswM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-KB3u8nGDPQis2P1Ra-lA-Q-1; Wed, 18 Mar 2020 04:25:19 -0400
X-MC-Unique: KB3u8nGDPQis2P1Ra-lA-Q-1
Received: by mail-wr1-f70.google.com with SMTP id u12so9529315wrw.10
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 01:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0qRY+15/GXqbsgWD3oQGOHwGPnFiy3YYTua5D4xCGqg=;
 b=B3phIQJQi4y6tBn88DE8l4nA9Ai2i4eacvmlFnpLanP8zq1P2sJNwfspq4Up2vmRZN
 BfgVp+jbFWY1/T4BQdIQ2t4Zxsut/V4f/n8BlrHHX1ySfcFtLJAFedKRLCVpaJvQvkDH
 xGjt0JJSOSO6EWl+I34X3eY5xe+Lzm85NDtOa1M0rjchKqMg1tHoQMUMYCgGeKUsgbJU
 SjY3tFbgutxAL+EH79FeRMR9JtzamvLnlxSnQ3WNaNnI/zgo2EHr7IiIyhLtFlfVJXFz
 RH0H4SaxUMC+pHHz2DtNrq3DZP8uoIdZGtpjje6F6+iy1G7Q0dGeKD6D/kH35AJicqEp
 ObEw==
X-Gm-Message-State: ANhLgQ2K/doGUYVa1OwPLjARA1DkrG0XJZr1l9byrQTG6E4YZjl47EZg
 nGIywqHJJ3UKKopGW5qn6WfQmV2wLLNfG1NMZpSxPvs8Ah2zxY19TZXesUOGbmHDviAfwmG7rMX
 rrfa1H801if6/GiI=
X-Received: by 2002:a5d:6388:: with SMTP id p8mr4047202wru.51.1584519917685;
 Wed, 18 Mar 2020 01:25:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv8USYEtCNgTQFEfTyMhjgs3hiiS1n0UvD7pmj15Y+qBhJHEGIxRmsQ1eJO5fUIbKfeoM1bzQ==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr4047166wru.51.1584519917410;
 Wed, 18 Mar 2020 01:25:17 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id t9sm4993516wrx.31.2020.03.18.01.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:25:16 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] user-mode: Prune build dependencies (part 3)
To: qemu-devel@nongnu.org
References: <20200316001111.31004-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5fa8b10e-b990-b324-dc3d-533842dd4266@redhat.com>
Date: Wed, 18 Mar 2020 09:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

On 3/16/20 1:11 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> This is the second part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).
>=20
> Part 3:
> - Extract code not related to user-mode from hw/core/qdev-properties.c
> - Reduce user-mode QAPI generated files
>=20
> Since v1:
> - Addressed Richard and Paolo review comments
>=20
> Patch missing review: #2 'Use qemu_strtoul() in set_pci_host_devaddr()'
>=20
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688486.html
>=20
> full series available at:
> repo: https://github.com/philmd/qemu/
> branch: usermode_pruning-v2
>=20
> Based-on: <20200316000348.29692-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=C3=A9 (9):
>    hw/core/qdev-properties: Use qemu_strtol() in set_mac() handler
>    hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()
>    hw/core/qdev-properties: Fix code style
>    hw/core/qdev-properties: Export enum-related functions
>    hw/core/qdev-properties: Export qdev_prop_enum
>    hw/core/qdev-properties: Export some integer-related functions
>    hw/core/qdev-properties: Extract system-mode specific properties

If you have to respin "x86 and machine queue" please consider including=20
reviewed patches 1-7 :)

>    hw/core: Add qdev stub for user-mode
>    qapi: Restrict code generated for user-mode
>=20
>   hw/core/qdev-prop-internal.h     |  28 ++
>   include/hw/qdev-properties.h     |   1 +
>   hw/core/qdev-properties-system.c | 602 ++++++++++++++++++++++++++++-
>   hw/core/qdev-properties.c        | 643 ++-----------------------------
>   hw/core/qdev-stubs.c             |  20 +
>   hw/core/Makefile.objs            |   3 +
>   qapi/Makefile.objs               |  37 +-
>   7 files changed, 714 insertions(+), 620 deletions(-)
>   create mode 100644 hw/core/qdev-prop-internal.h
>   create mode 100644 hw/core/qdev-stubs.c
>=20


