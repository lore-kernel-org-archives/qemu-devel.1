Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF2C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388A820715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gmBm+m8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388A820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagrr-0007Yy-5l
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kagqu-0006rj-5O; Thu, 05 Nov 2020 10:07:04 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:36935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kagqr-0001H3-Nb; Thu, 05 Nov 2020 10:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=J80vtLgb+JbeRkicM5+Hda5f+1nTevLNRPjcN23fEMA=; b=gmBm+m8zcHwMHHa2fbyf7qSnpF
 VqVI9pndK0nmSyWd1OcYVa+E4ZG3spmnE6McjnIX7pDMi1/tkaq49cxQNyXHli4VPovL98u6KEzoL
 lhYH/Pq+xgBOQX6J2SOgcaaLLJhUGOvhrM6r3kZJI7hAeRxPMSkDH/tr6p9oRxFfq9QByss84EBv+
 z20eAc/cng1Ga7DI4JxnB0WoxobrUQnw/76hQgm3JkvfLLqBXjBBEexcVE+F4WEFJS+jta74cbxzM
 V5h9ikuPEZGVlopDEH9OTHCdzNCvmWLe1bfKu6wWWbiJItsB1r0w84DDsfsSgu2eVsDLfjIRboOPU
 H5cePrkw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH-for-5.2 v3 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
Date: Thu, 05 Nov 2020 16:06:45 +0100
Message-ID: <401148579.MYj8lGMC4g@silver>
In-Reply-To: <2140852.vo20GZeEQY@silver>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201105132346.5e0adf94@bahia.lan> <2140852.vo20GZeEQY@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 10:06:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 5. November 2020 13:28:31 CET Christian Schoenebeck wrote:
> On Donnerstag, 5. November 2020 13:23:46 CET Greg Kurz wrote:
> > On Thu, 5 Nov 2020 13:15:59 +0100
> >=20
> > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> > > On 11/4/20 6:54 PM, Greg Kurz wrote:
> > > > On Wed, 04 Nov 2020 13:18:09 +0100
> > > >=20
> > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > >> On Mittwoch, 4. November 2020 12:57:04 CET Philippe Mathieu-Daud=E9
>=20
> wrote:
> > > >>> Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
> > > >>> CONFIG_9PFS (probably a wrong conflict resolution). This config is
> > > >>> not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
> > > >>> depends on CONFIG_VIRTFS.
> > > >>>=20
> > > >>> Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
> > > >>>=20
> > > >>> fix the './configure --without-default-devices --enable-xen' buil=
d:
> > > >>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in
> > > >>>   function
> > > >>>=20
> > > >>> `xen_be_register_common': hw/xen/xen-legacy-backend.c:754: undefi=
ned
> > > >>> reference to `xen_9pfs_ops' /usr/bin/ld:
> > > >>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined
> > > >>> reference to
> > > >>> `local_ops' /usr/bin/ld:
> > > >>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined
> > > >>> reference
> > > >>> to `synth_ops' /usr/bin/ld:
> > > >>> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined
> > > >>> reference
> > > >>> to `proxy_ops' collect2: error: ld returned 1 exit status
> > > >>>=20
> > > >>> Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
> > > >>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > > >>> Acked-by: Greg Kurz <groug@kaod.org>
> > > >>> Tested-by: Greg Kurz <groug@kaod.org>
> > > >>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > >>=20
> > > >> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > >=20
> > > > Phil,
> > > >=20
> > > > Same questioning as Connie. Do you intend to get this merged or sho=
uld
> > > > Christian or I take care of that ?
> > >=20
> > > Same answer too =3D) If you are preparing a pull request, please go a=
head!
> >=20
> > Heh I've just seen your answer.
> >=20
> > Christian,
> >=20
> > Maybe you can add this patch in your next PR ?
>=20
> Yes, I will prepare a 9p PR today anyway, so I will include this patch.
>=20
> Best regards,
> Christian Schoenebeck

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

Best regards,
Christian Schoenebeck



