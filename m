Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC1C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD954217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj4qpSYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD954217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4W3-0004QQ-6O
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iS4VB-0003xw-OD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iS4V9-0007rZ-Im
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:28:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iS4V9-0007rT-CL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572982106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9X81mEu1MDzl1AOfjuuKAxwHmrR6QwjQ1ogxXP4QFg=;
 b=Aj4qpSYZr9XB4TO0jA5WQ0XPFFwDEeCmAx7lFeRKULmeZwv07mSHUy1DyhjSDIbA0253TN
 8WnmPX+9DvK01E7QEL8ppEncL+Ucyt5aw2rf6wRdP85NTAdma2USIwonwQalEr1uv5fAsA
 b+bthPOWQuLRLp5RWllW7yJIU9kLKi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-MAbwzZisOgaX26uAXfLxGQ-1; Tue, 05 Nov 2019 14:28:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90405477;
 Tue,  5 Nov 2019 19:28:22 +0000 (UTC)
Received: from work-vm (ovpn-117-86.ams2.redhat.com [10.36.117.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C76ED5D9C9;
 Tue,  5 Nov 2019 19:28:21 +0000 (UTC)
Date: Tue, 5 Nov 2019 19:28:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chang Howard <f26227279@gmail.com>
Subject: Re: Live migration primary vncviewer blocked.
Message-ID: <20191105192819.GA2827@work-vm>
References: <CAHr38=GUGpC1s8fo_E4w4qbB6qjf===5WjsS=wSSPKSZ6SQkeA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHr38=GUGpC1s8fo_E4w4qbB6qjf===5WjsS=wSSPKSZ6SQkeA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MAbwzZisOgaX26uAXfLxGQ-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chang Howard (f26227279@gmail.com) wrote:
> Hi, I know after live migration, primary would be blocked and vnc is also
> blocked.
> Could I let primary vnc still work after live migration?
> I do vm start after live migration and in text mode primary's vnc can sti=
ll
> work, but graphic mode it would blocked.
> How can I do to make in graphic mode vnc can still work too?

Hi,
  Can you give some more context to your problem.  With normal qemu
migration VNC should work fine after migration.

Dave

>=20
>=20
>=20
>=20
> thanks a lot!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


