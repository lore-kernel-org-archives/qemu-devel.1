Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F62C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434F120723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/Cq5H1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434F120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaoI-0000bx-5b
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iVamy-0007kH-Ip
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iVamw-0003It-01
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iVamv-0003Ij-S9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573821200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oo7ziSWQTPYaEeau61aPHoxyP1yHc3naPfyxYAfrqKM=;
 b=U/Cq5H1phw2ouVRIfUKCSMmuAmEsOg6S8w3GDIKLUM4zTUWScaA1+Cy0cHnStAX00K52h8
 +YAt3zHhPCih5/Gs33XDPrBMh91a8Hq/1cFHuXkvbO4f8PxM1GS9lvIBYRiz8XEugLu8Yd
 5O9b4FGxNUIzx0t+9/n8WVqYFdDkQ3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-YTnt9wboOUqvTWKpfPqDxg-1; Fri, 15 Nov 2019 07:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD132107ACC4
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 12:33:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E934060C18;
 Fri, 15 Nov 2019 12:33:13 +0000 (UTC)
Date: Fri, 15 Nov 2019 12:33:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
Message-ID: <20191115123311.GE2514891@redhat.com>
References: <20191108092247.16207-1-kchamart@redhat.com>
 <f8dce546-ea28-0619-a20a-62c762f99721@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f8dce546-ea28-0619-a20a-62c762f99721@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YTnt9wboOUqvTWKpfPqDxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: aarcange@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 01:08:53PM +0100, Thomas Huth wrote:
> On 08/11/2019 10.22, Kashyap Chamarthy wrote:
> > This blog post summarizes the talk "Micro-Optimizing KVM VM-Exits"[1],
> > given by Andrea Arcangeli at the recently concluded KVM Forum 2019.
> >=20
>=20
>  Hi Kashyap,
>=20
> first thanks for writing up this article! It's a really nice summary of
> the presentation, I think.
>=20
> But before we include it, let me ask a meta-question: Is an article
> about the KVM *kernel* code suitable for the *QEMU* blog? Or is there
> maybe a better place for this, like an article on www.linux-kvm.org ?
>=20
> Opinions? Ideas?

I don't see a problem with this. KVM and QEMU developers work
very closely together and many users of QEMU care about the whole
stack, so KVM is on-topic IMHO


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


