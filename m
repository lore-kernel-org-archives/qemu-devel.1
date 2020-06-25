Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2C92076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gm4sPcOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2C92076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPTI-0003Tm-2Z
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1joPSd-0002xh-Td
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:50:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1joPSc-0000ES-Dy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593082225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OslMcnSl+PqC3MOFNyrLm9e8pRiMlnS0l2452fpCq/Q=;
 b=Gm4sPcObvTqg8QrYMRx7c1VJ9lIKE7E1eT6/xiNUSE7JatSBwTxIHG7hY7M/cBgySnuVUi
 ze7eogcawKMREMfuMafhFVhIIcRRfGrV8+3EO4Cpm3imsMMo2aAbHi9AGXun4iA9nJpIeS
 0qHwr6xX541nUNWi4sHmRGL0jVB2ZJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-FF8Lf261Nb2Hmnjyu5P4pg-1; Thu, 25 Jun 2020 06:50:24 -0400
X-MC-Unique: FF8Lf261Nb2Hmnjyu5P4pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2155964ADA;
 Thu, 25 Jun 2020 10:50:23 +0000 (UTC)
Received: from gondolin (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 424987932A;
 Thu, 25 Jun 2020 10:50:13 +0000 (UTC)
Date: Thu, 25 Jun 2020 12:50:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC 1/4] virtio: add vhost-user-fs-ccw device
Message-ID: <20200625125010.7b3480e5.cohuck@redhat.com>
In-Reply-To: <20200625100430.22407-2-mhartmay@linux.ibm.com>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200625100430.22407-2-mhartmay@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 12:04:27 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Wire up the CCW device for vhost-user-fs.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs       |  1 +
>  hw/s390x/vhost-user-fs-ccw.c | 74 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 hw/s390x/vhost-user-fs-ccw.c

(...)

> +static void vhost_user_fs_ccw_instance_init(Object *obj)
> +{
> +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(obj);

If it turns out to be a bug that pci is not forcing this to virtio-1,
you should add

    ccw_dev->force_revision_1 = true;

> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_FS);
> +}

(...)

LGTM.


