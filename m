Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207EDC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEFC20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPoY2PZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFG6i-0007hg-0z
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jFG60-0007H4-Ck
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jFG5z-0008DP-1r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jFG5y-0008CR-TI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584704745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dwvZQz1H6BNGdYtvFKFror0gWCuZYwBYr6FYRHceiM=;
 b=dPoY2PZAJvOTvurUEHH90zADUMtCGcRfVf1bQ8NwlkCO2VX7CWuIyU0z5sYwRUX8DkHLUd
 VeKIqox7PJDBbmMQgzrIINEyVjwdUTF/odjUdNFaDGnxl7ZLMH8DUvxeXGb0TkbYKKZgr1
 WoQWWALU9ZMHtaOjDwS9iEZtkKoyxKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-tMXJgk4rPL6e0ty66oSJSg-1; Fri, 20 Mar 2020 07:45:42 -0400
X-MC-Unique: tMXJgk4rPL6e0ty66oSJSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BBB8017CE;
 Fri, 20 Mar 2020 11:45:41 +0000 (UTC)
Received: from gondolin (ovpn-113-89.ams2.redhat.com [10.36.113.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E4B18AC30;
 Fri, 20 Mar 2020 11:45:33 +0000 (UTC)
Date: Fri, 20 Mar 2020 12:45:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 4/4] .travis.yml: Add a KVM-only s390x job
Message-ID: <20200320124530.0254531a.cohuck@redhat.com>
In-Reply-To: <20200318222717.24676-5-philmd@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-5-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 23:27:17 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add a job to build QEMU on s390x with TCG disabled, so
> this configuration won't bitrot over time.
>=20
> This job is quick, running check-unit: Ran for 4 min 48 sec
> https://travis-ci.org/github/philmd/qemu/jobs/663659486
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

That looks like a good idea.

Acked-by: Cornelia Huck <cohuck@redhat.com>


