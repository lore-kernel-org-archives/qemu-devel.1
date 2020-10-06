Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363CC4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDBB206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hwn+tiX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDBB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPozh-0004AS-Vu
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kPoy4-00037Z-5X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kPoxz-0006eQ-9D
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++6yuXWN6ko8ZpTeK17UHXTRv31hemak3S9rYqylvYU=;
 b=Hwn+tiX6MO/MEp2p2U85r1nNtNYKittuWj4gUPfQmBywJ3hY6ROUa/U2acLUhowbcl/S/p
 Od6gZdkN19VYNCukCoVOxbw8WYTDvhI9Mxq3breVuhrLYk2dxda7bsjCqlvcyT9kXKvHWM
 /CVbJhgbP6Bdjh5zY8MGoFqbpW5riWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-4tpQelb_PoKxPEpOL_SIQQ-1; Tue, 06 Oct 2020 11:33:22 -0400
X-MC-Unique: 4tpQelb_PoKxPEpOL_SIQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641B587952A;
 Tue,  6 Oct 2020 15:33:20 +0000 (UTC)
Received: from gondolin (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40E685C1C4;
 Tue,  6 Oct 2020 15:33:02 +0000 (UTC)
Date: Tue, 6 Oct 2020 17:32:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] s390x/pci: Move header files to include/hw/s390x
Message-ID: <20201006173259.1ec36597.cohuck@redhat.com>
In-Reply-To: <1601669191-6731-2-git-send-email-mjrosato@linux.ibm.com>
References: <1601669191-6731-1-git-send-email-mjrosato@linux.ibm.com>
 <1601669191-6731-2-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  2 Oct 2020 16:06:23 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Seems a more appropriate location for them.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c          |   4 +-
>  hw/s390x/s390-pci-bus.h          | 372 ---------------------------------------
>  hw/s390x/s390-pci-inst.c         |   4 +-
>  hw/s390x/s390-pci-inst.h         | 312 --------------------------------
>  hw/s390x/s390-virtio-ccw.c       |   2 +-
>  include/hw/s390x/s390-pci-bus.h  | 372 +++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390-pci-inst.h | 312 ++++++++++++++++++++++++++++++++
>  7 files changed, 689 insertions(+), 689 deletions(-)
>  delete mode 100644 hw/s390x/s390-pci-bus.h
>  delete mode 100644 hw/s390x/s390-pci-inst.h
>  create mode 100644 include/hw/s390x/s390-pci-bus.h
>  create mode 100644 include/hw/s390x/s390-pci-inst.h

Looks good, but...

<meta>Is there any way to coax out a more reviewable version of this
via git mv?</meta>


