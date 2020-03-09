Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC564C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7870B2464B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fulgjTkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7870B2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBL8d-000767-M3
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jBL7M-00066u-Uo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jBL7I-00048X-0Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:18:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22659
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jBL7H-000482-Sm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583770734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BtiGEoJia1AqzBWVUCUWdrJNVUUPcohcr3UDrNrmzRw=;
 b=fulgjTkN+3zI6Hys49i5xcOyPtjjI8ZeOQvSy16MtZVYKCWqHr+1D7BVXwKqlgZWZa56Zn
 nY9I3MtPTYNvTTsiUZZxXMajqeGTuoZa7z9cNTPNhqs+5aZArHUFClzEhAcJ2qNx3Dijl9
 8pXVxXc7ng9+3NLoj5aiXfkIUO344LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-45O50bQaPyScazyaISRcTQ-1; Mon, 09 Mar 2020 12:18:50 -0400
X-MC-Unique: 45O50bQaPyScazyaISRcTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ACA2801E70;
 Mon,  9 Mar 2020 16:18:49 +0000 (UTC)
Received: from localhost (ovpn-121-49.rdu2.redhat.com [10.10.121.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 985A210246F4;
 Mon,  9 Mar 2020 16:18:48 +0000 (UTC)
Date: Mon, 9 Mar 2020 12:18:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: vmx=on with -accel hax
Message-ID: <20200309161847.GD1187748@habkost.net>
References: <19980599-1cbf-9179-070d-59aa68847968@dcc.fc.up.pt>
 <87tv331i5k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tv331i5k.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Xin Xiaohui <xiaohui.xin@intel.com>,
 Vincent Palatin <vpalatin@chromium.org>,
 Jiang Yunhong <yunhong.jiang@intel.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Rui Prior <rprior@dcc.fc.up.pt>,
 Zhang Xiantao <xiantao.zhang@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 06:32:07AM +0100, Markus Armbruster wrote:
> Cc'ing people listed by "scripts/get_maintainer.pl -f target/i386/hax*".
>=20

Thanks!  get_maintainer.pl output here is a bit misleading.  We
have no maintainers listed for the hax accel.  CCing the original
authors, hoping they can help.

> Rui Prior <rprior@dcc.fc.up.pt> writes:
>=20
> > Dear qemu developers,
> >
> > I found a bug/limitation of qemu on windows (qemu-w64-setup-20200201.ex=
e
> > from https://qemu.weilnetz.de/w64/ ) that makes qemu terminate
> > immediately with "VCPU shutdown request" (twice) if I try to use the
> > "vmx=3Don" CPU option while simultaneously using "-accel hax".  Without
> > "vmx=3Don", it works fine (but it prevents me from using nested
> > virtualization).
> >
> > I am using HAXM v7.5.6.
> >

I don't see any CPUID handling in the hax accel code, so "vmx=3Don"
isn't even supposed to have any effect.  I don't think HAXM
supports nested virtualization, does it?


> > Should you need any further information, please let me know.
> >
> > Best regards,

--=20
Eduardo


