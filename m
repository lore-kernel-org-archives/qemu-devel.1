Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530DC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B4524125
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViDij9xU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B4524125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig3lu-00020m-Rg
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig3ks-0001UU-KT
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig3kq-0001rm-7j
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:30:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig3kq-0001q4-1b
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576315827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krUqtHQq2+/RjAJg5zXYP5k6eEvtTAFZGy9yHCYbMjo=;
 b=ViDij9xU9hEgTKy8NfpeadLSbHBsXynx83c9gBp/7T3VajN/RLKDunr4vMCODZjSz0HSIy
 3St0KzejfsH9+dRKTCO5V9BeGP9dkvbV6U104t9YmCuL0Mu36JQhXxbefr+6PF3nsHvcNw
 7bBgD0C0+5s4faRmyWpl1KmbgfbqtHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-7mDK5tegOZit7Fo8ZI7Syg-1; Sat, 14 Dec 2019 04:30:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A492F61;
 Sat, 14 Dec 2019 09:30:23 +0000 (UTC)
Received: from gondolin (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD5F5C298;
 Sat, 14 Dec 2019 09:30:21 +0000 (UTC)
Date: Sat, 14 Dec 2019 10:30:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/16] first s390x update for 5.0
Message-ID: <20191214103019.74bcd9f8.cohuck@redhat.com>
In-Reply-To: <CAFEAcA8O=ezHAQKKr9zrA0M_TE-FbnHmict5K8_+5v64BDoTxA@mail.gmail.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
 <CAFEAcA8O=ezHAQKKr9zrA0M_TE-FbnHmict5K8_+5v64BDoTxA@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 7mDK5tegOZit7Fo8ZI7Syg-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 21:12:18 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 13 Dec 2019 at 16:19, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f:
> >
> >   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cohuck/qemu tags/s390x-20191213
> >
> > for you to fetch changes up to b147562019dd845a224cde7a37c219f9848d1b8d:
> >
> >   qga: fence guest-set-time if hwclock not available (2019-12-13 12:16:50 +0100)
> >
> > ----------------------------------------------------------------
> > First s390x update for 5.0:
> > - compat machines (also for other architectures)
> > - cleanups and fixes in reset handling
> > - fence off guest-set-time, as we have no hwclock
> > - fix some misuses of the error API
> > - further cleanups
> >
> > ----------------------------------------------------------------
> >  
> 
> Hi -- this has conflicts. Most of them I could probably fix up,
> but this one in particular:
> 
> diff --cc hw/s390x/s390-virtio-ccw.c
> index cb5fe4c84d,e0e28139a2..0000000000
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@@ -645,9 -658,10 +658,13 @@@ static void ccw_machine_4_2_instance_op
> 
>   static void ccw_machine_4_2_class_options(MachineClass *mc)
>   {
> ++<<<<<<< HEAD
> ++=======
> +     ccw_machine_5_0_class_options(mc);
> ++>>>>>>> remotes/cohuck/tags/s390x-20191213  
>       compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>   }
> - DEFINE_CCW_MACHINE(4_2, "4.2", true);
> + DEFINE_CCW_MACHINE(4_2, "4.2", false);
> 
>   static void ccw_machine_4_1_instance_options(MachineState *machine)
>   {
> 
> 
> I don't know whether we want the 'true' or 'false' version...
> 
> Could you rebase and resend, please?
> 
> thanks
> -- PMM
> 

Yes, that's because 5f2585772fff ("virtio-blk: advertise F_WCE
(F_FLUSH) if F_CONFIG_WCE is advertised") introduced 4.2 compat options
before introducing the 5.0 machine types :/

Will send a rebased version.


