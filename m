Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D3C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7442146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7442146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6rO-00010J-Jm
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:03:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hQ6np-0006kR-BS
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hQ6ej-0006AU-6T
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hQ6ee-00066E-P7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29B31A0636;
	Mon, 13 May 2019 08:49:50 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-249.ams2.redhat.com
	[10.36.117.249])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D51B10027BF;
	Mon, 13 May 2019 08:49:47 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id 761E43E0060; Mon, 13 May 2019 10:49:45 +0200 (CEST)
Date: Mon, 13 May 2019 10:49:45 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190513084945.GA15247@paraplu>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190512142108-mutt-send-email-mst@kernel.org>
	<3779f01f-8a5b-0785-254b-d1a4cfdf593c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3779f01f-8a5b-0785-254b-d1a4cfdf593c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 13 May 2019 08:49:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/3] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 08:36:23AM +0200, Laurent Vivier wrote:
> On 12/05/2019 20:21, Michael S. Tsirkin wrote:

[...]

> > > Kashyap Chamarthy (1):
> > >    VirtIO-RNG: Update default entropy source to `/dev/urandom`
> > > 
> > > Laurent Vivier (2):
> > >    rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
> > >    virtio-rng: change default backend to rng-builtin
> > 
> > 
> > OK pls address Marku's comment on commit msg and I will merge.
> 
> Kashyap,
> 
> as this patch is from you, do you agree?

Yes.

> If so, I can update the message and send a new version of the series
> (or you canr esend your patch alone if you prefer).

Please go ahead and add it, the below is the text (from Dan/Markus):

    What about other OSes?
    ----------------------
    
    `/dev/urandom` exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
    and OpenBSD, which cover all the non-Linux platforms we explicitly
    support, aside from Windows.
    
    On Windows `/dev/random` doesn't work either so we don't regress.
    This is actually another argument in favour of using the newly
    proposed 'rng-builtin' backend by default, as that will work on
    Windows.

Thanks!

[...]

-- 
/kashyap

