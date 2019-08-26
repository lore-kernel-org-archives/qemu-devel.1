Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CAC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB802053B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB802053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53281 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Ffe-0005lL-7n
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i2FdK-00044E-3f
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i2FdE-0005DY-J8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i2FdB-00057r-VG; Mon, 26 Aug 2019 10:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F0EF3082B43;
 Mon, 26 Aug 2019 14:05:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D029E600D1;
 Mon, 26 Aug 2019 14:05:53 +0000 (UTC)
Date: Mon, 26 Aug 2019 16:05:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190826160552.77c35ac7@redhat.com>
In-Reply-To: <20190816170750.23910-1-ehabkost@redhat.com>
References: <20190816170750.23910-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 26 Aug 2019 14:05:58 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 14:07:50 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> We have this issue reported when using libvirt to hotplug CPUs:
> https://bugzilla.redhat.com/show_bug.cgi?id=1741451
> 
> Basically, libvirt is not copying die-id from
> query-hotpluggable-cpus, but die-id is now mandatory.
> 
> We could blame libvirt and say it is not following the documented
> interface, because we have this buried in the QAPI schema
> documentation:
> 
> > Note: currently there are 5 properties that could be present
> > but management should be prepared to pass through other
> > properties with device_add command to allow for future
> > interface extension. This also requires the filed names to be kept in
> > sync with the properties passed to -device/device_add.  
> 
> But I don't think this would be reasonable from us.  We can just
> make QEMU more flexible and let die-id to be omitted when there's
> no ambiguity.  This will allow us to keep compatibility with
> existing libvirt versions.
> 
> Test case included to ensure we don't break this again.
> 
> Fixes: commit 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Changes v1 -> v2:
> * v1 was "pc: Don't make CPU properties mandatory unless necessary"
> * Make only die-id optional (Igor Mammedov)
> ---
>  hw/i386/pc.c                             |  8 ++++++
>  tests/acceptance/pc_cpu_hotplug_props.py | 35 ++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3ab4bcb3ca..9c3f6ae828 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2406,6 +2406,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          int max_socket = (ms->smp.max_cpus - 1) /
>                                  smp_threads / smp_cores / pcms->smp_dies;
>  
> +        /*
> +         * die-id was optional in QEMU 4.0 and older, so keep it optional
> +         * if there's only one die per socket.
> +         */
> +        if (cpu->die_id < 0 && pcms->smp_dies == 1) {
> +            cpu->die_id = 0;
> +        }
> +
>          if (cpu->socket_id < 0) {
>              error_setg(errp, "CPU socket-id is not set");
>              return;
> diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/pc_cpu_hotplug_props.py
> new file mode 100644
> index 0000000000..08b7e632c6
> --- /dev/null
> +++ b/tests/acceptance/pc_cpu_hotplug_props.py
> @@ -0,0 +1,35 @@
> +#
> +# Ensure CPU die-id can be omitted on -device
> +#
> +#  Copyright (c) 2019 Red Hat Inc
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +from avocado_qemu import Test
> +
> +class OmittedCPUProps(Test):
> +    """
> +    :avocado: tags=arch:x86_64
> +    """
> +    def test_no_die_id(self):
> +        self.vm.add_args('-nodefaults', '-S')
> +        self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
> +        self.vm.add_args('-cpu', 'qemu64')
> +        self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
> +        self.vm.launch()
> +        self.assertEquals(len(self.vm.command('query-cpus')), 2)


