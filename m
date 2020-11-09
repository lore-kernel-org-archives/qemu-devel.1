Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B484C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8DE206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlk+XJJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8DE206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8zQ-0004u0-I4
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kc8yN-0004B4-CX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:20:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kc8yL-00026M-My
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HT6hBuVzp9W4LUDZRfrwtaEdBqIM6yl4EVT8eQLmlik=;
 b=Xlk+XJJ/1HwW2nBa2mNqDo0wu0x75g1SaF6JPxQEJcqhsc3wK6PW248/S+m14j6IqLZziQ
 OM3OrPXvQ+TgBMpndPdoCyIk4s84IzWhZjqPlivgekeTJ0PgxpUra/+agclGgwHz5kqb10
 WmQd/FNQPVg78k+4T02Jbw4E45ypqSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-JmmeDfAbMUCpOvrP-6eOPA-1; Mon, 09 Nov 2020 10:20:41 -0500
X-MC-Unique: JmmeDfAbMUCpOvrP-6eOPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6DCB1868434;
 Mon,  9 Nov 2020 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A5B6EF6B;
 Mon,  9 Nov 2020 15:20:35 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:20:33 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201109152033.GB3874327@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
 <20201019102741.GC495479@nautilus>
 <20201019202531.GB1617151@localhost.localdomain>
 <20201020061854.GD495479@nautilus>
MIME-Version: 1.0
In-Reply-To: <20201020061854.GD495479@nautilus>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 08:18:54AM +0200, Erik Skultety wrote:
> On Mon, Oct 19, 2020 at 04:25:31PM -0400, Cleber Rosa wrote:
> > On Mon, Oct 19, 2020 at 12:27:41PM +0200, Erik Skultety wrote:
> > > ...
> > >=20
> > > > diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventor=
y
> > > > new file mode 100644
> > > > index 0000000000..8bb7ba6b33
> > > > --- /dev/null
> > > > +++ b/scripts/ci/setup/inventory
> > > > @@ -0,0 +1,2 @@
> > > > +[local]
> > >=20
> > > Nit pick, is a group for localhost actually needed?
> > >
> >=20
> > You're right, it's not needed... I just thought it gave the
> > "localhost" entry some "shelter" and "context". :)
> >=20
> > And, I think a mostly "ini-like" file without a section triggers an OCD
> > reaction in me.  I can remove it if it does something similar to you! :=
)
> >=20
> > Thanks!
> > - Cleber.
>=20
> I understand, but even though it may be an ini-like config, "sections" ha=
ve a
> very distinct meaning in Ansible and that is grouping, so unless there ar=
e
> hosts to group, I'd keep the inventory in a form of a simple list of indi=
vidual
> hosts.
>

Fair enough.  Changing it for v5.

Thanks!
- Cleber.

> Regards,
> Erik

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+pXkEACgkQZX6NM6Xy
CfNxPRAA0epWJZ1VE0nx+om/2OFfrF9AFcc71im2GvVosz3g5rCwSI3e601Ab0lC
QPErFUrTSUeZH6t2983VLpSgDVhOiuVzLOq+jg2ZkoildRlx7z7//3YtgeaLJ3I0
RB7g+DQ3qrWf7Q4s8foPKHij1mu7wQz8p0NfMUALxoJsLmzT6HtYIkd491HDn5RC
h+tg1W49J1+t8WpBBSQUihsvduiCcuBowYD3ji7qmtIoCYiV5t/ScXIYOpXmbv8R
I29XZTgZ73WpmfNp70Ze8U6S2S2wPbRBMXY388KVusPaAZvJWs1LCQHWut3pig+M
RLI3HIhXGgOiJNqSW2kk3SkD868GwT6tq8UxZf/6Frf4poWg8e04/bKK1XsP6dfT
8PaT1AxT7iYRBMM33ndtDWPgLC+F9nW0+R6znv3YpxUfbgtwN/bpsjn6Pxqtc0e4
g1jRQmnNXAkR1M2Jl4uePy1i1I8w8mujBviHdJbcTYQupbXhezLVMoKz8r/jH6Ug
llw3vUpdXdQE3EJSULAVemy5P/l4/TGJdPivwbdjy0892axBr0dvWEfL30oy25of
EZdDTvuia0KRG9uYmxPXoS4cgjLT0W9dan4dSbZYmzc3IygU6zP/NJBdMRKzZFJB
CgNtBl4cznRJJySGSmJiz/Kt0GkfHYFhcX7xhD+dYHJ2uGfkZzI=
=CPLk
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--


