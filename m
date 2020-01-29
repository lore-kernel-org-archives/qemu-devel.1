Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBF7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498C720720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSMKyIEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498C720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqQK-00009e-Gt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 11:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iwqPm-0008AE-O9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iwqPk-0001eh-Sr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:42:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iwqPk-0001cx-Co
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 11:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580316123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXvQMXCn8T031UCQCNfRm1ZIWorYknaDITzhN0zd47k=;
 b=PSMKyIEj2K2vrb5xPFpd8LvrPArZRlvsdRjpzptENthqxT92w5YU/mxsbxdIn61GHt2Sld
 TnE8hHMk2XbvlLxxkSt6RSS7NGLBjtUDoJmmWE+U5FVg4jAhFfuGznwDYTj0JjuuJWX+fv
 0nUgPRPn1v3dHcpLY2YapI9tyJXLDcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-MmWplWtwPxWERwB14HwjWQ-1; Wed, 29 Jan 2020 11:41:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B538051A4;
 Wed, 29 Jan 2020 16:41:57 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31F5C84BC4;
 Wed, 29 Jan 2020 16:41:55 +0000 (UTC)
Date: Wed, 29 Jan 2020 11:41:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 16/18] hw/i386: Introduce EPYC mode function handlers
Message-ID: <20200129164154.GP18770@habkost.net>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541992659.46157.18191224973398213624.stgit@naples-babu.amd.com>
 <20200128200438.GJ18770@habkost.net>
 <90118d85-941f-52f1-1976-0831ed3378c4@amd.com>
MIME-Version: 1.0
In-Reply-To: <90118d85-941f-52f1-1976-0831ed3378c4@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MmWplWtwPxWERwB14HwjWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 03:48:15PM -0600, Babu Moger wrote:
> On 1/28/20 2:04 PM, Eduardo Habkost wrote:
[...]
> > If you need a CPU model to provide special behavior,
> > you have two options:
> >=20
> > * Add a method pointer to X86CPUClass and/or X86CPUDefinition
> > * Add a QOM property to enable/disable special behavior, and
> >   include the property in the CPU model definition.
> >=20
> > The second option might be preferable long term, but might
> > require more work because the property would become visible in
> > query-cpu-model-expansion and in the command line.  The first
> > option may be acceptable to avoid extra user-visible complexity
> > in the first version.
>=20
> Yes. We need to have a special behavior for specific model.
> I will look at both these above approaches closely. Challenge is this
> needs to be done much early in the initialization(before parse_numa_opts
> or machine_run_board_init). Will research more on this.

You should be able to look up the requested CPU model using
object_class_by_name(machine->cpu_type).  If you do this inside
x86-specific code before calling
apicid_from_cpu_idx/topo_ids_from_apicid/apicid_from_topo_ids,
you probably won't need a init_apicid_fn hook.

--=20
Eduardo


