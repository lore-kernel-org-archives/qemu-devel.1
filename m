Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D66C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478D122DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478D122DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Yc-0007Bk-DO
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i31GD-0004EH-4D
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i31GB-00048p-CC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i31GB-000483-3H; Wed, 28 Aug 2019 12:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C93F30014C6;
 Wed, 28 Aug 2019 16:57:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE4065D713;
 Wed, 28 Aug 2019 16:57:19 +0000 (UTC)
Date: Wed, 28 Aug 2019 18:57:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190828185718.0e4eced8@redhat.com>
In-Reply-To: <20190828143524.GA7642@habkost.net>
References: <20190816170750.23910-1-ehabkost@redhat.com>
 <871rx5eq8j.fsf@dusky.pond.sub.org>
 <20190828143524.GA7642@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 28 Aug 2019 16:57:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] pc: Don't make die-id mandatory unless
 necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Vanderson Martins do Rosario <vandersonmr2@gmail.com>,
 Like Xu <like.xu@linux.intel.com>, Erik Skultety <eskultet@redhat.com>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Aug 2019 11:35:24 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Aug 28, 2019 at 08:52:28AM +0200, Markus Armbruster wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >   
> > > We have this issue reported when using libvirt to hotplug CPUs:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> > >
> > > Basically, libvirt is not copying die-id from
> > > query-hotpluggable-cpus, but die-id is now mandatory.
> > >
> > > We could blame libvirt and say it is not following the documented
> > > interface, because we have this buried in the QAPI schema
> > > documentation:
> > >  
> > >> Note: currently there are 5 properties that could be present
> > >> but management should be prepared to pass through other
> > >> properties with device_add command to allow for future
> > >> interface extension. This also requires the filed names to be kept in
> > >> sync with the properties passed to -device/device_add.  
> > >
> > > But I don't think this would be reasonable from us.  We can just
> > > make QEMU more flexible and let die-id to be omitted when there's
> > > no ambiguity.  This will allow us to keep compatibility with
> > > existing libvirt versions.
> > >
> > > Test case included to ensure we don't break this again.
> > >
> > > Fixes: commit 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > Changes v1 -> v2:
> > > * v1 was "pc: Don't make CPU properties mandatory unless necessary"
> > > * Make only die-id optional (Igor Mammedov)
> > > ---
> > >  hw/i386/pc.c                             |  8 ++++++
> > >  tests/acceptance/pc_cpu_hotplug_props.py | 35 ++++++++++++++++++++++++
> > >  2 files changed, 43 insertions(+)
> > >  create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 3ab4bcb3ca..9c3f6ae828 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -2406,6 +2406,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > >          int max_socket = (ms->smp.max_cpus - 1) /
> > >                                  smp_threads / smp_cores / pcms->smp_dies;
> > >  
> > > +        /*
> > > +         * die-id was optional in QEMU 4.0 and older, so keep it optional
> > > +         * if there's only one die per socket.
> > > +         */  
> > 
> > Is this comment worth its keep?  
> 
> It's not obvious from the code why die-id is optional and all the
> other properties are not.  The purpose of the comment is to
> clarify that.
> 
> >   
> > > +        if (cpu->die_id < 0 && pcms->smp_dies == 1) {
> > > +            cpu->die_id = 0;
> > > +        }
> > > +
> > >          if (cpu->socket_id < 0) {
> > >              error_setg(errp, "CPU socket-id is not set");
> > >              return;
> > > diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/pc_cpu_hotplug_props.py
> > > new file mode 100644
> > > index 0000000000..08b7e632c6
> > > --- /dev/null
> > > +++ b/tests/acceptance/pc_cpu_hotplug_props.py
> > > @@ -0,0 +1,35 @@
> > > +#
> > > +# Ensure CPU die-id can be omitted on -device
> > > +#
> > > +#  Copyright (c) 2019 Red Hat Inc
> > > +#
> > > +# Author:
> > > +#  Eduardo Habkost <ehabkost@redhat.com>
> > > +#
> > > +# This library is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU Lesser General Public
> > > +# License as published by the Free Software Foundation; either
> > > +# version 2 of the License, or (at your option) any later version.
> > > +#
> > > +# This library is distributed in the hope that it will be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > +# Lesser General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU Lesser General Public
> > > +# License along with this library; if not, see <http://www.gnu.org/licenses/>.
> > > +#
> > > +
> > > +from avocado_qemu import Test
> > > +
> > > +class OmittedCPUProps(Test):
> > > +    """
> > > +    :avocado: tags=arch:x86_64
> > > +    """
> > > +    def test_no_die_id(self):
> > > +        self.vm.add_args('-nodefaults', '-S')
> > > +        self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
> > > +        self.vm.add_args('-cpu', 'qemu64')
> > > +        self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
> > > +        self.vm.launch()
> > > +        self.assertEquals(len(self.vm.command('query-cpus')), 2)  

test_plug_with_device_add_x86() is supposed to test device_add (currently broken),
so do we really need more heavy avocado tests,
how about adding this test to tests/cpu-plug-test.c
('make check' is used much more often by developers)

> > This tests intentionally violates the "a CPU hot-plug with -device must
> > specify all the properties returned by query-hotpluggable-cpus" rule
> > laid down in qapi/machine.json, and the change to pc.c permits it.
> > 
> > Missing: a suitable update to the rule.  
> 
> Intentional, because I don't want decisions about documentation
> to block the regression fix from being merged.
> 
> > 
> > In addition, I'd like us to either work on making the rule stick in the
> > future (see my reply to Igor for an idea), or ditch the rule.  But
> > that's outside the scope of this regression fix.  
> 
> I'd prefer to ditch the rule, or at least change it to be a
> suggestion instead of a requirement.
Perhaps someone reads docs and uses API as designed (libvirt is not the only user)

I'd prefer to allow implicit die-id in 4.1 and 'stable' as that
ship has already sailed and make it mandatory since 4.2 as it is
supposed to be (+opening bug on libvirt - hoping that API would
be fixed properly this time).


Another related to die-id series bug:
We should hide die-id from query-hotpluggable-cpus output
for 4.0 and older machine types as well, so it won't break
migration for users that implement interface as documented
as it won't be possible to start
 old-qemu-4.0 -device cpufoo,die-id=0,...
since that "-device cpufoo,die-id=0,..." were used on new-qemu source.

PS:
Adding affected targets maintainers to the loop to see if
we can drop restriction.

Even though it works fine for die-id and I don't see immediate problems
with relaxing rule, I reluctant to do it, since instead of simple
 "add all properties you were told to"
implicit rules would evolve into mess similar to smp_parse() over time.

Also if we would need to change implicit values logic down the road
it would be a pain like with any default parameters in QEMU, which is
a good reason against relaxing rule.


