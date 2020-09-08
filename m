Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EEAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A485822A84
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNV1XFX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A485822A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFehk-0001PZ-P9
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFeh8-0000sy-6h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:34:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFeh6-0008BF-OU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R9IGvupumaKmjbsR+/rQI1XJzNUwJ2MjmVKmXdUJnik=;
 b=dNV1XFX1N/8CDZ+yrnKMCgGbDeVba+Ss6BzY8KtQqkXgbi8sEQuG4HNifG4uXYZ9B8gfBD
 RxyuWA5ptUlJBIuF3d8aVNKpm4KbdKK2tHC8f+zbLymCmjSyUrNPTlNyJKIQGvzg1y7ceL
 tEU6HrM/eCu1Ey3XV44AoVPRVvEpHIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-5QWOsXKnMxOpdBotOT1hKg-1; Tue, 08 Sep 2020 10:33:55 -0400
X-MC-Unique: 5QWOsXKnMxOpdBotOT1hKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29D4C1007467;
 Tue,  8 Sep 2020 14:33:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-55.ams2.redhat.com [10.36.113.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60E611002D50;
 Tue,  8 Sep 2020 14:33:49 +0000 (UTC)
Date: Tue, 8 Sep 2020 16:33:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 3/4] docs: add qemu-storage-daemon(1) man page
Message-ID: <20200908143347.GE8175@linux.fritz.box>
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-4-stefanha@redhat.com>
 <20200908114233.GC19304@paraplu>
MIME-Version: 1.0
In-Reply-To: <20200908114233.GC19304@paraplu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, afrosi@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.09.2020 um 13:42 hat Kashyap Chamarthy geschrieben:
> On Tue, Sep 08, 2020 at 10:31:12AM +0100, Stefan Hajnoczi wrote:
> > Document the qemu-storage-daemon tool. Most of the command-line options
> > are identical to their QEMU counterparts. Perhaps Sphinx hxtool
> > integration could be extended to extract documentation for individual
> > command-line options so they can be shared. For now the
> > qemu-storage-daemon simply refers to the qemu(1) man page where the
> > command-line options are identical.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks good to me.

If you have to respin, maybe an example section with some full command
lines for common cases would be nice. Maybe one for exporting a qcow2
image via NBD, and another one for attaching a host_device and having a
QMP monitor, or something like this.

> > +**Warning:** Never modify images in use by a running virtual machine or any
> > +other process; this may destroy the image. Also, be aware that querying an
> > +image that is being modified by another process may encounter inconsistent
> > +state.
> 
> I wonder if it's appropriate to mention libguestfs for safe, read-only
> access to disk images (via `guestfish -ro -i -a disk.qcow2`).  I say
> this because, the above warning tells what _not_ to do; a pointer on
> what to do could be useful.  I let you decide on this.

libguestfs may expose exactly the inconsistent state that the above
warning is about. Maybe it breaks not very often in practice, but it's
fundamentally unsafe and if it breaks, you get to keep both pieces.

The safe way is to access it from the guest.

Kevin


