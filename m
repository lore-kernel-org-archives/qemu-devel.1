Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43091C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8957921D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORW0tHdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8957921D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdvP-0003Mw-Bv
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGdug-0002Ip-2X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:56:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGduc-0005Wz-6l
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599810960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hr81u7eMe+eZt/wS/Plq0RTW8wzeKJ2XtJkP6jGfroA=;
 b=ORW0tHdFh0hv+Sa62hEUwh7ke0YsxYNEIhvc4O2W11PwJcxbw8coqYrVy8uGqDlgUKsxjM
 4IbR1H0wEX4JwC7qgtnvTyVMtkiCNhaI89dDC4CznoZQpd4Dg6VWaD5XB0LdJFk6lyHivE
 VujkCav8BgPeOcym3PGCEN7LptlUTEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-sDWJ6NXVOnOy-J-JE9HLdw-1; Fri, 11 Sep 2020 03:55:58 -0400
X-MC-Unique: sDWJ6NXVOnOy-J-JE9HLdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3541020AD3;
 Fri, 11 Sep 2020 07:55:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-52.ams2.redhat.com
 [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9AA7BCC1;
 Fri, 11 Sep 2020 07:55:17 +0000 (UTC)
Subject: Re: PATCH: Increase System Firmware Max Size
To: "McMillan, Erich" <erich.mcmillan@hp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
Date: Fri, 11 Sep 2020 09:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Markus, Dave, Phil

On 09/11/20 03:45, McMillan, Erich wrote:
> Hi all,
> 
> (this is my first Qemu patch submission, please let me know if my formatting/content needs to be fixed).
> We have a need for increased firmware size, currently we are building Qemu with the following change to test our Uefi Firmware and it works well for us. Hope that this change can be made to open source. Thank you.
> -------
> Increase allowed system firmware size to 16M per comment suggesting up to 18M is permissible.
> 
>  Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355fbd19ffdcdb71ea75ca 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -46,7 +46,7 @@
>   * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
>   * size.
>   */
> -#define FLASH_SIZE_LIMIT (8 * MiB)
> +#define FLASH_SIZE_LIMIT (16 * MiB)
> 
>  #define FLASH_SECTOR_SIZE 4096
> -------
> 
> 

(1) This is not a trivial change, so qemu-trivial: please ignore.

(2) The comment has not been updated.

(3) I'm almost certain that *if* we want to change this, it needs to be
turned into a machine type (or some device model) property, for
migration compatibility.

(4) I feel we need much more justification for this change than just
"our firmware is larger than upstream OVMF".

In the upstream 4MB unified OVMF build, there's *plenty* of free room.
Of course that's not to say that we're willing to *squander* that space
-- whenever we include anything new in the upstream OVMF platform(s),
there must be a very good reason for it --, just that, given the
upstream OVMF status, the proposed pflash increase in QEMU is staggering.

Considering upstream OVMF and QEMU, it should take *years* to even get
close to filling the 4MB unified flash image of OVMF (hint: link-time
optimization, LZMA compression), let alone to exhaust the twice as large
(8MB) QEMU allowance.

Unless you are committed to open source your guest firmware too (maybe
as part of upstream edk2, maybe elsewhere), I seriously doubt we should
accommodate this use case in *upstream* QEMU. It complicates things
(minimally with regard to migration), and currently I don't see the
benefit to the upstream community.

Clearly, for building your firmware image, you must have minimally
modified the DSC and FDF files in OVMF too, or created an entirely
separate firmware platform -- DSC and FDF both.

If you are using your downstream OVMF build as a testbed for your
proprietary physical platform firmware, that's generally a use case that
we're mildly interested in not breaking in upstream OvmfPkg. But in
order to make me care for real (as an OvmfPkg co-maintainer), you'd need
to upstream your OVMF platform to edk2 (we already have Xen and --
recently added -- bhyve firmware platforms under OvmfPkg, not just
QEMU). You'd also have to offer long-term reviewership and testing for
that platform in edk2 (like the Xen and bhyve stake-holders do). Then we
could consider additional complexity in QEMU for booting that firmware
platform.

Thanks,
Laszlo


