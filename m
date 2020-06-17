Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20063C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E317520707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+Q6PLvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E317520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZt3-0001BL-8T
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZk7-0002P1-TY; Wed, 17 Jun 2020 11:12:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZk6-0007B0-D6; Wed, 17 Jun 2020 11:12:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id a6so774874wrm.4;
 Wed, 17 Jun 2020 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VVmcwQqcqsnfwV++or82zXFkixv3Ic9j45fRPzZ1wgk=;
 b=o+Q6PLvzHrjAwhnkEn7OrdBhtz9bUiL/LcfcAkawgrqjlNgRcYw7sHisCWyriksfWd
 josM8D4qgkVSjU2h+zpHqFhRrv4MrVeEMM09vfNxZcOVXx+SregghVN4iZyi/WBtQeCc
 6kTvwf6hGL4g5vDnpt2JgT5Qa5sxgJYv1vwQsGvYaUuEcpUp/Jx8pPOFdicNk973+DK1
 8gCpksRHVvRwcxCf/Xxo0xcep7uOhh6r7ZHvfiejJk6SFcGpaMJTUOWd1iMuo3OOxSV0
 honsgQrVRVVfwyIP3wLQk9YY10vYAVkW2I/BUciMdAoyjQxoXWuVU55xRNmkDzbx10oE
 PpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VVmcwQqcqsnfwV++or82zXFkixv3Ic9j45fRPzZ1wgk=;
 b=Nx5olbHwPWJY+Dw3supl2QKSZKUzZH0etdMhd+Usutz6eKUNYE56/xJb3uQPeJfC95
 8DqkBN2sN02T8/RocVXo7ZU6y9/7ud2X+Ve7MDRirl/A4Gb02Ifx06xvo3Y5o7HUVLm4
 qw9hgl9ziI3ELlP6oxsYfi81nr//zsYMmVMFvHF6KuBKIOxLzoQsa/4rsVj2PraS7c/5
 gHrBixXnj02jsWeNK5mY8v6HB63vd9C89TF2kuUI+C9xz8a7gffNAnMbiWw04oUspDU5
 QHWctcjUsLVLM7r+Qw1xMpuRVg3IccTr9gQOs/zRxHmxgSAEGQwp/F/1RaK6+hTljWLp
 FwLA==
X-Gm-Message-State: AOAM533vfjrxrksfk/TBL5HXjJdCbGwDUKI/OY+DTvB8+OcOhJV1PHpO
 TbAnwU2XcULHf34aWLjD2GE=
X-Google-Smtp-Source: ABdhPJx6Gu8KhbRy0Cz24GeuLrGIgVbaubDna00E+kKpMt/qJKxblIfvRJ6Dem7ZW7a8nQtIYOsGFw==
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr8650242wrp.424.1592406764489; 
 Wed, 17 Jun 2020 08:12:44 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p7sm34376447wro.26.2020.06.17.08.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:12:41 -0700 (PDT)
Date: Wed, 17 Jun 2020 16:12:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200617151240.GM1728005@stefanha-x1.localdomain>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote:
> +static struct YankInstance *yank_find_instance(char *name)

There are const char * -> char * casts in later patches. Please use
const char * where possible. Callers shouldn't need to cast away const.

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qMugACgkQnKSrs4Gr
c8jdaQgAieUMf4lNYjUEhSjICVFKSg0Y4mIh5zPEPM0mqtsC9TQU6lkCuE+TZxBE
BaCw3a4ys1MKS6TSCtGBUWFnOMVR9W7zz2lLUH8NOb1iy9sN0OxfkixA8Expv3lg
Xz1dJ0fmbbOAhshfO0fiZP331VdyWvurfrNOCD8Ghb9Y26etB7LsY1G5g8UAnZJJ
QT1qeI+LYViWHwYN12jQdHjWU5Hx4387x6nmce/w6cM+IxAl7tnVQbQWi3g/lQSD
qGinVy9NtSZJEslQYO4hlgggiUnvoeaFnvymmPEQOG+VRps8Jr/ujlLZx1vXOFlX
kg2/IFZXyG5eelhtrplmcFUXKEaC4w==
=a+dZ
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--

