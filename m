Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC5C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A795E20732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUQFecLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A795E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVXTc-0006sa-JF
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 04:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iVXSH-0005kt-KU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iVXSE-0007i3-Qn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:59:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54401
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iVXSD-0007dN-1u
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573808383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLUb0zNbebYnbqgm5xC8kICvQAF+NIpa2TBsPCz7rGM=;
 b=KUQFecLbv7INGw6ve4L1GrGmZCXWGoU8Oxf/tPQZkWRcWjdvC9gzTwVQsZoE4aKw24lc/u
 xjn6E829J4nOb4wbUma72skgxANKAAllITmsX2awueSgq5yBR2OP7Azsoi7fqE4jKdg3ib
 IpNv5AuDeygrxwcOgGIq0C0s5upOEHM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-1Dl33t1INAqu2O8H7fBTQw-1; Fri, 15 Nov 2019 03:59:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id v6so7213187wrm.18
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 00:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EAoMrOycLPsICECqXY+/i1ufSVcPIgS3UrLbF1mf3U8=;
 b=c0BjC2lyoAa0qlhJFtwXXH/v0JEf6mZyYyAcdU0TgcayFB/jkON+e5h7sIIpG6r+1W
 rH1904KGryry805y/7IewSbnmmXA+smWC6jLDkDZcfWWLyQQ2b5kRZYLOzSajDWMMtfl
 tTP5bfW2cM52rzqmsrBNs9rg5/4QKTj1mfmQtzbp33ZCrKkKUF3+oMJ2zpFsWsUG+PZs
 p9SFsgz++19SgVr6fZOZ/46yamiuPCsarAn+gg1v375GE+xBZXx/wNiFFl5In7fYQuIC
 To/7q6jfgdcxevTFnsjRTBc8uwg1TuE8CiLiVVhYVxCQSO5cx/jFQ5hb/IRqIUiq0do2
 C/WA==
X-Gm-Message-State: APjAAAUmrtfcLSSX96MA7MAZdWSj9t202DD/xs0Ae9H67PpZepINYgn1
 XVfbZ75z76LF/g26ejsIWtmDWSc+PJLScNG4pvpb4D9IGlkLlcyaP2dJdn+wwjtyNHDGUD8eDow
 zQFDf481Fj58/kJE=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr14091423wmi.67.1573808380950; 
 Fri, 15 Nov 2019 00:59:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8VX76Nu5Xx4104nZXlXQZygsOdDf9FezlRY9UFFjxz3JcVyxh5D2mdGbqsQZsT0EQg2oxPA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr14091408wmi.67.1573808380668; 
 Fri, 15 Nov 2019 00:59:40 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
 by smtp.gmail.com with ESMTPSA id t5sm10268526wro.76.2019.11.15.00.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 00:59:40 -0800 (PST)
Date: Fri, 15 Nov 2019 09:59:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH] vfio: don't ignore return value of migrate_add_blocker
Message-ID: <20191115085938.evd2lyxvivxlxwvy@steredhat>
References: <20191114133449.11536-1-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114133449.11536-1-jfreimann@redhat.com>
X-MC-Unique: 1Dl33t1INAqu2O8H7fBTQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 02:34:49PM +0100, Jens Freimann wrote:
> When an error occurs in migrate_add_blocker() it sets a
> negative return value and uses error pointer we pass in.
> Instead of just looking at the error pointer check for a negative return
> value and avoid a coverity error because the return value is
> set but never used. This fixes CID 1407219.
>=20
> Fixes: f045a0104c8c ("vfio: unplug failover primary device before
>   migration")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


