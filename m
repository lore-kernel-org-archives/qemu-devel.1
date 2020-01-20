Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C0A2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWOk85aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C0A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUM0-0001T5-39
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itUKj-0000Yh-G5
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itUKi-00087J-1D
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itUKh-00086K-Tf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6N0ShmSlnD5tAHaBlzCb6wLvRQ0yAmGd4ejIOdMpzY=;
 b=WWOk85aPsNWWl/6WI+zRWug2jrkxZv+p/+S1amK9TYiqJocf+7bmh2qeCyr4IzBDQg1QqD
 N8vZch1VlHxYL7SOD8OqnudC3w+DhcLNEoxyt6mSDq9KPJQYir3v7K8y64snAdPsAkjGp3
 xy0r76CGFgCPlfxayrJgcC0qodYBVwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-DKjNUYwiMuGt5v11XiwMqw-1; Mon, 20 Jan 2020 05:30:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 562338017CC;
 Mon, 20 Jan 2020 10:30:54 +0000 (UTC)
Received: from gondolin (ovpn-205-161.brq.redhat.com [10.40.205.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB58D60BF7;
 Mon, 20 Jan 2020 10:30:49 +0000 (UTC)
Date: Mon, 20 Jan 2020 11:30:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200120113046.05d37145.cohuck@redhat.com>
In-Reply-To: <20200120094901.6432-1-thuth@redhat.com>
References: <20200120094901.6432-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DKjNUYwiMuGt5v11XiwMqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 10:49:01 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The AIS feature has been disabled late in the v2.10 development cycle since
> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
> to enable it again for newer machine types, but apparently we forgot to do
> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
> 
> While at it, also add a more verbose comment why we need the *_allowed()
> wrappers in s390-virtio-ccw.c.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Matthew, could you please give this another try on your system? Thanks!
> 
>  hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  target/s390x/kvm.c                 |  9 ++++++---
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 

> @@ -658,6 +669,9 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>  
>  static void ccw_machine_4_2_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
> +    s390mc->kvm_ais_allowed = false;
>      ccw_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);

One thing I've noticed: You set the _allowed value to false, and
afterwards apply the options from any 'later' class; this is the same
order as for the other _allowed values. There's also
css_migration_enabled, which is set to false _after_ the class options
from 'later' classes have been applied.

Both variants end up the same, as we only ever set the value to true in
the base class and to false just in a single class option callback; but
I wonder whether it would be cleaner to set it to false after the other
options have been applied. Or am I thinking backwards here?

>  }


