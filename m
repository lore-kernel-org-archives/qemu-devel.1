Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF5D20899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJxkfouB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF5D20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzSs-0008Lo-C5
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzEb-0006VS-QU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:26:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzEZ-0007f2-6g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UoXVmIV6ADAT6X8G0PbTREebuaqkvNoES0WPCGg+2Yw=;
 b=eJxkfouB2MjpUe0QggzhT9IQms+fxC2XKBr1JVmQ7QWNzvNgKVgXPMD2UgBltDYGIhNJwy
 cG5EIZXHPnMNjKgoFDPrvinCQQJLCx6P/iwwBvsyOtx6SSZQAW6exd75SwUwI0bZYYcpJU
 yJXg8VWzgfMc5geUPov6pJT3YqVciTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-CbxCsSPYP1SSM3nIfDpScA-1; Thu, 02 Jul 2020 09:26:30 -0400
X-MC-Unique: CbxCsSPYP1SSM3nIfDpScA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5261940920;
 Thu,  2 Jul 2020 13:26:28 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3EC173FC7;
 Thu,  2 Jul 2020 13:26:22 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:26:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 21/21] multi-process: add configure and usage
 information
Message-ID: <20200702132621.GE152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <3624d64f8943aea7f9867c10159e15b42cac77ff.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3624d64f8943aea7f9867c10159e15b42cac77ff.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:43AM -0700, elena.ufimtseva@oracle.com wrote:
> +2) Usage
> +--------
> +
> +Multi-process QEMU requires an orchestrator to launch. Please refer to a
> +light-weight python based orchestrator for mpqemu in
> +scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
> +
> +Please refer to scripts/mpqemu-launcher-perf-mode.py for running the remote
> +process in performance mode.

What is performance mode?

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl794H0ACgkQnKSrs4Gr
c8hLtQf/WAzYQi36lrC+a/VCb36cM3IwVDW4rRGfBBV1DvUDDUlFmIK09CFX3WbY
fvGVjFpnZGj18QMU38j0OHHqaAlNuEe/VpBNrRdcvmZMSC01qw0Zkzs13KAbtZDF
SwLnywZCumseimPoYfeu8YoOX/313fcbdpwQiyS4IQRqbrZTTBUDum+IJIvqMoVz
trQdQpzb4hku72d4Dg8sTbqVMzcIu3DkDpLJ31ujuVvpI4nzg9gJC7nV3FkdHZlo
CtfK02D1nHB94cLZRP9lGIwb0JUftso69qEU4LOGup4VQYC3ltPEzvOc9DJGRO2d
4zWqw0VTfRCOC2jJcdfLhQevOoG6aA==
=K8b/
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--


