Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB36020787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOqyYo8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB36020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaab9-0001Lg-1Q
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 03:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jaaab-0000w9-4u
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:53:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jaaaZ-0003m8-Q4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589788410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzrzeFsW1iYLqUo8C1br5D9Z1GhvJrK33QNMbSplb5s=;
 b=VOqyYo8ICi1yVD6h9zXAEJ7at2B0/Wymmksa9r5s18Z//rn1kDzz71H92B/XVuP456F85y
 RamW0dW3xwjDcLAaOqxCRRandJ/UAsIGcFlg6ubDeIfXwnHcPo5ZgnVjwkGG8GVShRAmcy
 Z16hn11iTOKvBqM4kdm0Plq3nShIixo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-IXldVLs5P3WwpuGjn9mSVg-1; Mon, 18 May 2020 03:53:28 -0400
X-MC-Unique: IXldVLs5P3WwpuGjn9mSVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB26464;
 Mon, 18 May 2020 07:53:27 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35E4A46;
 Mon, 18 May 2020 07:53:24 +0000 (UTC)
Date: Mon, 18 May 2020 09:53:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 0/3] s390x: improve documentation
Message-ID: <20200518095322.50bd5849.cohuck@redhat.com>
In-Reply-To: <20200515151518.83950-1-cohuck@redhat.com>
References: <20200515151518.83950-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 17:15:15 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The documentation for the s390x system emulation target still has quite
> a bit of room for improvement, so I started adding some device documentation.
> 
> v1->v2:
> - css.rst: added example for cssid == 0 (Thomas)
> - css.rst: mention what the properties look like (Thomas)
> - css.rst: it's "channel subsystem image" (me)
> - 3270.rst: make introduction less confusing (Thomas)
> - 3270.rst: fix device name (Thomas)
> - 3270.rst: use unprivileged port (Thomas)
> - vfio-ccw.rst: add mdevctl example (Thomas)
> - vfio-ccw.rst: formatting tweaks (Thomas)
> 
> Cornelia Huck (3):
>   docs/s390x: document the virtual css
>   docs/s390x: document 3270
>   docs/s390x: document vfio-ccw
> 
>  docs/system/s390x/3270.rst     | 32 +++++++++++++
>  docs/system/s390x/css.rst      | 86 ++++++++++++++++++++++++++++++++++
>  docs/system/s390x/vfio-ccw.rst | 72 ++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst   |  3 ++
>  4 files changed, 193 insertions(+)
>  create mode 100644 docs/system/s390x/3270.rst
>  create mode 100644 docs/system/s390x/css.rst
>  create mode 100644 docs/system/s390x/vfio-ccw.rst
> 

Queued patches 1/2, will send an update to patch 3.


