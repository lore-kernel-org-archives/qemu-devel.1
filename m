Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083242078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBLpKEa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083242078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlRD-0006iZ-2X
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHlQR-0006HD-Ed
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHlQK-0006kq-44
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600078162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btL/XCcR2ElM9o1Z6wzGb21Rzgql8/q3+WXl1pNqG2o=;
 b=eBLpKEa9tZJqyf74iXkBmLNTqBImjgUGwwqNJPTuvEPwied73In4JXDJxsHBt/e7pJmnS0
 HMpF6wrjaunxvE5NdTCIOVMnxNwmxuwuE8D33pXlHMa1dGU1y9qWKf/49jTqxcZXOTppdo
 Ii7KoXoTBD3UdxjwwJK4HgEkID+RZbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-tHZASE4VOYuRDIdN7DwQSA-1; Mon, 14 Sep 2020 06:09:19 -0400
X-MC-Unique: tHZASE4VOYuRDIdN7DwQSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FA78030BA;
 Mon, 14 Sep 2020 10:09:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E10417A1FC;
 Mon, 14 Sep 2020 10:09:07 +0000 (UTC)
Date: Mon, 14 Sep 2020 12:09:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2] cphp: remove deprecated cpu-add command(s)
Message-ID: <20200914120901.1f8769fb@redhat.com>
In-Reply-To: <f8406b80-0243-49bf-a384-5c625d9a7974@redhat.com>
References: <20200914074614.973112-1-imammedo@redhat.com>
 <f8406b80-0243-49bf-a384-5c625d9a7974@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 10:07:36 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> On 9/14/20 9:46 AM, Igor Mammedov wrote:
> > theses were deprecated since 4.0, remove both HMP and QMP variants.
> > 
> > Users should use device_add command instead. To get list of
> > possible CPUs and options, use 'info hotpluggable-cpus' HMP
> > or query-hotpluggable-cpus QMP command.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   include/hw/boards.h         |   1 -
> >   include/hw/i386/pc.h        |   1 -
> >   include/monitor/hmp.h       |   1 -
> >   docs/system/deprecated.rst  |  25 +++++----
> >   hmp-commands.hx             |  15 ------
> >   hw/core/machine-hmp-cmds.c  |  12 -----
> >   hw/core/machine-qmp-cmds.c  |  12 -----
> >   hw/i386/pc.c                |  27 ----------
> >   hw/i386/pc_piix.c           |   1 -
> >   hw/s390x/s390-virtio-ccw.c  |  12 -----
> >   qapi/machine.json           |  24 ---------
> >   tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
> >   tests/qtest/test-hmp.c      |   1 -
> >   13 files changed, 21 insertions(+), 211 deletions(-)  
> 
> Thanks to Peter Libvirt uses device_add instead cpu_add whenever 
> possible. Hence this is okay from Libvirt's POV.
we shoul make libvirt switch from -numa node,cpus= to -numa cpu=
to get rid of the 'last' interface that uses cpu-index as input.

To help libvirt to migrate existing configs from older syntax to
the newer one, we can introduce field x-cpu-index to
query-hotplugable-cpus output (with a goal to deprecate it in few years).
Would it work for you?

> 
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Thanks!

> 
> Michal
> 


