Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E15C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3202076A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOGD2a8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3202076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGdm9-00042X-7G
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGdlX-0003Xf-Fu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGdlW-0003wA-2k
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:14:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGdlV-0003uF-Vr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585034059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wz5kxioYiJxXtReqDV/jbjk589cDzk44WppcJVhUyIM=;
 b=FOGD2a8KheTOM7RxaIkLs3JK/3HwrN3rUdAQ2/uQm8/9LX+ZWCxtbCjJing+DdFr6lAfHd
 XJpYIIW1WMEAcEZjXF5zfQWyTE23mZgtWxPnNhjeVriTiau4wiB7xnJ0eJ4ohsXlmM6XQl
 Xv6y9dkAXAI7TCYzvj2nr85jXmoMyPE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fXNvvHXBO9a9PTVaVwgQHA-1; Tue, 24 Mar 2020 03:14:15 -0400
X-MC-Unique: fXNvvHXBO9a9PTVaVwgQHA-1
Received: by mail-ed1-f72.google.com with SMTP id b7so14073407edz.9
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 00:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XY41nutp8rk2xlY3re0lENVVKZUUO+5VVrUHSgFeBbc=;
 b=sKP0msu5PLVEKe4Qqdzqm7ZaYFZ4AXlUnroSWBCTSFLYnPrIHXtsTh83/nFw+ufxWU
 Do4O3+iTydFVh+TC2cYyk+GOc6q9nCN2kwGU1nh8pwUNUPJqh2/o94adfVLkMfEaCdez
 M5u+jtDmvlXpcWF+4Po0hI+SBma7+szM71C3dwfwrLQlPN9tDibcQyWowvQpZgPRHpMD
 hphxw/XNQ0f6eNANSHxrfIks4oIEWcDWPBeGbEt+r4MPpwXqZSu5BhV72GSMOgD7bX9Z
 UHD+VIFf4kUTMeVLZFTkDmVFhmElfOl0NccwdB6cAxOQWBmVi395KB/7J2tg/ncOjcHZ
 a9Rw==
X-Gm-Message-State: ANhLgQ0MwyRq2Dhcwfs8HBFlnKeIJPK/C6o/khtz0w73jiwsTD2XqCwm
 hqT3AUpYlkzRQX9POzPFHqq7kQ79zt0OTiNkpgV9BqWac3rzyfCfhWoi6G3qjt5Q8SN3LIpft0s
 00g39I/xuxTFZSyM=
X-Received: by 2002:a17:906:748f:: with SMTP id
 e15mr22158232ejl.319.1585034053968; 
 Tue, 24 Mar 2020 00:14:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLZAaWAbjO+pLNqQ5+iGeF7mKa9+sWWxJxP0491PMV4Lgcwh+f9J3JPiQQTZa2+iq5izhVYg==
X-Received: by 2002:a17:906:748f:: with SMTP id
 e15mr22158216ejl.319.1585034053721; 
 Tue, 24 Mar 2020 00:14:13 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id a32sm1198875edf.46.2020.03.24.00.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 00:14:12 -0700 (PDT)
Subject: Re: Potential Null dereference
To: Mansour Ahmadi <ManSoSec@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <336bbdf8-140a-e884-d5d1-0610a9b1c6a6@redhat.com>
Date: Tue, 24 Mar 2020 08:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 4:05 AM, Mansour Ahmadi wrote:
> Hi,
>=20
> Nullness of=C2=A0 needs to be checked here:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df7=
6/block/commit.c#L221
>=20
> pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),...
>=20
>=20
> While it is done at 2 other locations:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df7=
6/block/backup-top.c#L113
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df7=
6/block/mirror.c#L1477
>=20
> if(bs->backing=3D=3D NULL) {return}

Thanks for spotting this. Do you mind sending a patch?

>=20
> Thanks,
> Mansour
>=20


