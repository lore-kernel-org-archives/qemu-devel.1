Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06076C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B8F2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPRbDLOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B8F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLRq-0006De-Vx
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnLPc-00051l-VP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:19:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnLPb-0008CJ-4B
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592828333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xlzNFcV/SC/V8GWQmhiDyIenL9TGM6jw+R2VWaLlSc=;
 b=VPRbDLORVKVGB4r+FLNGtwqJuV+3g1pzUXeH9y+owZZLi5lksnlat3jbvYOFj8V/MsnzR4
 hgL0pM1fvWx3GOrUPuLmgaXcmE57RObg4syndovqE4TLw75ELfutpcl6Us1SPFu7/VSJIC
 IRdYD9iubaQmiabQfxN0+WXgprC6GoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-KOhC8agaNKWz-wyQe9SxQQ-1; Mon, 22 Jun 2020 08:18:50 -0400
X-MC-Unique: KOhC8agaNKWz-wyQe9SxQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CDEB80572C;
 Mon, 22 Jun 2020 12:18:49 +0000 (UTC)
Received: from localhost (unknown [10.40.208.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C02E11002388;
 Mon, 22 Jun 2020 12:18:42 +0000 (UTC)
Date: Mon, 22 Jun 2020 14:18:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] hw/acpi: specify 64-bit acpi table
Message-ID: <20200622141838.2c858274@redhat.com>
In-Reply-To: <CAHmME9ruo0ZihXbtGdygAm48NBaXR0botmLyMxa+_YYPpHwghA@mail.gmail.com>
References: <20200616003654.1058035-1-Jason@zx2c4.com>
 <20200616101627.74dd1542@redhat.com>
 <CAHmME9ruo0ZihXbtGdygAm48NBaXR0botmLyMxa+_YYPpHwghA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kraxel@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 13:20:17 -0600
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> > > increment the revision to '2' so that these larger addresses are
> > > addressable. This matters because the DSDT revision represents the
> > > maximum capability of all other SSDTs. This is also what arm does.  
> > it was keept at 1 for compat reasons with WindowsXP.
> > by now it is long time EOL, so it might be fine to bump version,
> > but it would be nice to know if this change breaks XP or not?  
> 
> I just installed Windows XP twice, once without the patch and once
> with the patch. The command line I used for this was:
> 
> qemu-system-x86_64 -m 3G -cpu host -enable-kvm -M pc-1.0 -drive file=disk.qcow
> 2 -cdrom en_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso
> 
> Aside from the nostalgia being completely overwhelming, both installs
> were successful, and I was greeted with the terrific bliss.bmp
> background.
I'm not sure runnig test with pc-1.0 is valid, since ACPI tables generated by QEMU
happend around 1.7 time.
Can you retest with latest machine version "-M pc", please?


