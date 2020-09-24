Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B9C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9456D23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCI4nLV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9456D23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMnR-0002v4-MX
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMmF-00026H-LL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMmE-00006H-4Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLdzcM+E42ThiHQBIhDSXJ90qzg8Wk0cdYHGj6Z7n6w=;
 b=eCI4nLV9BTZaoD1NRJepBkTbnjzy0yrTn9XoLK4k6JhKiHhvgEeSnL0giRD5ihvOpjCxZy
 UGQNuySB1EuVYeARrgHD4TfrnrrY3Evu8xZR3tDCHOVr+Y8UAhB1WKIeINFMUGGXmS7VfA
 N4uWgnByx/e5k9k+c/j0M5BYQTVAk9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-R1ewerxZNauVXWn_NpLHBA-1; Thu, 24 Sep 2020 04:38:51 -0400
X-MC-Unique: R1ewerxZNauVXWn_NpLHBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 211EF802B49;
 Thu, 24 Sep 2020 08:38:49 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F138E5D990;
 Thu, 24 Sep 2020 08:38:42 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:38:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 00/20] Initial support for multi-process Qemu
Message-ID: <20200924083841.GQ62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NEaRsfQExFH3jWtg"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NEaRsfQExFH3jWtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2020 at 11:12:11AM -0700, elena.ufimtseva@oracle.com wrote:
> The v9 has the following changes:
> - Communication channel. Qemu side uses blocking call to send
>   and receive the message from the remote and cannot progress
>   further until the remote side replies. Enhanced the
>   communication channel by dropping iothread lock before blocking
>   on Qemu end. Use the co-routines on the remote end to avoid
>   blocking QMP monitor;
> - removed the heartbeat functionality, it will be added later
>   in a full extent;
> - fixed leaked errors and similar fixes;
> - eliminated bytestream passing over the channel;
> - The build system had to be changed in order to accomodate the
>   latest changes in Qemu to use Kconfig/mason.

Thanks, I left comments but I'm happy with most patches now.

Stefan

--NEaRsfQExFH3jWtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sWxEACgkQnKSrs4Gr
c8iFIwf+PZ+h1wDvauzbQ0TG8w9zuIRmtbcagb1gIpWDKyqfkqAZRO3pdxo1+rcJ
ggihaCyFEaQCr3VAf/qBlINSqda+hAeVJHjEGAwN/sG1APuucwytAVJ2wCakjtMq
h9p+vGpnH182b789bh/AVv9K5A7BOyKdi8xSSjGDh2+S6NKuHgmQ6ZULwMjFRHuJ
1EkFJN0GmKMKwCqUCzKzLRxKph+xLku2kVv0/MU5XSr8fkIAWaGwoijlpSYt9nYw
HPptsJV0xnm3r9iejfGJLKKidFl4WjZImkpfjkcHuRVQHxrr5EpCcJatnFFgE+F8
pL5rDwqqI7cCtL+51zBvYnC1mAnWIw==
=IHsu
-----END PGP SIGNATURE-----

--NEaRsfQExFH3jWtg--


