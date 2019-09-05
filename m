Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6646C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842C021743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842C021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ojY-0007D7-MX
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i5ois-0006mF-8N
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i5oip-0001SQ-VC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i5oip-0001Rg-PM
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7267A46673;
 Thu,  5 Sep 2019 10:10:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com
 [10.36.117.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF55260CDA;
 Thu,  5 Sep 2019 10:10:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 17F7F784F; Thu,  5 Sep 2019 12:10:07 +0200 (CEST)
Date: Thu, 5 Sep 2019 12:10:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190905101007.s4elgn3jjjhypcmf@sirius.home.kraxel.org>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <59cb496983f03b05f6da87af73bc2a2ac0bb7f81.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59cb496983f03b05f6da87af73bc2a2ac0bb7f81.1567534653.git.jag.raman@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 05 Sep 2019 10:10:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 44/45] multi-process: add the
 concept description to docs/devel/qemu-multiprocess
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +Current separation models
> +
> +In order to separate the device emulation code from the CPU emulation
> +code, the device object code must run in a different process. There ar=
e
> +a couple of existing QEMU features that can run emulation code
> +separately from the main QEMU process. These are examined below.

There also is vfio+mdev.  Right now a kernel interface, so
(hardware-assisted) device emulation runs in the linux kernel.
IIRC someone suggested to build a process->process interface
based on the vfio api.  What happened to that idea?

> +If these devices are emulated by remote process =E2=80=9Cdisk-proc,=E2=
=80=9D as
> +described in the previous section, the QEMU command line would be:
> +
> +    -device lsi53c895a,id=3Dscsi0,remote=3Ddisk-proc
> +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,remote=3D=
disk-proc

Does that work with the patch series?
Why does qemu need to know about scsi-hd?

cheers,
  Gerd


