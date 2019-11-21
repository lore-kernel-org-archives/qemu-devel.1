Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53008C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C58120715
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auGPywev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C58120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXixH-0006MM-BH
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXiw8-0005oo-F7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXiw6-0000RS-9y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:39:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXiw5-0000QL-TE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574329177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNJDjYEnzCl0dgTl7/z8b5Rr0AAOf8FbnX5tp9TgO5Y=;
 b=auGPywevXvp5DVSQZuDx7krxRoKiWcXdPKUXybMpXKWMgvOs0agtM42D0hQeQQe/iA6E3H
 lY4jhmWBQbIXp7T9QYxNbXj13khlvUfXtbUh4wRdKEt0rIe+7biG2Vz1vEzBHGXIcY9aL4
 +H1E3q5yZaOvp8YpwXNRPA+aqpSLC/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-_4rrxrEhPxOKQSDjoRzjIA-1; Thu, 21 Nov 2019 04:39:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3391418557C4;
 Thu, 21 Nov 2019 09:39:26 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 185D86FEF6;
 Thu, 21 Nov 2019 09:39:21 +0000 (UTC)
Date: Thu, 21 Nov 2019 10:39:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
Message-ID: <20191121103920.580e0364.cohuck@redhat.com>
In-Reply-To: <754ae692-a6d8-8a94-e687-3a01218e0381@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120142627.39d041fe.cohuck@redhat.com>
 <754ae692-a6d8-8a94-e687-3a01218e0381@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _4rrxrEhPxOKQSDjoRzjIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 10:13:29 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/20/19 2:26 PM, Cornelia Huck wrote:
> > On Wed, 20 Nov 2019 06:43:19 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >=20
> > Do you have a branch with this somewhere? =20
>=20
> Just for you:
> https://github.com/frankjaa/qemu/tree/protvirt
>=20

Thanks!


