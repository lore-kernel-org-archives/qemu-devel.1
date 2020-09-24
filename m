Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA09C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18E323741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+KAMOV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18E323741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLU8H-0007ms-JS
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLTh3-00086S-9a
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLTh0-0002W0-RC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDQUzjh5Yc+JPg6KNY+7EEeWccIRk34fc+LmiDLBG/0=;
 b=Y+KAMOV0Ef0kjCMum3GgOiHGCmCg1vxWNDGoy2IbHz0AV6L49J4lr/rLJGkG/S0ghxGKKk
 S5Nf5LDU/nDIgdXw8SvePrJBvKXYPBmwWq1H/w02OAmQpJCF8TQL2bGLv5wf9znd+8psNM
 9T8s8amX7KV0ZzGKPR1qiSFLRPIXGog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-dnpm36A-ODqCDQYDBxzLUA-1; Thu, 24 Sep 2020 12:01:55 -0400
X-MC-Unique: dnpm36A-ODqCDQYDBxzLUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7507100747C;
 Thu, 24 Sep 2020 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFFC31002D41;
 Thu, 24 Sep 2020 16:01:52 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:01:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 28/38] qapi/gen.py: update write() to be more idiomatic
Message-ID: <20200924160151.GD191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-29-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-29-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pmKUVAsxJ35RhmJn"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pmKUVAsxJ35RhmJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:51PM -0400, John Snow wrote:
> Make the file handling here just a tiny bit more idiomatic.
> (I realize this is heavily subjective.)
>=20
> Use exist_ok=3DTrue for os.makedirs and remove the exception,
> use fdopen() to wrap the file descriptor in a File-like object,
> and use a context manager for managing the file pointer.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--pmKUVAsxJ35RhmJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9swu4ACgkQZX6NM6Xy
CfNgsg//TkEi5p6A9Fmrtl5PINfgdpc+SWOWrsBDTCVi9OhpAjSkgszYlUZKO2rf
MyFzKEYMkreFhv2TGFC4Ag38Fy2svOP8X0nsISajJ2rN7ScaPUtdn1hiyO4X3xza
FejP+MWCp0CzZ6nVtJ6PDLq7mh3BWTGH5XrS6m4f6fVPIr5wDE1qC3obNI0rZ1vK
PT7aSdgBvRU8qCSjdfq9QHxl0tPqbwbA2kMBXvbdo/V7kZODOBbDBiWCxtV/Nyz1
w8ZjWlOaejJLaJ5IZvqAakDjCwiPbKmwAcjzbwZt0rKRA87Q21vUkJ4si2+yveh6
+21M7M6fUIlW2/BPCNMjcSIp8t1Gn/O3dhxMUkCXpuaYESZl5MxJHDb+fourEeyB
NSCKKlXUmeKATZGxQ3iB2WH7ohaUjdVQknq5fS1cm8SewqaGJe9hJFTvjGvPn8vm
ihXLH8HLKZmgTVJcHx/7NNZ4s/Is9M9narPjdGAdq8lTpfnX1Eg7+bc756GxhC39
le4P22Nu46RldX4F6IGJB7KVhjTP35YfKgimWF0naaXFGhwPESks2V6XHFRAFzsV
EiGeDORrKdCKgxVxU5/tAG7nMJG/PwTAAHeY/pxqjizGRwLb6znjD7PK8UQUuzFq
/iZg2DKc7xmkpb6A4jUhXKmnimpARbGA6bAxB+OtL/012SK8R4E=
=3TCv
-----END PGP SIGNATURE-----

--pmKUVAsxJ35RhmJn--


