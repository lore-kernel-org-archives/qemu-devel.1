Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A29C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 03:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C9420718
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 03:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo4Q4BEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C9420718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ4lF-0006o9-OE
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 22:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iZ4kQ-0006Ne-60
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 22:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iZ4kN-0006OM-L2
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 22:09:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iZ4kN-0006Nq-5K
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 22:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574651345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqhDz0NPstlSqfLlZAplPG4XAdB6YpmXBDy67QYyD88=;
 b=Lo4Q4BEYralfFob8O14bpn1vXXY2M1L8ntvUQHnK9UHPf0XcZeGw6MucpIw8k24qIvuBaZ
 Hy/L9vRqXVT1Gh2EfTMiJbILojSqENMN8NhGg/FmlYoYevTJEIOMg+o81dTmkwy25CSayr
 9Nnc7SVFnI7pG8f7g1tSfx6+cpYCDFA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-xryF0RMBOfCgDlHf-d--Ng-1; Sun, 24 Nov 2019 22:09:02 -0500
Received: by mail-qv1-f71.google.com with SMTP id e11so4278830qvv.18
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 19:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JIrzYAZXJlr2LN19j2k8f4Yyim21hu12CwqKLSMwGe8=;
 b=cvrqeKhapsRPi8k7rjhFTmeOXe7UYwITsAf6thQRq5VwH765A0gIfQNKvCGfh1Ob+S
 45T7LCMMhkSWHmziw9TgfmfbwSGblw1OU2qn74vWEyfMZtyBI9qHVniZQsCcyuTUIj2n
 6l/2+mepaFCgO8Bv3PDm2O7s58Hvkm+PEkz05PbeiP8WhqN+T08A4HIXBczZnPh8oxxQ
 c2Li5N81suK1esvX+03pLj8GY9pwbuew8lAjt6RSFaL2jNRqxaCY6qfB6vZSCmorHQu4
 0dKN0U4+a1rE7Vh2P9wmsAt8oEUmWl2C/mhsiDaV4FYsSjJg8rzVJ5qi3DvFxSspKLB1
 bd1Q==
X-Gm-Message-State: APjAAAVK6AZy24aQS9FdFC/2270H3hHlHmQ1eCHsErj8SpNJ5EtqCdtf
 xu2ijFDN6lY8SG2LqQD8ouQBuNjB91DK0jiL7JbuK9A26Mvjlt4TJvGg3OfFdGC95F7lz3Spgiz
 vmN0067yHMvtPOn8=
X-Received: by 2002:a37:9d0:: with SMTP id 199mr24456239qkj.356.1574651341970; 
 Sun, 24 Nov 2019 19:09:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdKvIY5dPs1RNnNv4iOIry/1oaxXHutt31A51yK90qrr2qsnntqQBi0rzlvKV7cFchIfCzHg==
X-Received: by 2002:a37:9d0:: with SMTP id 199mr24456222qkj.356.1574651341665; 
 Sun, 24 Nov 2019 19:09:01 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
 by smtp.gmail.com with ESMTPSA id g11sm2672324qkm.82.2019.11.24.19.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2019 19:09:00 -0800 (PST)
Date: Sun, 24 Nov 2019 22:08:59 -0500
From: Peter Xu <peterx@redhat.com>
To: yadong.qi@intel.com
Subject: Re: [PATCH v3 0/2] Refine Second-Level Paging Entries reserved
 fields checking
Message-ID: <20191125030859.GE30539@xz-x1>
References: <20191125003321.5669-1-yadong.qi@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191125003321.5669-1-yadong.qi@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: xryF0RMBOfCgDlHf-d--Ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 08:33:19AM +0800, yadong.qi@intel.com wrote:
> From: "Qi, Yadong" <yadong.qi@intel.com>
>=20
> The following patches are to refine/fix issues of reserved fields checkin=
g logic
> of Second-Level Paging Entries of VT-d:
> - split the resevred fields arrays into two ones,
> - large page only effect for L2(2M) and L3(1G), so remove
>   checking of L1 and L4 for large page,
> - when dt is supported, TM filed should not be Reserved(0).
>=20
> Changes in v3:
> - large page only effect for L2(2M) and L3(1G), so remove
>   checking of L1 and L4 for large page

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu


