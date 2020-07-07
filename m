Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E57CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7EB206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR5EBL/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7EB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshS4-0003UG-5X
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jshQi-00027W-Po
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:50:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jshQc-000150-GN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594104605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GD/aR7YdYjGqFqj3DhJDszcPCzdEA0c14PN15EmwW8=;
 b=NR5EBL/P0oIKN04Cp9bwJa5SwxsSUEF5Uwo6/0S6oTVSiNfiGgkMgpYZpa0WrHL2lnXjmc
 oZqKaOSYI5l9i+0xNc363lwfUKNkbRlimgipA1GYLqcEXq4AlzwL9onMp3cLFcT9m7rdwQ
 +JSrZEwARj/A0SLQRWSGHgrBwxk/ZBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-rdi-f3QIOkykAbFaGVa3yg-1; Tue, 07 Jul 2020 02:50:02 -0400
X-MC-Unique: rdi-f3QIOkykAbFaGVa3yg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BADD9107ACCA;
 Tue,  7 Jul 2020 06:50:00 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8F40B3A65;
 Tue,  7 Jul 2020 06:49:54 +0000 (UTC)
Date: Tue, 7 Jul 2020 08:49:51 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/2] hw/sd/sdcard: Deprecate the SPI mode
Message-ID: <20200707064951.GC9048@angien.pipo.sk>
References: <20200705220731.28101-1-f4bug@amsat.org>
 <20200705220731.28101-3-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200705220731.28101-3-f4bug@amsat.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 23:10:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 libvir-list@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 00:07:31 +0200, Philippe Mathieu-Daudé wrote:
> SD cards be used with SPI, SD or MMC protocol.
> 
> Unfortunately, maintaining the SPI protocol make improving the
> MMC mode very difficult. As of 2020 users are more interested
> in using cards with the MMC protocol.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  docs/system/deprecated.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 5e67d7f3e0..01dca3d038 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -384,6 +384,11 @@ full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
>  Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
>  alias.
>  
> +``-device sd-card,spi=on`` (since 5.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The SPI mode of the 'sd-card' device is deprecated.

libvirt didn't implement this knob so it's okay to remove it without
replacement.

ACKed-by: Peter Krempa <pkrempa@redhat.com>



