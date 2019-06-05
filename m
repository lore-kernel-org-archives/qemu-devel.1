Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3B020866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3B020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZoE-0007E1-7k
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:34:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYZn4-0006fX-1a
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYZn2-0001wb-IN
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYZmx-0001eX-5i
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FD6A883BA
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 17:33:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 325CC1019615;
	Wed,  5 Jun 2019 17:33:14 +0000 (UTC)
Date: Wed, 5 Jun 2019 18:33:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190605173311.GA13261@redhat.com>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 05 Jun 2019 17:33:25 +0000 (UTC)
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
	armbru@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To summarize implications on libvirt...

This patch currently doesn't change the deprecation status of any machine
type, so it is effectively no-op metadata addition right now.

Libvirt version N can implement support for this today, and nothing would
change from a functional POV with QEMU 4.1.

At some later time, a QEMU release X.Y will mark a new machine type has
having this deprecation enabled, at which point the dormant libvirt logic
will activate, causing libvirt to use the new syntax for NUMA.


IOW, libvirt version N onwards can live migrate QEMU with machine type
pc-X.Y to a host with arbitrary future libvirt or QEMU version.

Libvirt version N-1  can *not* live migrate QEMU with machine type
pc-X.Y to a host with libvirt version N or newer.

This restriction won't be a problem in practice if there's a moderate
time window between libvirt implementing support for this concept,
and the future QEMU X.Y which actually enables the deprecation.

The main downside of this approach is the one Eduardo raised previously
which is that the dormant libvirt logic will not be testable/tested until
that QEMU X.Y actually arrives.

The testing gap is not nice, but I don't think it is sufficient to reject
this approach entirely.

I wonder if there's a way to close the testing gap somehow ? Random idea
would be a non-versioned "pc-no-deprecated" machine type, which blocks
all use of deprecated features and does not promise any migration compat.
Essentially it would exist just for testing purposem as a way todo
functional tests for libvirt & mgmt apps to prove they don't use any
deprecated features (any deprecated features, not merely this  NUMA one).

On Thu, May 30, 2019 at 10:33:16AM +0200, Igor Mammedov wrote:
> Changes since v3:
>   - simplify series by dropping idea of showing property values in "qom-list-properties"
>     and use MachineInfo in QAPI schema instead
> 
> Changes since v2:
>   - taking in account previous review, implement a way for mgmt to intospect if
>     '-numa node,mem' is supported by machine type as suggested by Daniel at
>              https://www.mail-archive.com/qemu-devel@nongnu.org/msg601220.html
>       * ammend "qom-list-properties" to show property values
>       * add "numa-mem-supported" machine property to reflect if '-numa node,mem=SZ'
>         is supported. It culd be used with '-machine none' or at runtime with
>         --preconfig before numa memory mapping are configured
>   * minor fixes to deprecation documentation mentioning "numa-mem-supported" property
> 
>  1) "I'm considering to deprecating -mem-path/prealloc CLI options and replacing
> them with a single memdev Machine property to allow interested users to pick
> used backend for initial RAM (fixes mixed -mem-path+hostmem backends issues)
> and as a transition step to modeling initial RAM as a Device instead of
> (ab)using MemoryRegion APIs."
> (for more details see: https://www.mail-archive.com/qemu-devel@nongnu.org/msg596314.html)
> 
> However there is a couple of roadblocks on the way (s390x and numa memory handling).
> I think I finally thought out a way to hack s390x in migration compatible manner,
> but I don't see any way to do it for -numa node,mem and default RAM assignement
> to nodes. Considering both numa usecases aren't meaningfully using NUMA (aside
> guest side testing) and could be replaced with explicitly used memdev parameter,
> I'd like to propose removing these fake NUMA friends on new machine types,
> hence this deprecation. And once the last machie type that supported the option
> is removed we would be able to remove option altogether.
> 
> As result of removing deprecated options and replacing initial RAM allocation
> with 'memdev's (1), QEMU will allocate guest RAM in consistent way, fixing mixed
> use-case and allowing boards to move towards modelling initial RAM as Device(s).
> Which in its own turn should allow to cleanup NUMA/HMP/memory accounting code
> more by dropping ad-hoc node_mem tracking and reusing memory device enumeration
> instead.
> 
> Reference to previous versions:
>  * https://www.mail-archive.com/qemu-devel@nongnu.org/msg617694.html
> 
> CC: libvir-list@redhat.com
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: berrange@redhat.com
> CC: armbru@redhat.com
> 
> Igor Mammedov (3):
>   machine: show if CLI option '-numa node,mem' is supported in QAPI
>     schema
>   numa: deprecate 'mem' parameter of '-numa node' option
>   numa: deprecate implict memory distribution between nodes
> 
>  include/hw/boards.h  |  3 +++
>  hw/arm/virt.c        |  1 +
>  hw/i386/pc.c         |  1 +
>  hw/ppc/spapr.c       |  1 +
>  numa.c               |  5 +++++
>  qapi/misc.json       |  5 ++++-
>  qemu-deprecated.texi | 24 ++++++++++++++++++++++++
>  vl.c                 |  1 +
>  8 files changed, 40 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

