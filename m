Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D42C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791D62073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsMisuq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791D62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ied8s-00032Q-Ii
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ied87-0002Uj-4g
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ied84-0005kO-17
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:52:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ied83-0005jq-Jh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575975150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W61nSZaUVLO4Vp/QnzKDkE1CwnSMFi/TW/Eh8kmsieQ=;
 b=MsMisuq1A3rWL85fReXgYWBz3JXR7Ixl0EpPI9+EnNIACdUDBCvBwRrOVxiGVpMGbiCwMf
 e+bTcSBU0iSJ12qT+9oQr2sY+YPWFZGrbVgr/UPSb0CK94hQjc3IuRCkkW6oHmvLb2TuMK
 GMHAt9CZUvD1qnV1EyIVFzdATdQ5fns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-0vpbaQFaNMyBFGpVuGcHYw-1; Tue, 10 Dec 2019 05:52:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBD2B8CC981;
 Tue, 10 Dec 2019 10:52:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A688D6F964;
 Tue, 10 Dec 2019 10:52:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B0BE11386A7; Tue, 10 Dec 2019 11:52:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
 <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
Date: Tue, 10 Dec 2019 11:52:18 +0100
In-Reply-To: <bf095dc0-321e-0d19-9d18-309317654050@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Dec 2019 15:02:38
 +0100")
Message-ID: <87h8283125.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0vpbaQFaNMyBFGpVuGcHYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 12/9/19 2:28 PM, Greg Kurz wrote:
>> PPCVirtualHypervisor is an interface instance. It should never be
>> dereferenced. Drop the dummy type definition for extra safety, which
>> is the common practice with QOM interfaces.
>
> This "common practice" is also referenced in commit 00ed3da9b5:
>
>     xics: Minor fixes for XICSFabric interface
>
>     Interface instances should never be directly dereferenced.  So,
> the common
>     practice is to make them incomplete types to make sure no-one does
> that.
>     XICSFrabric, however, had a dummy type which is less safe.
>
>     We were also using OBJECT_CHECK() where we should have been using
>     INTERFACE_CHECK().
>
> This indeed follow the changes from commit aa1b35b975d8:
>
>     qom: make interface types abstract
>
>     Interfaces don't have instance, let's make the interface type really
>     abstract to avoid confusion.
>
> Now I can't find guidelines for this. If you don't know about it and
> use 'git-grep', it is very confusing to see we use structures we never
> define.

Incomplete type is the closest you get to abstract class in C.

Prior discussion:
Subject: Re: Issues around TYPE_INTERFACE
Message-ID: <fdaa779c-ed79-647b-6038-3df2353fe502@redhat.com>
https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00749.html

> Can we document this use please?

Fair.


