Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FEF206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpW2PoEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FEF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1DtQ-0003gY-KT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1DsT-00038f-1c
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:06:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1DsO-0000Ue-HF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596135958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ipCiurHLOlbmkmcIYdgYhd6j0u9AN9m5UfV5M7Jec=;
 b=OpW2PoEbQSoWUbxpiZU09+Tio1Ru/mi7hWdmaHDEk0PIix0gEWKegEPPdDoPo5pRvwmITI
 4pDEAkq5p5tWrpHU9gs9K4w7KnVuij3k39ZsyKbmTRYle7/gQqp6/qisSaxxCw+EJc6QCQ
 1UVOluKETFhxPtnxQHsL16IcJrhZDm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-EKCddYUvO-qy-uFBXM3TOg-1; Thu, 30 Jul 2020 15:05:54 -0400
X-MC-Unique: EKCddYUvO-qy-uFBXM3TOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59F5800461;
 Thu, 30 Jul 2020 19:05:52 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 456F972ADE;
 Thu, 30 Jul 2020 19:05:49 +0000 (UTC)
Subject: Re: [PATCH v12 01/11] iotests: add test for QCOW2 header dump
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <644c25e0-2d5b-1eee-68aa-245026b9c94e@redhat.com>
Date: Thu, 30 Jul 2020 14:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596118512-424960-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 9:15 AM, Andrey Shinkevich wrote:
> The simple script creates a QCOW2 image and fills it with some data.
> Two bitmaps are created as well. Then the script reads the image header
> with extensions from the disk by running the script qcow2.py and dumps
> the information to the output. Other entities, such as snapshots, may
> be added to the test later.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/303     | 59 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/303.out | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 124 insertions(+)
>   create mode 100755 tests/qemu-iotests/303
>   create mode 100644 tests/qemu-iotests/303.out

> +import iotests
> +import subprocess
> +from iotests import qemu_img_create, qemu_io, file_path, log, filter_qemu_io
> +
> +iotests.script_initialize(supported_fmts=['qcow2'])
> +
> +disk = file_path('disk')
> +chunk = 1024 * 1024
> +
> +
> +def create_bitmap(bitmap_number, disabled):
> +    granularity = 1 << (14 + bitmap_number)
> +    bitmap_name = 'bitmap-' + str(bitmap_number)
> +    vm = iotests.VM().add_drive(disk)
> +    vm.launch()
> +    vm.qmp_log('block-dirty-bitmap-add', node='drive0', name=bitmap_name,
> +               granularity=granularity, persistent=True, disabled=disabled)
> +    vm.shutdown()

Would it be any easier to use qemu-img bitmap here instead of firing up 
a full VM?

At any rate, this is a nice starting point for tracking what the rest of 
your series improves.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


