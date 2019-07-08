Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09957C606A1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12D920659
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQ8j-00082D-1D
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkQ6f-0006YD-0A
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkQ6d-00025d-RE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkQ6d-00023L-0c
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CFF45AFE3;
 Mon,  8 Jul 2019 09:38:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64E031837B;
 Mon,  8 Jul 2019 09:38:35 +0000 (UTC)
Date: Mon, 8 Jul 2019 10:38:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190708093833.GC3082@redhat.com>
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
 <26ae890e-ca8a-6a5b-0d93-67cd266c8e93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26ae890e-ca8a-6a5b-0d93-67cd266c8e93@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 08 Jul 2019 09:38:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add live migration support in the
 PVRDMA device
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 06, 2019 at 10:04:55PM +0300, Marcel Apfelbaum wrote:
> Hi Sukrit,
>=20
> On 7/6/19 7:09 AM, Sukrit Bhatnagar wrote:
> > Changes in v2:
> >=20
> > * Modify load_dsr() such that dsr mapping is not performed if dsr val=
ue
> >    is non-NULL. Also move free_dsr() out of load_dsr() and call it ri=
ght
> >    before if needed. These two changes will allow us to call load_dsr=
()
> >    even when we have already done dsr mapping and would like to go on
> >    with the rest of mappings.
> >=20
> > * Use VMStateDescription instead of SaveVMHandlers to describe migrat=
ion
> >    state. Also add fields for parent PCI object and MSIX.
> >=20
> > * Use a temporary structure (struct PVRDMAMigTmp) to hold some fields
> >    during migration. These fields, such as cmd_slot_dma and resp_slot=
_dma
> >    inside dsr, do not fit into VMSTATE macros as their container
> >    (dsr_info->dsr) will not be ready until it is mapped on the dest.
> >=20
> > * Perform mappings to CQ and event notification rings after the state=
 is
> >    loaded. This is an extension to the mappings performed in v1;
> >    following the flow of load_dsr(). All the mappings are succesfully
> >    done on the dest on state load.
>=20
> Nice!
>=20
> > Link(s) to v1:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
> > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
> >=20
> >=20
> > Things working now (were not working at the time of v1):
> >=20
> > * vmxnet3 is migrating successfully. The issue was in the migration o=
f
> >    its PCI configuration space, and is solved by the patch Marcel had=
 sent:
> >    https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01500.htm=
l
> >=20
> > * There is no problem due to BounceBuffers which were failing the dma=
 mapping
> >    calls in state load logic earlier. Not sure exactly how it went aw=
ay. I am
> >    guessing that adding the PCI and MSIX state to migration solved th=
e issue.
> >=20
>=20
> I am sure it was connected somehow, anyway, I am glad we can continue
> with the project.
>=20
> > What is still needed:
> >=20
> > * A workaround to get libvirt to support same-host migration. Since
> >    the problems faced in v1 (mentioned above) are out of the way, we
> >    can move further, and in doing so, we will need this.
>=20
> [Adding Daniel=C2=A0 and Michal]
> Is there anyway to test live-migration for libvirt domains on the same =
host?
> Even a 'hack' would be enough.

Create two VMs on your host & run inside those. Or create two containers
if you want a lighter weight solution. You must have two completely
independant libvirtd instances, sharing nothing, except optionally where
you store disk images.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

