Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9899B20936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQI7d9Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9899B20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqxb-0004xM-Nd
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLqtT-0001h7-4a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLqtQ-000248-KB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:48:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601052498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LnyDtffTTlcYPQpb3B/1gHWzohrDiRY4Wt+0jcNo3E=;
 b=AQI7d9SsVpfEG1XDHhQtFzSFVX4VeokA/jCen2nEoC5zuF00yWxAAEZd4vKllGSnGdMf5Y
 zEfyxsK+jC9NkRXu3zLrYAexQjgiJgXVExOMe2J+nogKueXIiih7L84al6OcPCIh41tbAI
 ViVe8ATjZ12kNC6RKL8XTWsfuZMqy3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-UuuNHX7KMsmM8z6fdRu26A-1; Fri, 25 Sep 2020 12:48:16 -0400
X-MC-Unique: UuuNHX7KMsmM8z6fdRu26A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1608B186DD4A;
 Fri, 25 Sep 2020 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8271B60CCC;
 Fri, 25 Sep 2020 16:48:14 +0000 (UTC)
Date: Fri, 25 Sep 2020 12:48:12 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/16] qapi/expr.py: Check type of 'data' member
Message-ID: <20200925164812.GB402155@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-7-jsnow@redhat.com>
 <20200925003102.GI347918@localhost.localdomain>
 <37788a49-bce8-d04e-0d98-72c50fb9e2ec@redhat.com>
MIME-Version: 1.0
In-Reply-To: <37788a49-bce8-d04e-0d98-72c50fb9e2ec@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:50:27PM -0400, John Snow wrote:
> On 9/24/20 8:31 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:13:03PM -0400, John Snow wrote:
> > > Iterating over the members of data isn't going to work if it's not so=
me
> > > form of dict anyway, but for type safety, formalize it.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/expr.py | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> > > index 3f5af5f5e4..633f9b9172 100644
> > > --- a/scripts/qapi/expr.py
> > > +++ b/scripts/qapi/expr.py
> > > @@ -247,6 +247,9 @@ def check_union(expr, info):
> > >               raise QAPISemError(info, "'discriminator' requires 'bas=
e'")
> > >           check_name_is_str(discriminator, info, "'discriminator'")
> > > +    if not isinstance(members, dict):
> > > +        raise QAPISemError(info, "'data' must be an object")
> > > +
> >=20
> > Don't you mean "must be a dict" ?
> >=20
>=20
> This error is speaking JSON-ese! json objects become python dicts, so if =
we
> didn't get a python dict here, we didn't get a json object.

Right!  Thanks for the explanation.

- Cleber.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9uH0oACgkQZX6NM6Xy
CfNsog/+NhpC//As78+grHy807Rr6tOljUEnToCe6vGt89zgVX/1y3Fe8CnRYD0G
sIPmQ/3Xgx1VPygLYtcT04qESlzZngK1ERbRzN4GybTI7TaGIL6ElY3DX959Cqfu
XTWez0jS6H7esKgfUr7uENENef72SZ0vxAjK7ime2d/4wsGFUkiYV6oXINfeYlpS
M1YlXx7gt7Z13j+k9yFXH0nW0maKyNn14ySuqHxBPqC5DBB9VasgCZyaOhyiAhvE
bwyjHRqGkif11RL7GkmMFQCvnIVrlTpp8pUzSJf2w9xl6yNMLzD2mH54VUvIsDWi
/tILmZ9Zt9gUKrNDD3PuTg/rfpg6q17fZVNNkUcaQBBdmz1pZcw8MZ0Z8AWz7Zse
bVsE8CIhDcLzbRBklyAzXUd1KMLh6/hP31r/jTQLaAMi1YbFWfLVuFMcZaCzXk/B
zcASBwoLWWXcu2eHTNhNO1L5FzQm0PsetE4klul6fpg2T44EO8B571M/pd/lqDwO
WMo7bAEYzBYpdoriszfM1fEAwrgmCrcM0CmJr3IlQFQ1vnMm8sYlinYujo48obJ5
M+5xF3SfT1MagdiKrbAvEZ/adR7a0jI0hW50pJmxNbfTfCJMnNdWc1UEYHq8SJcY
PcHe4b3L6BTkPI0I1N6BeQhh5rqYZ9aNlO+P6V6jNlNDJKnuhSY=
=oMtj
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--


