Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD4DC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC3F2071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNQ8j8Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC3F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBnxz-0000jp-S2
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jBnxG-0000KB-4t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jBnxF-0004sv-AY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:06:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jBnxF-0004of-6q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583881588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXId9yRLM7W6Cn7/Bu5yt38A6ueA/MGGZTFT8POc87w=;
 b=XNQ8j8Q9ren2MqaSDgUvAWL7LX2BfaNXGaM4fNjoJReFUo5CwWf0rsE/hjIOuoFsbaSwrS
 in15mC3fhv/JJJ3HKn68TcsFywCEc9CWAZ2BxY1cAs5ph/ciBBLUKGh1eFMiYQAufXjVo2
 /lfL94JwWoVHQPiIRzhs1YYdkmoXYmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-255sQ6E_MHGCZLQ8WJ52Ww-1; Tue, 10 Mar 2020 19:06:25 -0400
X-MC-Unique: 255sQ6E_MHGCZLQ8WJ52Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C97800EBD;
 Tue, 10 Mar 2020 23:06:24 +0000 (UTC)
Received: from localhost (ovpn-122-18.rdu2.redhat.com [10.10.122.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD28E5D9C5;
 Tue, 10 Mar 2020 23:06:21 +0000 (UTC)
Date: Tue, 10 Mar 2020 19:06:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 16/16] tests: Update the Unit tests
Message-ID: <20200310230619.GK1187748@habkost.net>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326551802.40452.18371333088303667854.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <158326551802.40452.18371333088303667854.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 01:58:38PM -0600, Babu Moger wrote:
> Since the topology routines have changed, update
> the unit tests to use the new APIs.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>

This has to be part of the patches that changed the function
interfaces, otherwise we break bisectability.

--=20
Eduardo


