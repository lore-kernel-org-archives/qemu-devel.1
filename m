Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C7C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340FE2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340FE2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExdW-0002KT-Ex
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 10:58:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hExcb-0001u0-Oq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hExca-0002az-3i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:57:41 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:47152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hExcX-0002Ta-Ua
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:57:39 -0400
Received: from player786.ha.ovh.net (unknown [10.109.143.183])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D30B220682F
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:57:10 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player786.ha.ovh.net (Postfix) with ESMTPSA id 5D5D64D0143E;
	Fri, 12 Apr 2019 14:57:02 +0000 (UTC)
Date: Fri, 12 Apr 2019 16:57:01 +0200
From: Greg Kurz <groug@kaod.org>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190412165701.44079175@bahia.lan>
In-Reply-To: <fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
	<20190408042747.GI16627@umbus.fritz.box>
	<fb1fe659eb80b99b9696ff4b128cd070c4e0dabc.camel@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12053321454071290280
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrvddugdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.98
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
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412145701.5yzR-7A_9nXT2S_iqFMEW6EavlTN2Dy-8wIhx21AKps@z>

On Tue, 09 Apr 2019 18:24:07 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> Apologies for taking this long to respond.
> 

No problem :)

> On Mon, 2019-04-08 at 14:27 +1000, David Gibson wrote:
> > On Tue, Apr 02, 2019 at 12:28:07PM +0200, Greg Kurz wrote:  
> > > The recent fixes around "host-serial" and "host-model" simply moved
> > > the decision to expose host data to the upper layer, ie. libvirt
> > > which should be involved in this discussion.  
> > 
> > Right, that's deliberate.  Note that roughly-equivalent information on
> > x86 is currently supplied via the SMBIOS.  OpenStack Nova sets that,
> > rather than qemu, and I'd like to move towards a common configuration
> > model with x86, though it's a fairly long path to there.
> > 
> > OpenStack had an equivalent security problem to our one, which it
> > addressed by taking the host serial from /etc/machine-id if present
> > rather than the real host info.  
> 
> IIUC the situation is a bit different between x86 and ppc64, because
> while for the latter SPAPR defines a way for the guest to access
> information about the host it's running on, that's not the case for
> the former, at least to the best of my knowledge.
> 
> What OpenStack is doing is reading the machine-id (if explicitly
> configured to do so: the default is to use the guest's own UUID[1])
> and exposing that as the *guest* serial, not as the *host* serial.
> 

Hmm... are you sure ? Daniel seems to be saying the opposite here:

https://bugs.launchpad.net/nova/+bug/1337349/comments/9

which was referring to:

https://bugs.launchpad.net/nova/+bug/1337349/comments/6

> From libvirt's point of view, the entire mechanism is entirely
> optional, so unless the management layer explicitly asks it to set
> a certain value for the serial, libvirt will simply pass no
> information down to QEMU.
> 
> The relevant XML elements[2] are clearly modeled after x86, so I
> wonder if Nova is setting them also on ppc64 and if so, what the
> guest will ultimately see...
> 
> > > Cc'ing Andrea for expertise. Problem exposed below.
> > > 
> > > The pseries machine used to expose the content of the host's
> > > /proc/device-tree/system-id and /proc/device-tree/model in the guest
> > > DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> > > types. Instead, two new properties where added to the pseries machine:
> > > 
> > > pseries-4.0.host-serial=string (Host serial number to advertise in guest device tree)
> > > pseries-4.0.host-model=string (Host model to advertise in guest device tree)
> > > 
> > > It is up to the caller to pass something... which may be anything,
> > > including something like $(cat /proc/device-tree/system-id) or
> > > randomly generated.  
> 
> What happens if the caller doesn't provide any value? Will QEMU come
> up with something itself?
> 

QEMU up to 3.1 used to fill these up with values from directly copied
from the host's device tree. Starting with 4.0, it is up to the caller
to provide values, with no fallback in QEMU.

> Adding a few extra knobs in the vein as the existing ones sounds like
> a fairly reasonable idea. It will still be up to the management layer
> to actually provide the values.
> 

Sure.

> > > Is there a chance libvirt can be taught to pass a different string
> > > to the target QEMU in case of migration ?  
> 
> libvirt already supports providing a different XML to the target
> host, so changing a couple values should be no big deal.
> 

Oh, I didn't know that, but that's cool. It is likely needed for
what Maxiwell's trying to achieve.

> 
> As a final note, unless I've gotten it wrong and x86 actually *does*
> provide a way for the guest to figure out its host's serial, then any
> software relying on the attributes defined by SPAPR is ultimately not
> portable to non-ppc64 hardware and should probably be rearchitected
> to go through the management layer, as Daniel was also suggesting
> earlier in the thread.
> 
> 
> [1] https://github.com/openstack/nova/blob/master/nova/virt/libvirt/driver.py#L364-L372
> [2] https://libvirt.org/formatdomain.html#elementsSysinfo


