Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B07C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7365A2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h90e5rHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7365A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9P9r-0000LC-KP
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j9P9B-000812-Bo
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j9P9A-0005ku-4d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:12:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j9P99-0005hD-Ty
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583309571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzDF16ATaKvIueA08VO8R3vgfafwO3hAgKu/WVq6Jns=;
 b=h90e5rHBnJfvEne3MN+MIMoHTZlYkdSe1hWSK0ogtENK4FouolKThG43qK/VD8Vlzxd/0y
 GpjCB2Gd+giCS2GObFJXp5/nXcSIbA2HcUyECuwy+EFKyPi9sR6uZAithiFHA6vQwVaV5S
 8sLy8KzxWkn+xUQjzvCpmgqo9FSa+kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-jBncDhdQP0KlkMX2tcKwsQ-1; Wed, 04 Mar 2020 03:12:49 -0500
X-MC-Unique: jBncDhdQP0KlkMX2tcKwsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C758B18B5FA0;
 Wed,  4 Mar 2020 08:12:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 404EE60BF3;
 Wed,  4 Mar 2020 08:12:44 +0000 (UTC)
Message-ID: <fbf4ecddf8bae8586b25dbfc78e3cbae7b9106c4.camel@redhat.com>
Subject: Re: [PATCH v4 02/11] monitor/hmp: uninline add_init_drive
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 04 Mar 2020 10:12:43 +0200
In-Reply-To: <20200303171033.GF5733@linux.fritz.box>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
 <20200130123448.21093-3-mlevitsk@redhat.com>
 <20200303171033.GF5733@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-03 at 18:10 +0100, Kevin Wolf wrote:
> Am 30.01.2020 um 13:34 hat Maxim Levitsky geschrieben:
> > This is only used by hmp_drive_add.
> > The code is just a bit shorter this way.
> > 
> > No functional changes
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Shouldn't the subject say "inline" rather than "uninline"?
> 
> Kevin

Oh, you are absolutely correct. I don't know why I even now thought
about this that way.

Best regards,
	Maxim Levitsky


