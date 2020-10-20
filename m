Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E239CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449F222283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUw63Ns7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449F222283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnde-0001eK-2w
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUncn-00012k-OB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUncl-0004cp-O6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54nZIz51ZCOiwc4h+f+/satGRG3Sk0a4XFYX6KaTE2I=;
 b=HUw63Ns7WCTxbUVaoGrVmEZDCHvOy38OxzlrrXTYiTl9LVySfn6ZFw46ZNGFTxw12gJyum
 YbNMqm7OYpDQmSaRf7BH5YNymumyw/JdkE8VI2E+gu+3FjyDsS92/E0RfcJwAhEehJyqPC
 tocwVqMjjWRuIZyV+BwJAr0ht6cS1cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-0NuqlWNYOF6wnYbZCoTSDA-1; Tue, 20 Oct 2020 05:08:03 -0400
X-MC-Unique: 0NuqlWNYOF6wnYbZCoTSDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2199957055
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:08:02 +0000 (UTC)
Received: from localhost (ovpn-115-35.ams2.redhat.com [10.36.115.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 275BC60BF3;
 Tue, 20 Oct 2020 09:07:56 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:07:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 1/5] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20201020090755.GA140014@stefanha-x1.localdomain>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014180209.49299-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 07:02:05PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add an option to define mappings of xattr names so that
> the client and server filesystems see different views.
> This can be used to have different SELinux mappings as
> seen by the guest, to run the virtiofsd with less privileges
> (e.g. in a case where it can't set trusted/system/security
> xattrs but you want the guest to be able to), or to isolate
> multiple users of the same name; e.g. trusted attributes
> used by stacking overlayfs.
>=20
> A mapping engine is used wit 3 simple rules; the rules can

s/wit/with/

> +``:type:scope:key:prepend:``
> +
> +**type** is one of:
> +
> +- 'prefix' - If 'key' matches the client then the 'prepend'
> +  is added before the name is passed to the server.
> +  For a server case, the prepend is tested and stripped
> +  if matching.

It may be clearer to document rule types like this:

  - :prefix:client:key:prepend: - Add 'prepend' before the name if it
                                  starts with 'key'.

  - :prefix:server::prepend: - Strip 'prepend' if the name starts with
                               it.

The client vs server behavior is independent so it's clearer to list
them as separate cases. In addition, using the full rule syntax shows
which fields are valid arguments and which ones are ignored.

The 'all' scope can be documented later as "Combines both the 'client'
and 'server' scope behavior".

> +
> +- 'ok' - The attribute name is OK and passed through to
> +  the server unchanged.

The documentation isn't explicit but I think the default behavior is to
allow all xattr names?

What is the purpose of the 'ok' rule? I guess it's to define an
exception to a later 'prefix' or 'bad' rule. It would be nice to make
this clear.

The documentation only mentions :client: behavior, leaving :server:
undefined. Please indicate whether this rule has an effect in server
scope.

> +
> +- 'bad' - If a client tries to use this name it's
> +  denied using EPERM; when the server passes an attribute
> +  name matching it's hidden.
> +
> +**scope** is:
> +
> +- 'client' - match 'key' against a xattr name from the client for
> +             setxattr/getxattr/removexattr
> +- 'server' - match 'prepend' against a xattr name from the server
> +             for listxattr
> +- 'all' - can be used to match both cases.
> +
> +**key** is a string tested as a prefix on an attribute name originating
> +on the client.  It maybe empty in which case a 'client' rule
> +will always match on client names.

Is there a way to match a full string instead of a prefix (regexp
^<pattern>$ instead of ^<pattern>)?

> @@ -2010,6 +2020,169 @@ static void lo_flock(fuse_req_t req, fuse_ino_t i=
no, struct fuse_file_info *fi,
>      fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
>  }
> =20
> +/*
> + * Exit; process attribute unmodified if matched.
> + * An empty key applies to all.
> + */
> +#define XATTR_MAP_FLAG_END_OK  (1 <<  0)
> +/*
> + * The attribute is unwanted;
> + * EPERM on write hidden on read.

Making this sentence easier to parse:

s/write hidden/write, hidden/

> + */
> +#define XATTR_MAP_FLAG_END_BAD (1 <<  1)
> +/*
> + * For attr that start with 'key' prepend 'prepend'
> + * 'key' maybe empty to prepend for all attrs

s/maybe/may be/

> +    /* Add a terminator to error in cases the user hasn't specified */
> +    tmp_entry.flags =3D XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD |
> +                      XATTR_MAP_FLAG_LAST;

The comment is slightly misleading. This entry must be added in all
cases since it terminates the lo->xattr_map_list with the
XATTR_MAP_FLAG_LAST flag. If we don't add this entry then
free_xattrmap() will iterate beyond the end of lo->xattr_map_list.

Another approach is to set XATTR_MAP_FLAG_LAST in add_xattrmap_entry()
(and clear it on the previous last entry). That way adding the 'bad'
catch-all truly is optional and just for cases where the user hasn't
defined a catch-all rule themselves.

> +    tmp_entry.key =3D g_strdup("");
> +    tmp_entry.prepend =3D g_strdup("");
> +    lo->xattr_map_list =3D add_xattrmap_entry(lo->xattr_map_list, &nentr=
ies,
> +                                            &tmp_entry);
> +
> +    return res;
> +}
> +
>  static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name=
,
>                          size_t size)
>  {
> @@ -2806,6 +2979,8 @@ static void fuse_lo_data_cleanup(struct lo_data *lo=
)
>          close(lo->root.fd);
>      }
> =20
> +    free(lo->xattrmap);
> +    free_xattrmap(lo->xattr_map_list);
>      free(lo->source);
>  }
> =20
> @@ -2906,6 +3081,11 @@ int main(int argc, char *argv[])
>      } else {
>          lo.source =3D strdup("/");
>      }
> +
> +    if (lo.xattrmap) {
> +        lo.xattr_map_list =3D parse_xattrmap(&lo);
> +    }

The function always returns NULL. Has this been tested?

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+OqOsACgkQnKSrs4Gr
c8go4ggAic/86MvVgjCIFR1IN4EcPlPw5sJhcC7OvyOvt6S7eKNnWD5nuzDVQELr
+18eWtIMbMT5y8HkyLxvLFVG3tSZYx2kMmobRLhP3dbFxbDOObZ7srslv+45tYVe
aKDTNWVg40vVgZ9PT8YwOcjlVs8rsgrKINXljIGd7Z6BvylggUqNrCCIDeTc9i4H
nUFS2BEeLqzyEww6A9SDCMbNwNUcXlCERHKbAIXlTN5GFB3Iwgvk37iKuTN383yG
mb3aWb9Lx/ctGb4vxATxrVh2QtehWTo26Ny2+JYWX3bNicMRqQPv1+1x2yLSM8K8
YxHpHfSs2fVHCTS4W/SP64TMNcukQQ==
=xgA4
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


