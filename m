Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80FCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81CD208B3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFCrienc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81CD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsPy-0006Ng-Rk
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsP4-00057q-FV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDsP2-0005LY-2i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599151678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6S5irUz7sP52TDx9DOe8eIiioM8zQlBMo31b+/JLEJc=;
 b=cFCriencbOsyi8CkHAKXuNtPtEi2/C8CL1HSUY7+P7bvPz7ToTNQnX4V11z4vsY77wGqvv
 0EjsKjNvy198uIUuSa7yTSFBD1fOZWtRJ74iauQT1bV8Sa/HvcJGF9bfmtX1dXfawveHwS
 v3TT/HvwWqw8j66oafddI65VQ9KAmaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-x9xnjMVtNg66_WXO3trsFA-1; Thu, 03 Sep 2020 12:47:55 -0400
X-MC-Unique: x9xnjMVtNg66_WXO3trsFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FEE7100746C;
 Thu,  3 Sep 2020 16:47:52 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC6791EA;
 Thu,  3 Sep 2020 16:47:35 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:47:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 00/63] qom: Rename macros for consistency
Message-ID: <20200903164735.GO4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Ben Warren <ben@skyportsystems.com>, John Snow <jsnow@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Tony Krowiak <akrowiak@linux.ibm.com>,
 berrange@redhat.com, qemu-block@nongnu.org,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 06:42:08PM -0400, Eduardo Habkost wrote:
> Reducing boilerplate QOM code using the new OBJECT_DEFINE_* and
> OBJECT_DECLARE_* macros is quite difficult when there are
> multiple ways a TYPE_* constant name is written.
> 
> This series renames many type checking macros and/or TYPE_*
> constants to make sure they are consistent.
> 
> This series is based on machine-next and can be fetched from:
> 
>   https://github.com/ehabkost/qemu-hacks work/qom-rename-macros

I'm queueing:

[PATCH 01/63] gpex: Fix type checking function name
[PATCH 02/63] chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV
[PATCH 05/63] ap-device: Rename AP_DEVICE_TYPE to TYPE_AP_DEVICE
[PATCH 06/63] dev-smartcard-reader: Rename CCID_DEV_NAME to TYPE_USB_CCID_DEV
[PATCH 08/63] vfio: Rename VFIO_AP_DEVICE_TYPE to TYPE_VFIO_AP_DEVICE
[PATCH 10/63] vmgenid: Rename VMGENID_DEVICE to TYPE_VMGENID
[PATCH 32/63] ahci: Rename ICH_AHCI to ICH9_AHCI
[PATCH 39/63] esp: Rename ESP_STATE to ESP
[PATCH 40/63] filter-rewriter: Rename FILTER_COLO_REWRITER to FILTER_REWRITER
[PATCH 47/63] rs6000_mc: Rename RS6000MC_DEVICE to RS6000MC
[PATCH 48/63] sabre: Rename SABRE_DEVICE to SABRE
[PATCH 53/63] usb: Rename USB_SERIAL_DEV to USB_SERIAL
[PATCH 55/63] vfio: Rename PCI_VFIO to VFIO_PCI

-- 
Eduardo


