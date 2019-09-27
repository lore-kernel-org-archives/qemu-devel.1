Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B8C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5162217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5162217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqYi-0007yl-5D
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iDpue-00054c-PL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iDpub-00047s-VN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iDpua-00046F-Oz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C52953065603;
 Fri, 27 Sep 2019 11:44:56 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 633B53DBB;
 Fri, 27 Sep 2019 11:44:53 +0000 (UTC)
Date: Fri, 27 Sep 2019 08:44:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] i386: Re-add "pconfig" CPUID flag name
Message-ID: <20190927114451.GW8144@habkost.net>
References: <20190926212326.4092-1-ehabkost@redhat.com>
 <CABgObfa-PHfeNVVYCuEFJ4_=KADJEddJS1k0Au+sOgtxgundDQ@mail.gmail.com>
 <20190927004220.GV8144@habkost.net>
 <20190927090905.GC20911@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190927090905.GC20911@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 27 Sep 2019 11:44:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: thomas.lendacky@amd.com, "Kang, Luwei" <luwei.kang@intel.com>,
 libvir-list@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>, kai.huang@intel.com,
 robert.hu@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 10:09:05AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Sep 26, 2019 at 09:42:20PM -0300, Eduardo Habkost wrote:
> > (CCing libvir-list)
> >=20
> > On Thu, Sep 26, 2019 at 11:58:30PM +0200, Paolo Bonzini wrote:
> > > Is this really needed? QEMU's value of pconfig=3Don vs. off should =
be
> > > provided by QMP CPU model queries, if a property is not available t=
hen
> > > Libvirt should not try to set it to off.
> > >=20
> >=20
> > Libvirt can easily work around it for new VMs, and it should.
> >=20
> > The issue are VMs that were created with QEMU 3.1.0.  QEMU 3.1.0
> > was telling libvirt "Icelake-Server can't be used unless
> > pconfig=3Doff is used", and libvirt was adding pconfig=3Doff to the
> > domain XML as expected.
> >=20
> > It would be wrong for libvirt to remove a device option when
> > migrating an existing VM to another QEMU version.  We can change
> > the rules (and document that), but do we want to?
>=20
> IIUC currently any existing VMs with Icelake-Server will *not* have
> pconfig present, since libvirt is going to set pconfig=3Doff
>=20
> QEMU has now dropped pconfig CPUID entirely. If libvirt were to stop
> setting pconfig=3Doff, then there is NO guest ABI change, so we'd be
> safe in that sense.

This is correct.  Only pconfig=3Doff worked, and no accelerator
ever supported pconfig=3Don.

--=20
Eduardo

