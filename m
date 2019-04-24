Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24570C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8512148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8512148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJDN9-0000oI-Vv
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 04:35:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDLU-00083L-6L
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDJJ-0002xI-HS
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hJDJJ-0002xB-By
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A99A8307D859
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 08:31:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CED5600C5;
	Wed, 24 Apr 2019 08:31:16 +0000 (UTC)
Date: Wed, 24 Apr 2019 09:31:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190424083113.GE28615@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <2b1d825f-8bd3-ba25-3e1b-8415aeec8ce6@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 24 Apr 2019 08:31:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: mprivozn@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424083113.00qXk8C7gxjYyWvkbn9R3tIvAg-4dNG8V6WNh6iE97s@z>

On Wed, Apr 24, 2019 at 09:56:53AM +0200, Thomas Huth wrote:
> On 23/04/2019 23.22, Eduardo Habkost wrote:
> > This series adds machine type deprecation information to the
> > output of the `query-machines` QMP command.  With this, libvirt
> > and management software will be able to show this information to
> > users and/or suggest changes to VM configuration to avoid
> > deprecated machine types.
> > 
> > Eduardo Habkost (3):
> >   qapi: SupportStatusInfo struct
> >   machine: Use SupportStatusInfo for deprecation info
> >   qmp: Add deprecation information to query-machines
> > 
> >  qapi/common.json                   | 24 ++++++++++++++++++++++++
> >  qapi/misc.json                     |  5 ++++-
> >  include/hw/boards.h                |  7 ++++---
> >  hw/i386/pc_piix.c                  |  4 +++-
> >  hw/ppc/prep.c                      |  4 +++-
> >  vl.c                               | 19 +++++++++++++++----
> >  tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
> >  7 files changed, 80 insertions(+), 10 deletions(-)
> >  create mode 100644 tests/acceptance/query_machines.py
> 
> Good idea, but some questions come to my mind:
> 
> - What about devices? IIRC Gerd wrote a patch series last year that does
>   something similar for devices... It would be good to synchronize the
>   work, so that we do not have two completely interfaces between devices
>   and machines here in the end...

Might as well add  CPU models to that too as there's plenty of awful
CPUs no one should use with KVM. The tricky thing is they are fine
/ sensible with TCG still.

> 
> - Is deprecation as a status enough, or do we want to carry more
>   information here? E.g. is the machine maintained or orphan? Is it
>   stable or rather experimental? And didn't Gerd have also some
>   patches for this last year? ... yes, I think it was this series here:
>   http://lists.gnu.org/archive/html/qemu-ppc/2018-11/msg00039.html
>   ... actually, I like that idea with QemuSupportState... maybe you
>   could base your work on that series instead?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

