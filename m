Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3BEC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67A82190F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67A82190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hclxZ-0002cN-Qm
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 03:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hclwf-00027O-0E
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 03:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hclwe-00007l-1z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 03:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hclwZ-0008Ti-Ui; Mon, 17 Jun 2019 03:20:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 990CC30872F6;
 Mon, 17 Jun 2019 07:20:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7691001E6E;
 Mon, 17 Jun 2019 07:20:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6256D11AAF; Mon, 17 Jun 2019 09:20:40 +0200 (CEST)
Date: Mon, 17 Jun 2019 09:20:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190617072040.yriunmoffbjhvqc5@sirius.home.kraxel.org>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612115939.23825-8-shmuel.eiderman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612115939.23825-8-shmuel.eiderman@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 17 Jun 2019 07:20:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 7/8] bootdevice: FW_CFG interface
 for LCHS values
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> We serialize this information in a similar way to the "bootorder"
> interface.
> The fw_cfg entry is "bootdevices" and it serializes a struct.

Why "bootdevices"?  I'd suggest to use "geometry" or "lchs" instead.

> At the moment the struct holds the values of logical CHS values but it
> can be expanded easily due to the extendable ABI implemented.
> 
> (In the future, we can pass the bootindex through "bootdevices" instead
> "bootorder" - unifying all bootdevice information in one fw_cfg value)

I don't think deprecating bootorder is useful.  Nobody cares about the
disk geometry, except some legacy x86 bios guests.  So seabios will be
the only firmware using this new interface.  Switching all firmware to a
new fw_cfg file is pointless churn.

Why make this extendable?  What possible extensions do you have in mind?

Also note that with a possible extension you might end up in a situation
where you have info A for device 1 and info B for device 2 and info A+B
for device 3 while with your current patch there is no way to signal
whenever info A or B is available for a given device.

> +/* Serialized as: struct size (4) + (device name\0 + device struct) x devices */
> +char *get_boot_devices_info(size_t *size)
> +{
> +    FWLCHSEntry *i;
> +    BootDeviceEntrySerialized s;
> +    size_t total = 0;
> +    char *list = NULL;

if (QTAILQ_EMPTY(&fw_lchs)) {
	return NULL;
}

> +    if (!mc->legacy_fw_cfg_order) {
                ^^^^^^^^^^^^^^^^^^^
Hmm?

cheers,
  Gerd


