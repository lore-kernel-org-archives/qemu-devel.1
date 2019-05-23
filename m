Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F9F20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5VDLoC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F9F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmUA-00009L-JA
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:06:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTmTD-0008Dn-Er
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTmTC-0006kx-Bo
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:05:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hTmTC-0006kO-2U
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:05:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so5986763wrs.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=sc8t6CEv10E4v29Fa5Tkr1QhQ2iklG/xlqy+l3B343s=;
	b=a5VDLoC4Vm0Y8hJcpB6XDyCSd3n+IccDShDXxiF2jBd/4IjOgVgoT+Uly8GCnImuFp
	eFmoIWG3SL0Mbe+LLEn2v/IXLcR8TBaEx4AaDL9kCXMMErZYmbGU87Ol/ooo9YRmLnUW
	uXowC5WhA/UbIPxS0MwCna7liHuNk+RFmkpA97RRwPcgzjLkR5R2xd3MBBkkJ7uj2Ayl
	cOZFUxtMDfv6J9sSUrkDfhYd1xbKwQtGOsLaXKhJNt1xP9N2/f42csqew3gfEc/H2Pmp
	0lT6Cl3iRPoEntvp3h8vm4khD2Uj+NP1ZRQXjBu+Ct1wj/fXEsGo1IPU1Hi4VxNVWJuV
	g/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=sc8t6CEv10E4v29Fa5Tkr1QhQ2iklG/xlqy+l3B343s=;
	b=WiKZJlOwYzG5O1ELZRZXUSTNRFQmshZdHTPDbZz9hkaEFqgOjtywzp8nRBm9gHmEHH
	6i6EV1CUX1POXPy9cGWrQPXKeOM5GM8abu8fgtcJbcnmBWK+y7SVnpj+/GmXgXJl25TB
	wfl0HABk4aS5VMSfKpvHzv5LKiHgAnjfMl45YuZOSJha4JIYOnZFruD7FsUqc8GghojL
	+Ed2QsLki9FvFnO9TLwL4zwxmNnuSPMAMFwMhPDrkuZAcnNtylsnve8S0JS91HvZ20HF
	zXhtfu7kZmqhN//z0rD3HbitS0TjXhsAbh8BLCZ5cQisBSk4j5jCE9WQRvQJC5wNPl+o
	zOPA==
X-Gm-Message-State: APjAAAUBSQ0ZTo7pLPphPDT1RFtKf8WJCmDehWkkM5CVnwY+VSj8xuuO
	S+Qqg16olOkIw7cVPn3msDhGBd5lYlSjaSKg5u0=
X-Google-Smtp-Source: APXvYqzadPEVXj+NobAMFU7Q1wGsLcgT8syCYlcoPSGHM/jH6v0tSDPVNakM/8JYcMYi/C7S+TtC+AN2EL2+DQczV28=
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr31646131wre.31.1558613112370; 
	Thu, 23 May 2019 05:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190519084815.7410-1-ppandit@redhat.com>
	<CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
	<nycvar.YSQ.7.76.1905231257400.23354@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1905231257400.23354@xnncv>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 May 2019 14:05:00 +0200
Message-ID: <CAJ+F1CLH1qN-jVVaMacMB41PWfZ5Xd9A8ycowaNxwgvQhPEvMQ@mail.gmail.com>
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Ferm=C3=ADn_J=2E_Serna?= <fjserna@gmail.com>,
	"Daniel P . Berrange" <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 23, 2019 at 9:54 AM P J P <ppandit@redhat.com> wrote:
>
> +-- On Wed, 22 May 2019, Marc-Andr=C3=A9 Lureau wrote --+
> | On Sun, May 19, 2019 at 10:55 AM P J P <ppandit@redhat.com> wrote:
> | > Qemu guest agent while executing user commands does not seem to
> | > check length of argument list and/or environment variables passed.
> | > It may lead to integer overflow or infinite loop issues. Add check
> | > to avoid it.
> |
> | Are you intentionally not telling where these overflow or loop happen?
> |
> | Isn't the kernel already giving an error if given too much
> | environment/arguments on exec?
>
> Kernel would report error; But integer overflow would occur while computi=
ng
> 'str_size' in a loop below, if count++ wraps around due to long list of
> arguments (or a loop) in 'strList *entry'. Negative 'count' would allocat=
e
> large memory for 'args'

I don't see how you could exploit this today.

QMP parser has MAX_TOKEN_COUNT (2ULL << 20).

We could have "assert(count < MAX_TOKEN_COUNT)" in the loop, if it helps.


>     args =3D g_malloc(count * sizeof(char *));
>
> We don't have a reproducer. It does seem remote/unlikely, considering
> guest-agent is to be used by trusted parties to manage a guest.
>
> | >      int count =3D 1, i =3D 0;  /* reserve for NULL terminator */
> | > +    size_t str_size =3D 1, arg_max;
> | >
> | > +    arg_max =3D ga_get_arg_max();
> | >      for (it =3D entry; it !=3D NULL; it =3D it->next) {
> | >          count++;
> | >          str_size +=3D 1 + strlen(it->value);
> | > +        if (str_size >=3D arg_max || count >=3D arg_max / 2) {
> | > +            break;
> |
> | This seems to silently drop remaining arguments, which is probably not
> | what you want.
>
> Umnm, report an error and return?
>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F



--=20
Marc-Andr=C3=A9 Lureau

