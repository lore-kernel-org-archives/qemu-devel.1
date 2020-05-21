Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC259204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJdSzCIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC259204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbi1I-0004Df-3a
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbi0B-00026y-Rs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:00:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbi0B-0006NU-1W
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:00:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id k13so6090609wrx.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TPaV4JvfBALFnzvbJlsMc6Qn+duNP6FlrUkXM33a6Ig=;
 b=fJdSzCIeY526wuiKXjxWf+YC15xOvErHP3l5qUgANXy4f9dcW1DjzUUQWzD13jkWPl
 4egw4fqOd5fxXiB4LGY6i1dEucc84HcepAlPRycF4k8HlMiaB3+MQvE8tWrS3UZLc9u8
 FAsDXx7EKx9MvLFLa9wsIKJ8yGgpBhymLHPmS1s3NXfBz1CUy5m0WFGUghhgJSYCypyF
 05H1CA13TWEhvqkDYT5U5bImO3pxKgVraCjSIFWjozcyB4G0a2mJN8ekJOrk97WdPcUm
 Fz6k/JpKuBy58yfJ2ol1dmAWmRYzeVD+0LGbtp5ll0KEpO3WHb81bhOichZNI2A210kC
 ue4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TPaV4JvfBALFnzvbJlsMc6Qn+duNP6FlrUkXM33a6Ig=;
 b=WtHBPbBcxy+OiQ6bCF7aZyIkguVVvvv3eFgViR4iHb6HczxrcGayPCW5I9RP+fQdQ2
 Wr7rpyhPC4BYjJDueGIR1cTduQzf3+6Xw2bltdFIDB8QM43ZJK1WdOGzyffY63CPmSlk
 3WTQFAhQ3pAwOaCv7iMrywLH9kVqQtSJI38FxBZTlRemGb/eTjqdBDqfMYkpU70MBSTf
 3I9I+kawl/2G9/Mo9oxP+1sjNC4AzkAEL/sggjLSzEdTvzUtnMkHFZoCupzVMGw7UiFh
 Tw6hWrCTLpQ2QJYSc4k97D3sl37hOSG6hJPcvVcsBnLSt5Mw/3wO5tX1Gszlynmuc9nB
 r1yw==
X-Gm-Message-State: AOAM530N1uuiQDbvsAS6325zkfXfvOjQFUjfz3EN7d//DMwPwAQnzLcY
 T/sX5Qkf5+xDKWDJ548x89WzpfCv
X-Google-Smtp-Source: ABdhPJxInjn7lEqv4lIAZ1KK/yqSZqEpDmd/FyjT35VHCrrC9Zn2gc9I/DdLUqEhoEvTgM+JDhTejg==
X-Received: by 2002:a5d:4e8f:: with SMTP id e15mr7791115wru.91.1590055232979; 
 Thu, 21 May 2020 03:00:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i21sm5972732wml.5.2020.05.21.03.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 03:00:32 -0700 (PDT)
Date: Thu, 21 May 2020 11:00:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Add support for SafeStack
Message-ID: <20200521100030.GE251811@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
 <20200505133111.GM764268@redhat.com>
 <c6ac2d0e-34bf-9927-f2fe-2ef0408dcbfb@redhat.com>
 <7f6916f8-c559-ebae-e6b2-75083f3ff2e5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <7f6916f8-c559-ebae-e6b2-75083f3ff2e5@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 10:48:04AM -0400, Daniele Buono wrote:
> Hello everybody, just pinging since it it's been a few days.

Hi Daniele,
Sorry I'm late to the party. This looks useful, the patches are not
invasive and provide the option of enabling extra security.

I have left comments on specific patches.

Stefan

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GUT4ACgkQnKSrs4Gr
c8iuQAf+MvVb+ZZZErrIb4Rl0gCB4njhLVCCFeio92TlMTGR8mWbKp/ZnV+4bXE8
6sEz4J94exjWfB3QTg45br5JQ8u/QPrslVvwPNI4RGESNRfj9x3EjymznysNkbEs
gVn4f6xIwKQ/HlViPSHxnhiFfuCTM+BkFVVz/aWPngESaVXiVQrMxX93TwUPoXcL
x9odVwIwAXXAiRyWVAep8e/4w/4ajmWnZSgpy1r+jxjl6XRr5ETNezmNc6scSPgO
B9Dgn3bhfBX9nRce8VsEyriD/jHxCboUPJTLKPe+4yoNTJXQBjkbaXfuRE/yRBtW
winv4mssf+nvIAClqjgo1GsdsB5xpg==
=0mKc
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

