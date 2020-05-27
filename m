Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7019D208DB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+bZOaCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxyv-0000Qq-Li
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxyG-0008RH-3O
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:27:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxyF-00036S-30
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:27:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so3477212wmj.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RmKmjceXc9rZfc29KsKqhudrbpSuuLTlySi8QbHRb20=;
 b=I+bZOaCdE8wJS3H2Q9VWa0lohkytOC0Jq/0i45ypFPC4d0XkOoeEbw32dqY56gtj4F
 mWqkfhd30sgpOFHsfz+bxiZfnf3MLINOsvD92cZ20FRME4RBhV/T6caIH7bRZUU500QR
 q7I59YxHsse4HEmwqMikBDVPslJuZpS7YdYELXfyMGB2+NAwfbIceN8BaY3jCsYN39Sk
 U3nwlNAaoccuqXowAtOdbSJXgvjxD00K6c0BShJc3r+gnQuTgEj2t4F/4E8S8S69a8eg
 VD2BlSPEHWuc5BXex8wBriLsD6BK5zg7XYs3wQ2caMD+d95DbCXFqqMA2jgzzYQX59pt
 ZLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RmKmjceXc9rZfc29KsKqhudrbpSuuLTlySi8QbHRb20=;
 b=Scl77PdpJub/tODQoaCiQXbSa+cqw6zBJQbQDyjKNfgjsd31eN2X4tphEbiQ5AE9gK
 7oMNTVoigaj4nROpgMZICyZUvbY3XZxNGxWNpvbhsIZVHuj12pZTv7GZsDmd4OEiUY7Y
 YXZM4AfzgEmOY4584XzIOp8T2uRkKKio0d0tH/PNu8sGgn98nJzYjIdheEossWjxvqPA
 VATtlya2qy+Ip2C4bTGo9TAHAe9h9M3eQxGWixuwEVFPRvosEwEz25OmnerOK//1xBkX
 a5UC7H9qS/Aef0MdJfjtAaNOBYNZZoyh17XmTPPMf/opKga5DfEdFodjcx0LJvAnd4fW
 70TQ==
X-Gm-Message-State: AOAM530Mp5nH3EBZjcifTBpytizSCswDr+Ta3z+yMdyIhK6PyxAZMn6o
 CX1Oawnv6Ag/9KcyyUzGUkE=
X-Google-Smtp-Source: ABdhPJyM7kVHXleYh7Nqqv3Fx0tuc9qcLdPUHNyxz9la4y6N9NqS4u3GRKhR+a6GrNq20soshUm1ug==
X-Received: by 2002:a1c:9ac1:: with SMTP id c184mr4673194wme.152.1590593272870; 
 Wed, 27 May 2020 08:27:52 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j135sm3650855wmj.43.2020.05.27.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:27:51 -0700 (PDT)
Date: Wed, 27 May 2020 16:27:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 6/7] scsi: Add scsi_device_get
Message-ID: <20200527152749.GL29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-7-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-7-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 07:09:50PM +0300, Maxim Levitsky wrote:
> +/*
> + * This function works like scsi_device_get but doesn't take a refernce

s/refernce/reference/

> + * to the returned object. Intended for legacy code

The following explains this in more detail. It's not necessarily legacy
code but rather whether it runs under the QEMU global mutex or not:

Devices that run under the QEMU global mutex can use this function.
Devices that run outside the QEMU global mutex must use
scsi_device_get() instead.

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OhvUACgkQnKSrs4Gr
c8j3UQgAntOwPqIpkQWocTjtseOt9QtmOrDngRw6Gy6HKjcNce9BUJdJ+PKn/mE3
2oIp4FcmLQzDmqCuoLCIET64Pn/atAXSNio4+3TgD5oO2KpamDIzOsFYxKgs+s0F
5305yIuMq0Cx9OfpFFz5ndnvCtpFw38hrQzFbLBjTGs6EPS+Qy7MHaKiFVTwOyPV
NH7SkmgcChp+RInm14SxmztQWg4WJyhxkkVQBw8h3RwApGGjD11fWVcsZMcA0fzF
pvPjxVvpqOlhDG4D/ynEi0SjU5SoyKN9qJ5df1wAX6y5py0UD8oy0nCk9IWJWmZI
J48bvg5av4Y6vMzvx43EdW+GljLuyQ==
=U+e6
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--

