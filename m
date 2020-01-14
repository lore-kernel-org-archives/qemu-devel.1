Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FBC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B12024672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX/NfTe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOGT-0007cB-7l
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irO1l-0004wG-De
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irO1k-0004t8-6T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:22:45 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32]:38216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irO1k-0004rw-2o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:22:44 -0500
Received: by mail-qv1-xf32.google.com with SMTP id t6so5815086qvs.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=sGSH+IQlQUpGY7KF52LbS3Sr2SWrDfuS4pXyDnX+7v4=;
 b=MX/NfTe550zuC3FwRtqoTwouP7sKw3LZEpmO+gmJ2rLqORQV+VQluEqKsGa8vdwZk6
 EtfINcokMyO9rzCOqFlNXoWrWMPhamDn5Gde0WmEaEZV8ZMX1p4eH7dlRQeJQbuVwEHY
 FlSqsCZL13Isq4FkfJ8cbMYLE1/4GtIBbZ7OghHL9rMlUD1SEVZLACf+omHz7L1iRjhy
 LRRH4EDx8HKSBNKho59Yu9EwJN1askHQcWuclf2S/RSlTvpQFI4HKKdXCdckjJ6gWmjT
 Vz5M4stiJ2IFQO16sA0alyU0jdLTOseKUHxSQlzHLG12fquzO3GPwr+wXpn19lAt+F3/
 jeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=sGSH+IQlQUpGY7KF52LbS3Sr2SWrDfuS4pXyDnX+7v4=;
 b=lTkZZtDkE/kqysO2dxCakAHYgsmxg8Mmw+YnQGyw2NdFmHDo/CS97ATS8dkFxETAjx
 NydSROVf48VV85eqT9n2OkhUb16NqqKefDYZYFJUeX44yLgVuNzxrLPWndjOQgRwobAn
 tkpEb5WevjfajpUvbqRiPyhDimNXloi8DZipXUPMrAKQSlKsZI+M9Na6UIab4fBmc9P3
 fVg85Dsc2gSyvbqMuDA6+Q2sGGpcXy5N8N1CBwkx8wYUqzwV+P2xO0irBMDJUqvRgGlV
 KCk+cQUJOxTX6Rb0yf3GML5iikRePN7zJ84m5SmKVpchtK8gyydTrhsmrtMm8h7RBST5
 wBUA==
X-Gm-Message-State: APjAAAXyXruodssOzP0h7W3rczyT3qQqlvph8CXABSHBXsT+KOYy2SUl
 xWpTsFN/Ychf5ak0dKo0FCNwFC4ZQXvlO4vbZgn5ewStT8s=
X-Google-Smtp-Source: APXvYqwN4D+3gnhT5ILtw7eyoEFsPo8Oy4a0dP5VSRm1kWk2AgCkKOLDgqG8uLutWOavzkMTjlIU9C68aW4Wo3QaBvc=
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr16749667qvp.171.1579015363207; 
 Tue, 14 Jan 2020 07:22:43 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2020 15:22:30 +0000
Message-ID: <CAJSP0QWUfHyAk-xLFA1-sWSU7CvB4yKu0=Okoc7wcv7TinmXWg@mail.gmail.com>
Subject: Feedback on multi-process QEMU muser prototype
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f32
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I haven't seen the link to the muser prototype shared on the list yet,
so I'm taking the liberty of posting it for discussion:
https://github.com/oracle/qemu/tree/multi-process-qemu-v0.4.1-muser

Great that a lot of the multi-process patch series is no longer
necessary.  The muser approach requires less code in QEMU.

The following points came to mind:

1. Configure PCI configuration space, BARs, and MSI/IRQs based on the PCIDevice
   instead of hard-coding the LSI SCSI controller's specifics.  That way any
   PCIDevice can run as an muser device.

2. Integrate with QEMU's event loop instead of spawning threads and calling
   lm_ctx_run().  The event loop should monitor the muser fd for activity using
   aio_set_fd_handler() and then call into libmuser to handle the event.  This
   will avoid thread model problems in the future and also allow true
   multi-threading (IOThreads).

3. Drop previous multi-process QEMU commits if they are not needed.

Stefan

