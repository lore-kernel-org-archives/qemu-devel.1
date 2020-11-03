Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4895CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7D122370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPFDLg8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7D122370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyy9-0001d6-LW
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZys2-0003U0-5O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:09:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZyrz-0005eL-8U
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604419753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LotJNhTI2rO3TJnVQ4PaWnClZei+7rEJA2Z6dLGRzHc=;
 b=DPFDLg8Bn49DfUxE7MWBPrid57yC3zuIjnyLH9xjtOkrzz4eJefFx5kLcNt0ojT0AivyZI
 nCsmDJAjf297elYm5nFiGThN23Fiay9+8KUFKF3a0yZJDVx+vVINswhmpJsa1DNJDSsTc1
 gj7igJwW+Yw6fYGhpR977FFSIWL7HqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-V_zi3_k0O8OyGVyu6kX30w-1; Tue, 03 Nov 2020 11:09:06 -0500
X-MC-Unique: V_zi3_k0O8OyGVyu6kX30w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81438AF2EB
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 16:08:47 +0000 (UTC)
Received: from redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2E0B10013C1;
 Tue,  3 Nov 2020 16:08:46 +0000 (UTC)
Date: Tue, 3 Nov 2020 16:08:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
Message-ID: <20201103160843.GP205187@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103151452.416784-5-pbonzini@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 10:14:52AM -0500, Paolo Bonzini wrote:
> Options such as "server" or "nowait", that are commonly found in -chardev,
> are sugar for "server=on" and "wait=off".  This is quite surprising and
> also does not have any notion of typing attached.  It is even possible to
> do "-device e1000,noid" and get a device with "id=off".
> 
> Deprecate all this, except for -chardev and -spice where it is in
> wide use.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char.c             |  1 +
>  docs/system/deprecated.rst |  7 +++++++
>  include/qemu/option.h      |  1 +
>  tests/test-qemu-opts.c     |  1 +
>  ui/spice-core.c            |  1 +
>  util/qemu-option.c         | 22 +++++++++++++++-------
>  6 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 78553125d3..108da615df 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -829,6 +829,7 @@ Chardev *qemu_chr_find(const char *name)
>  
>  QemuOptsList qemu_chardev_opts = {
>      .name = "chardev",
> +    .allow_flag_options = true, /* server, nowait, etc. */
>      .implied_opt_name = "backend",
>      .head = QTAILQ_HEAD_INITIALIZER(qemu_chardev_opts.head),
>      .desc = {
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 32a0e620db..0e7edf7e56 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -146,6 +146,13 @@ Drives with interface types other than ``if=none`` are for onboard
>  devices.  It is possible to use drives the board doesn't pick up with
>  -device.  This usage is now deprecated.  Use ``if=none`` instead.
>  
> +Short-form boolean options (since 5.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +Boolean options such as ``share=on``/``share=off`` can be written
> +in short form as ``share`` and ``noshare``.  This is deprecated
> +for all command-line options except ``-chardev` and ``-spice``, for
> +which the short form was in wide use.

So IIUC, the short form was possible to use for absolutely /any/
boolean property ?

IMHO if we're going to deprecate short forms, we should do it
universally including chardev and spice. Arguably spice/chardev
are the most important ones to give an explicit warning about
precisely because their widespread usage means a heads up is
important to users.  For chardev in particular it is possible
we might end up wanting to wait longer than the usual 2 cycles
before removal. So if we're serious about removing the short
forms long term, the sooner we deprecate & warn the better
for chardev.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


