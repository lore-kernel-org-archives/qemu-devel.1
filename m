Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A6C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF29238E2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbHBkyVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF29238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvH2-0007XB-Fv
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUvGC-00078F-GE
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUvG8-0002V2-Px
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:12:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUvG8-0002Ue-Mg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573661563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCM5T8MVesOsDUn8bKfjoi2YKMbOHD6Myk5oZUDSVTM=;
 b=hbHBkyVXKumvr8AhshnBLI1RT1BDpYoW4ma3x1a+6LVdwphADqdII7Y6PS30DS6fyZy/7Y
 r4K71itB/lR0zPzQ+KXnsmFTysKRQ0QPqZya0sDYFhcsZm+IlLOvyl/gqaQWdJWY0bfy+S
 mN59mPtg6jIy7au+4w9QgIbaMzsLoao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-J_bJlwfvPrGyWX5Cm5Kdyg-1; Wed, 13 Nov 2019 11:12:40 -0500
Received: by mail-wm1-f72.google.com with SMTP id f21so1380968wmh.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/6lxEdzWQKxS1govTrLP+jIwfpqxXwBXEhqDjHvzyQQ=;
 b=IJxvscnEzK3X5tA/dP/olK47b4CUiB6y/oVLJExq9Hnia6jZlV7kZtBjHGCENqEnRa
 JVjeZtuHoIx6135Eb9nEesjzOa/H069f2hIgENVLTc8rVO6FkxqHMNU5cguuYkn8GG2W
 4SKeCHX+RleNNA6smXbY5rR4zp6sQfWDzu+6Ya86JVfJX81JEJ/CR6ZqEUYA4yrQ7wRA
 lGQt+EvB3Dp5w0GztbkEHj2iru1veqZHWS/5S+HZ7NTK25Oq3sBDIT7Cm47EtDQ8PiMe
 OWCRc683fsmZ336kcRfqBMRFuuQFChyIjxN1RWqLNnLbLzzlahHyyKh0SYaAufYQpp6l
 U3/Q==
X-Gm-Message-State: APjAAAX2VF9dw1AF75wAkjPgCksXOb1v/L2yU/Za+r1rgYi0Y1iiJobB
 tt5NKV6LPHDI6RgRNoOzmvSmQxz3kpl0KKR3gND7a9i4v2zT3sHYe+ydXW3UV2vbYSdJwqZQqJO
 CVVDJwYPizvuusb8=
X-Received: by 2002:a1c:a9c7:: with SMTP id s190mr2741472wme.92.1573661559025; 
 Wed, 13 Nov 2019 08:12:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZqh+bq62SUTZGlW0Fo/j6C79qJcgVMuKsTy03i44N/ZPej6/mf2kzmnJzRzCSxHVwD3EIgw==
X-Received: by 2002:a1c:a9c7:: with SMTP id s190mr2741452wme.92.1573661558835; 
 Wed, 13 Nov 2019 08:12:38 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id o5sm3227423wrx.15.2019.11.13.08.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:12:38 -0800 (PST)
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
To: Sam Eiderman <sameid@google.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ca6dadb1-fddf-5f6f-a6fc-f94eb02862b6@redhat.com>
Date: Wed, 13 Nov 2019 17:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: J_bJlwfvPrGyWX5Cm5Kdyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sam,

On 11/13/19 4:03 PM, Sam Eiderman wrote:
> Hi,
>=20
> Does this fix a bug that actually happened?
>=20
> I just noticed that in my lchs patches I assumed that lchs struct is
> zeroed out in all devices (not only ahci):
>=20
> 9caa19be0e53 (geometry: Apply LCHS values for boot devices)
>=20
> Seems like this is not the case but why only ahci is affected?
>=20
> The list of devices is at least:
>=20
>          * ata
>          * ahci
>          * scsi
>              * esp
>              * lsi
>              * megasas
>              * mpt
>              * pvscsi
>              * virtio
>          * virtio-blk
>=20
> As specified in the commit message.
>=20
> Also Gerd it seems that my lchs patches were not committed in the
> latest submitted version (v4)!!!
> The ABI of the fw config key is completely broken.

What do you mean? Can you be more specific?


