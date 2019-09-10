Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4237D21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4237D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7gpB-0003fQ-Ck
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i7goG-0002uo-TF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i7goF-000429-DH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i7goF-00041q-6J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:07:55 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C45D8830C
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 14:07:54 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m6so1409863wmf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=fxAs1uhQgsx7471tyDgPIk1p3r7y5AN+xVnLbk7ax+4=;
 b=p0C0h+GSXeTfUuitqi5+qMx6fsfy+QqDYB2SYFcNtXsH3PXZlL0kvahDQOjk+Xu7PE
 LAO0heCg5xDMMIlZ0KPm8YRSUnKropgR73ulotEAVMRTLX5LoHFDiGTmUZD2olafT7i0
 YiKgFQmpCHyC6ZX8V3zVsdIg40t/sdOj1bYLkOT0Z8V7sWJWG8bjGQiTgPe05+g+5Wja
 ffzeLr0+TUsTqiaD9gDW58uMKbfpc7i5h/V7IZCyCQmz5IiGXmz53kKDhqnCiLSL5xcy
 MlNS+0oBCBnc3gv7zR9vgLNt/Lugsb2Nj+BwB46z2IsHkAU95/eBonkDkI2kjRKNU22g
 PLNQ==
X-Gm-Message-State: APjAAAVftIVwOx3EULoHqpHfEldCPYr/8LcaOxBJ26fj0JbwVR1iJzMp
 Q0/UDzFXWPiEr5bxIJ7BgqhOv802LRgzi7VOj9kExHnrU3mVp6HyxeeVCg9q9gwafY+qeSSjKSt
 TrGsd2MBnxES4cAM=
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr3871146wrg.74.1568124472868; 
 Tue, 10 Sep 2019 07:07:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyVCd2cE1eTDtEHnPqazWaBqxOCDLgX6wA3EiTe3fM0oIXzvMrRRi0mor4hLRGWpmVJb1NJsA==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr3871115wrg.74.1568124472594; 
 Tue, 10 Sep 2019 07:07:52 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id o22sm32440894wra.96.2019.09.10.07.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:07:51 -0700 (PDT)
References: <20190910133611.149421-1-slp@redhat.com>
 <aef947c6-b1df-7700-809f-4c9917abb561@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <aef947c6-b1df-7700-809f-4c9917abb561@redhat.com>
Date: Tue, 10 Sep 2019 16:07:47 +0200
Message-ID: <87imq0utvw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] blockjob: update nodes head while
 removing all bdrv
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> On 10.09.19 15:36, Sergio Lopez wrote:
>> block_job_remove_all_bdrv() iterates through job->nodes, calling
>> bdrv_root_unref_child() for each entry. The call to the latter may
>> reach child_job_[can_]set_aio_ctx(), which will also attempt to
>> traverse job->nodes, potentially finding entries that where freed
>> on previous iterations.
>>=20
>> To avoid this situation, update job->nodes head on each iteration to
>> ensure that already freed entries are no longer linked to the list.
>>=20
>> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1746631
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>> Changelog
>>=20
>> v2:
>>  - Avoid leaking job->nodes (thanks Max Reitz)
>> ---
>>  blockjob.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> ---
>> diff --git a/blockjob.c b/blockjob.c
>> index 6e32d1a0c0..ffda6dd1e4 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -187,13 +187,21 @@ static const BdrvChildRole child_job =3D {
>>=20=20
>>  void block_job_remove_all_bdrv(BlockJob *job)
>>  {
>> -    GSList *l;
>> +    GSList *l, *orig_nodes;
>> +
>> +    orig_nodes =3D job->nodes;
>>      for (l =3D job->nodes; l; l =3D l->next) {
>>          BdrvChild *c =3D l->data;
>>          bdrv_op_unblock_all(c->bs, job->blocker);
>>          bdrv_root_unref_child(c);
>> +        /*
>> +         * The call above may reach child_job_[can_]set_aio_ctx(), whic=
h will
>> +         * also traverse job->nodes, so update the head here to make su=
re it
>> +         * doesn't attempt to process an already freed BdrvChild.
>> +         */
>> +        job->nodes =3D l->next;
>>      }
>> -    g_slist_free(job->nodes);
>> +    g_slist_free(orig_nodes);
>>      job->nodes =3D NULL;
>
> Hm, this assignment is now a no-op.
>
> I think I=E2=80=99d just rewrite the whole function in the following fash=
ion:
>
> orig_nodes =3D job->nodes;
> while (job->nodes) {
>     BdrvChild *c =3D job->nodes->data;
>     [...]
>     job->nodes =3D job->nodes->next;
> }
> g_slist_free(orig_nodes);
>
> What do you think?
>

As this is the first time I was touching this code, I was trying to keep
the changes minimal, but I definitely prefer to rewrite the function as
you suggest.

Should I send a v3, or do you want to send a patch yourself? I don't
really mind either, just want to get this fixed ASAP :-)

Thanks Max,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl13rjMACgkQ9GknjS8M
AjVAcw//eClZXISHGOHrrlrj34ovRKHDjCPjhFFVVkiyIOhHuiFpj9mGQ4NI7TGi
5e70v+t/ONY6Vcg/FGPtzbP+u4LGsBVS0UCQt1aUP36yBpVD6ul0YvrZS8uvaQUP
0+Finyi/ZWjmd2KZaFgXAQePWT/g5/hsCVPpibbBPiFsJ3mL8xDDbt9SJLntV+C7
m7AIbt+ZETERX51BgoHKcBUjhA1AJgJIU3Y4C3iPZF/IwIFBOhTfjk9na2ubWqYa
u9H1/6U4Q7ASnCeMuTWbaWg4hoCh5gVlr/GUVKHNevV1rxTKvrxeLX6akdU/ljgZ
rL8xvAIhussC//BwfyeXV3CLJAGyedX3rWFGP237Bb3LmW1ANMl3csqRGbVDD364
LzUHZHB/ep++TUA44rbv1AUsgHb6NGDcwtSbXgqbhVXTCrxfbSBpgGunTrmJdSzH
1S4fFeYqIyGz79K0Ep/vgC7hQgZoAQ+VY4D5Yiyid7r4ThXecQ0Mff9AC8a7aYbC
ZanYh0rJCGUXXqsicfmFiCnCpup2IN8wN6Sd9Y5/dZjpaAC7kFaE0ZZ6H3erFrh1
XWoMeYsVuIL/YWdhkouGSzSbZxgRB26s7w+OSk7VClvi4bVy8RqVCz6dHD5Nc3b6
crk4mv6cW/dPAyFIbz8hrwXfZlbtWF9WUDZa/vbTNPXWllF44w8=
=plXo
-----END PGP SIGNATURE-----
--=-=-=--

