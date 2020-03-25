Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEAFC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFBD2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihgGOepB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFBD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH67Y-0007ce-1t
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jH66d-000732-4r
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jH66Z-0003lA-Ql
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:30:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jH66Z-0003gV-Nb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3swTRB0IyaXev/IV4lQ7UNOV56SHcllb9IQiVK3oAI=;
 b=ihgGOepBf+4BhFasjrRJ5CFJI8y3UhdyegEauqbaXHmO+lFTYXPv45oFHUSQfr62yJSZsM
 5S2sjmHjndAjK8aZdshLbPzop8HUDpEtHQQErZfuwA9EFZzYhI4wT7yTEWYOgoG3bfFPi9
 kFa+LwZGgXFalcIEHF3kze6at3J3+fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-TI-1ifR-NG2gTDfkW-YgZA-1; Wed, 25 Mar 2020 09:29:50 -0400
X-MC-Unique: TI-1ifR-NG2gTDfkW-YgZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A2A190D34C;
 Wed, 25 Mar 2020 13:29:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-184.ams2.redhat.com [10.36.113.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B869F5DA7C;
 Wed, 25 Mar 2020 13:29:46 +0000 (UTC)
Date: Wed, 25 Mar 2020 14:29:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: Print 'cqid' for nvme_del_cq
Message-ID: <20200325132945.GB6756@linux.fritz.box>
References: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.03.2020 um 15:06 hat Minwoo Im geschrieben:
> The given argument for this trace should be cqid, not sqid.
>=20
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks, applied to the block branch.

Kevin


