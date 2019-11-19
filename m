Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D37C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C5C21850
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7F0ZLHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5C21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyGf-0003OQ-95
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWyG3-0002xK-48
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWyG0-0007V0-KV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:49:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWyG0-0007Ud-9c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574149743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=021bTqa66lBLzJldrNSWEda1K+Xrp3FNczvmZJCy6LA=;
 b=O7F0ZLHfawZ2cFK27wRIhz+KOpUkIuejkECNEVpnZOewZr3kPpP4/v4RpMuq/q/zgwcqw3
 asDZtTmj7eny/R6yAuNZ0K+DaSyPuawigN6O6ITZnwxNrCus0y4uA4V5YJX+KW9qVPkNVh
 3BGum2YLWuX6NZLq7JotPXC3A3Cj7bs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-X3RiPEdONgyGT_tDACu59Q-1; Tue, 19 Nov 2019 02:49:01 -0500
Received: by mail-wm1-f70.google.com with SMTP id m68so1972883wme.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M39AAyn0qYcnDmcJMitPC5UN2a8z5Hoazf53n49XPX0=;
 b=EH3Ryhf040wVw8ZTUvx1iIksP8NSqVCMLuKnYPu5O2Dx+DH8PLA7i0WSJZtRRPL9AI
 GqwoZjJfnWYiRovRIl1ixwhC9wu8wCkAdWxgEjqFQHhJ5I5P/alsEk03qkygDM2LcroK
 qZHzGwwkKpqNXTWXp8mbh6ilHJfxW5oF+FIZLoi/y5PkxIbaODAbDgiL1OUpWyusjjhQ
 W2dWRFGo8SFwfL57mXFTlILJxy+CsuHzKjkdR++gD8poE3f1Rh//rYLRqRT22xLZ+wZm
 +qMGFCFfLnwei6NarGGFmxILhJhdUVPEPQeherVFrN8k6kUNqpM3EorrdUL7dwuGrQQv
 J3dA==
X-Gm-Message-State: APjAAAVaBJCWSa85zWHvB077NGAA8oe6+mtRWJU77gjjr0qeiaTr049g
 zONHcYw65s7Ln1FjvQavffhHksKPHDLm+nIFD0vujvNvq0lyMBNBDOtXGM41NmFJVoSxTO+HIaJ
 uWBMYfnM+NO5puZY=
X-Received: by 2002:a5d:5742:: with SMTP id q2mr24976386wrw.311.1574149740742; 
 Mon, 18 Nov 2019 23:49:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqX5x2YtXTM4c989S+IFAGa5qe8h1S+xFgGEHNobJHNNMIhAxnI1nzinAnvWerKXSa8D4ZMA==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr24976371wrw.311.1574149740497; 
 Mon, 18 Nov 2019 23:49:00 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id f67sm2196238wme.16.2019.11.18.23.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 23:48:59 -0800 (PST)
Subject: Re: [PATCH v4] Implement backend program convention command for
 vhost-user-blk
To: Micky Yun Chan <chanmickyyun@gmail.com>, qemu-devel@nongnu.org
References: <20191119022640.11021-1-michan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a4cfd68-5f15-b25b-fab6-c384153a9ab0@redhat.com>
Date: Tue, 19 Nov 2019 08:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119022640.11021-1-michan@redhat.com>
Content-Language: en-US
X-MC-Unique: X3RiPEdONgyGT_tDACu59Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: michan <michan@redhat.com>, stefanha@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Micky,

On 11/19/19 3:26 AM, Micky Yun Chan wrote:
> From: michan <michan@redhat.com>

It seems your git setup lacks your username.

This should solve it (eventually running with --global):

   git config user.name "Micky Yun Chan"

> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst
> For vhost-user-* program
>=20
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> ---
>   contrib/vhost-user-blk/vhost-user-blk.c | 109 ++++++++++++++----------
>   1 file changed, 65 insertions(+), 44 deletions(-)
[...]


