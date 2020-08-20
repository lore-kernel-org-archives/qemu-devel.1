Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A528C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EB92075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUjrf9JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EB92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pwq-0004kD-BQ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k8pwG-0004Kg-7o
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 15:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1k8pwD-00071H-A2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 15:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597950563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=SmU0k361h7pYFN6SzS8dkdBuY5utUyXWI8bfS7l8rTY=;
 b=OUjrf9JQcXUWVCbO/H1XlueFRR+Tmp1E2/Jq3PtZUgD4YVg/BF61KheMt5SmLtAOQq5wpG
 Z7s9gAb6TRy1nEgEfUWt8IJ1elzh9k0Wgtho8HtGn/xRibV1PMsaDREvghBn01VrU475m0
 FSIK9PPVoeMKmYtcukiDPM43mCeY80k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-lLxf5nnfN8K_5ufPFXd4iA-1; Thu, 20 Aug 2020 15:09:20 -0400
X-MC-Unique: lLxf5nnfN8K_5ufPFXd4iA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 728A78030B9
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-115-22.rdu2.redhat.com
 [10.10.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 064B560BF1;
 Thu, 20 Aug 2020 19:09:15 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:09:13 -0400
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: Avocado's upcoming LTS release
Message-ID: <20200820190913.GA1086329@localhost.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: avocado-devel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi QEMU community,

I'd like to bring to your attention that the Avocado project has an
upcoming 82.0 LTS release scheduled for Sept 7th[1].

We're writing to projects that use Avocado so that they can start
testing with (what's going to be) the new release, and adapt their
usage or influence the final release bits.  But, because of the close
proximity between Avocado and QEMU, we've picked up the responsibility
of this work ourselves[2].

Of course, the more testing the marrier, so please get in touch if you
can:
 * run the existing tests you have, with the most recent Avocado
   version possible
 * open any issues[4] you encounter

This will feed into either bug fixes, or documentation on how to
migrate from (as early as) 69.x LTS to 82.0 LTS.

In addition to this this, feel free to engage with us about how the
new Avocado features (and there's a lot of them) may be beneficial to
the QEMU project.

Thanks!
- Cleber

--

[1] - https://github.com/avocado-framework/avocado/milestone/8
[2] - https://github.com/avocado-framework/avocado/issues/4116

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8+ylYACgkQZX6NM6Xy
CfPLEA//ck2mq5GsZ4Xj6EGWYjzqTWijgldSLwTQBI9/7fUZJ4UWEWXfLe7msh96
UuPw3e5JIEOrT86+BTeHtbvxxQkWYCaC1c5x+X/8f2/C2EA0blPyZqqasj0VBCBt
FtwlLvppSCHM3aovm/B7WQrMG5caVELbzRoUPEfAuzsEF1h5H0Bcdft37/oBFSWl
GEMf5KYQ0Ie8usdnOE7ap2ojYgnaiAusVinQTBKByFfs6rP4hjL14LjC557B7K5t
H04N0h9hZcj5/NPgYUq0s/wJtdwmPCTqxsMHiqmpVeuxtEoo573MmDR1BZbGUtOj
vc7ekkjVlrnmq6r5PCCdRCWln9j3Xsit/offeRa8+sqndJ3218CsGtgo67ZTWuBj
RXQ6cF7n1WtMfPEx3Ix0qOVttBuPL9C4gtSUoQty4zjExcSVEQS9bSA+WwBEiz1j
T6T/VC0OK8luTPDwsCobqGiOVE4/SBeSSzzlGcyjTGJxSUbdHq3rWJ5/xnEBUpsw
He+Ggn9kWuW4p4iOovKUceMmKkImNhAu1IzsADXZwr5P9EhKdTl9yf2o/RsOwGue
QBsRUr7ROeMSx1rHL6SkW5fpKA8j4QVBYK8tbaYEu3jRYKRYIIf7hc0LiFbDmjHb
ICCy/QwQhYyIGzVkkILHWK6MBHiOwUNaGRJ3IS9y/ok9vMdIhno=
=7m3s
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


