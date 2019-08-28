Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27650C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51912342A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Q/7J+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51912342A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2tLQ-0002Vy-1b
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2tKJ-0001e0-KW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2tKI-00057j-NZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:29:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i2tKI-00057T-H4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:29:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id j16so1536142wrr.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+VFWSq9y8cOjHszadJf0wWDK4NTHviei6/UpUHSl440=;
 b=L0Q/7J+CXlpfH10Ypg8p0WyvWTgx50TI1taKa2I8PiCVEQQcEbgWwVlntw92YNdFvp
 m7wHrTnJw7uX2Bu6YynZ1ymwYaZMeVu8XbeuyvmjtKzAEXwIhmwiaGrO6ZmZv9f7Ioeo
 5rV8QpoewdEB4yF2g40EYvpAO93U30oeDIoznwCFdZmZ+O65rf9holXr7QzYBYChqzne
 nRfJUfEbDe/HEC9UOx7GBMD4KnfpU+2rGKssZ1Ae9XBoX2wL3T8T4U29utktc4tu8Oh/
 O9vNsrMb+KrF64a6sOtdUAnqp/ftxQaNJvwXFyJXLnTxTm+a3cDyMYFFb4BCMQlRxlvS
 i/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+VFWSq9y8cOjHszadJf0wWDK4NTHviei6/UpUHSl440=;
 b=fa1o40qUODqinyrjNU+kgHY7W35Fh6IwubWVE2wGjTpRwb2TWcuLA69sPCN3icVu0o
 rFH4Vb1hsKOHMZtakAaUGZ6/G7e2EQtwUTDIjJQFxq7dzz371w3knOCicju4psSjp6A9
 GqIZUcbVhMGorZZTxxbCNgeo2ibOilZhvZs9oOOTJW+CHDNkijfpK1htj+9ECcwjfs3Z
 8OJUjbp2hO7Z6nhO1Qtqbz8jSLZtIP9zqCSvY9rMxLqJAfRQ9Zrv/EN0UKqc6D+lO9Zn
 mRMGywVS+FzDExcCwVs6BYF5Qg66PAZVwF+vXBip75dwGBlDKRvFwVMiT3NiiGj+qppt
 dIuA==
X-Gm-Message-State: APjAAAX+a/zS0Lql9hGFg2L+oPU9i1pzon2KQ5LpmsMtvDnxMfT7pBWs
 2hA87mpHHpo4oY7gXUblSowAgScpKoI=
X-Google-Smtp-Source: APXvYqyh4V8FsxDDzDy1dnCcki1T6+O5/LSqpOyGUblNp2S9qGEjyvjS5VMK/CqujbFRMPXRqj+izw==
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr3090126wrn.118.1566980949539; 
 Wed, 28 Aug 2019 01:29:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f197sm5207033wme.22.2019.08.28.01.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 01:29:08 -0700 (PDT)
Date: Wed, 28 Aug 2019 09:29:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190828082907.GA5573@stefanha-x1.localdomain>
References: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
 <1566498865-55506-2-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <1566498865-55506-2-git-send-email-raphael.norwitz@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 2/2] backends/vhost-user.c: prevent using
 uninitialized vqs
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 11:34:25AM -0700, Raphael Norwitz wrote:
> Similar rational to: e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
>=20
> For vhost scsi and vhost-user-scsi an issue was observed
> where, of the 3 virtqueues, seabios would only set cmd,
> leaving ctrl and event without a physical address.
> This can caused vhost_verify_ring_part_mapping to return
> ENOMEM, causing the following logs:
>=20
> qemu-system-x86_64: Unable to map available ring for ring 0
> qemu-system-x86_64: Verify ring failure on region 0
>=20
> The issue has already been fixed elsewhere, but it was noted
> that in backends/vhost-user.c, the vhost_user_backend_dev_init()
> function, which other vdevs use in their realize() to initialize
> their vqs, was not being properly zeroing out the queues. This
> commit ensures hardware modules using the
> vhost_user_backend_dev_init() API properly zero out their vqs on
> initialization.
>=20
> Suggested-by: Philippe Mathieu-Daude <philmd@redhat.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  backends/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mO1MACgkQnKSrs4Gr
c8hvJAf9FEjR5Dbjhm4wNKqtDOv5FhKMbqFbTdpqey2KKr4/qod/vav31UwCAGWn
ojeRjatXF/GcKY92/0B26Izq6UGwXsi6J9xtW8q0aMFPfj++mYePylBqa849GOMU
MzogPC44LVn63U+6TeVTy3mjWXDx2G5a2tEGAe+3egQnXOWx0wZDOvCXOFE3GdJn
c5WmSQDq68bZZW0cuRDh2HYMZwk2grsEbgWiCJ8v7fRMa1XAu0PJLhexlfveHB8S
ujgSPyErAjXtpdkUejcyNrb6proFThF3Q5ivjG/WuOV50u/mi+NcGJdpffPoq4pm
ixI5mJqRvYq4p9YPFTSy8V216CDpdg==
=/d1E
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

