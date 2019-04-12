Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7002C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A422083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A422083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38471 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExnA-0006PN-Su
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:08:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hExlw-0005ji-3T
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hExls-0007op-9X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hExlr-0007oI-U0; Fri, 12 Apr 2019 11:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC85A3088B89;
	Fri, 12 Apr 2019 15:07:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D9705D6A9;
	Fri, 12 Apr 2019 15:07:10 +0000 (UTC)
Date: Fri, 12 Apr 2019 16:07:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190412150707.GD25308@redhat.com>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
	<20190408042747.GI16627@umbus.fritz.box>
	<fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
	<20190412165701.44079175@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190412165701.44079175@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 15:07:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Andrea Bolognani <abologna@redhat.com>,
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412150707.OSDvPCB1slgro_Er4kLx4QfjRxHJ0mhGSZ1KqJSCgvA@z>

On Fri, Apr 12, 2019 at 04:57:01PM +0200, Greg Kurz wrote:
> On Tue, 09 Apr 2019 18:24:07 +0200
> Andrea Bolognani <abologna@redhat.com> wrote:
> 
> > Apologies for taking this long to respond.
> > 
> 
> No problem :)
> 
> > On Mon, 2019-04-08 at 14:27 +1000, David Gibson wrote:
> > > On Tue, Apr 02, 2019 at 12:28:07PM +0200, Greg Kurz wrote:  
> > > > The recent fixes around "host-serial" and "host-model" simply moved
> > > > the decision to expose host data to the upper layer, ie. libvirt
> > > > which should be involved in this discussion.  
> > > 
> > > Right, that's deliberate.  Note that roughly-equivalent information on
> > > x86 is currently supplied via the SMBIOS.  OpenStack Nova sets that,
> > > rather than qemu, and I'd like to move towards a common configuration
> > > model with x86, though it's a fairly long path to there.
> > > 
> > > OpenStack had an equivalent security problem to our one, which it
> > > addressed by taking the host serial from /etc/machine-id if present
> > > rather than the real host info.  
> > 
> > IIUC the situation is a bit different between x86 and ppc64, because
> > while for the latter SPAPR defines a way for the guest to access
> > information about the host it's running on, that's not the case for
> > the former, at least to the best of my knowledge.
> > 
> > What OpenStack is doing is reading the machine-id (if explicitly
> > configured to do so: the default is to use the guest's own UUID[1])
> > and exposing that as the *guest* serial, not as the *host* serial.
> > 
> 
> Hmm... are you sure ? Daniel seems to be saying the opposite here:
> 
> https://bugs.launchpad.net/nova/+bug/1337349/comments/9

Note my comment is from 2014, where as Andrea is describing OpenStack's
impl in 2019 :-)

Originally Nova would populate guest SMBIOS with a UUID taken
from Host SMBIOS

My fix for the security problem made it use host /etc/machine-id
instead of Host SMBIOS when /etc/machine-id is available.

In Nova 2018, Nova was changed to use the guest instance UUID
instead of /etc/machine-id by default.

Anyway the key factor is to *never* expose and UUID you get
from the host hardware as vendors frequently treat these as
semi-secret keys.

If you need a UUID, it has to be software generated from
somewhere and not otherwise need to be kept private.

As long as QEMU lets this be configurable, libvirt can plumb
it into its sysinfo XML and thus we can ultimately delegate
the decision to the mgmt app like OpenStack.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

