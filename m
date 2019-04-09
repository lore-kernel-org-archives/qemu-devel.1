Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B6BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDEB2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDEB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtd9-00021o-4l
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:29:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hDtXy-0005kG-2t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hDtXv-0004Rz-AC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:24:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>)
	id 1hDtXt-0004Ft-20; Tue, 09 Apr 2019 12:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C54753005127;
	Tue,  9 Apr 2019 16:24:10 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.212])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A03911001E6B;
	Tue,  9 Apr 2019 16:24:09 +0000 (UTC)
Message-ID: <fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Date: Tue, 09 Apr 2019 18:24:07 +0200
In-Reply-To: <20190408042747.GI16627@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
	<20190408042747.GI16627@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 09 Apr 2019 16:24:10 +0000 (UTC)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409162407.D5RZgCNXANuT8fbev2ev_KdWCAzHlnUNxhoxCx5Pv3Y@z>

Apologies for taking this long to respond.

On Mon, 2019-04-08 at 14:27 +1000, David Gibson wrote:
> On Tue, Apr 02, 2019 at 12:28:07PM +0200, Greg Kurz wrote:
> > The recent fixes around "host-serial" and "host-model" simply moved
> > the decision to expose host data to the upper layer, ie. libvirt
> > which should be involved in this discussion.
> 
> Right, that's deliberate.  Note that roughly-equivalent information on
> x86 is currently supplied via the SMBIOS.  OpenStack Nova sets that,
> rather than qemu, and I'd like to move towards a common configuration
> model with x86, though it's a fairly long path to there.
> 
> OpenStack had an equivalent security problem to our one, which it
> addressed by taking the host serial from /etc/machine-id if present
> rather than the real host info.

IIUC the situation is a bit different between x86 and ppc64, because
while for the latter SPAPR defines a way for the guest to access
information about the host it's running on, that's not the case for
the former, at least to the best of my knowledge.

What OpenStack is doing is reading the machine-id (if explicitly
configured to do so: the default is to use the guest's own UUID[1])
and exposing that as the *guest* serial, not as the *host* serial.

From libvirt's point of view, the entire mechanism is entirely
optional, so unless the management layer explicitly asks it to set
a certain value for the serial, libvirt will simply pass no
information down to QEMU.

The relevant XML elements[2] are clearly modeled after x86, so I
wonder if Nova is setting them also on ppc64 and if so, what the
guest will ultimately see...

> > Cc'ing Andrea for expertise. Problem exposed below.
> > 
> > The pseries machine used to expose the content of the host's
> > /proc/device-tree/system-id and /proc/device-tree/model in the guest
> > DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> > types. Instead, two new properties where added to the pseries machine:
> > 
> > pseries-4.0.host-serial=string (Host serial number to advertise in guest device tree)
> > pseries-4.0.host-model=string (Host model to advertise in guest device tree)
> > 
> > It is up to the caller to pass something... which may be anything,
> > including something like $(cat /proc/device-tree/system-id) or
> > randomly generated.

What happens if the caller doesn't provide any value? Will QEMU come
up with something itself?

Adding a few extra knobs in the vein as the existing ones sounds like
a fairly reasonable idea. It will still be up to the management layer
to actually provide the values.

> > Is there a chance libvirt can be taught to pass a different string
> > to the target QEMU in case of migration ?

libvirt already supports providing a different XML to the target
host, so changing a couple values should be no big deal.


As a final note, unless I've gotten it wrong and x86 actually *does*
provide a way for the guest to figure out its host's serial, then any
software relying on the attributes defined by SPAPR is ultimately not
portable to non-ppc64 hardware and should probably be rearchitected
to go through the management layer, as Daniel was also suggesting
earlier in the thread.


[1] https://github.com/openstack/nova/blob/master/nova/virt/libvirt/driver.py#L364-L372
[2] https://libvirt.org/formatdomain.html#elementsSysinfo
-- 
Andrea Bolognani / Red Hat / Virtualization


