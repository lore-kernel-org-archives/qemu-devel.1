Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BEC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDD9206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD+KlHiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDD9206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvNd-0008Uf-DW
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNvMo-00083s-GN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNvMk-0005ia-Sj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601546348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E54GCM9SE1zpiBjScssTTUR3ldeIs5ugDcNo0G7H5Iw=;
 b=BD+KlHiMKwF+3M7gHLGQhbQFt6a42WrKGMFgvapoksFZtJC47t4d4lHNQHzpdAZ0WjY49+
 9Yk+p3MqBkFd7LwbI5iDREJ7ZA7KpXzHIZT3IXDDxLwHEWHptI5KPFboi/nkcLF6S8liJy
 OBRnfyF3ildIXBusIQby1E0stg4h9vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-fylyeLKtO-q2ncaLdaeZZA-1; Thu, 01 Oct 2020 05:59:06 -0400
X-MC-Unique: fylyeLKtO-q2ncaLdaeZZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08F9F64082;
 Thu,  1 Oct 2020 09:59:05 +0000 (UTC)
Received: from localhost (ovpn-113-137.ams2.redhat.com [10.36.113.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56B477883A;
 Thu,  1 Oct 2020 09:59:04 +0000 (UTC)
Date: Thu, 1 Oct 2020 10:59:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] block/nvme: Add driver statistics for access alignment
 and hw errors
Message-ID: <20201001095903.GA343239@stefanha-x1.localdomain>
References: <20200930133617.1320941-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930133617.1320941-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 03:36:17PM +0200, Philippe Mathieu-Daud=E9 wrote:
>     "return": [
>         {
>             "device": "",
>             "node-name": "drive0",
>             "stats": {
>                 "flush_total_time_ns": 6026948,
>                 "wr_highest_offset": 3383991230464,
>                 "wr_total_time_ns": 807450995,
>                 "failed_wr_operations": 0,
>                 "failed_rd_operations": 0,
>                 "wr_merged": 3,
>                 "wr_bytes": 50133504,
>                 "failed_unmap_operations": 0,
>                 "failed_flush_operations": 0,
>                 "account_invalid": false,
>                 "rd_total_time_ns": 1846979900,
>                 "flush_operations": 130,
>                 "wr_operations": 659,
>                 "rd_merged": 1192,
>                 "rd_bytes": 218244096,
>                 "account_failed": false,
>                 "idle_time_ns": 2678641497,
>                 "rd_operations": 7406,
>             },
>             "driver-specific": {
>                 "driver": "nvme",
>                 "completion-errors": 0,
>                 "unaligned-access-nb": 2959,
>                 "aligned-access-nb": 4477

"nb" is number?

Using plural ("unaligned-accesses" and "aligned-accesses") makes it
clear that the value is a count. It's also consistent with the existing
"wr_operations" and "failed_operations" stats.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl91qGcACgkQnKSrs4Gr
c8gW/wgAsHAKsUgnNkgF7KbX3yHg5xS/kFLXW+76EVDPsMVJMtdqgQZhxK4cQ+xo
DuT01Z6ygi/n8NOqlMEh1nvCLvUNANM6450w+CbAYMEWvzwfmYOIUV8SW8+l5w+S
kWkqQ0gKYqbAbmb9XZIrnVMT1R/5wsPnQA8HWlNcwHpNVA74JSmmlNU1F1BT4rsS
GE6UFYDUehC98pGVTzSobSkacsLcvwjJKW4JFflX6OsfVVx0egp7I02Ef2KdKTb7
DZM/NG3QkHMjUoF5JfDFdZZ/G+YID5W94HR1WhsyOZelfRiyciihMv+t4F7Pmtf4
mSvDwbgi3DOQuPj20vi/wOgKKbqQYw==
=9Fs7
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--


