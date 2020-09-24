Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A875C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6E421534
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzrhAz/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6E421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEiz-0002qv-7m
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 20:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEgy-0001jg-Va
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEgw-0005Cp-SD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPF4OtNEV6eyvJZ/SiQMND4O1EIKXmJlpOJtabMX6G8=;
 b=fzrhAz/SHB7WZAR+Ti6s8dem07TkGcRlN+FKdTbalA1oIPXddjVj0AnZnc393feL502NRx
 CXRQEKYwF1nQmRhtffAOGSaPfU+hy4WBZvyVMJf3FxL9I/7NxkimqoV+TithKGy1sY51hV
 +XRNU8A1XankNL+Z9ITtwptkdXfIsMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-CTiM-tFGNnq2lT6w0AF4_w-1; Wed, 23 Sep 2020 20:00:51 -0400
X-MC-Unique: CTiM-tFGNnq2lT6w0AF4_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3891007464;
 Thu, 24 Sep 2020 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 121EB1002C03;
 Thu, 24 Sep 2020 00:00:48 +0000 (UTC)
Date: Wed, 23 Sep 2020 20:00:47 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 27/38] qapi/gen.py: Remove unused parameter
Message-ID: <20200924000047.GB191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-28-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-28-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YLwdFo+Xu6B7B0Yp"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--YLwdFo+Xu6B7B0Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:50PM -0400, John Snow wrote:
> module_basename doesn't use the 'what' argument, so remove it.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--YLwdFo+Xu6B7B0Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r4a8ACgkQZX6NM6Xy
CfObOxAApj9NsmSIyYlFx79YCgtosxjIHWF7BBJBVFLdZioddnldxZZPrfvcpP9U
voKhE6dNdF/3S2Aew5iD6LVAb/jkfSDu+zbF34XTXl6YnwBTd5PEeUF6pCTVbV4z
eU+wYTPASBsiL5HPXWIZzvpVA/155p/sNYF2AUnVNk8xPHopw3Q+BhKCRsFSOnRa
ZV1O3DxhjfwO/+eKNf0fo2mxSNwLjNWwtHo3gHiqLZ16sohOR1LE6a0U+j2XMezk
H472bKF34CwMHIt0FVbJBIem71JUIo4UVoDmsIZLS+PgYEoeI5jxZzUrNh0/0GiH
Q8Wl0nVMGrVsVmylzcaRkrNPKdMU2OUXyqCqLaDN0bl/xtyOA7UJU8u9O4ZKVkBL
dS3qKcktAM++TZXGpOPjMIBVpwhNQ7jcRQQFfr0ZdBo3nnzvLRXWbqvyAGATmxvg
GgdGCz4MY8BSqtdfrkq6pnuoGNdW0GXxQjUGBkFXu3Hq8vSV3YqpfGO0BrRNFBx0
iVEbPu7aKujG3EXjW2cqWsECW64gtBUit55evU/7M429iTcTllZ/GZiz12dptTdl
CSvEbDZ7u1/0rANG7I4YVESjDaMwrwhJlk3GzDO1bZPhs1V2BVqVMuix5HPqZKu3
Mu13GcLoPRimtUZKVt1tm8iwW51RivhMhT3kCfmbCDr9PGmi16k=
=qbNc
-----END PGP SIGNATURE-----

--YLwdFo+Xu6B7B0Yp--


