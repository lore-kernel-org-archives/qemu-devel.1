Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A5C20776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mnA6QixD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A5C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlH8y-0003Sa-B5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jlH8J-00033f-Do
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:20:31 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:36175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jlH8H-0004ok-Ty
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:20:31 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4fba693d
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type; s=mail; bh=f2K7+XxFSA6FheSWXnyl3ArHBUk=; b=mnA6Qi
 xDn0c0xgrMzrZLPkxqeG5rS0oo+zbgNJwWuMJIBJ78EAeUGdgNmIAbp6N3yT1onK
 vtIIRzuMhwrOrqdebfz+Ie0a1diJUAUrU6Y/DZiKx4DnDDaLhjhiGeDfjBz2Hg+8
 7QDhIzAeTUYrdm0ueE4l4t9nKVtie+xmakZEQJwTKrV2PqMtkWTyByls5CEy4teQ
 zCozu5CcTLQykXlpPyOn6EfSabnP0JR4WcvRnh93YR+fbVMz/2AMK1WJzwp8K1B+
 R4Wl/J6UfJTwIa1cJS7b6h47CiFommZXyjH3MKPQUmYvTRqEbZ3CptcXElkx1FhP
 z73dH7lmH40d8A4w==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e9dec1e
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Tue, 16 Jun 2020 19:02:29 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id j19so15963272ilk.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 12:20:28 -0700 (PDT)
X-Gm-Message-State: AOAM5336XYDexopti4REAt7c8PfLUfw0PhdNqelgMyyGcsFUvjaf8/6t
 YNJHLYV4zUxZ2mYh6GaoJv2WscYszpMAR6m99+A=
X-Google-Smtp-Source: ABdhPJyVGlbGx4VBMsM0ZwQ1HqoqXRgaXgHcpUTwrrREZRgdInJP0kufRTPSov21T6sSHciqtZYxhE+1n6y5zVpRAbE=
X-Received: by 2002:a92:cf4d:: with SMTP id c13mr4639679ilr.207.1592335228184; 
 Tue, 16 Jun 2020 12:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200616003654.1058035-1-Jason@zx2c4.com>
 <20200616101627.74dd1542@redhat.com>
In-Reply-To: <20200616101627.74dd1542@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Jun 2020 13:20:17 -0600
X-Gmail-Original-Message-ID: <CAHmME9ruo0ZihXbtGdygAm48NBaXR0botmLyMxa+_YYPpHwghA@mail.gmail.com>
Message-ID: <CAHmME9ruo0ZihXbtGdygAm48NBaXR0botmLyMxa+_YYPpHwghA@mail.gmail.com>
Subject: Re: [PATCH] hw/acpi: specify 64-bit acpi table
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=192.95.5.64; envelope-from=Jason@zx2c4.com;
 helo=mail.zx2c4.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 14:50:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > increment the revision to '2' so that these larger addresses are
> > addressable. This matters because the DSDT revision represents the
> > maximum capability of all other SSDTs. This is also what arm does.
> it was keept at 1 for compat reasons with WindowsXP.
> by now it is long time EOL, so it might be fine to bump version,
> but it would be nice to know if this change breaks XP or not?

I just installed Windows XP twice, once without the patch and once
with the patch. The command line I used for this was:

qemu-system-x86_64 -m 3G -cpu host -enable-kvm -M pc-1.0 -drive file=disk.qcow
2 -cdrom en_windows_xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso

Aside from the nostalgia being completely overwhelming, both installs
were successful, and I was greeted with the terrific bliss.bmp
background.

