Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F452C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F5B20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOpbGz+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F5B20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIln-0006AP-UP
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJIk3-0003PO-S7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJIk3-0000Rz-0F
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJIk2-0000RO-S6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=369J1UXoJF3a7bjFJOWp93ZqaJFMh6PY6DnisP3F0IY=;
 b=NOpbGz+2sNsTcdJB8xJxly1ObOY7WK6aQ2zZn00h2+sPzCdJTvUQz6oMqZxrX5dspSwslj
 iX+QQQ/iGgXl+13rbTNdRiAfI0FQU23GGzaURi4ZtOUgx3Q8JDKM7CwgUjiuvKJ2MUjJeR
 XF+dbUhmxGULNh2SzSqYD5BZkvRTrF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-4FomtiiqO1-vO2m1xblbIA-1; Tue, 31 Mar 2020 11:23:48 -0400
X-MC-Unique: 4FomtiiqO1-vO2m1xblbIA-1
Received: by mail-wm1-f71.google.com with SMTP id f9so829383wme.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M61tZc1fBjEbffVvMcZZtGhS2S/zfDSMILKJt9cHfwA=;
 b=ZdQGnZ/TZE4rU86tef8H0kKGdgHa78ksmMhCRW5nvQsozTOowIkvZUZSua9Tns2Ysp
 bfEUkS/t3b2HckEgUYPoCfJCpiwoWT/nqlnw5jzOw8SRu3UabeFGL1IqNhJEHXUd9mj1
 24BDz9KJFDhGbKQ53SYMFfltpQjxzvHofTPyhXif8KmdNjgegovMbzqUGziPb9lmQnMN
 Bw9pAQ5CfqGdhhN+vbE+XRzwfnoJmkz2l4mmfyLLSpn36Fd9WiAX6l+crBF9EsyAC+Rk
 veLV37J6qrFY+gYqJIyXmJkuz82xoLq4NZHQejnE/L7Hu0k0RmAZBtdAstw76xQotwf4
 gMsA==
X-Gm-Message-State: ANhLgQ2P6rImsFN61/61Ikkcm3e0JXgzc3uVAiQEQ2aiAvds94KhBML6
 r3ATHzq/32D7UM01HMjP8vHT4TyHUOXL0+MXsWmeqzx8adeJnQOqNkKepZ9FFa2Ivk3Ky61/D+q
 Smy76scNqyXEb/tQ=
X-Received: by 2002:adf:9384:: with SMTP id 4mr20765023wrp.214.1585668227398; 
 Tue, 31 Mar 2020 08:23:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2/JWCGMnYm+FKxJLXFNNqn7AshlaXMNexUtsK29gOLPUvd6bzGe+JtY0xMQBEQ7nqcrcuUw==
X-Received: by 2002:adf:9384:: with SMTP id 4mr20765005wrp.214.1585668227177; 
 Tue, 31 Mar 2020 08:23:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id y189sm4402922wmb.26.2020.03.31.08.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:23:46 -0700 (PDT)
Subject: Re: [PATCH] serial: Fix double migration data
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200330164712.198282-1-dgilbert@redhat.com>
 <CAJ+F1CKd9x3BQKCGFPF8ouW4Fzvw0R5z3ZRT_0XPNSepP5hMZQ@mail.gmail.com>
 <20200330174116.GC2843@work-vm>
 <CAJ+F1CJzdso1xNj+XyiriByHzYekz74+JRCCQ4a6ygWLrCGMvA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b30270b-207f-4b5d-bc4c-323827868f60@redhat.com>
Date: Tue, 31 Mar 2020 17:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJzdso1xNj+XyiriByHzYekz74+JRCCQ4a6ygWLrCGMvA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/03/20 19:56, Marc-Andr=C3=A9 Lureau wrote:
>>> Why do you make it a sub-state?
>> Because it's consistent with serial-isa and it's simple.
> ok, lgtm then
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Queued, thanks.

Paolo


