Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4792AC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE832067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 11:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE832067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9p1q-00028x-8Z
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 07:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i9p0q-0001av-Om
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i9p0o-00036l-Ow
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i9p0o-00035p-I1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 07:17:42 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D292A87648
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 11:17:39 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m9so7632037wrs.13
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 04:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=M65l+re00niTWvcjIWYvWdhCUvbnHF5D4Ptm3N0ROkQ=;
 b=Jso3rCi1tRvTQoLLQqzQ8KRHHrHOixc+CN0KumhD6/d9TOyiW9BYLhrob2XSm4CrLL
 HK1wu10eB+IR0+wn/gFbve6p1MAz58Trw/J4I+vALQPxwp3tLLgbjViI4y9uB57SjDdI
 G5RItFMIZSKGkC1viK8FSbkqKiEeFLMQu3tXT7Ab9xDD4RHIAW+1Xxp64OPFR7Jk1OYQ
 gB3zDBqU+jWgLi+H0WdAfbaR9ffXPkfL9Kr0pyl6z+4QoLdOo5k/PjAZYnZp34ACgqDR
 mv3ULMCqgS6KjLmuYcNPt7UIOvK9XPcgfXUjQihNBjDaFLHD7pYMLE/u2sbFltzkpmgj
 a2Kw==
X-Gm-Message-State: APjAAAWPiVtpcidFmCXbqUqcFbkUGJKv4UEJpouwyA3Y4+dLM7IJ8yDL
 IMIziJ7Et7RNi7226dr6LLwo22/RVGDXcBHRDiGys/03bvXp3sIrcAFyDpkZR4vS+4kPli/8CPX
 tPmtizUXhULNF+Ss=
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr15882143wrr.64.1568632658657; 
 Mon, 16 Sep 2019 04:17:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+PpxtBK9k4GiXLAs5wBJp+zSXRNS2CTB+GIB4nEobeaUENphaZhb1XMyh5ZUqR0BSD0RrMg==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr15882122wrr.64.1568632658367; 
 Mon, 16 Sep 2019 04:17:38 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id 207sm24757582wme.17.2019.09.16.04.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 04:17:37 -0700 (PDT)
References: <20190913152507.56197-1-slp@redhat.com>
 <20190913152507.56197-2-slp@redhat.com>
 <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
 <20190916075303.GA10930@localhost.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190916075303.GA10930@localhost.localdomain>
Date: Mon, 16 Sep 2019 13:17:35 +0200
Message-ID: <87d0g0h4mo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/2] blockdev: release the
 AioContext at drive_backup_prepare
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
Cc: mreitz@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 13.09.2019 um 21:54 hat John Snow geschrieben:
>>=20
>>=20
>> On 9/13/19 11:25 AM, Sergio Lopez wrote:
>> > do_drive_backup() already acquires the AioContext, so release it
>> > before the call.
>> >=20
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > ---
>> >  blockdev.c | 6 +-----
>> >  1 file changed, 1 insertion(+), 5 deletions(-)
>> >=20
>> > diff --git a/blockdev.c b/blockdev.c
>> > index fbef6845c8..3927fdab80 100644
>> > --- a/blockdev.c
>> > +++ b/blockdev.c
>> > @@ -1783,20 +1783,16 @@ static void drive_backup_prepare(BlkActionStat=
e *common, Error **errp)
>> >=20=20
>> >      aio_context =3D bdrv_get_aio_context(bs);
>> >      aio_context_acquire(aio_context);
>> > -
>
> Are you removing this unrelated empty line intentionally?

Yes. In the sense of that whole set of lines being a "open drained
section" block.

>> >      /* Paired with .clean() */
>> >      bdrv_drained_begin(bs);
>>=20
>> Do we need to make this change to blockdev_backup_prepare as well?
>
> Actually, the whole structure feels a bit wrong. We get the bs here and
> take its lock, then release the lock again and forget the reference,
> only to do both things again inside do_drive_backup().
>
> The way snapshots work is that the "normal" snapshot commands are
> wrappers that turn it into a single-entry transaction. Then you have
> only one code path where you can resolve the ID and take the lock just
> once. So maybe backup should work like this, too?

I'm neither opposed nor in favor, but I think this is outside the scope
of this patch series.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1/b08ACgkQ9GknjS8M
AjUqlQ//bldygiGkMsCIgpDrH6rN2zrPFuppr7tENAKgMj96u735uJPdiBAfre5X
iVp8oZmhMG/HuOqZgkY5myWnQ09oxRRTytwdXbIpC2sYSfJJwQkZMdHG9pKHpj/U
cZ6hbUJMkRbDGxuWMm6H9gKYYK6FZ43xxUT2xF61BCdXzqUX3ratunLZqCcNBlzf
pN+fVdzTpA0Pki3ASj/kSrkAs6KNJJzC1WoQ3Utd4Kn0EuXPyOTOeZvyWsl6tvTV
VKMAXZjaFJn1k+uZkgMDR9BytNRxgow33qP34bUodQkWfFDgbMwVmQaHC/n7h9+i
qEVSCOHxeDyprd41P0C1gkXBfUKvC4BDVW+qWPQC191TbwbJyejczcTrv7E+fgzs
qEzrMzb8qJJpPL0x2+Zk9/KZLDYlbFBHzrecrW9hcGevxRJKdfJMLrG76++Re+7c
IUldubHUG/ndDQ7XtI8lr14LET0p5fvPjJ8c5KqhzU7RuJV3a585IYO+DLT+88tp
R0HpFXQMkKLq7n4D0l7wXkPHxDFJa54jFfWQMJd446d5asz+eiUUpFikGLBcL67j
btQpa740Af38k5HQg2hxDcDkO7VtZqRphSFzhxgyhx59vOEINEsoTWv9/RbN0UpN
GGyWxm/uLzlhFb5KK10tGs+PBgzEPK63DHexEh2DwjbLTN5nSYY=
=Hy3q
-----END PGP SIGNATURE-----
--=-=-=--

