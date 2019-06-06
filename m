Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF1C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36FB2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36FB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYoW8-0002Dr-QK
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:17:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYoVN-0001ut-5r
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYoVM-0007Mn-1a
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYoVL-0007Lk-SM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 168E03087944
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 09:16:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6D262732;
	Thu,  6 Jun 2019 09:16:09 +0000 (UTC)
Date: Thu, 6 Jun 2019 10:16:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190606091606.GC14300@redhat.com>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
	<20190605173311.GA13261@redhat.com>
	<20190605180608.GW22416@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605180608.GW22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 06 Jun 2019 09:16:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] numa: deprecate '-numa node,
 mem' and default memory distribution
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>,
	pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 03:06:08PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 05, 2019 at 06:33:11PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> [...]
> > I wonder if there's a way to close the testing gap somehow ? Random i=
dea
> > would be a non-versioned "pc-no-deprecated" machine type, which block=
s
> > all use of deprecated features and does not promise any migration com=
pat.
> > Essentially it would exist just for testing purposem as a way todo
> > functional tests for libvirt & mgmt apps to prove they don't use any
> > deprecated features (any deprecated features, not merely this  NUMA o=
ne).
>=20
> This isn't the first time I wish we had a machine type with
> experimental features enabled.  What about calling it "pc-next"?

No objection from me.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

