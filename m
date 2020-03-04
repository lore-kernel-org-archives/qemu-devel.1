Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A060C21744
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFEBYH5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A060C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SdW-00010c-T1
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j9Scq-0000Yj-KY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j9Scp-00008X-19
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:55:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j9Sco-00008H-SR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583322942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfS3NQ02kTnpsbdgag0fuFEV6mZFUPpUfR82m/76Gm8=;
 b=ZFEBYH5t5ToEuci9PRBIwYDQyiAgPncnfBtMvWOTauBKTQrPAmggvQoSnE+Zv7Qpbpebfk
 Am8PJIFRDcCfOLD7S0VdaiUlEnMNe8Hj1SvkFuA6vV4ShWdemZgZ+GiWaJfgq1IJ+IPZOu
 eQV5auhqJPv8BwINr6oPYG3Ua6ZL1eM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Ky72xvYkMyCkOlyPjlSGqA-1; Wed, 04 Mar 2020 06:55:40 -0500
X-MC-Unique: Ky72xvYkMyCkOlyPjlSGqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A8C800D48
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2020 11:55:39 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09DCE91D71;
 Wed,  4 Mar 2020 11:55:35 +0000 (UTC)
Date: Wed, 4 Mar 2020 12:55:33 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
Message-ID: <20200304115533.GB1320660@angien.pipo.sk>
References: <20200303163505.32041-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200303163505.32041-1-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 17:34:35 +0100, Markus Armbruster wrote:
> Based-on: <20200227144531.24309-1-armbru@redhat.com>
>=20
> This series extends QMP introspection to cover deprecation.
> Additionally, new option -compat lets you configure what to do when
> deprecated interfaces get used.  This is intended for testing users of
> the management interfaces.  It is experimental.

I've quickly hacked up support for the 'deprecated' feature in libvirt's
QMP validator. I've found a few uses of deprecated commands but they
might very well be in code paths that are no longer invoked in modern
qemus:

Offenders from qemumonitorjsontest:

44) qemuMonitorJSONSetCPU                                             ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'cpu-add': failed to validate arguments of 'cpu-add' against QAPI schema: E=
RROR: 'cpu-add' is deprecated
FAILED
46) qemuMonitorJSONChangeMedia                                        ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'change': failed to validate arguments of 'change' against QAPI schema: ERR=
OR: 'change' is deprecated
FAILED
49) qemuMonitorJSONSetMigrationSpeed                                  ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'migrate_set_speed': failed to validate arguments of 'migrate_set_speed' ag=
ainst QAPI schema: ERROR: 'migrate_set_speed' is deprecated
FAILED
50) qemuMonitorJSONSetMigrationDowntime                               ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'migrate_set_downtime': failed to validate arguments of 'migrate_set_downti=
me' against QAPI schema: ERROR: 'migrate_set_downtime' is deprecated
FAILED
77) qemuMonitorJSONGetMigrationCacheSize                              ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-migrate-cache-size': failed to validate arguments of 'query-migrate-=
cache-size' against QAPI schema: ERROR: 'query-migrate-cache-size' is depre=
cated
FAILED
83) qemuMonitorJSONQueryCPUs                                          ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
93) GetCPUInfo(x86-basic-pluggable)                                   ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
94) GetCPUInfo(x86-full)                                              ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
95) GetCPUInfo(x86-node-full)                                         ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
97) GetCPUInfo(ppc64-basic)                                           ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
98) GetCPUInfo(ppc64-hotplug-1)                                       ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
99) GetCPUInfo(ppc64-hotplug-2)                                       ... l=
ibvirt: QEMU Driver error : internal error: unable to execute QEMU command =
'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sch=
ema: ERROR: 'query-cpus' is deprecated
FAILED
100) GetCPUInfo(ppc64-hotplug-4)                                       ... =
libvirt: QEMU Driver error : internal error: unable to execute QEMU command=
 'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sc=
hema: ERROR: 'query-cpus' is deprecated
FAILED
101) GetCPUInfo(ppc64-no-threads)                                      ... =
libvirt: QEMU Driver error : internal error: unable to execute QEMU command=
 'query-cpus': failed to validate arguments of 'query-cpus' against QAPI sc=
hema: ERROR: 'query-cpus' is deprecated
FAILED

Here all commands are tested just for legacy reasons. query-cpus-fast is
used on any live codebase, cpu-add is no longer used, change is not used
with -blockdev. I'm not sure about the migration parameter APIs but I
didn't check either.

The above shows that we can't enable this without thinking even in our
test-suite.

I'll try to come up with a solution where we can enable the reporting of
use of deprecated commands through /etc/qemu.conf so that I as an
developer can always use it.

I'm currently busy but I plan to follow up later.

I've pushed the test change here:

https://gitlab.com/pipo.sk/libvirt/-/commits/qmp-deprecated

The unfortunate part is that we'll need to manually inspect the codebase
for any deprecation in returned values. Our parser is 'artisanaly
handcrafted' so it can't be introspected.


