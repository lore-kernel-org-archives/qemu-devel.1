Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFD42080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP27xrGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFD42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiTl-0004Wf-8x
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPiSi-0003sa-9z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPiSf-0002M0-9o
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601973400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yp7bRzjl41RMemMJv+HyhXOXK+UVthtom94TvDlJQhk=;
 b=RP27xrGhwmv3RGJAlL41EfpBVPdnzyUFaCdk3h7yQZVgYWxTo192Ie1N4r7Jh2FZggYBHG
 Oz2N2xOSxX8pNuRhmLXk7Dbr4gq0HNsm6ORJRRzeSS1NTmJmLv4xPamWHtJWqB1BigYeAk
 omoYCsR9CriQ9pY72VKc/JFBJRsux60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-E1Nl1OFTOeiocBDavztNcw-1; Tue, 06 Oct 2020 04:36:38 -0400
X-MC-Unique: E1Nl1OFTOeiocBDavztNcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CA2109106E;
 Tue,  6 Oct 2020 08:36:37 +0000 (UTC)
Received: from redhat.com (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 863457838A;
 Tue,  6 Oct 2020 08:36:35 +0000 (UTC)
Date: Tue, 6 Oct 2020 09:36:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Subject: Re: [PATCH v2 1/3] qga: add command guest-get-disks
Message-ID: <20201006083632.GD2482221@redhat.com>
References: <cover.1599470071.git.tgolembi@redhat.com>
 <d8573ee72572ba586c285472789243b37527e2b9.1599470071.git.tgolembi@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d8573ee72572ba586c285472789243b37527e2b9.1599470071.git.tgolembi@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 11:14:40AM +0200, Tomáš Golembiovský wrote:
> Add API and stubs for new guest-get-disks command.
> 
> The command guest-get-fsinfo can be used to list information about disks
> and partitions but it is limited only to mounted disks with filesystem.
> This new command should allow listing information about disks of the VM
> regardles whether they are mounted or not. This can be usefull for
> management applications for mapping virtualized devices or pass-through
> devices to device names in the guest OS.
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |  6 ++++++
>  qga/commands-win32.c |  6 ++++++
>  qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 744c2b5a5d..f99731af51 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -3042,3 +3042,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>  
>      return info;
>  }
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index aaa71f147b..e9976a0c46 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2229,3 +2229,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>  
>      return info;
>  }
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 408a662ea5..70b54e0d07 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -862,6 +862,35 @@
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str'} }
>  
> +##
> +# @GuestDiskInfo:
> +#
> +# @name: device node (Linux) or device UNC (Windows)
> +# @partition: whether this is a partition or disk
> +# @slaves: list of slave devices (Linux)

What are "slave devices" ?

For that matter, please don't use the term "slaves" at all in any
new code.

> +# @address: disk address information (only for non-virtual devices)
> +# @alias: optional alias assigned to the disk, on Linux this is a name assigned
> +#         by device mapper
> +#
> +# Since 5.2
> +##
> +{ 'struct': 'GuestDiskInfo',
> +  'data': {'name': 'str', 'partition': 'bool', 'slaves': ['str'],
> +           '*address': 'GuestDiskAddress', '*alias': 'str'} }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


