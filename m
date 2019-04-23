Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FCBC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D48214AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D48214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwPz-0001Lg-EA
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:29:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hIwNq-0008Nh-GF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hIwNp-0007oa-19
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1hIwNo-0007ly-Nt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:26:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CB40DBD6F
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:26:50 +0000 (UTC)
Received: from caroline (unknown [10.43.2.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5DD61B7D;
	Tue, 23 Apr 2019 14:26:49 +0000 (UTC)
Received: by caroline (Postfix, from userid 1000)
	id 691AB1206F3; Tue, 23 Apr 2019 16:26:48 +0200 (CEST)
Date: Tue, 23 Apr 2019 16:26:48 +0200
From: Martin Kletzander <mkletzan@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190423142648.GA2967@wheatley>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190423121218.GF9041@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 23 Apr 2019 14:26:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
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
Cc: qemu-devel@nongnu.org, Richard Jones <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423142648.kGh9SW4fewASPlo8_oxYYksCHmoGnzuDq1cFlHz3RLU@z>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>> Hi,
>>
>> I am using qemu-img with nbdkit to transfer a disk image and the update =
it with
>> extra data from newer snapshots.  The end image cannot be transferred be=
cause
>> the snapshots will be created later than the first transfer and we want =
to save
>> some time up front.  You might think of it as a continuous synchronisati=
on.  It
>> looks something like this:
>>
>> I first transfer the whole image:
>>
>>  qemu-img convert -p $nbd disk.raw
>>
>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=3Dnbdk=
it.sock`
>>
>> Then, after the next snapshot is created, I can update it thanks to the =
`-n`
>> parameter (the $nbd now points to the newer snapshot with unchanged data=
 looking
>> like holes in the file):
>>
>>  qemu-img convert -p -n $nbd disk.raw
>>
>> This is fast and efficient as it uses block status nbd extension, so it =
only
>> transfers new data.
>
>This is an implementation detail. Don't rely on it. What you're doing is
>abusing 'qemu-img convert', so problems like what you describe are to be
>expected.
>
>> This can be done over and over again to keep the local
>> `disk.raw` image up to date with the latest remote snapshot.
>>
>> However, when the guest OS zeroes some of the data and it gets written i=
nto the
>> snapshot, qemu-img scans for those zeros and does not write them to the
>> destination image.  Checking the output of `qemu-img map --output=3Djson=
 $nbd`
>> shows that the zeroed data is properly marked as `data: true`.
>>
>> Using `-S 0` would write zeros even where the holes are, effectively ove=
rwriting
>> the data from the last snapshot even though they should not be changed.
>>
>> Having gone through some workarounds I would like there to be another wa=
y.  I
>> know this is far from the typical usage of qemu-img, but is this really =
the
>> expected behaviour or is this just something nobody really needed before=
?  If it
>> is the former, would it be possible to have a parameter that would contr=
ol this
>> behaviour?  If the latter is the case, can that behaviour be changed so =
that it
>> properly replicates the data when `-n` parameter is used?
>>
>> Basically the only thing we need is to either:
>>
>> 1) write zeros where they actually are or
>>
>> 2) turn off explicit sparsification without requesting dense image (basi=
cally
>>    sparsify only the par that is reported as hole on the source) or
>>
>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report =
data,
>>    but qemu-img found they are all zeros (or source reported HOLE+ZERO w=
hich, I
>>    believe, is effectively the same)
>>
>> If you want to try this out, I found the easiest reproducible way is usi=
ng
>> nbdkit's data plugin, which can simulate whatever source image you like.
>
>I think what you _really_ want is a commit block job. The problem is
>just that you don't have a proper backing file chain, but just a bunch
>of NBD connections.
>
>Can't you get an NBD connection that already provides the condensed form
>of the whole snapshot chain directly at the source? If the NBD server
>was QEMU, this would actually be easier than providing each snapshot
>individually.
>
>If this isn't possible, I think you need to replicate the backing chain
>on the destination instead of converting into the same image again and
>again so that qemu-img knows that it must take existing data of the
>backing file into consideration:
>
>    qemu-img convert -O qcow2 nbd://... base.qcow2
>    qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.qc=
ow2
>    qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overlay=
2.qcow2
>    ...
>

I thought of this, but (to be honest) I did not know that `-B` would work f=
or
nbd.  Does it assume that data are to be taken from the base image if and o=
nly
if the source (be it nbd server or just a plain file) says there is a hole?=
  If
yes, then it could nicely solve the issue.

>And at the end you can merge the snapshot chain (using a commit or
>stream b=C4=BAock job, or qemu-img commit/rebase).
>
>Kevin



--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAly/IKgACgkQCB/CnyQX
ht3N8xAAmhNuj1bdKsTBmfOWgfBgqtHIsVe4pNTDDdEn2SqRu9Yemy247kjSD0yv
IWXDu+IkTieYOaIve228QwWoEtErPFklObERYQrBfNiTx1Rpnt2URmYKZS3fFidI
pnSgxZ3g0DTibcFGWTeWQoHm0HOT0rXRYWMm3sJRM8CtpExB5GR6w3jSuta6wGah
MhQEfJ0M+rt6G6OrF21gJVWj5eYiuK0wyZyBL0hHNCGqa7cFPySvIB7JGuXc9sVS
/G62poiKq/ykPERVZIt+UrExTSJ2S/w01fg8U46Hp8JfL7HvRcjJKqCy3m2unxs0
CGroGxdW9IUKhTTU6NZ6uq3cpJ3wdFKnvpr2r/9F4g7ikl65OcSlxSkmZCcXfil2
30VOgfLm+WrAy5Aw/catlQiUjda56d5MmA8FzOE8tqV0uofPdpxbmmCCbKT5LZ8+
UKblTQfK0ZcdRrZxMVfVgt3fqOXsmajfsK5s37AH0vkp0dvn6DlMcIT+f0xTQDDs
wZiia8bRGeBT72CHLTa1ko7kHFIdcFf7qt8zhOWnQA3QTC/HKV2oZLzmR5BR7kb2
AisjHA4IFP7S2rTVVqDiQ82NPqTdAIYCqdkJDAWTK5b6JxXd3ID8QgzC5wvU/d0S
wzfmZ7hADRJ7GSlWFqgwQDDYC2u71o3wiyI7Oz0SvmZxvyCop/U=
=FwVf
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

