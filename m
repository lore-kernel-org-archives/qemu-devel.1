Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A88C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4385C2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/dDIGpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4385C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14Qn-0004uU-Ir
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k14Pt-0004PJ-N0
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:59:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k14Pr-0001u6-3S
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596099593;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oy4y1XX3qEC/F151hiPi3q9+0DIBRAFLl3WnzndQFF8=;
 b=i/dDIGpqkBMwJBKDBfvx3OVp/zeCpY7sa/Cg76CPpVB/9b/Kvp6ksNheWMiIP5iTGVu9z1
 YnxBqaZ7YMDPqricEYQLlMrGNVhm3t5wCUS/Q3NvOV36sIFo5x1sEwRMhtmSRfrTuSJQ0d
 Fa3ZLzPpf7kSHeJZY+xeuraZZVyH084=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-d7qsv3vmMIeX92UPlj6O9A-1; Thu, 30 Jul 2020 04:59:48 -0400
X-MC-Unique: d7qsv3vmMIeX92UPlj6O9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 485E8107ACCA
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 08:59:47 +0000 (UTC)
Received: from redhat.com (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 354305D9D3;
 Thu, 30 Jul 2020 08:59:39 +0000 (UTC)
Date: Thu, 30 Jul 2020 09:59:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/5] virtiofsd: create lock/pid file in per user cache dir
Message-ID: <20200730085937.GA3477223@redhat.com>
References: <20200729221410.147556-1-vgoyal@redhat.com>
 <20200729221410.147556-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200729221410.147556-3-vgoyal@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 06:14:07PM -0400, Vivek Goyal wrote:
> Right now we create lock/pid file in /usr/local/var/... and unprivliged
> user does not have access to create files there.
> 
> So create this file in per user cache dir as queried as specified
> by environment variable XDG_RUNTIME_DIR.
> 
> Note: "su $USER" does not update XDG_RUNTIME_DIR and it still points to
> root user's director. So for now I create a directory /tmp/$UID to save
> lock/pid file. Dan pointed out that it can be a problem if a malicious
> app already has /tmp/$UID created. So we probably need to get rid of this.

IMHO use of "su $USER" is simply user error and we don't need to
care about workarounds. They will see the startup fail due to
EPERM on /run/user/0 directory, and then they'll have to fix
their command to use "su - $USER" to setup a clean environment.


> +    /*
> +     * Unpriviliged users don't have access to /usr/local/var. Hence
> +     * store lock/pid file in per user directory. Use environment
> +     * variable XDG_RUNTIME_DIR.
> +     * If one logs into the system as root and then does "su" then
> +     * XDG_RUNTIME_DIR still points to root user directory. In that
> +     * case create a directory for user in /tmp/$UID
> +     */
> +    if (unprivileged) {
> +        gchar *user_dir = NULL;
> +        gboolean create_dir = false;
> +        user_dir = g_strdup(g_get_user_runtime_dir());
> +        if (!user_dir || g_str_has_suffix(user_dir, "/0")) {
> +            user_dir = g_strdup_printf("/tmp/%d", geteuid());
> +            create_dir = true;
> +        }

As above, I don't think we need to have this fallback code to deal
with something that is just user error.

Also, g_get_user_runtime_dir() is guaranteed to return non-NULL.

> +
> +        if (create_dir && g_mkdir_with_parents(user_dir, S_IRWXU) < 0) {
> +            fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
> +                     __func__, user_dir, strerror(errno));
> +            g_free(user_dir);
> +            return false;
> +        }
> +        dir = g_strdup(user_dir);

Don't we also want to be appending "virtiofsd" to this directory path
like we do in the privileged case ?


> +        g_free(user_dir);
> +    } else {
> +        dir = qemu_get_local_state_pathname("run/virtiofsd");
> +        if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
> +            fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
> +                     __func__, dir, strerror(errno));
> +            return false;
> +        }
>      }
>  
>      sk_name = g_strdup(se->vu_socket_path);
> -- 
> 2.25.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


