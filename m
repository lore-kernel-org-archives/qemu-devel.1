Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D505C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA9B20774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSubx+qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA9B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQqW-0001MZ-6n
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQod-0008RF-PW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPQoX-0007ak-N6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601905564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/3d8IVKj4L1Ph3rSApF+Q7x6Gi7COij3vKIFWWh9/p4=;
 b=CSubx+qjR7znjvY+c8Q79uleuWpXlpaE0hp51pe1Me5i5RN8RBJ2rkm2ghoOU6Awt8t1hp
 fMwkydQn7V6saP3iPCmCwSYQy9/WH361/WXb/8JFtl3VH+5i7rSlLoOIRCtzGSMweHXNY5
 tOE/aMQBufv3ESm6FjJ30wW1UJt+kvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-2EU-5NoEO7-A3C2Q6abgcA-1; Mon, 05 Oct 2020 09:46:01 -0400
X-MC-Unique: 2EU-5NoEO7-A3C2Q6abgcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942D02FD14;
 Mon,  5 Oct 2020 13:46:00 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3F1A1002C00;
 Mon,  5 Oct 2020 13:45:52 +0000 (UTC)
Date: Mon, 5 Oct 2020 14:45:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
Message-ID: <20201005134552.GC5029@stefanha-x1.localdomain>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 03, 2020 at 08:14:11PM -0400, John Snow wrote:
> I would like to use the KVM call to discuss a roadmap for converting the
> remaining options to QAPI, what that would take, and who will take ownership
> for which subsystems/flags. I would like to bring these discussions to KVM
> Forum and lend serious, dedicated effort to finishing this task.

Subsystem maintainers will need to review these patches. Hopefully many
of them are willing to do the conversion themselves. Code examples for
common conversions would help (e.g. QemuOpts to QAPI, strtol() to QAPI,
etc).

Do error messages need to be preserved? For example, maybe the input
validation order or the actual error message is different with QAPI and
that may affect programs that launch QEMU.

Is there any way to detect incompatible command-line changes besides
running make check? One idea is to run a fuzzer to check if certain
inputs are accepted by the new/old version but not the other.

Stefan

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl97I48ACgkQnKSrs4Gr
c8jCoAf/UAXPYRCTYrTFFJBDNQxXVHMrHj/awrWz29SOjQwKG6/Si0OVC2bRY9gw
zHj15MT6nRfRQkSoI2VeSbJYWmgWjkMU9RIKx4TrP7ucFhqGW9FCjkyIysFNuOME
Eart0gbXBlQVd+mNL6ts7rWLbeLgr3BtbxmgnPL35GP+eLk90xjGNsCO/a26N8ZA
HRwC2ZilkI2OFjIV0QhO3lEb+nG9qgVtiORvECiow8Mguxs6UAJyUzTGEnTc7+Ry
hzpElX2u93IHTIqrpbF+J/22cTs89F68/7c6+rD48qHIpm558F058oXiN19ajR5T
1/O2W6kSXXr5GF8O5gQTEjd5SmTCUg==
=03+B
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--


