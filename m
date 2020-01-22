Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB0224673
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWVh3aO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB0224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuH6A-0001EK-U2
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuH5V-0000mx-UX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuH5R-0007RW-5I
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:34:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuH5R-0007RA-1d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579703668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bd8QWgIYcYgKFL9W9/El0IMI5RBLcZQ9bnBFKpmfxGI=;
 b=HWVh3aO8PPanqI964vhDac8/vIcgzEL4cmErlrW4NegW+yci/Oyop+ejsusp8mIL6HRL+a
 AjJoBFsDGfEA9fIcZzBmVDMuk930mWm9rLeHY8B3faOyAby5FuSHM3P4DfGMWlvAhAYIct
 CN4QWCxCXQDWzKmqXJXagDdCKFFWW/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-8ONIo9GYPbS0hIyXXaSkVw-1; Wed, 22 Jan 2020 09:34:25 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so3140116wrt.15
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zSJ6O/m1YzmIYTNRxB0ABI6Sd+3yFsnMMw8Yr1rMGlQ=;
 b=cttdu6eZgxv536JoVol5EtKe+nViIkqI8hFbB+n5mHSeFBsC2QvQWGoIuD0aZE45YL
 M/iDnhAuDILtcrVod7cTbz8AHPL6+oXIAbGNcxt+rRhEh8JmR8zi0rXc3y2rr3vGSMcD
 iw88np2eLT/kUqRPWgSLAU498+JBtkFHYqW92OVyzl+cDP9NuBj+DPtxhrewhyy2c8QB
 misVWl9q/XRMS0a4dji82SjMrL6hQ2q8JGQxo57f9I9Zhoh5lTHUnmkLxRN6qyZ+VMz7
 +PA2kJkf3m4bT0zRaVu9I1DiVdbhL/IZyQjfkBXP0X4snRSTY56bx8HSzichlJ7O+1au
 Rq7w==
X-Gm-Message-State: APjAAAXPS1rilMdo9PP8vzZ9p2pVNy4Qr+d31VOoRdws/EIf7pKjlYWW
 D7jFQ9gwwHXrc0J5s70Bu+2dx9hicYPK8lzPrb3J45zg6BYQ1XZtezqCFyAhLAabU80ziIjFj1r
 A5tUXs4CLQf1n7iE=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr11333065wru.353.1579703663681; 
 Wed, 22 Jan 2020 06:34:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxlQMC2RIc/DCJ84/cyjYfgzgzI2Aw2DNkc2YsnlNEg7oCoLLuq+vKRxo8DtdOoc8m+1oQ0A==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr11333032wru.353.1579703663311; 
 Wed, 22 Jan 2020 06:34:23 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n3sm54117458wrs.8.2020.01.22.06.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:34:22 -0800 (PST)
Subject: Re: [PATCH v4 1/6] migration-test: Use g_free() instead of free()
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200122111517.33223-1-quintela@redhat.com>
 <20200122111517.33223-2-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed895ebb-4116-37c2-a29c-f6e761e9113f@redhat.com>
Date: Wed, 22 Jan 2020 15:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122111517.33223-2-quintela@redhat.com>
Content-Language: en-US
X-MC-Unique: 8ONIo9GYPbS0hIyXXaSkVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 12:15 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Fixes: b99784ef6c3
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/qtest/migration-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 26e2e77289..b6a74a05ce 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1291,7 +1291,7 @@ static void test_multifd_tcp(void)
>       wait_for_serial("dest_serial");
>       wait_for_migration_complete(from);
>       test_migrate_end(from, to, true);
> -    free(uri);
> +    g_free(uri);
>   }
>  =20
>   int main(int argc, char **argv)
>=20


