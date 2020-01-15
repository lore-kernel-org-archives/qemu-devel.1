Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C10C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAA62077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKhRubuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmeC-0003RI-3k
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irmd6-00024X-TS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irmd3-00064s-16
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:38:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irmd2-00064P-Tj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579109932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/RGcWBoi1JbDjYunVRER2KEmScGvcPPldJl4TiWFPo=;
 b=WKhRubuqbfrca3UTvch83N/w8XeTrdib4EAFvgWkYfPmtOamI0DR24MJr+DhplTsGNdTuU
 NYKxZ6v7M0XsUX8D2zwOxfFyHk+M9bAR7E/FPid0+AAfXHOhAi53G8uiz1yhJP2bZPEdAa
 +pvn/aOFRqliXhWEJfY4YBjHKhG6C4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-BfSHljurPF-vHLLuev_42w-1; Wed, 15 Jan 2020 12:38:47 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so8287345wrw.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 09:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Amz9A7+8VbgC5K8Y2TqU215DmfbdreP2ZgRc57/eLc=;
 b=WYSlbnKAUdUWbv0d1BtSimhNWZTAfC7EdVlHjRYCkn0VB+VqtrMxizL/Y+J7SlP6Mo
 tFi1CKRDIFoEE+qkpQ28sjyqeYmvI2aJ2+uwCkst9OIowSwbO5CyG+Y7fabs2ca8Ugl2
 1qC+E5toLxkMDuoABmHicKTUW6EdWXzjHK0oMT5j069QD9GMAAj5Eck1FLKgpqpo9nR+
 l4yWX/q49IMWKA8IIZwgEf2nsdglh5WnjU0tUr0z0AlAD/TnouN/3u3xCWTtqx0p0SdB
 yGxbBKcLs5E3z/umtywCKCCA7R5YVpIMiaAasR6L5wWtJgzAXZId80ko4CP2MZUAiX3Y
 CDoQ==
X-Gm-Message-State: APjAAAU9RIkDKIzGE4yHUcmRT01Xps5vTXtYHIGu7Tx3af97PUBtnkMj
 giEU3X3hDt5CXTzvMYiCQx6VbT/Yh19ylIWCDiacKnAF1JjlMmouhdAlJpRjtGY3pthz1R9wTc+
 LD+1umAkPmNKObOU=
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr30898719wrv.368.1579109925798; 
 Wed, 15 Jan 2020 09:38:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOp0BIrAf3X5qLsshkwsSNwQAvG3k0SvyG8hF8o0ZHCSrjmLO02Ha+7XmByknN5k5VQdkOlA==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr30898698wrv.368.1579109925566; 
 Wed, 15 Jan 2020 09:38:45 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id x6sm654523wmi.44.2020.01.15.09.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 09:38:45 -0800 (PST)
Subject: Re: [PATCH 001/104] virtiofsd: Pull in upstream headers
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-2-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8602dfb-7b07-b1ce-75e1-ea41c983d40e@redhat.com>
Date: Wed, 15 Jan 2020 18:38:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-2-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: BfSHljurPF-vHLLuev_42w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:37 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Pull in headers fromlibfuse's upstream fuse-3.8.0

So diffing vs https://github.com/libfuse/libfuse/tree/fuse-3.8.0.

>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/fuse.h                | 1275 +++++++++++++++

include/fuse.h, OK

>   tools/virtiofsd/fuse_common.h         |  823 ++++++++++

include/fuse_common.h, OK

>   tools/virtiofsd/fuse_i.h              |  139 ++

lib/fuse_i.h, OK

>   tools/virtiofsd/fuse_log.h            |   82 +

include/fuse_log.h, OK

>   tools/virtiofsd/fuse_lowlevel.h       | 2089 +++++++++++++++++++++++++

include/fuse_lowlevel.h, OK

>   tools/virtiofsd/fuse_misc.h           |   59 +

lib/fuse_misc.h, OK

>   tools/virtiofsd/fuse_opt.h            |  271 ++++

include/fuse_opt.h, OK

>   tools/virtiofsd/passthrough_helpers.h |   76 +

example/passthrough_helpers.h, OK

>   8 files changed, 4814 insertions(+)
>   create mode 100644 tools/virtiofsd/fuse.h
>   create mode 100644 tools/virtiofsd/fuse_common.h
>   create mode 100644 tools/virtiofsd/fuse_i.h
>   create mode 100644 tools/virtiofsd/fuse_log.h
>   create mode 100644 tools/virtiofsd/fuse_lowlevel.h
>   create mode 100644 tools/virtiofsd/fuse_misc.h
>   create mode 100644 tools/virtiofsd/fuse_opt.h
>   create mode 100644 tools/virtiofsd/passthrough_helpers.h

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


