Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB0F2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv6aCNxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB0F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyFEP-0003Xe-PS
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyFDo-00035D-8P
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:55:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyFDl-0005JZ-P6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595426143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nFS4pbPO2QymDgUPC6O2Eiq04kMKhr0DyEGdhA9cEg=;
 b=Fv6aCNxsVW1gIfRTizhPR1JjfCOxzhQL8p2RTU6u4KnXvBldbklNptb5xS0CdT5NwBBQfv
 IsNUh8eBSXCRrHe5IgMwiUTbddxQBoMG37R9u0x3mDNubnBuAJz0jSWiDRW+sWV6bd+hzm
 FGI/RvcjXZSGg3oHcvGiw8DlIvj7kfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-FBu-ImrxOkyPj1-IbQXTDQ-1; Wed, 22 Jul 2020 09:55:42 -0400
X-MC-Unique: FBu-ImrxOkyPj1-IbQXTDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F2980047C;
 Wed, 22 Jul 2020 13:55:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A943578551;
 Wed, 22 Jul 2020 13:55:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 38B249D9F; Wed, 22 Jul 2020 15:55:38 +0200 (CEST)
Date: Wed, 22 Jul 2020 15:55:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: https booting
Message-ID: <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <20200722122347.GF2324845@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722122347.GF2324845@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ipxe-devel@lists.ipxe.org,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org,
 crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > How does edk2 handle the root ca problem?
> 
> There are two fw_cfg paths
> 
>   - etc/edk2/https/ciphers
>   - etc/edk2/https/cacerts
> 
> The first sets the cipher algorithms that are permitted and their
> priority, the second sets the CA certificate bundle.

Ok, ipxe should be able to fetch them.  Would be roughly the same as
compiling in the certificates, except that they don't take up space in
the rom and are much easier to update.

What is in cacerts?
Basically /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem of the host
machine?

thanks,
  Gerd


