Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F03C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348A1204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO51MwwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348A1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhzW-0000wl-Dq
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhyl-0008CA-Bk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:59:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbhyk-000611-Em
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:59:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so4857772wrw.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RfqkWEfWMVg9QTo4uO9M/wlF4mdizaDQ392VK3kQ5/E=;
 b=IO51MwwQqUnw2j+XfGeBgCBkuitiNSZFdB77uAfjMazItFTdTMqESvUv5OwfiHwfQ6
 doHBzUfVj4EPLLg7N3XD7y0Y66mZ3lqUEDBeRYinBEOVwOmbEQVVEU6KPyGyqns8u2Sh
 fBhMIPTPHVBzcGdk/e4NCwtN4kDxIAMGw8vdZrcBngWF214qdt6vVH33LEFihGuFHnkA
 +kZRevvPvsxN8wTzXukAiXX9Zr1yJZZj8s6/Mm5TbdoAZso2L1DpmHbnGje6wo+Rp0ip
 +lo6td1mp1Vg7mUOyNRJhES42lR77KXwvFm+MLg2helio7k5SOQgr83m+RObRWc5ijWI
 1cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RfqkWEfWMVg9QTo4uO9M/wlF4mdizaDQ392VK3kQ5/E=;
 b=tcbnyk3uLXQN7JqD0Z/boewRNZ0qWhx+OpS7A935MzmLTfCEts8heFkwY0XimF72al
 gofTN293prQM8QScAp/QgCUIFsVOaGDv8IvaX46wXtSeDENlsIn4FxFyoTGiAeng8sNk
 3ol57hNVxjv9AdO7IGzyvRtdI6FGOX70CZNhgiHRwlElVvXbZp+YmRYL9hmwAN1LMcat
 z++VasXg8Sfq1bqOS+JJpd53AF1bxqzLsIGxJTGwj+3iwezE5XAW0NirfxFns8YNUQTg
 mUhDCYG2U1bpUAJoSyfEh9drx1UoqI3T9OgG6NftwGlcRpT1VwAlu75M7Fgig534l4HE
 XgYg==
X-Gm-Message-State: AOAM531H9Ew60QJypzljpAfZ1TrHKDnadmhyXr6UWn4Me6gsI1tVj05J
 b43aELS8ImN74H//Vqqkkpk=
X-Google-Smtp-Source: ABdhPJwLQKU7O8zyYClNo7Cq/haLIzNADcVHvr+B8SZx2uOkSt9nPT0fnUf0Qheu46X9/z/lxA0UzQ==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr7727716wrq.171.1590055144846; 
 Thu, 21 May 2020 02:59:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q74sm6275881wme.14.2020.05.21.02.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 02:59:03 -0700 (PDT)
Date: Thu, 21 May 2020 10:59:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] check-block: Enable iotests with SafeStack
Message-ID: <20200521095902.GD251811@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-5-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20200429194420.21147-5-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
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


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 03:44:20PM -0400, Daniele Buono wrote:
> SafeStack is a stack protection technique implemented in llvm. It is
> enabled with a -fsanitize flag.
> iotests are currently disabled when any -fsanitize option is used.
> Since SafeStack is useful on production environments, and its
> implementation may break the binary, filter it out when the check is
> performed, so that if SafeStack was the only -fsanitize option, iotests
> are still performed.

I can't parse this sentence. What does "its implementation may break the
binary" mean? Do you mean it's worth running tests with SafeStack
enabled because it exposes failures that go unnoticed without SafeStack?

>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  tests/check-block.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index ad320c21ba..8e29c868e5 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -21,7 +21,17 @@ if grep -q "CONFIG_GPROF=3Dy" config-host.mak 2>/dev/n=
ull ; then
>      exit 0
>  fi
> =20
> -if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
> +# Disable tests with any sanitizer except for SafeStack
> +CFLAGS=3D$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
> +SANITIZE_FLAGS=3D""
> +#Remove all occurrencies of -fsanitize=3Dsafe-stack
> +for i in ${CFLAGS}; do
> +        if [ "${i}" !=3D "-fsanitize=3Dsafe-stack" ]; then
> +                SANITIZE_FLAGS=3D"${SANITIZE_FLAGS} ${i}"
> +        fi
> +done
> +if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
> +    # Have a sanitize flag that is not allowed, stop
>      echo "Sanitizers are enabled =3D=3D> Not running the qemu-iotests."
>      exit 0
>  fi

The commit that disabled check-block.sh with sanitizers said:

  The sanitizers (especially the address sanitizer from Clang) are
  sometimes printing out warnings or false positives - this spoils
  the output of the iotests, causing some of the tests to fail.

It seems fine to allow SafeStack if check-block.sh currently passes with
it enabled. Does it pass and produce no extra output?

Stefan

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GUOYACgkQnKSrs4Gr
c8hEmAgAul7ACHMyTMKZMJIFtW3FN/jSmhlzpJDFHvkbDJsh3tJMA+J7jdD3k/M+
LKgsr53K+jZKChzxDC6mtREmzRzj+ISTAZsdg44vz5TmdBVRQ6OSTg32BGKlV9Ky
DPX/hcNI8gaHLsGaW5dTqytc/Ow9FwGEE6ia1TPOVEfEY534uoNwBUSFlXL6hTZV
WZynczvHGQJl0kJqde4qNcsdvOoMOFKTO0dheL7doZImMZZPfwAxcnbaJzVSBd5f
aD4lszREgtyibmzPM51RxCU1PjBaOxwFFD214hbxuQ0jMWnudd7yFylmgIxLiy5m
JX+AUZvuW2hM9NsBNjLM80mnS5WJOw==
=gKzJ
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--

