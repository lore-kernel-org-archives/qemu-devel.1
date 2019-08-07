Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5979B21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5979B21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvM5t-0001aE-LX
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvM5R-00015q-FC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvM5K-0000kn-3H
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:34:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvM5J-0000kH-Se
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:34:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so91492957wrs.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OzNZ3TuBBaUSt7AFSANl7iXtLVFoQW+p9Wo9m/sc8zY=;
 b=lLZU76eAa8NgYpPv/oC/k6uDQo/Kd2XNMk4M9O7rwPFY0P4O87XLHDQ8J80L+iAUFV
 KLrcQotIFXTLVogDyQ9d94P5S+RtWdmdk5Izv0HR2vZMs40RTT8NsJZuUX2F1s8MwJKv
 Lsqf0nn7Z3XIvfbLnQHIIzmJJMcS14zBNyMi7UdN8Wt9LKupBd3O4yk2CLfMf/HxjoUQ
 MSpW/rjicF11vyT1/jHbBjqVRnOzpfQDmwnuSWiNHFqbXlz3E+5OsGyNuk2D5fxOjuSO
 2zswrzV8Y5KL0A4nmQ5AcJnel+OkKGyT+xY+qaspaM3hJLH//BvTEXk1NdMPk6hbzTGd
 JCPw==
X-Gm-Message-State: APjAAAUSasdAZ9yMvzEU0fRjBF9ZkiYfQM6wTKDh+nbdPOcbNEZGTbpZ
 AcCoLwv00vq1oBrC8ecDsCTJgA==
X-Google-Smtp-Source: APXvYqzKk1Q/uJbJXxiZd3Ewsgi01IBw/asJSVyKPc/8ov9CBCsfOLmPXfIz931UA4lVEistVVMg1A==
X-Received: by 2002:adf:aa85:: with SMTP id h5mr1577898wrc.329.1565184872809; 
 Wed, 07 Aug 2019 06:34:32 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id h8sm20067wmf.12.2019.08.07.06.34.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:34:32 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190807084048.4258-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <19e4a0b7-d21e-c243-202d-c1f6708cab1f@redhat.com>
Date: Wed, 7 Aug 2019 15:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807084048.4258-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on vmload
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 10:40 AM, Marc-André Lureau wrote:
> If interface_count is NO_INTERFACE_INFO, let's not access the arrays
> out-of-bounds.
> 
> ==994==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
> READ of size 1 at 0x625000243930 thread T0
>     #0 0x5642068086a7 in usbredir_check_bulk_receiving /home/elmarco/src/qemu/hw/usb/redirect.c:1503
>     #1 0x56420681301c in usbredir_post_load /home/elmarco/src/qemu/hw/usb/redirect.c:2154
>     #2 0x5642068a56c2 in vmstate_load_state /home/elmarco/src/qemu/migration/vmstate.c:168
>     #3 0x56420688e2ac in vmstate_load /home/elmarco/src/qemu/migration/savevm.c:829
>     #4 0x5642068980cb in qemu_loadvm_section_start_full /home/elmarco/src/qemu/migration/savevm.c:2211
>     #5 0x564206899645 in qemu_loadvm_state_main /home/elmarco/src/qemu/migration/savevm.c:2395
>     #6 0x5642068998cf in qemu_loadvm_state /home/elmarco/src/qemu/migration/savevm.c:2467
>     #7 0x56420685f3e9 in process_incoming_migration_co /home/elmarco/src/qemu/migration/migration.c:449
>     #8 0x564207106c47 in coroutine_trampoline /home/elmarco/src/qemu/util/coroutine-ucontext.c:115
>     #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/usb/redirect.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 998fc6e4b0..9764a57987 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1495,6 +1495,11 @@ static void usbredir_check_bulk_receiving(USBRedirDevice *dev)
>      for (i = EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
>          dev->endpoint[i].bulk_receiving_enabled = 0;
>      }
> +
> +    if (dev->interface_info.interface_count == NO_INTERFACE_INFO) {
> +        return;
> +    }
> +
>      for (i = 0; i < dev->interface_info.interface_count; i++) {
>          quirks = usb_get_quirks(dev->device_info.vendor_id,
>                                  dev->device_info.product_id,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

