Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78AA2250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzyFcG55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78AA2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Iqh-0002Z5-Uz
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Ipu-0001tV-1X
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:48:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Ipq-0006NL-Ob
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596631677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ec9VPVPPOKsPBJCxnotSg/YlsFZ8GxrrnDkpnlZcGz0=;
 b=NzyFcG55uHDB3jjtJ6PQqSnIRlP2sphhSxRLU+lRp3y7GtaapQtOJLljTF9f7v37MLXvjl
 3An8u7zW5TELLMzEknhBNsBMOM2Gi+zVgBq1X0cCU7pXom/1dNP+IGqJDV0mjNsQ5K1OyY
 JSxIarBrCczhUIPki09CVNSK/Phml6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-rE9nsjLDOF6NQzzTtrTxPQ-1; Wed, 05 Aug 2020 08:47:55 -0400
X-MC-Unique: rE9nsjLDOF6NQzzTtrTxPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 532D8101C8A0
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 12:47:54 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBCAE7B904;
 Wed,  5 Aug 2020 12:47:50 +0000 (UTC)
Date: Wed, 5 Aug 2020 13:47:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/3] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20200805124749.GH361702@stefanha-x1.localdomain>
References: <20200803191511.45261-1-dgilbert@redhat.com>
 <20200803191511.45261-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803191511.45261-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2020 at 08:15:09PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 824e713491..82b6f6d90a 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -107,6 +107,51 @@ Options
>    performance.  ``auto`` acts similar to NFS with a 1 second metadata ca=
che
>    timeout.  ``always`` sets a long cache lifetime at the expense of cohe=
rency.
> =20
> +xattr-mapping
> +-------------
> +
> +By default the name of xattr's used by the client are passe through to t=
he host
> +file system.  This can be a problem where either those xattr names are u=
sed
> +by something on the host (e.g. selinux guest/host confusion) or if the
> +virtiofsd is running in a container with restricted priviliges where it =
cannot
> +access some attributes.
> +
> +A mapping of xattr names can be made using -o xattrmap=3Dmapping where t=
he ``mapping``
> +string consists of a series of rules.
> +
> +Each rule starts and ends with a ':'.  The mapping stops on a matching
> +rule.  White space may be added before and after each rule.
> +
> +:scope:type:key:prepend:
> +
> +scope=3D 'c' - match 'key' against a xattr name from the client
> +            for setxattr/getxattr/removexattr
> +       'h' - match 'prepend' against a xattr name from the host
> +            for listxattr
> +       both letters can be included to match both cases.
> +
> +type is one of:
> +       'p' Prefixing: If 'key' matches the client then the 'prepend'
> +           is added before the name is passed to the host.
> +           For a host case, the prepend is tested and stripped
> +           if matching.
> +
> +       'o' OK: The attribute name is OK and passed through to
> +           the host unchanged.
> +
> +       'b' Bad: If a client tries to use this name it's
> +           denied using EPERM; when the host passes an attribute
> +           name matching it's hidden.
> +
> +key is a string tested as a prefix on an attribute name originating
> +       on the client.  It maybe empty in which case a 'c' rule
> +       will always match on client names.
> +
> +prepend is a string tested as a prefix on an attribute name originiating
> +       on the host, and used as a new prefix by 'p'.  It maybe empty
> +       in which case a 'h' rule will always match on host names.

This syntax and the documentation is hard to understand. Defining
concrete commands instead of a single super-command would make it more
straightforward.

Here is the functionality I've been able to extract from the
documentation:

1. Rewrite client xattrs

   rewrite OLD NEW -> s/^OLD/NEW/

2. Allow client xattrs

   allow PREFIX -> allow if matching

3. Deny client xattrs

   deny PREFIX -> EPERM if matching

4. Unprefix server xattrs

   unprefix PREFIX -> s/^PREFIX//

5. Hide server xattrs

   hide PREFIX -> skip if matching

Did I miss any functionality?

I suggest using "client" and "server" terminology instead of "client"
and "host".

Prefix syntax: xattr names are matched by prefix. The empty string
matches all xattr names. How is ':' escaped?

It is unclear whether 'o' terminates processing immediately. Will later
'p' rules still execute?

It is unclear whether 'o'/'b' match the original client name or the
rewritten name after a 'p' command.

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qqnUACgkQnKSrs4Gr
c8g8rgf/f1wYLasnqqi1EWMrYj1WL9+0vvyGPEteDMK46Gclq8K+e7AsoLOaq5hf
DQOdFyC/IwkiBfFD1dVBXnRKeUN47rtRCgOK0czLtcBCR8LREvwTpKBKRX+8Lcpz
UAtP+x2/Aik5+cwOzdFC0lilY191gMrB4xP8M6vfEnynOTRkWsP9QY9ccej3IFJY
J8EfGBFQeXrLYYPtKZOkE+sPp2lfi/dK9kWV2/MfUhd2l/naLOah3Z3R+2HaveAO
RR5BeLNAOb1r+0oDntgmfsjfSImWn75ZCxlvkUQbT+ZeMCcHkxLkR4yc3c21ZYJB
kMnJ5DNLdXV0bJ8lIiJMtf3M41N80Q==
=qN12
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--


