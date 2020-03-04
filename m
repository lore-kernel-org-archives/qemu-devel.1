Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C73C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF61C215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh7Eo2T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF61C215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9WCY-0000Kc-S5
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W9n-0005Ua-2b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W9m-00065w-0I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:41:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W9l-00064l-SZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faBOvIyuYD4kOjDqnf5vnV+OAJpUxg4KO9Xy2+uCAnA=;
 b=Gh7Eo2T5BkW2OYet8pc8EHwcoovkCYIXscCY6LATyEufVBAvT6oSlx2tg8lpFeLwI1HXOM
 UK26iEDdhLcFOxmgVDefGJ+L01lIrEcZxH1sfTTLVx/MPJEqiuwtX4TDGc8+T7tVjDigHo
 Y81t7K9wDv9zPu+NF0+GrJWi8I69PN0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Lxbv_wbFMsqzcobX_Y6f1w-1; Wed, 04 Mar 2020 10:41:52 -0500
X-MC-Unique: Lxbv_wbFMsqzcobX_Y6f1w-1
Received: by mail-ed1-f71.google.com with SMTP id u12so1889673edb.20
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EK9w5zFORySIK7tms+65QsHl8EPjhuzaESYQp3A9+Ug=;
 b=MV2ZsALZVsl/ztXquz+douBKkWeupfVq4/HD89s7jXnIrk3dE2s3PH1nkDDHquFobZ
 oXPp97+9WMSKFhvuwYDiraD1WsrjFDtdeHIKqjC9J5C7uLUfypdNKdwB6iOSbEsjo71B
 rEguAkaqSyrYGcV100Olfj8B3E1q5P8z9cxHwA8DLTNxw8XqEuKPhueoOf89EtOf5jL7
 PDS0WT5kfmZBMNcJVO5qaoxlSKoO5gi9pTilWyTpjid4ziIdoLs7fTUA5NWCJx3XMnLk
 roqXcFqb0p504ZLf89Z5oqNFGaAR1KK9Q91xoiHzDSw2bT30EW0KmQV2iV0syF4PQv3J
 sLFw==
X-Gm-Message-State: ANhLgQ2fKU5ODDHo/LBFinOYuYpPlHDjX7OI7Tz66sKL37SWPGa04r8q
 y1grFA1VPam0xx+Uxjj6+qvbL9aOftqvZ1eY1oeJZlidBGzfbceID0azpWex8Or0Se8zNZL7zS2
 KBHy+CvVyTycd84o=
X-Received: by 2002:a17:906:728e:: with SMTP id
 b14mr3098531ejl.162.1583336511317; 
 Wed, 04 Mar 2020 07:41:51 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuvNqZBvKZviqVGhkjwR3C7yysrXEc3poRbRBpJyXrroYSY0k24TiVBfWX+BunEur1rJ1TLOQ==
X-Received: by 2002:a17:906:728e:: with SMTP id
 b14mr3098513ejl.162.1583336511082; 
 Wed, 04 Mar 2020 07:41:51 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r14sm864460eds.70.2020.03.04.07.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 07:41:50 -0800 (PST)
Subject: Re: [PATCH v2] Fixed integer overflow in e1000e
To: andrew@daynix.com, dmitry.fleytman@gmail.com
References: <20200304142058.52458-1-andrew@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <badcfed3-94e4-b411-667d-616d790b28b3@redhat.com>
Date: Wed, 4 Mar 2020 16:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304142058.52458-1-andrew@daynix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 3:20 PM, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
>=20
> Fixes: 6f3fbe4ed06
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
> Fixed setting max_queue_num if there are no peers in NICConf. qemu_new_ni=
c() creates NICState with 1 NetClientState(index 0) without peers, set max_=
queue_num to 0 - It prevents undefined behavior and possible crashes, espec=
ially during pcie hotplug.

Hoping the maintainer taking this can reformat the commit description a=20
bit nicer... (moving the tags down), then for the code part:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index a91dbdca3c..f2cc1552c5 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_d=
ev, uint8_t *macaddr)
>       s->nic =3D qemu_new_nic(&net_e1000e_info, &s->conf,
>           object_get_typename(OBJECT(s)), dev->id, s);
>  =20
> -    s->core.max_queue_num =3D s->conf.peers.queues - 1;
> +    s->core.max_queue_num =3D s->conf.peers.queues ? s->conf.peers.queue=
s - 1 : 0;
>  =20
>       trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
>       memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac=
));
>=20


