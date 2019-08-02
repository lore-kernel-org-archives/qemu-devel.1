Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0878C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797EE21842
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797EE21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXMe-0003mx-CQ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tgolembi@redhat.com>) id 1htXMG-0003O7-18
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1htXMF-00040g-3E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:12:31 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1htXME-0003yx-Su
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:12:31 -0400
Received: by mail-wm1-f53.google.com with SMTP id g67so62194170wme.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding:user-agent;
 bh=oN9qlD2a2rKANzLQEnW/gHIsGQ8RD57FHJrnXqsXXFg=;
 b=LoTCa79B35qEYUf1nQuk/1gUkFRcURhxobWZpdPdatr5BBF6UwkosQ7IN4d1fOmGIT
 FADyXGEU9KPt6/y3B4YrbR52HZViX9mgSQa0BQICNnfg2KGO+e3z4Y6XUoZK3p5kJCwn
 hYT4DgHqeVpgH8h9IRhTAlUiElEgVazHvEfLjFzEUWoIVYA8oGWUQqR7e6huY+vQKrrZ
 kplVnFVR22m7A8cTFBlrZqAryWRkAi8uEqeP3gAXoEEBaL0fnPxFn6t/nwRfUQWpg9mV
 Kfk8WCMxASjF3FwV5BdwRrwBcVeVSOXsVz+2ER04DI83fIXSty3Y4w6858w9mTnkGYod
 X4wg==
X-Gm-Message-State: APjAAAVu0Cq8sgbF+4gyIb2HKxVyvnklmr9bvA58XPMSgBnmia6dJrcL
 rYihFzxMf0y9zzZzbd5Rfg4BWE3wuxs=
X-Google-Smtp-Source: APXvYqxH2PwgGLpWqs7VkrHdmaNvPa/Q2seuql2u/qnmyleljH+JvuMiIHnZSkyLhajsDDPLMqP9/w==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr4465470wma.68.1564751548747; 
 Fri, 02 Aug 2019 06:12:28 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 c65sm77546559wma.44.2019.08.02.06.12.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 06:12:28 -0700 (PDT)
Date: Fri, 2 Aug 2019 15:15:10 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190802131509.lplyvrbdwiwo2tve@auriga.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: [Qemu-devel] qemu-ga -- virtio driver version reporting
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
Cc: Gal Hammer <ghammer@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I would like to add version reporting of Windows virtio drivers to qemu-ga. 
Obviously this is specific to Windows as for POSIX systems it corelates with
the version of kernel. I would appreciate your ideas on a few topics.

Does it make sense to add this information as new (optonal) field to result of
'guest-get-osinfo'. Or would it be better to add whole new command? I expect
the result to look something like this:

    "component-versions": [
        {
            "name": "VirtIO Balloon Driver",
            "version": "03/10/2019,62.77.104.16900"
        },
        {
            "name": "QEMU PVPanic Device",
            "version": "06/11/2018,62.76.104.15400"
        },
        ...
    ]

Alternatively we could report all available versions of the specific
driver instead of just the latest. Note that this does not say much
about which version is in use or if a device is available in the
system.


I have checked the available drivers and the names quite vary. I guess we'll
need to list and match the complete name and not just some substring (like
"VirtIO"). See the following list:

    QEMU FWCfg Device
    QEMU PVPanic Device
    QEMU Serial PCI Card
    Red Hat Q35 SM Bus driver
    Red Hat QXL controller
    Red Hat VirtIO Ethernet Adapter
    Red Hat VirtIO SCSI controller
    Red Hat VirtIO SCSI controller
    Red Hat VirtIO SCSI pass-through controller
    VirtIO Balloon Driver
    VirtIO Input Driver
    VirtIO RNG Device
    VirtIO Serial Driver
    VirtIO-Serial Driver

Is it OK to hardcode the list in qemu-ga source? Is there already any support
for dealing with regexes or tries in qemu source tree?

Any other ideas, concerns?

    Tomas

-- 
Tomáš Golembiovský <tgolembi@redhat.com>

