Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66232C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC992177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry1FBCXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC992177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBD07-00064F-Ey
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBCyg-00042H-Kd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:09:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBCye-0002pC-NZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598515784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiUSUVaV7yCQKnHmW+6YYOGpEA2xiF2TilGLq3dIZ6U=;
 b=Ry1FBCXVuKsF8+KH5OI51Kd7WVdEd5PPEVCW5bK6+Y1hZ58Q5uGtd4w1CAP9Rlg/MWSrTH
 siV7HB9NW6YTuE2t9cRr7srDblUVGv1VLHiTpqsN/hvQ4ttrAwyg9vTD/4tenqFJfUt3ki
 iHj5GEJeHpaUmyq/0XhfAZ/AQ9PzQgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-V8WJbQDHOi-BtTUwvimkXg-1; Thu, 27 Aug 2020 04:09:41 -0400
X-MC-Unique: V8WJbQDHOi-BtTUwvimkXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182CD1074652;
 Thu, 27 Aug 2020 08:09:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDC877B9F2;
 Thu, 27 Aug 2020 08:09:38 +0000 (UTC)
Date: Thu, 27 Aug 2020 09:09:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Bozuta <Filip.Bozuta@syrmia.com>
Subject: Re: [PATCH v3 0/8] linux-user: Adding support for a group of btrfs
 ioctls
Message-ID: <20200827080935.GC192458@redhat.com>
References: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
MIME-Version: 1.0
In-Reply-To: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 23, 2020 at 09:50:06PM +0200, Filip Bozuta wrote:
> This series covers support for following btrfs ioctls
> 
>     *BTRFS_SUBVOL_CREATE           *BTRFS_IOC_ADD_DEV
>     *BTRFS_SUBVOL_SETFLAGS         *BTRFS_IOC_RM_DEV
>     *BTRFS_SUBVOL_GETFLAGS         *BTRFS_IOC_DEV_INFO
>     *BTRFS_GET_SUBVOL_INFO         *BTRFS_IOC_GET_DEV_STATS
>     *BTRFS_IOC_SNAP_CREATE         *BTRFS_IOC_GET_FEATURES
>     *BTRFS_IOC_SNAP_DESTROY        *BTRFS_IOC_SET_FEATURES
>     *BTRFS_IOC_SCAN_DEV            *BTRFS_IOC_GET_SUPPORTED_FEATURES
>     *BTRFS_IOC_DEFAULT_SUBVOL      *BTRFS_IOC_QUOTA_RESCAN
>     *BTRFS_IOC_GET_SUBVOL_ROOTREF  *BTRFS_IOC_QUOTA_RESCAN_WAIT
>     *BTRFS_IOC_QUOTA_CTL           *BTRFS_IOC_SCRUB
>     *BTRFS_IOC_QGROUP_CREATE       *BTRFS_IOC_SCRUB_CANCEL
>     *BTRFS_IOC_QGROUP_ASSIGN       *BTRFS_IOC_SCRUB_PROGRESS
>     *BTRFS_IOC_INO_PATHS           *BTRFS_IOC_QGROUP_LIMIT
>     *BTRFS_IOC_LOGICAL_INO         *BTRFS_IOC_QUOTA_RESCAN_STATUS
>     *BTRFS_IOC_LOGICAL_INO_V2
>     *BTRFS_IOC_INO_LOOKUP_USER
>     *BTRFS_IOC_INO_LOOKUP
> 
> The functionalities of individual ioctls were described in this series
> patch commit messages. Since all of these ioctls are added in kernel
> version 3.9, their definitions in file 'linux-user/ioctls.h' are
> enwrapped in an #ifdef directive.
> 
> Testing method:
> 
>     Mini test programs were written for these ioctls. These test programs
>     can be found on a repositort which is located on the link:
>     https://github.com/bozutaf/btrfs-tests
> 
>     These test programs were compiled (sometimes using cross compilers) for
>     following architectures:
> 
>          * Intel 64-bit (little endian)
>          * Power pc 32-bit (big endian)
>          * Power pc 64-bit (big endian)
> 
>     The corresponding native programs were executed without using QEMU on
>     an intel x86_64 host.
> 
>     All applicable compiled programs were in turn executed through QEMU
>     and the results obtained were the same ones gotten for native
>     execution.
> 
> v2:
> 
>     * Merged two series in one 8 patch series
>     * Changed target ioctl definitions from IOR/IOW/IOWR to IORU/IOWU/IOWRU
>     * Fixed some thunk struct definitions
> 
> v3:
> 
>    * Added some checks in fine 'syscall_types.h' to see whether the ioctls that
>      use the defined thunk types are present. This is done to support systems
>      that have older versions of 'btrfs.h' file or if the file is not present
>      at all. This is neccesary as to not cause build errors as some structures
>      depend on values which are defined in 'btrfs.h'.
> 
> Filip Bozuta (8):
>   linux-user: Add support for a group of btrfs ioctls used for
>     subvolumes
>   linux-user: Add support for a group of btrfs ioctls used for snapshots
>   linux-user: Add support for btrfs ioctls used to manipulate with
>     devices
>   linux-user: Add support for btrfs ioctls used to get/set features
>   linux-user: Add support for a group of btrfs inode ioctls
>   linux-user: Add support for two btrfs ioctls used for subvolume
>   linux-user: Add support for btrfs ioctls used to manage quota
>   linux-user: Add support for btrfs ioctls used to scrub a filesystem
> 
>  configure                  |   9 ++
>  linux-user/ioctls.h        | 124 ++++++++++++++++++++++++++++
>  linux-user/syscall.c       |   3 +
>  linux-user/syscall_defs.h  |  37 +++++++++
>  linux-user/syscall_types.h | 163 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 336 insertions(+)

Tested-by: Daniel P. Berrangé <berrange@redhat.com>

This series solves a problem that Fedora has with creating btrfs volumes
inside a mock chroot using qemu-user.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


