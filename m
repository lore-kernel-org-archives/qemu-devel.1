Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD7C47E49
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9636021D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ+m5J1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0vQ-0001OB-SO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iO0ay-00043L-Oq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iO0aw-0005Zi-Ot
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:29:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iO0aw-0005XJ-LP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fblDzTrmI95HD+bJkNSsAeGKfOWqeeZ7ZSjhHYvBbxU=;
 b=XQ+m5J1ZtSybdqwQrjWafCKr4otwlKrKbDdzsAfuaCao8tquJN656pCF5NaZlFBxqbjwwC
 pxr0N8o4Grn2S8gIy5KxV50bXvtf5h2VtuUa+GaW+tiTACEDZPiHfl7mQW4PhN1z+ze+P0
 v/VkjAUusWsb1zAGZt94Lsto8+NOl30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-F-fYz5zCOQmutQSFA5w4YQ-1; Fri, 25 Oct 2019 10:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8DB800D41;
 Fri, 25 Oct 2019 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A84A35D721;
 Fri, 25 Oct 2019 14:29:16 +0000 (UTC)
Date: Fri, 25 Oct 2019 16:29:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: mdroth@linux.vnet.ibm.com
Subject: Early 4.1.1 release for image corruption fixes?
Message-ID: <20191025142915.GG7275@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: F-fYz5zCOQmutQSFA5w4YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

the QEMU 4.1.0 release has two problems that can easily cause image
corruption with any qcow2 images (no special configuration needed to
trigger the bugs):

1. A locking bug in the qcow2 code. I just sent a pull request that
   includes the fix for this. The important patch there is:

   'qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation()'

2. A kernel bug in the XFS driver that became visible by new I/O
   patterns the qcow2 implementation started to use in 4.1. Max is
   currently working on a workaround for this.

The Planning/4.1 wiki page tells me that a 4.1.1 release is planned for
end of November, which isn't too far, but I was wondering if want to
have a stable release even earlier, right after the fixes for both
problems are in.

Peter, if we haven't made a decision until then, maybe discussing this
is an agenda item for QEMU Summit, too.

Kevin


