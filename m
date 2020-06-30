Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF561C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5172074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB1hfSkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5172074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIEX-0001Ac-5H
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqI9j-0003jm-G5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:26:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqI9h-0000d3-Vf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593530801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=25A6aUdUTCCivlqxoWuju97U3Dsppk++2iIa592V/fg=;
 b=HB1hfSkDuXv4jG9UYxS5rogrzh5TvNW/8cFMXdWV+LLULSGin6ufr78cONCspuhEzJLTgF
 Jib71h/F+K96s0EWBOmQVxkNHHJzIfntIsNNr3xPI771m4PczbCZqSeMjBj+W4f+o4XrLa
 /6+o3IbSpIEc3K4FIitQiMvJLlWp/JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-GsKjtRSjO3-9Epw1RYKi2A-1; Tue, 30 Jun 2020 11:26:38 -0400
X-MC-Unique: GsKjtRSjO3-9Epw1RYKi2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C3E518A076A;
 Tue, 30 Jun 2020 15:26:36 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C521F5DAA9;
 Tue, 30 Jun 2020 15:26:29 +0000 (UTC)
Date: Tue, 30 Jun 2020 16:26:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 04/21] multi-process: setup a machine object for
 remote device process
Message-ID: <20200630152628.GD109906@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <e0192d9ae8c34016a834872dc037a04b4d66fdda.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e0192d9ae8c34016a834872dc037a04b4d66fdda.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:26AM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/hw/i386/remote.c b/hw/i386/remote.c
> new file mode 100644
> index 0000000000..4d13abe9f3
> --- /dev/null
> +++ b/hw/i386/remote.c
> @@ -0,0 +1,64 @@
> +/*
> + * Machine for remote device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.

A suggestion for expanding the comment:

  This machine type is used by the remote device process in
  multi-process QEMU. QEMU device models depend on parent busses,
  interrupt controllers, memory regions, etc. The remote machine type
  offers this environment so that QEMU device models can be used as
  remote devices.

> +typedef struct RemMachineState {
> +    MachineState parent_obj;
> +
> +    RemotePCIHost *host;
> +} RemMachineState;

s/RemMachineState/RemoteMachineState/ for consistency with
"remote-machine" and RemotePCIHost.

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77WaQACgkQnKSrs4Gr
c8j3NQf8Cvt7bc+/RUW6qgQTT1WTTQlbduswls6Y7oqc4FyzvZmiSqE7Xtxm3F/V
5HTkyfsFXOsu1y5TWRTVcAdgsvK5Ba5kZ/ZtqD/H0AW2SMa92GcHx8LKs2pkcMTq
RJWf8k0Z4hCfBe8D7iEVv5AGuyTEtYrqiRet7rSYXnjNUZLEX0NPbB6emJLiJanL
HM/7FucQShLvmpk5YFs3hwXnXUUmOUv85AywdjZHRq2lBWrfXL27kUSJuanTarpc
mtMXpK6lSfHX1lW5oFr/fzfSPBl+4V08v+9GQWJKEY3kKYl1NnSThevOglhB+Byd
LJHmBbxXqmkfbDr76Phl6LjELpik/w==
=lUG+
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--


