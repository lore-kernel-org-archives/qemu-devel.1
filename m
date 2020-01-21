Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79479C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4421F21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmiPJW1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4421F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwsu-0000Xm-O4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 12:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itwqq-0006hl-KF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itwqm-0004FA-1k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:58:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itwql-0004ED-UN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axxASofLYZYqqQFr5c8j1BAwDDyECpmqfOsAqwQITp8=;
 b=GmiPJW1xqihB0A4c/UipYiq8ldxE031Zju1bCe7oHyKl9/+U6EYIwC/1H5Uum98pH/JMdL
 FJe9kHTbuNhQyngDS25C4jD5p+/Sv2AANNjpimK8e3s1vHKBoxchpcDmkbP6vuB41XUm1r
 Nbg2h/DhK74T01PBrENQLLuedy2JmYU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-22qQY-QZPSWZW2IKpCBCPw-1; Tue, 21 Jan 2020 11:57:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so1610611wrx.22
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AWkuofPtgAAVLOxujRUkLLONoKFMYK44F6wR34FraLY=;
 b=MSympFPDNZ+H/dbFWf6HAeAO1++5/S1hzXBXYzMqVGlHRRcz9W8A4/ObA/kzF4Axvt
 P9uI2qzOwTHMY9CAxrZjdEBb/128j6FiQM7lGZizt2PE3yGPbm/v8I2IY/Th+9entOht
 2iCNxkymFMFHGuebY9J687M4dsxCIU4oUlWshjSHB9vXrO7RDiec7OU+5JOB4sN/1Kho
 BWizv91zI1U0VkZoQ3MUrj+uw0JbzIhzmesxpicw0906D4okMzQWaHKIc8XnGuiSTVCC
 PvSJp6Y5ICJHrJi/FR70lfUsrdzDZuQGAKgZbfI2RzaRv7XM45/2KaZ7cCseVZODQtB3
 s2Ww==
X-Gm-Message-State: APjAAAXDBozMS+ucZAEVmSgY1EuVwYlIrB00T5D5squXNxhOKxVyWIQ4
 hyeqKz4yv4gM6coQNL0tAeDBEz2rOmCjgZ1s/Q1aidQJXEwZR4/UNtbKBjryRKAd41KWf/zJ+J0
 k/4mdCdI+BxXTYjI=
X-Received: by 2002:adf:fe43:: with SMTP id m3mr6431956wrs.213.1579625874480; 
 Tue, 21 Jan 2020 08:57:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqygMzF9AN+BbXadMW9fc2q7WbpBO34rafRwA227XKd22n3/UB+b4x7GJmqOVOfYWNxxjhDA2A==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr6431933wrs.213.1579625874160; 
 Tue, 21 Jan 2020 08:57:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id l18sm4668626wme.30.2020.01.21.08.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 08:57:53 -0800 (PST)
Subject: Re: [PATCH 00/26] Various qom & qdev enhancements
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLH_G1diJvm+xcb28Gsy_YizEncuHsX3HTC2y_y2CFd1A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7bf504d-6625-a884-772c-5318dd40a144@redhat.com>
Date: Tue, 21 Jan 2020 17:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLH_G1diJvm+xcb28Gsy_YizEncuHsX3HTC2y_y2CFd1A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 22qQY-QZPSWZW2IKpCBCPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/20 16:38, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
>=20
> Something went wrong with git-publish & "git branch
> --edit-description" interaction (which I started to play with - I
> think git-publish should make use of it). It seems it got the mail
> summary from git-publish and content from git description, fun :)
>=20
> On Fri, Jan 10, 2020 at 7:31 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> aa bpkwef
> That should read instead:
>=20
> The following series has some qom/qdev cleanups, moves qdev instance
> properties to class properites, and return the default values in help
> and QMP commands.

Queued, thanks.

Paolo


