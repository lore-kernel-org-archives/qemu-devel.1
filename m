Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A76DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F02206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWJxuptC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F02206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54u5-0001xy-F9
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k54tP-0001P8-7Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:18:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k54tL-0008Uo-SV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597054733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNpd4Ppf/S+A61p3gn336tjMJJHggACBCURT+G/026M=;
 b=bWJxuptCSGvDWi2jIzkvlftM58QLLpsnRbTYqB0XkB+H27Ku4QnGBS9SdMO8cLAIqiLnHR
 7zi4XbAvR3pBe5G8Aw1vQtPuX5Q0KlrNaizqzd00obG8LRPJJc01zrWT/FPEvsKq5UhMvX
 MH9JamCFppyh8ztgvUqKnY6TcM9o8/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-GNj9Xf8POM2Zl03XkOAGYA-1; Mon, 10 Aug 2020 06:18:52 -0400
X-MC-Unique: GNj9Xf8POM2Zl03XkOAGYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FED5100CCC0;
 Mon, 10 Aug 2020 10:18:51 +0000 (UTC)
Received: from gondolin (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64CCA1755E;
 Mon, 10 Aug 2020 10:18:50 +0000 (UTC)
Date: Mon, 10 Aug 2020 12:18:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] docs/system/s390x: Add a chapter about s390x boot devices
Message-ID: <20200810121847.5ab4e227.cohuck@redhat.com>
In-Reply-To: <20200806150507.12073-1-thuth@redhat.com>
References: <20200806150507.12073-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Aug 2020 17:05:07 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Booting on s390x is a little bit different compared to other architectures.
> Let's add some information for people who are not yet used to this.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/s390x/bootdevices.rst | 82 +++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst      |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 docs/system/s390x/bootdevices.rst
> 
> diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
> new file mode 100644
> index 0000000000..68f0ffd450
> --- /dev/null
> +++ b/docs/system/s390x/bootdevices.rst
> @@ -0,0 +1,82 @@
> +Boot devices on s390x
> +=====================
> +
> +Booting with bootindex parameter
> +--------------------------------
> +
> +For classical mainframe guests (i.e. LPAR or z/VM installations), you always
> +have to exactly specify the disk where you want to boot from (or "IPL" from,

s/exactly/explictly/ ?

> +in s390x-speak -- IPL means "Initial Program Load"). Especially, there can

s/Especially/In particular/ ?

> +also be only one boot device according to the architecture specification, thus
> +specifying multiple boot devices is not possible (yet).
> +
> +So for booting an s390x guest in QEMU, you should always mark the
> +device where you want to boot from with the ``bootindex`` property, for
> +example::
> +
> + qemu-system-s390x -drive if=none,id=dr1,file=guest.qcow2 \
> +                   -device virtio-blk,drive=dr1,bootindex=1
> +
> +For booting from a CD-ROM ISO image (which needs to include El-Torito boot
> +informatin for being bootable), it is recommended to specify a ``scsi-cd``

s/informatin for being/information in order to be/

> +device, for example like this::
> +
> + qemu-system-s390x -blockdev file,node-name=c1,filename=... \
> +                   -device virtio-scsi \
> +                   -device scsi-cd,drive=c1,bootindex=1
> +
> +Note that you really have to use the ``bootindex`` property to select the
> +boot device. The old-fashioned ``-boot order=...`` command of QEMU (and
> +also ``-boot once=...``) is not supported on s390x.

(...)

This looks good to me, and is certainly helpful. I can fix the nits
myself and apply it.

There's also some documentation regarding DASD IPL in the devel guide;
but as that is mostly helpful for people actually working with the
code, I don't think that it makes sense to cross-reference it.


