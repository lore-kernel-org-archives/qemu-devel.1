Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFC0207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnbF90aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFC0207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdu0i-00037F-Sy
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtzw-00023B-DX
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:13:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtzv-0001jA-Jy
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:13:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id q11so11452941wrp.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GR1wpP6C9oLtVywgRIBLk1J1L2VLoQurxkiBQfEuvR4=;
 b=TnbF90aSQqlET8bLVljUh6c6VcfA7CYU4bp/kLLepQKqS7ygQ/ktCy2eeNIr3YQ05n
 Gjz6K030pvxTLoZdiZ96/jGo7gPDwRbJy7wr6qCcRelrWEC9HY2R4UU0hC4XH9vzcyV1
 oK2F6aFmiQQ0CIktYwaxYuDyOt+gdCJwJ5dg0nifgbUsl+Z1fqSSRGi7TzyxmZNv6bDP
 hrJs8Ej+K5/hpYPBsGZOXxo1puH3yqQs+5YHWxQUm4DiLYJVVA6QxZUQmIZACXaQI7U6
 rP28TvlFHkpX7/Ekp+mw9xWy6E6zLqkrKJqP2jktgo+kmyHNyF0ryAARafk/tC1shqA6
 fsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GR1wpP6C9oLtVywgRIBLk1J1L2VLoQurxkiBQfEuvR4=;
 b=solno5ha+6IGzdwv7YiVV444erutju67WMwgOqZSWhyl+DS5NO0nXU2U53COWXqSzA
 gWQD+GT9H9qqCrnz3bb6SOHuRf9VIlE4xYwJNuBSx8nECx6YdSQ6Ln7cMKAj9VtyShB8
 0b23tq9LWs+ddfyjKfYK8ZjWWBiBGv5shsv1SSCyG4UIaAEmJkxoK+sff7+uBQAxqG76
 8guADMQ3BgZ8GSmhcxMQrPnEFyIAghlZ3Dqf4g6qvpG2zlNbbjl/npC2WrwedbqXwKvC
 KS3gbUAbnLF49WqnGpves97OMaJd0w0r+aRVH093WOXSjecl7Sn8vFlSU3GtUuEwsvdW
 VujA==
X-Gm-Message-State: AOAM530zfxus0Soiskxjj8jDcIs+M93qJNyuK17nJgk4Wdf5Tys3huK7
 epfhw7xX42IoeO3aMouBzSY=
X-Google-Smtp-Source: ABdhPJygVXWjhKUQhN0zQYfGElJcXqYslVvMNhnhiOgNHN2A5LlghyZzAva+SHuEb6VjSEIM/svClQ==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr23963705wrt.298.1590578001984; 
 Wed, 27 May 2020 04:13:21 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h15sm2462922wrt.73.2020.05.27.04.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 04:13:20 -0700 (PDT)
Date: Wed, 27 May 2020 12:13:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] check-block: Enable iotests with SafeStack
Message-ID: <20200527111319.GD29137@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-5-dbuono@linux.vnet.ibm.com>
 <20200521095902.GD251811@stefanha-x1.localdomain>
 <dc422d29-131b-a5a8-ee10-6dccff7caea4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <dc422d29-131b-a5a8-ee10-6dccff7caea4@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, thuth@redhat.com,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 11:35:42AM -0400, Daniele Buono wrote:
> On 5/21/2020 5:59 AM, Stefan Hajnoczi wrote:
> > On Wed, Apr 29, 2020 at 03:44:20PM -0400, Daniele Buono wrote:
> >=20
> > >=20
> > > Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> > > ---
> > >   tests/check-block.sh | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/tests/check-block.sh b/tests/check-block.sh
> > > index ad320c21ba..8e29c868e5 100755
> > > --- a/tests/check-block.sh
> > > +++ b/tests/check-block.sh
> > > @@ -21,7 +21,17 @@ if grep -q "CONFIG_GPROF=3Dy" config-host.mak 2>/d=
ev/null ; then
> > >       exit 0
> > >   fi
> > > -if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
> > > +# Disable tests with any sanitizer except for SafeStack
> > > +CFLAGS=3D$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
> > > +SANITIZE_FLAGS=3D""
> > > +#Remove all occurrencies of -fsanitize=3Dsafe-stack
> > > +for i in ${CFLAGS}; do
> > > +        if [ "${i}" !=3D "-fsanitize=3Dsafe-stack" ]; then
> > > +                SANITIZE_FLAGS=3D"${SANITIZE_FLAGS} ${i}"
> > > +        fi
> > > +done
> > > +if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
> > > +    # Have a sanitize flag that is not allowed, stop
> > >       echo "Sanitizers are enabled =3D=3D> Not running the qemu-iotes=
ts."
> > >       exit 0
> > >   fi
> >=20
> > The commit that disabled check-block.sh with sanitizers said:
> >=20
> >    The sanitizers (especially the address sanitizer from Clang) are
> >    sometimes printing out warnings or false positives - this spoils
> >    the output of the iotests, causing some of the tests to fail.
> >=20
> > It seems fine to allow SafeStack if check-block.sh currently passes with
> > it enabled. Does it pass and produce no extra output?
> >=20
> Yes, that was the idea. SafeStack should pass the tests without extra
> output.
>=20
> It did (pass) on my testing machine. However I don't remember if I did the
> full (slow) check or only the partial one.
>=20
> Will check again before I submit v2

Great, thanks!

Stefan

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OS08ACgkQnKSrs4Gr
c8hksQf/fNs/bm0HP6Rk+hqQf49ax8P5QvPs295imavF+oCgLUXyAD173A94/jO6
I2+52w0ECphegGv3m5QS94HO0OKsfzyJPTITBnwC7QHzsaFEzW6ano9LDu34NFJj
ymJfIRdyvgeA7Ggk6IRcfJQOw8Jn5KnUek4gobBDIKAiY1PLX5V0Bymim2QuIzj2
yv75swihWvXfYQNVmkY/fwWLj+pp/dvzrigClTxDC8DBjTwp6SjHIkNVuv7RAGHD
FgjrcHx7bb2+fiDLOEo2ZvRSfJl2mECoytvH7sOShZWX/V+o2Yet4OkjxRkOD3Mo
6bi49/c7HggbR1adWYTaxCdC+DjSKA==
=y/XD
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--

