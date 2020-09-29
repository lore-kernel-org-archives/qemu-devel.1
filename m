Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA8C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313362075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUG6REvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313362075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAab-0000k5-2h
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNA3P-000394-5K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNA3N-0002pg-ET
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:28:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEK8I/FGG3j53B+4b6RsOT7X9rvIJgBnm8LqJyACgd8=;
 b=gUG6REvbhGKHh3EbL4H4Hwywpp2+9Tv3e7UwYiU1AFmNCt6ObJWLFSmdLEJF0zpuTX10vX
 T7cE4JedkajTr7ikfoq88j96VEaKkU4hCIpvLtO97QRGdXxWtZFiqZbyvr2a4ogoLyVL3T
 ypwPPvy5EYi8gRrDVGdhJIJjHsny2eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-q5ReYIHIMZWWCgnLmzWyXg-1; Tue, 29 Sep 2020 03:27:58 -0400
X-MC-Unique: q5ReYIHIMZWWCgnLmzWyXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F155B1084D64;
 Tue, 29 Sep 2020 07:27:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A21F3782;
 Tue, 29 Sep 2020 07:27:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F28B1750A; Tue, 29 Sep 2020 09:27:50 +0200 (CEST)
Date: Tue, 29 Sep 2020 09:27:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH v3 0/6] Add physical display dimensions to spice/virtio-gpu
Message-ID: <20200929072750.uvddsvf325hkvpb7@sirius.home.kraxel.org>
References: <20200927145751.365446-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200927145751.365446-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 06:57:45PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> This series improves the support for HiDPI displays with Spice.
> The related spice series have already been merged.
> 
> v3:
>  - simplify the handling of Spice monitor configuration (Frediano)
> v2:
>  - add a patch to "spice: remove the single monitor config logic" (Gerd)

Series queued up now.

thanks,
  Gerd


