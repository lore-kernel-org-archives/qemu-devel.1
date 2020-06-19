Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C993DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B9321527
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay5aLixo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B9321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMSb-0003ZS-T5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmMRp-0002ps-W6
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmMRl-0000fl-Jc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592593983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=385nODIH37xQrMKjL6PFgIeww8ShpBfvGybyOp/6DWI=;
 b=Ay5aLixoknck3Sepxffw12WlWTtPYaiZJW0W8AsxlSPBxaAEn4X0DPoIthUgfjactSnWcK
 w4ZM7ld85z8usqT1zBbdnqbYVQu+eXpRIzGKYwesMVqWs3/UKq3dDvEKFGhqh0Qn0bkUYr
 fggGIBLbF2wmDs6lTvH/5YaZxjpyxrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Ql44sma_MtStIaqMDwW05Q-1; Fri, 19 Jun 2020 15:13:01 -0400
X-MC-Unique: Ql44sma_MtStIaqMDwW05Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7889A72EA1;
 Fri, 19 Jun 2020 19:13:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 179317C1EF;
 Fri, 19 Jun 2020 19:12:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 8CA9E220390; Fri, 19 Jun 2020 15:12:54 -0400 (EDT)
Date: Fri, 19 Jun 2020 15:12:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619191254.GH3154@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com> <20200619082746.GA2690@work-vm>
 <20200619113914.GI700896@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619113914.GI700896@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 12:39:14PM +0100, Daniel P. Berrangé wrote:
[..]
> The CAP_SYS_ADMIN requirement for 'trusted.' xattrs is simply a useful
> mechanism for applications to control access. The host kernel doesn'
> tuse this namespace itself. Linux has four namespaces for xattrs:
> 
>  -  user - for userspace apps. accessible based on read/write permissions
>  -  trusted - for userspace apps. accessible by CAP_SYS_ADMIN processes only
>  -  system - for kernel only. used by ACLs
>  -  security - for kernel only. used by SELinux
> 
> The use case for "trusted" xattrs is thus where a privileged management
> application or service wants to store metadata against the file, but
> also needs to grant an unprivileged process access to write to this file
> while not allowing that unprivileged process the ability to change the
> metadata. This is mentioned in the man page:
> 
> [man xattr(7)]
>    Trusted extended attributes
>        Trusted  extended attributes are visible and accessible only to pro‐
>        cesses that have the CAP_SYS_ADMIN capability.  Attributes  in  this
>        class  are used to implement mechanisms in user space (i.e., outside
>        the kernel) which keep information in extended attributes  to  which
>        ordinary processes should not have access.
> 
>    User extended attributes
>        User  extended  attributes  may be assigned to files and directories
>        for storing arbitrary additional information such as the mime  type,
>        character  set  or  encoding  of a file.  The access permissions for
>        user attributes are defined by the file permission bits:  read  per‐
>        mission is required to retrieve the attribute value, and writer per‐
>        mission is required to change it.
> [/man]
> 
> Libvirtd uses the "trusted." xattr namespace to record information against
> disk images for QEMU, because we need to grant QEMU access to read/write
> the disk iamges, but don't want QEMU to be able to alter our xattrs.
> 
> It is unfortunate that this namespace is tied to the CAP_SYS_ADMIN cap.
> It really ought to have had its own dedicated capability :-( Such is
> life with anything that uses CAP_SYS_ADMIN...
> 
> With this in mind we really should have both trusted. & user. xattrs
> allowed to the guest by default.
> 
> Conversely, we'll need to block usage of the security. and system.
> namespaces.

I am wondering can we block usage of "system" and "security"?  What
about guest setting acls over virtiofs files. These will have to
go through and that means we need to allow system xattrs.

Similarly setting file capabilities inside should trigger
setxattr(security.capability) and that means we need to allow security
xattr as well.

Thanks
Vivek


