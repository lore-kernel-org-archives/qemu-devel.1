Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C96C4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560E520714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtLkud5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560E520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEh0t-0000VI-HV
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEgyx-0006wT-PG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEgyu-0001zF-Vq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEgyt-0001oH-Dp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584569766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RqF9REAd7/gJMfA82uLkk0CM27eAOuw3vU7rX/MVoi0=;
 b=AtLkud5FhNeG45Q2VtoAWiFhi531zVg3aN15Xx4Jmdppwp8H9YKd5D0cz3aIQAbtzoItJJ
 hY1VomG/5FSokI58hplTNtvVKD3p96JSEsKLO42ztEWbiJUZnvRaq9HmR0glXFPuQD+t6L
 9hzaeqBbDVVRPK0VtQCRH4pBjWKwa14=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-ZP4T9YQSMGOJNowHJ9H9bg-1; Wed, 18 Mar 2020 18:16:04 -0400
X-MC-Unique: ZP4T9YQSMGOJNowHJ9H9bg-1
Received: by mail-wm1-f69.google.com with SMTP id x7so175249wmi.4
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+w58ng0FC1YIuq7fEP/4sQboxKnH2dQVp9VBYKvGc/A=;
 b=o1RmhV62Wn2aae7yuCSc2xdq8nQVzNjHBcWFHNVfbEQoxqIWY3e2F0R1OeVWT9568+
 TdJELXr4TIBTpRPPDrVhGQkm6mPXOSXs0nkLtZ1JVrl7x4Y76A17W2cwvT3LILdr9B7w
 TpwJbieDj5h+1sah7PAYfv4HxkLiqdNf2EzXt8HjV1zPgqP/W1wksbjb2SUxzeh0I4wO
 r2lQPrWAPSN9wV5tysgh2M90Qf31+mcgbgYkx6fcpTHUPbrPYcO3cTV2usBC2QEbNrWT
 Uar2WnG/jxF4myI1dldHr0SD4LdRp3HfiL1QatiH+VeYnZHtMOTS5M7WWfNvPBJq9/gM
 AvPg==
X-Gm-Message-State: ANhLgQ0/79Nb8RFBOiTozpYehDhEgnPPpe6Y4siCzV32p1N3STIxVWgR
 ZPdBbGlJI3hLeqfa30ydQuuNrW/ODAXizBzAaF2LkTW2bdstlnePMSGVvE9uo+8Quh6M2ggBp27
 OwwSXpw4VwpazwdM=
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr7314396wmh.134.1584569763206; 
 Wed, 18 Mar 2020 15:16:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsYil6uVpODLlXaZj/FDh1UnsG40YjsypwA8NgVAU7GEg2LYFdqsKWtvqyWzON6HGIzINZNnQ==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr7314370wmh.134.1584569762906; 
 Wed, 18 Mar 2020 15:16:02 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n1sm287466wrj.77.2020.03.18.15.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:16:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 0/2] hw/acpi/piix4: Restrict 'system hotplug' feature
 to i440fx PC machine
Date: Wed, 18 Mar 2020 23:15:29 +0100
Message-Id: <20200318221531.22910-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This feature is not documented in the PIIX4 datasheet. It appears
to be only used on the i440fx PC machine. Add a property to the
PIIX4_PM device to restrict its use. This fixes MIPS guest crashing
QEMU when accessing ioport 0xaf00.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/acpi/piix4: Add 'system-hotplug-support' property
  hw/acpi/piix4: Restrict system-hotplug-support to x86 i440fx PC
    machine

 include/hw/southbridge/piix.h |  3 ++-
 hw/acpi/piix4.c               | 13 ++++++++++---
 hw/i386/pc_piix.c             |  1 +
 hw/isa/piix4.c                |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

--=20
2.21.1


