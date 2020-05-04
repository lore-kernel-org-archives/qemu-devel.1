Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B439320746
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8oKQMaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B439320746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWRB-0001rd-Tb
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jVWPM-0000Ff-F1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:25:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jVWPK-0007v1-V1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588580697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qorGcxSAjOIgJk/59eG7n1rtibQF5qfTSUT7p+Fnl2o=;
 b=e8oKQMaUYCT841O4dW9hNciR6XXyZpz/lT5QkaMtG/aFvtTM+10fVipMG1QgEWny99uhX8
 keam9m6mT2ptaqIZiheynccGlGR19w45hD6Wru0kY9QvM7CCpad59F/rPsfYSnGi1OjIU/
 QchFEVvZs5hm28XG3lmpM4PFunw/h+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-48Sa7pq_MU6EwgkEL84gbQ-1; Mon, 04 May 2020 04:24:56 -0400
X-MC-Unique: 48Sa7pq_MU6EwgkEL84gbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50E808014C0;
 Mon,  4 May 2020 08:24:55 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A0045C1BD;
 Mon,  4 May 2020 08:24:42 +0000 (UTC)
Date: Mon, 4 May 2020 10:24:39 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 00/34] Configurable policy for handling deprecated
 interfaces
Message-ID: <20200504082439.GC2102825@angien.pipo.sk>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
 marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 12:54:25 +0100, Markus Armbruster wrote:
> This series extends QMP introspection to cover deprecation.
> Additionally, new option -compat lets you configure what to do when
> deprecated interfaces get used.  This is intended for testing users of
> the management interfaces.  It is experimental.
>=20
> -compat deprecated-input=3D<in-policy> configures what to do when
> deprecated input is received.  Available policies:
>=20
> * accept: Accept deprecated commands and arguments (default)
> * reject: Reject them
> * crash: Crash

I've noticed that the 'crash' option doesn't manage to log the reason to
stderr. Relevant section of libvirt's log file which agregates the
stderr/out

2020-04-30 13:24:22.006+0000: 2072883: debug : virCommandHandshakeChild:418=
 : Handshake with parent is done
char device redirected to /dev/pts/0 (label charserial0)
2020-04-30 13:24:31.879+0000: Domain id=3D4 is tainted: custom-monitor
2020-04-30 13:24:32.330+0000: shutting down, reason=3Dcrashed

'handshake' line is last of libvirt's messages pre-start of the qemu
process. 'char device redirected' is reported by qemu. 'domain is
tainted' is added by libvirt when I've issued the deprecated API via
virsh qemu-monitor-command. 'reason=3Dcrashed' is added by libvirts VM
shutdown hanlder.

>=20
> -compat deprecated-output=3D<out-policy> configures what to do when
> deprecated output is sent.  Available output policies:
>=20
> * accept: Emit deprecated command results and events (default)
> * hide: Suppress them
>=20
> For now, -compat covers only deprecated syntactic aspects of QMP.  We
> may want to extend it to cover semantic aspects, CLI, and experimental
> features.
>=20
> PATCH 01-04: Documentation fixes
> PATCH 05-10: Test improvements
> PATCH 11-24: Add feature flags to remaining user-defined types and to
>       =09     struct members
> PATCH 25-26: New special feature 'deprecated', visible in
>       =09     introspection

These are cool. I've added support for verifying that any command
excercised by the libvirt unit test suite is not deprecated, or we at
least know that it is and have a replacement.

https://www.redhat.com/archives/libvir-list/2020-April/msg01444.html

> PATCH 27-34: New -compat to set policy for handling stuff marked with
>       =09     feature 'deprecated'

While implementing support for this feature I noticed that it's
impossible for libvirt to detect that it's available. The idea is to
make a developer-centred setting in our config which will enable the
compat setting if available and ignore it if not available to prevent us
having to fiddle with the settings when testing various qemu versions.

Thanks!

Peter


