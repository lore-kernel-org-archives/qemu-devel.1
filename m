Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F838C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D832071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqQY/BrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D832071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iutp3-00068q-Tk
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 02:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iuto9-0005f5-Aj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iuto7-0007QV-7o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:55:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iuto6-0007Ku-Kc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579852509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb4KPVZ9A95lFoj2S1g8sdrV7H3Ryj3/C0K8tTqTEv4=;
 b=XqQY/BrDSS5fDoLM4YHrFqo4Lf8hBaoRVw8SwCr3aZJf+InVPiDjAafEiL6Jtms9D4uK4k
 asbIS6vJj3BfCo64LrvIZcTKuusW3p53cVNWejiR5cYuedGLn9RdOQ8bDiRfKgZepGnu6g
 eHlqjHiHXS3j45xlYkk1vc+v9A3XaRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-bIWdNitgOSGXgBDyUurQkA-1; Fri, 24 Jan 2020 02:55:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA124A0CBF;
 Fri, 24 Jan 2020 07:55:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C947A867EC;
 Fri, 24 Jan 2020 07:54:58 +0000 (UTC)
Date: Fri, 24 Jan 2020 08:54:56 +0100
From: Andrew Jones <drjones@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot
 Linux with kvm tests
Message-ID: <20200124075456.ysi6ippct7xfmzzj@kamzik.brq.redhat.com>
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-3-wainersm@redhat.com>
 <20200122090246.oehdjxeotx5tz64l@kamzik.brq.redhat.com>
 <7106bfc9-067e-6864-c766-046372ed4bd0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7106bfc9-067e-6864-c766-046372ed4bd0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bIWdNitgOSGXgBDyUurQkA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 07:47:19PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 1/22/20 7:02 AM, Andrew Jones wrote:
> > On Tue, Jan 21, 2020 at 10:27:51PM -0300, Wainer dos Santos Moschetta w=
rote:
> > > +    def test_aarch64_virt_kvm(self):
> > > +        """
> > > +        :avocado: tags=3Darch:aarch64
> > > +        :avocado: tags=3Dmachine:virt
> > > +        :avocado: tags=3Daccel:kvm
> > > +        """
> > > +        self.do_test_aarch64_virt()
> > > +
> > > +    def test_aarch64_virt_tcg(self):
> > > +        """
> > > +        :avocado: tags=3Darch:aarch64
> > > +        :avocado: tags=3Dmachine:virt
> > > +        :avocado: tags=3Daccel:tcg
> > > +        """
> > > +        self.do_test_aarch64_virt()
> > > +
> > Does do_test_aarch64_virt() add more machine parameters? Also, which cp=
u
> > type does it choose? The reason I ask is because aarch64 virt will fail=
 to
> > run with KVM unless the appropriate gic version is specified (the
> > gic-version machine parameter). Also the cpu type must be 'host' or 'ma=
x'.
> > 'max' is the better choice as it also works for tcg. gic-version also
> > takes 'max' allowing it to auto-select the appropriate version. So if i=
t's
> > not already there somewhere, then please ensure aarch64 has these
> > additional parameters:
> >=20
> >   machine:gic-version=3Dmax
> >   cpu:max
>=20
>=20
> The test was passing '-cpu cortex-a56', I replaced with '-cpu max'. Also,
> now, it passes the gic version as you pointed out. I will send those chan=
ges
> on a v4.
>=20
> Other than that, I tried '-cpu max -machine virt' (without gic-version) a=
nd
> QEMU crashed:
>=20
> [root@virtlab-arm03 build]# ./aarch64-softmmu/qemu-system-aarch64 -accel =
kvm
> -cpu max -machine virt -display none -vga none
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
> qemu-system-aarch64: failed to set irq for PMU
> Aborted (core dumped)
>=20
> ----
>=20
> Should I expect it to crash or rather nicely fail?

crash, unfortunately. I recall we once had a plan to send patches to
fail nicer, and to output a hint on how to resolve the issue, but I
guess that never happened...

Thanks,
drew


