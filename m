Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B484AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAE62076B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrukJeQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAE62076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUHD-0003h4-8t
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIUFM-0001fO-LD
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIUFF-0001oY-Dh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600250456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xQ27GPfz/kPhUeEmqcAhqi68KDDXcyOF4aOYg91w7Q=;
 b=RrukJeQIPNUTuWPWHgRsXAQhmwCtA6kImMND+d3SKtnGKalWF+Ks83uMJk7wQ12Sxl1sQG
 AvjPnjprSFeTPyWIzA+P8ntvfvnnP1+3sszHjx64FL+zTpg0SmppDkN08FOY98iHstm6p7
 tCMxGyQ2IJJq6cBpE7krxyR+TosaZNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-9iMQqA3mMkmo0Pu0C6lZSA-1; Wed, 16 Sep 2020 06:00:51 -0400
X-MC-Unique: 9iMQqA3mMkmo0Pu0C6lZSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4C181CBEB;
 Wed, 16 Sep 2020 10:00:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-213.ams2.redhat.com
 [10.36.113.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDF6419646;
 Wed, 16 Sep 2020 10:00:45 +0000 (UTC)
Subject: Re: PATCH: Increase System Firmware Max Size
From: Laszlo Ersek <lersek@redhat.com>
To: "McMillan, Erich" <erich.mcmillan@hp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB0327959D96C84FB32E071E49F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB03279AC1D869BBBA8D810A19F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <eaa64c6a-18cb-69df-3154-614744e1bfa9@redhat.com>
Message-ID: <5a407d82-49bb-ce57-f7bc-ceeb8cc5fc2c@redhat.com>
Date: Wed, 16 Sep 2020 12:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <eaa64c6a-18cb-69df-3154-614744e1bfa9@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/16/20 11:52, Laszlo Ersek wrote:

> (5) In my opinion (which could be wrong of course), we shouldn't
> introduce a new command line option for this, but a new PC machine type
> property called "x-firmware-max-size".
> 
> Please look at the object_class_property_add() calls in
> pc_machine_class_init() [hw/i386/pc.c].
> 
> I think the PC_MACHINE_MAX_RAM_BELOW_4G property is a good example to
> imitate:
> 
> - It has type "size".
> 
> - It comes with a getter and a setter, and an associated field in
> PCMachineState ("max_ram_below_4g").
> 
> - It has a nice description.
> 
> Then in pc_system_flash_map() [hw/i386/pc_sysfw.c], I suggest replacing
> FLASH_SIZE_LIMIT with "pcms->firmware_max_size".

The default value (8MB) should be set in pc_machine_initfn() [hw/i386/pc.c].

Thanks
Laszlo


