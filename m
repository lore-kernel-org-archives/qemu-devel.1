Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87C206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JulM9WaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyAK-0005xi-A7
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1kFy9M-0005Qp-Fp
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1kFy9J-0005fn-VG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599650424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1vxC8HOW8BTtV2K9h458OpZbcikKwdHEuZxxQyxtlY=;
 b=JulM9WaXfAunmZf495TbhCtqht+LXiYEagBTUB9u1YgglFljnQDhDxsHKKqgOnmvCI+XfF
 kHerUgiHDlCZ/aZeMaFCz7LTHVBqHHh4nGFvkLXbnlot5BmcTOf+5612137FVEeG+V4dh3
 G+1+BJnqnfe43KwXe7kDyVZMYYxZT2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-jo17jsGbPI2LN74CoQNyqg-1; Wed, 09 Sep 2020 07:20:22 -0400
X-MC-Unique: jo17jsGbPI2LN74CoQNyqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9084D802B62
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 11:20:21 +0000 (UTC)
Received: from lpt (unknown [10.43.2.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85B63838C4;
 Wed,  9 Sep 2020 11:20:14 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:20:12 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 3/6] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20200909112012.GD1377607@lpt>
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-4-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827153657.111098-4-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jtomko@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Thursday in 2020, Dr. David Alan Gilbert (git) wrote:
>From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
>Add an option to define mappings of xattr names so that
>the client and server filesystems see different views.
>This can be used to have different SELinux mappings as
>seen by the guest, to run the virtiofsd with less privileges
>(e.g. in a case where it can't set trusted/system/security
>xattrs but you want the guest to be able to), or to isolate
>multiple users of the same name; e.g. trusted attributes
>used by stacking overlayfs.
>
>A mapping engine is used wit 3 simple rules; the rules can
>be combined to allow most useful mapping scenarios.
>The ruleset is defined by -o xattrmap='rules...'.
>
>This patch doesn't use the rule maps yet.
>
>Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>---
> docs/tools/virtiofsd.rst         |  55 ++++++++++++
> tools/virtiofsd/passthrough_ll.c | 148 +++++++++++++++++++++++++++++++
> 2 files changed, 203 insertions(+)
>
>diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
>index 824e713491..2efa16d3c5 100644
>--- a/docs/tools/virtiofsd.rst
>+++ b/docs/tools/virtiofsd.rst
>@@ -107,6 +107,60 @@ Options
>   performance.  ``auto`` acts similar to NFS with a 1 second metadata cache
>   timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
>
>+xattr-mapping
>+-------------
>+
>+By default the name of xattr's used by the client are passed through to the server
>+file system.  This can be a problem where either those xattr names are used
>+by something on the server (e.g. selinux client/server confusion) or if the
>+virtiofsd is running in a container with restricted priviliges where it cannot

privileges

>+access some attributes.
>+
>+A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
>+string consists of a series of rules.
>+
>+The first matching rule terminates the mapping.
>+
>+Each rule consists of a number of fields separated with a separator that is the
>+first non-white space character in the rule.  This separator must then be used
>+for the whole rule.
>+White space may be added before and after each rule.
>+Using ':' as the separator a rule is of the form:
>+
>+``:scope:type:key:prepend:``
>+
>+**scope** is:
>+
>+- 'client' - match 'key' against a xattr name from the client for
>+             setxattr/getxattr/removexattr
>+- 'server' - match 'prepend' against a xattr name from the server
>+             for listxattr
>+- 'all' - can be used to match both cases.
>+
>+**type** is one of:
>+
>+- 'prefix' - If 'key' matches the client then the 'prepend'
>+  is added before the name is passed to the server.
>+  For a server case, the prepend is tested and stripped
>+  if matching.
>+
>+- 'ok' - The attribute name is OK and passed through to
>+  the server unchanged.
>+
>+- 'bad' - If a client tries to use this name it's
>+  denied using EPERM; when the server passes an attribute
>+  name matching it's hidden.
>+
>+**key** is a string tested as a prefix on an attribute name originating
>+on the client.  It maybe empty in which case a 'client' rule
>+will always match on client names.
>+
>+**prepend** is a string tested as a prefix on an attribute name originiating

originating

>+on the server, and used as a new prefix.  It maybe empty

may be

>+in which case a 'server' rule will always match on all names from
>+the server.
>+
>+
> Examples
> --------
>
>@@ -123,3 +177,4 @@ Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
>       -numa node,memdev=mem \
>       ...
>   guest# mount -t virtiofs myfs /mnt
>+

git complains about trailing whitespace at EOF

Jano

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE7DTm0WabvfIr7YZ4Ak1z5KIMl5QFAl9YumsACgkQAk1z5KIM
l5Ry0Af/Zjbvzw4apmipGfIqkDHTdj3ujBEvABtzHkR/E3gnyB1kpVHQX2WI/kCv
DkMGNF1GjV3B7Tn1TGv/32Sel9xU0V2pIZNCjUNRGlJ9V2ct4kFDjfeVNyUKX9SS
mE/OxS3aJ2whyS0kZvWBbQAqZXf8h52ffgaiSBFM3wdB5SW7KdT8SOh0IVQl4Smc
A7uwojQfYI2JE3rxqJcu2Uq+dOzVCak8ZIcG5D0Vlq9upf3dSVB5+uKw8cPs0A0F
F4fZCFVFCp53j4YudCPk+PDIrgjiUA0ize0pTpkriU+HUyl9yM1X1y9NNfvebonx
DKIA+QxHdcS2AgtRcxcHrLm7ExRY/w==
=fIpH
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--


