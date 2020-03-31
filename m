Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1586120838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoxDaKdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1586120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHYg-0003np-8v
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHXV-0002Bz-9G
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHXU-0007bE-89
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHXU-0007ab-4C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/RNZWLQ1tyRweK5cW0qRXo3NwaYw9C8YTQTDQoLxT5Y=;
 b=MoxDaKdzfmna5LQtIUf5BuGwmOOxPcmKwrumZQGOlRvkyl61l1P96CPvG5LdIvaaujrjpF
 GnrWQVm7Z1uFmEFk8hnZIDeV/++63Fa8fQgChw2VaJnLWnkmli80leLVReqY/EDkujz3ya
 bXC0nOcVRc9QVATdifNTlU0k8jbymtM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-7_e2KTroNG-QI2OdQC_2LQ-1; Tue, 31 Mar 2020 10:06:43 -0400
X-MC-Unique: 7_e2KTroNG-QI2OdQC_2LQ-1
Received: by mail-wr1-f71.google.com with SMTP id h95so7813604wrh.11
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AYrDtixOot8xU91Wwu0BS20n7PFxs1iHJRpYB9+GD2I=;
 b=jJxuXmZVold8zaR0Wfm+orE7ejrVC4JEUqcb74Lop77UTGUC2RfKjiNq+dUAIF53vm
 uOY3mq8KgPubjSDlgtaFeVpFJ3uB5ObIRuZHeVtzinaYfE8NfnP0Zz1Ce3vR9K0xmhqw
 tXcSS7Sn7x3XA9aVuM3ohzq/w9K63OFboCnwWWiR6ZxXv/2a/mJJUrNtCjBNxdPHwNdI
 Q1Z0SD0dQ5sTn1A112JAUwmGj8XO8SaDESYsbi3Zr9O5Q+g7YDeW8Q/bbrozDFHyjSoR
 yOATDU2Ga+8L4r4b1x++YH4Q/Oqrgp3oT/lDfOTqfLyhK4C6e8GcQIo/81tJAxcAoCTJ
 y0ag==
X-Gm-Message-State: ANhLgQ0XNm2qQKngn5qkibxy+ewO5WvUuisJuaM3j8jnyYt1pQ91YiNu
 RfR4AdGnSM23THD7maEb/Vp18mcNTK8AHA7eteduiNiiDoIdO0ncJoPdXTqAnXN+aYTl1F91Sdt
 CJnqr6Cl8/rU4Xvw=
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr3405745wmg.99.1585663601575; 
 Tue, 31 Mar 2020 07:06:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsIpZbV29IyCZymRlqsi4L3jUpGrbBSIutY2DeZiLy75Ko8ZiafOw8x/Tjr/7jEhNAsQJsWRA==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr3405725wmg.99.1585663601371; 
 Tue, 31 Mar 2020 07:06:41 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l10sm26483824wrq.95.2020.03.31.07.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 0/4] qga: Restrict guest-file-read count to 10 MB
 to avoid crashes
Date: Tue, 31 Mar 2020 16:06:34 +0200
Message-Id: <20200331140638.16464-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fakhri Zulkifli reported BZ#1594054
https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054

Dietmar Maurer noticed the fix from 807e2b6fce0 doesn't help
as error_setg() also calls malloc().

Daniel Berrang=C3=A9 suggested a clever fix, restrict the
guest-agent command size to avoid heap mayhem.

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg691773.html

Philippe Mathieu-Daud=C3=A9 (4):
  Revert "prevent crash when executing guest-file-read with large count"
  qga: Extract guest_file_handle_find() to commands-common.h
  qga: Extract qmp_guest_file_read() to common commands.c
  qga: Restrict guest-file-read count to 10 MB to avoid crashes

 qga/qapi-schema.json  |  6 ++++--
 qga/commands-common.h | 21 +++++++++++++++++++++
 qga/commands-posix.c  | 29 +++++++----------------------
 qga/commands-win32.c  | 35 ++++++++---------------------------
 qga/commands.c        | 29 +++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 51 deletions(-)
 create mode 100644 qga/commands-common.h

--=20
2.21.1


