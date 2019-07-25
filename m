Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E92C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494802238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4qczxMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494802238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdah-0003gk-R2
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bharathpaul@gmail.com>) id 1hqc5d-0002wk-U1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharathpaul@gmail.com>) id 1hqc5b-00054b-Mk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:39:16 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:42756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharathpaul@gmail.com>)
 id 1hqc5b-00053f-Ho
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:39:15 -0400
Received: by mail-io1-xd36.google.com with SMTP id e20so66124698iob.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ooAoYM8kjiXrUQlGskzKajBALCVq96NDwOrZNjCwIaM=;
 b=o4qczxMe5jWiuGzYIOr7+Sajdp41h1AdEBJfS9nGcyxI1WCH/HUTHEMp3/EEDrK2Pd
 vWk1LxlkAHR1CwbI1pbqEWYadsyaOKuEJF1BIGE2CJQKc8GkGPrDK7Xkrq6kyVmZSx3f
 oZJMyqhuaIUd/7R4IczXa5TDSM857gDf2j66wnvQpqHqlufj+t3CeAe3bRnpW2+4NOMs
 i2zloSC7CAOSW+tz+9ekobOT02ZHeme+SJpXNRLMBL2fr3Q4BlvPN1hE+xlS20oZgAUk
 b4ykODvLK9+NRq27OvoiYGXQPqvC/16w1jyw/E+pei6PrdeBF9EhyvBC32xtt1ZIQn31
 cRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ooAoYM8kjiXrUQlGskzKajBALCVq96NDwOrZNjCwIaM=;
 b=VI6L68EBh9iVZGKXNdv487o9b+A9DBzeXlQzJXqlG1AWR+IAzUQlWzpyJuhUbTgffj
 ouPSy3VOwqH7uDPZ0eolZoIGRN8jqFwKWygt7tRuO/H1YXBaXDILnuPXS5+HVMdcGVU5
 BNClmgE7J3e13v3rZlSDMB8JUqkUY1zD/7FDQQ/CgXDZA+ilP5icsZvfZd1W/tPiN/sm
 sacb/Ljc9yLZzcVznnG/ObkJhs4BOYzAitV7A5J4psNa18Il9ofr6IdIhAISVf+WIyGM
 sJo7pOC+tM0U7h4AiuUUI5IZDpMFsCAWFf215VGZo/Q/ZDsQ3N8xV5nbzwp0T5L4/0Te
 /Etg==
X-Gm-Message-State: APjAAAX0aupe00f3r1YVcO1oOkWOmQVWML3fcxg4bX95QcoEBha4su4u
 mZAmtyOwlm7KJurPcWdmaJY4nn2Rt4D7I8hiGvxEzKjT
X-Google-Smtp-Source: APXvYqwJ0c2PZuCESYHaNbDWdwZi05wE0D3bs1P6VGQUuTVExCBRW/gN/qlLcUE+ypEPJE2y2H0oQzzs6XBtxKIWNo4=
X-Received: by 2002:a6b:90c1:: with SMTP id
 s184mr45618729iod.244.1564054754008; 
 Thu, 25 Jul 2019 04:39:14 -0700 (PDT)
MIME-Version: 1.0
From: bharath paulraj <bharathpaul@gmail.com>
Date: Thu, 25 Jul 2019 17:09:02 +0530
Message-ID: <CACfjA+m9_yYwArootOPmkHc2uGSXjeQeHPkX5DU9U4WWANUPcw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
X-Mailman-Approved-At: Thu, 25 Jul 2019 09:14:59 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Reg: <VM LIVE Migration><conntrack entries>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Team,

I am using QEMU/KVM for launching VMs and libvirt to govern those VMs.  I
would like to synchronise the connection tracking entries specific to the V=
M
 during the VM LIVE migrations. It is required when the firewall is
implemented at the host level like libvirt's "network filters".  Unless
these connection tracking entries are synchronised, all the connections to
the VM are lost and all TCP connections should be reestablished. Is there
any option already available? or do we need to develop the code? We can't
rely on the migration hooks as VM pause in the source hypervisor and VM on
in the destination hypervisor is done by QEMU and it does not wait for any
application that needs to sync-up some metadata =E2=80=94 In my case, it is
conntrack entries.

If I like to add the code and contribute to the community, what could be
the best approach to take?
Approach-1: Add a new command in QEMU to configure "maximum waiting-time
allowed".  During the VM Migration, Invoke the hook in the source when the
VM is paused and wait till the time value configured is elapsed or the hook
returns success, then do VM on in the destination.  It is more generic and
its up to the application to synchronise whatever required with in the
specified time span.
Approach-2: Modify the migrate command to accept the list of IP-Address,
which should be an optional parameter. If the IP-Address is specified,
along the dirty page synchronisation, synchronise the conntrack entries
that matches the IP address in its source or destination address and in the
destination QEMU, the conntrack entries should be segregated and programmed
in the hypervisor.

Thank you,
Bharath Paulraj
