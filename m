Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898F2206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnAhup7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898F2206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAC1-0005fK-Ch
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kcAAo-0004pB-Nm
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kcAAl-000504-Ua
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604939859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+g5hXVF/6tHVrSt/PoVz0WCJEPMqhhQeSGsCxE1qRto=;
 b=UnAhup7/HbXl4hjc5WX1pQ7C2HspDDvykYD0NyU8FSl1ztpkBVr6Wx4GeKKEw8E0vcpI04
 g9fLu54SJowAN06hisSBh9fvFFPAEpLCzXg5JYsm0k+uotVjHqBdrLR97hSCaQhQmVsZ0N
 sMMO0rwtecA6FzO6Br7v/PFdWA/2K2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-R9-dunfhNgWkHUo_U7Wo-A-1; Mon, 09 Nov 2020 11:37:35 -0500
X-MC-Unique: R9-dunfhNgWkHUo_U7Wo-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2798C898C;
 Mon,  9 Nov 2020 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8086910074EA;
 Mon,  9 Nov 2020 16:37:28 +0000 (UTC)
Date: Mon, 9 Nov 2020 11:37:26 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201109163726.GC3874327@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
 <c0e7bd88bf64c0b22023810192fdb6e38d96fd97.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c0e7bd88bf64c0b22023810192fdb6e38d96fd97.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:52:43PM +0200, Andrea Bolognani wrote:
> On Sun, 2020-10-18 at 21:50 -0400, Cleber Rosa wrote:
> > +++ b/scripts/ci/setup/build-environment.yml
> > @@ -0,0 +1,233 @@
> > +---
> > +- name: Installation of basic packages to build QEMU
> > +  hosts: all
> > +  tasks:
>=20
> My Ansible-fu is a bit rusty at the moment, so please double-check my
> claims and apologies in advance for the ones that I will get wrong O:-)
>=20
> > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > +      apt:
> > +        update_cache: yes
> > +        # Originally from tests/docker/dockerfiles/ubuntu1804.docker
> > +        pkg:
> > +          - ccache
> > +          - clang
>=20
> Instead of using the 'apt' module here, and the equivalent module
> further down, you could just do
>=20
>   package:
>     name:
>       - pkg1
>       - pkg2
>         ...
>     state: present
>=20
> every single time and let Ansible take care of the differences for
> you.
>

I'm almost sure that this was a conscious decision.  I remeber it had
to do with not being able to set `update_cache`, and failures on
recently installed systems and containers that did not update the APT
cache.  There may be something else, but I'll have to give it another
round of testing.

FIY, under the hood, package is not really a module, but an action
plugin that forwards these very limited options to the set or detected
package manager, so it brings uniformity in the playbook, but limits
the control too.  IMO, it's very low impact to leave it AS IS.

> > +      when: "ansible_facts['distribution'] =3D=3D 'Ubuntu'"
>=20
> Quoting the entire condition is not necessary, you can just have
>=20
>   when: ansible_facts['distribution'] =3D=3D 'Ubuntu'
>=20
> or, my preference,
>=20
>   when:
>     - ansible_facts['distribution'] =3D=3D 'Ubuntu'
>

Yep, I've used the explicit lists when there was more than one
condition, but having a standard style is better indeed.

> which results in a nicer diff when you add/remove conditions.
>=20
> > +    - name: Install packages to build QEMU on Ubuntu 18.04/20.04 on no=
n-s390x
> > +      apt:
> > +        update_cache: yes
> > +        pkg:
> > +         - libspice-server-dev
> > +         - libxen-dev
>=20
> Indentation of list items is inconsistent here.
>

True.  Fixed, thanks!

> > +    - name: Install basic packages to build QEMU on FreeBSD 12.x
> > +      pkgng:
> > +        # Originally from packages on .cirrus.yml under the freebsd_12=
_task
> > +        name: bash,curl,cyrus-sasl,git,glib,gmake,gnutls,gsed,nettle,n=
inja,perl5,pixman,pkgconf,png,usbredir
>
> See above for 'pkgng' vs 'package', but at the very least this should
> be
>=20
>   pkgng:
>     name:
>       - bash
>       - curl
>         ...
>=20
> or each time the list is touched the resulting diff is going to be
> unmanageable.
>

The documentation suggests a comma separated list of package names:

   https://docs.ansible.com/ansible/2.8/modules/pkgng_module.html#pkgng-mod=
ule

And the reason is that this module is not as smart as others, and will
run one separate command for each individual package name value:

   https://github.com/ansible/ansible/blob/v2.10.3/test/support/integration=
/plugins/modules/pkgng.py#L214

It's a tradeoff indeed, but I think we're aligned with the docs.

> > +    - name: Enable PowerTools repo on CentOS 8
> > +      ini_file:
> > +        path: /etc/yum.repos.d/CentOS-PowerTools.repo
> > +        section: PowerTools
> > +        option: enabled
> > +        value: "1"
> > +      when:
> > +        - "ansible_facts['distribution'] =3D=3D 'CentOS'"
> > +        - "ansible_facts['distribution_major_version'] =3D=3D '8'"
>=20
> Another option would be to use
>=20
>   command: 'dnf config-manager --set-enabled Stream-PowerTools -y'
>   args:
>     warn: no
>=20
> but I have to admit the way you're doing it is very clever ;)
>

Yeah, that would require another package to be installed, and then the
command executed... So I think this is cheaper and eaiser indeed.

> --=20
> Andrea Bolognani / Red Hat / Virtualization
>=20

Thanks for the review, I'll report on the additional points as soon as
I test them.  If appropriate, I'll put notes on the v5.

- Cleber.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+pcEMACgkQZX6NM6Xy
CfN+mBAAh1i8Rjzlp/JFOVlXinnXczgon1s/Zn6wK+j/YXh0faaf4LCRasbBlHxd
ynQMTcd8ycT1kwFuRFN4YRx9WXC0H/TCese4i1TmjeMGCAC8tmOoKSGQ7FOZX/Sr
UUAR5p1vyPgMz/DB/utLxJjukGsD/mIWPt4Zo36B2b1aUxN22jDzXAsCzpqxE/d9
5Vo8aLgfKUbaxv06iJJCr+wHsGvGOziiNG+wXv9a08FONj2h1lFKJe6dghmNmbUm
FJfgkdCbijllljzGdDEA70kPyLfZD9ewZWIKxfXGIwjXpMGskc+PrRKPks38xI/z
QMjCc9ZdBtCNQ4XB1G/0yfbH3j8iqjzauIUYXHzuk6KaJ13jHIVRGMb/Ai/0gSaG
bRXlKYJZq3m+nAtz1wVoVT3rkP5bfuY1FyLD2ZmOUmzW4J+9uQyzbiU+QMLbbXMj
dX7BpJtA9ew9vrziGbDs7uvSJBR7Dxoddn2yqQkNnCM30/92+cC2SkcjKwkNf0rH
HkEdllbzA4Li1rc4QW60LYaxpW/iET5BWcDVgLvZhB3svjl8I4xnr7dB6zZhhMcv
vuRU3S3oQjjW/3IJ/BE7KYlyPgsJ9fdtYS13xYf2cjg+3Wa+NJkX1wFEgKTNKROB
48GFS0xn62nKbwS7M6UbSfACIAA8F0qAQIBoVFU/Uy4i2koOOMc=
=IgZY
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--


