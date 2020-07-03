Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDBBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5A3207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv4dTMX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5A3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOl5-0003e9-4z
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1jrOZR-00086b-LD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:29:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1jrOZP-00071f-CQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593793786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vN2fS22YUAOiPADTj63wVYJzCGx4BlHPtm2JWT9AZg=;
 b=Sv4dTMX9E6jQXqyIUl+rsiMOqzXvLlxXXjKiagK4yA7J3FJEwOHmiep3Zd1/SN3hfqBLfp
 Dsrtx7P3ldVyQCU8/t5IDMZ3eC30MlakRS0gQBOb81dE78Q+9suNDtCoIvQ3NHsw+D6t6p
 VML66RUhx4U1W77ySdTHhDwEETgeAu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Ioql2spIOSupcUZuObInkQ-1; Fri, 03 Jul 2020 12:29:42 -0400
X-MC-Unique: Ioql2spIOSupcUZuObInkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 918CF800C60
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 16:29:41 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-114-211.ams2.redhat.com
 [10.36.114.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B4A1EE;
 Fri,  3 Jul 2020 16:29:35 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id A09753E048E; Fri,  3 Jul 2020 18:29:34 +0200 (CEST)
Date: Fri, 3 Jul 2020 18:29:34 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200703162934.GJ24474@paraplu>
References: <20200703161453.8406-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703161453.8406-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kchamart@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 06:14:53PM +0200, Philippe Mathieu-Daudé wrote:
> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
> schema that describes the different uses and properties of
> virtual machine firmware).
> Cc the libvirt maintainers if it ever changes.
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based on a comment from Laszlo:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
> 
> I don't think Laszlo should be the sole maintainer, not sure
> who else should be listed. Gerd and Kashyap? :)

Hiya,

I'm a mere enthusiastic user of firmware.json. :-) The original design
heavy-lifting[*] was done by Dan, Gerd, and Laszlo.  That said, I'm
happy to be Cced on patches to it, and review changes to the extent I
can.

[*] https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
    — [RFC] Defining firmware (OVMF, et al) metadata format & file

> Can we add it 'maintained' without specific maintainer?
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..57c90201df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2601,6 +2601,12 @@ F: include/hw/i2c/smbus_master.h
>  F: include/hw/i2c/smbus_slave.h
>  F: include/hw/i2c/smbus_eeprom.h
>  
> +Firmware schema specifications
> +M: Laszlo Ersek <lersek@redhat.com>
> +R: libvir-list@redhat.com
> +S: Maintained
> +F: docs/interop/firmware.json
> +
>  EDK2 Firmware
>  M: Laszlo Ersek <lersek@redhat.com>
>  M: Philippe Mathieu-Daudé <philmd@redhat.com>
> -- 
> 2.21.3
> 

-- 
/kashyap


