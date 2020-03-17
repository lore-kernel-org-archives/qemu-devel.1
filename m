Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F66CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C7E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axQ+soSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C7E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEQ5-0001yf-7t
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEEL5-0004Xd-St
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEEL1-0003FW-00
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:41:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEEL0-0003Dy-SP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584459662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNIvdCFkbhhWtvqMmqjJEG3FPAvakEkXe9qb9UW+Z4M=;
 b=axQ+soSUwomIBb3fwrdfD1IsZd/dQEeifXlUYUbUrZ9ctbBjBh2TLVXEmVh5/hTsoVYfzi
 zrs23yXMdUmcucBYrQ4bG5K1C+PEEVnYs2mCg8hRdbW1qdKfosmA9UjAGYbBZPMW/Xe0Xk
 TNbsyMTTcXtGUSP2WfsS1RcZgWlyGoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-kXc9CVHeOKCNKewtB0O_pg-1; Tue, 17 Mar 2020 11:41:00 -0400
X-MC-Unique: kXc9CVHeOKCNKewtB0O_pg-1
Received: by mail-wm1-f69.google.com with SMTP id 20so5899271wmk.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EKr3v9KEER1rDvaLZ1Ew27fVsL/dVowXe2qq2qvjiyE=;
 b=n1kwAyXvXIiDK3qyO7jcgQ42ao34jUFw4WIDRhsfy7m1JJmspYDv1CBvVSI/sxgku+
 TW97qfXD15AGySMaWYpgjUgwbQocaWAOF6Q5uB/u4Uo+xfWPzf9HNDZX9ijC1GsQd9PJ
 mTcagV6HoVOaITvnlaGJy/NqxGntKxoZrAy94lVX3Lax9qltYhmgUmyUtnx/Uqc0Bgxe
 9TxiKa5oeb3sDfZHAeV8NNbxdLlfFPs9AJbZvLPwbcmqHnTam2PSgixOxYb6/pk4QmNT
 nAt0gtu+y6K65DcokzLJogWDukUB3yVXP82WSkCwXmi+O8LldQxWjkYwvxYiaDuUDjqu
 aG8Q==
X-Gm-Message-State: ANhLgQ197w8AkPl5wM3Jg5bWGwkrpMPb7kMiRqrHfy0VykRvU2o7TpD6
 4hREDPrCI/2Trbjoona6xRgGEytOV1NChWtAiYXBUzHFIkhSXu9L03LEj0oyJcQK0NffrqK8Y05
 i3DLqZpdCGk5r+LU=
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr6411023wrw.383.1584459659232; 
 Tue, 17 Mar 2020 08:40:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvMqmkNwzyYr37cUwSf6nFs7oG+HmkKrMOZUQMyBzlXUn3C9WQrsZJNk5YrpRJ03ApyxSJMyQ==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr6411007wrw.383.1584459658918; 
 Tue, 17 Mar 2020 08:40:58 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
 by smtp.gmail.com with ESMTPSA id d21sm4854784wrb.51.2020.03.17.08.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:40:57 -0700 (PDT)
Subject: Re: [PATCH] softmmu: fix crash with invalid -M memory-backend=
To: Igor Mammedov <imammedo@redhat.com>
References: <20200309145155.168942-1-marcandre.lureau@redhat.com>
 <20200317161342.53ae8b98@office.mammed.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71d93e5c-7c77-4577-d31a-a112be822904@redhat.com>
Date: Tue, 17 Mar 2020 16:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317161342.53ae8b98@office.mammed.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/20 16:13, Igor Mammedov wrote:
> On Mon,  9 Mar 2020 15:51:55 +0100
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
>> Fixes: fe64d06afc1c5d895f220c268cfe4d5f1e65d44e ("vl.c: ensure that
>> ram_size matches size of machine.memory-backend")
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Paolo,
>=20
> Can you pick up this patch for your pull req?=20

I've done it already, but I can send more.

Paolo

>> ---
>>  softmmu/vl.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 5549f4b619..38e9c404f2 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -4287,6 +4287,11 @@ void qemu_init(int argc, char **argv, char **envp=
)
>> =20
>>          backend =3D object_resolve_path_type(current_machine->ram_memde=
v_id,
>>                                             TYPE_MEMORY_BACKEND, NULL);
>> +        if (!backend) {
>> +            error_report("Memory backend '%s' not found",
>> +                         current_machine->ram_memdev_id);
>> +            exit(EXIT_FAILURE);
>> +        }
>>          backend_size =3D object_property_get_uint(backend, "size",  &er=
ror_abort);
>>          if (have_custom_ram_size && backend_size !=3D ram_size) {
>>                  error_report("Size specified by -m option must match si=
ze of "
>=20


