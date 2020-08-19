Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CA8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0041A2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhWY2Fjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0041A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MjU-0004BC-9a
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8Mik-0003Dd-ML
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:57:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8Mih-0005Lp-4U
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597838249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2fQml7RkcfQbkrT5X+s+6N5y+feqLc/ptN1uVYDZTY=;
 b=NhWY2FjlBVYKT+j+MbrFFgF9yNVLXGsHVWEjapEHsJeSJH7RFDo1Q57+jnOrD/AjZFmbqh
 rLT8iApl5nQvEeB5GtjdzB0vCoE145QpHPQX/Xm0cOJy00hiP8h4Qt9RCgu7I3/Gj2lNgK
 aTJO6Km6JJ/Hb9wBme0BfFxmmTCY938=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-cL6-JV_CPE-65Eu2BvnuZA-1; Wed, 19 Aug 2020 07:57:27 -0400
X-MC-Unique: cL6-JV_CPE-65Eu2BvnuZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCD561DE06;
 Wed, 19 Aug 2020 11:57:25 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D92485C70C;
 Wed, 19 Aug 2020 11:57:14 +0000 (UTC)
Date: Wed, 19 Aug 2020 13:57:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 2/3] vhost-user-vsock-pci: force virtio version 1
Message-ID: <20200819135712.4297c1a4.cohuck@redhat.com>
In-Reply-To: <20200819105156.54163-3-sgarzare@redhat.com>
References: <20200819105156.54163-1-sgarzare@redhat.com>
 <20200819105156.54163-3-sgarzare@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 12:51:55 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> accidentally on") added a safety checks that requires to set
> 'disable-legacy=on' on vhost-user-vsock-pci device:
> 
>     $ ./qemu-system-x86_64 ... \
>     -chardev socket,id=char0,reconnect=0,path=/tmp/vhost4.socket \
>     -device vhost-user-vsock-pci,chardev=char0
>         qemu-system-x86_64: -device vhost-user-vsock-pci,chardev=char0:
>         device is modern-only, use disable-legacy=on
> 
> virtio-vsock was introduced after the release of VIRTIO 1.0
> specifications, so it should be 'modern-only'.
> 
> This patch forces virtio version 1 and remove 'transitional_name'
> properties, as done for vhost-vsock-pci, removing the need to specify
> 'disable-legacy=on' on vhost-user-vsock-pci device.
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/virtio/vhost-user-vsock-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same nits for the patch description as for patch 1, otherwise

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


