Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9C12068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmPOKkMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9C12068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6RM-0005iH-C3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ic6Ao-0004hH-MS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ic6Ag-0007rP-6o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ic6Ad-0007lS-Sw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575371802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46GkAHZ0kT4yudLpq/A3X3Stoo/DLwoWQbUp1hxmoeM=;
 b=DmPOKkMgJvCJmn1EX9bhw0x+PFj/CwFg1Tu7W7X/mftgOeE1tJdH3Z3RGNAtJCf9gXywi/
 le/0zSpUFuuMr0cKhfBn9nQArvihg5s06E0wXigiB9cpDWHXRXsfKd0o6dZbHSvApKXwPv
 bdt5AN6cwdMxiblTWGVSyQM1C+s6tfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-EszTurjQMXW19SBBsTCvXg-1; Tue, 03 Dec 2019 06:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E8DD107ACC4;
 Tue,  3 Dec 2019 11:16:39 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A05E85DA70;
 Tue,  3 Dec 2019 11:16:33 +0000 (UTC)
Date: Tue, 3 Dec 2019 12:16:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v5 03/13] hw/core: create Resettable QOM interface
Message-ID: <20191203121630.279e68e3.cohuck@redhat.com>
In-Reply-To: <20191018150630.31099-4-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-4-damien.hedde@greensocs.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EszTurjQMXW19SBBsTCvXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, mark.burton@greensocs.com, qemu-devel@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 17:06:20 +0200
Damien Hedde <damien.hedde@greensocs.com> wrote:

> This commit defines an interface allowing multi-phase reset. This aims
> to solve a problem of the actual single-phase reset (built in
> DeviceClass and BusClass): reset behavior is dependent on the order
> in which reset handlers are called. In particular doing external
> side-effect (like setting an qemu_irq) is problematic because receiving
> object may not be reset yet.
> 
> The Resettable interface divides the reset in 3 well defined phases.
> To reset an object tree, all 1st phases are executed then all 2nd then
> all 3rd. See the comments in include/hw/resettable.h for a more complete
> description. The interface defines 3 phases to let the future
> possibility of holding an object into reset for some time.
> 
> The qdev/qbus reset in DeviceClass and BusClass will be modified in
> following commits to use this interface. A mechanism is provided
> to allow executing a transitional reset handler in place of the 2nd
> phase which is executed in children-then-parent order inside a tree.
> This will allow to transition devices and buses smoothly while
> keeping the exact current qdev/qbus reset behavior for now.
> 
> Documentation will be added in a following commit.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> 
> In this patch only a single reset type is supported, but the interface
> allows for more to be defined.
> 
> I had some thought about problems which may arise when having multiple
> reset types:
> 
> - reset type propagation. Right now we propagate the same reset type
>   to the children. I don't think it will work that with multiple
>   types.
>   For example, if we add pci_bus_reset type: a pci device will
>   implement the reset type but not its children (they may have
>   nothing to do with pci).
>   This can be solved by changing the child_foreach method rules.
>   We should say that child_foreach may change the type it
>   propagates to its children (on a children by children basis).
>   For example, the pci device may just propagate cold reset type
>   to its children.
>   For this we need to pass the type as parameter to child_foreach()
>   method.
> 
> - are all children concerned ? For a given reset type, some child
>   may not need to be reset. As above we can handle that with
>   child_foreach: an resettable object can propagate the reset only
>   to a partial set of its child.
>   For this we need to know the type when we release the reset,
>   that's why I added it to resettable_release_reset() even if it
>   is unused right now.
>   I've also added an opaque parameter to child_foreach. I think
>   we will need that to handle the change of parent because we
>   will need to test if a child is concerned by a reset type: the
>   opaque will allow to use a test callback and get some result.

What about an optional ->filter() callback? That would be invoked if
existing prior to calling the child_foreach callback and could be used
to exclude children from the reset for this round for all callbacks. Or
have it modify the reset type (like in your pci reset -> cold reset
example above), and completely skip it if the reset type has been
modified to a 'no reset' type?

> 
> - several reset types at the same time. I don't another solution
>   than saying we execute *enter* and *hold* phase for every reset
>   type. *exit* will still be executed once for all at the end.
>   It will be up for each object to cope with it if it handle
>   multiple reset types. For *enter* is trivial, calling it twice
>   in a row is no problem given that it should only reset internal
>   state. For *hold* there may be some complication.
> 
> - Obviously we will need to at least an interface class field to hold
>   the supported reset types by the class. Also the reset state will
>   need some modification.
> ---
>  Makefile.objs           |   1 +
>  hw/core/Makefile.objs   |   1 +
>  hw/core/resettable.c    | 230 ++++++++++++++++++++++++++++++++++++++++
>  hw/core/trace-events    |  17 +++
>  include/hw/resettable.h | 199 ++++++++++++++++++++++++++++++++++
>  5 files changed, 448 insertions(+)
>  create mode 100644 hw/core/resettable.c
>  create mode 100644 include/hw/resettable.h


