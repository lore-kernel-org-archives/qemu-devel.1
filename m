Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF99ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B778C2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE9YMubl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B778C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP36j-0001jv-I9
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iP34u-0007Dp-VR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iP2uv-0001GN-VC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:10:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iP2uv-0001Fr-Qz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572261032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zohqijfxF5D9YM71qCzB9euIglsluQox3t0/XjbXgTE=;
 b=ZE9YMublszE0G0GIcowr5Vd4Fl4A5ymWPyv2OMv+kq1AhtZUBrbFQ5Cv9wUtY8NEpU9663
 XUcRszZhuyCVv2bu0Fw7WVJl1yewLRlxx00o/ioeaKM17RM/UGFSzyMMDvgccaEnY2kuBg
 BcM7PpXm8OgJDSfL8IRk022gZwpt/8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-L_tPP8M3NpqZxkRUTSAoGg-1; Mon, 28 Oct 2019 07:10:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC76A107AD28;
 Mon, 28 Oct 2019 11:10:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF4C5DA5B;
 Mon, 28 Oct 2019 11:10:27 +0000 (UTC)
Received: from zmail22.collab.prod.int.phx2.redhat.com
 (zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5C8DE18089DC;
 Mon, 28 Oct 2019 11:10:27 +0000 (UTC)
Date: Mon, 28 Oct 2019 07:10:27 -0400 (EDT)
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <557725864.14167224.1572261027082.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA9ZdrAgMhdfUxz0OJnM-dF9XGwR-+FeqnyJAsrntGgL_A@mail.gmail.com>
References: <20191024121808.9612-1-drjones@redhat.com>
 <CAFEAcA9ehcuktCTGR0xpTvZegUkr99H62F_fiT7RY_L_dqgN4g@mail.gmail.com>
 <CAFEAcA981jAU6F9RRWBuzg+_5JDrd-ip-L_awtzdZFqKmewMvA@mail.gmail.com>
 <20191025135159.44siz7g3szpz23og@kamzik.brq.redhat.com>
 <CAFEAcA9ZdrAgMhdfUxz0OJnM-dF9XGwR-+FeqnyJAsrntGgL_A@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
MIME-Version: 1.0
X-Originating-IP: [10.33.36.124, 10.4.196.23, 10.5.101.130, 10.4.195.29]
Thread-Topic: target/arm/kvm: enable SVE in guests
Thread-Index: 6FyxgKxkmPsj++mnzc7OD2PU83owkg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: L_tPP8M3NpqZxkRUTSAoGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: m mizuma <m.mizuma@jp.fujitsu.com>,
 Beata Michalska <beata.michalska@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Apologies if this mail is messed up. I'm having trouble with a hotel's netw=
ork and am forced to use a webui.

----- Original Message -----
> On Fri, 25 Oct 2019 at 14:52, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Fri, Oct 25, 2019 at 01:06:26PM +0100, Peter Maydell wrote:
> > > Fails 'make check' on my aarch32-compile-in-chroot-on-aarch64
> > > machine:
> >
> > Are there easy-to-follow instructions for setting this environment up
> > somewhere?
>=20
> It's an ancient setup, so not really. But it's just an
> Ubuntu 32-bit chroot inside an Ubuntu 64-bit host. I use
> schroot to manage it.
>=20
>=20
>=20
> > I guess the problem is how we're determining if KVM is available, which
> > is like this
> >
> > int main(int argc, char **argv)
> > {
> >     bool kvm_available =3D false;
> >
> >     if (!access("/dev/kvm",  R_OK | W_OK)) {
> > #if defined(HOST_AARCH64)
> >         kvm_available =3D g_str_equal(qtest_get_arch(), "aarch64");
> > #elif defined(HOST_ARM)
> >         kvm_available =3D g_str_equal(qtest_get_arch(), "arm");
> > #endif
> >     }
>=20
> > So we need /dev/kvm and the QEMU binary arch type (qemu-system-arm in
> > this case) needs to match the host arch type. The problem is that
> > HOST_<type> doesn't imply anything about the actual host arch type.
> > <type> comes from the configure $ARCH variable, which for 'arm'
> > comes from the $cpu variable, which for 'arm' comes from whether or
> > not the compiler defines __arm__, and cross compilers certainly do.
> > I guess we'd have the same problem in an aarch32-compile-in-chroot-on-
> > <any-other-type> environment, if a cross compiler is used for the
> > compiling. I should change the KVM available check to something that
> > uses the actual host arch type. I assume the following works, but
> > I don't know if I'm allowed to use uname() in these tests, and, if
> > not, then I don't know what the right way to get the actual host
> > type is.
>=20
> This all feels like it's trying to do the wrong thing, ie
> replicate the logic within QEMU that decides whether to use
> KVM or not. Some possible other approaches:
>=20
>  * If you want to know whether you can run the qemu binary
>    with -accel kvm, then just try that and see if it succeeds.

That's what's happening here, but the failure happens in qtest_init(), so
there's no way to avoid the assert.

>  * Or use '-accel kvm:tcg' and make the test work so that it
>    will pass for both KVM and TCG

For the KVM tests, I'd prefer we specifically test the 'host' cpu type,
which requires we specifically test with KVM. That said, we can use
the fallback along with an additional query to make sure 'host' is
ok to use.

>  * Or use QMP to query what accelerators are available, assuming
>    there's a QMP command for that

Looks like we can check for kvm with query-kvm.=20

I'll rework patch 2/9 using the fallback and kvm query to ensure
kvm can be used. I can even add a test or two that ensure 'host'
is ok to use.

Thanks,
drew


