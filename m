Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9F3222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2kCkSwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9F3222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2iE-0000ai-K4
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iX2fK-0007aS-AJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iX2fC-0007nc-JV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:31:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iX2fA-0007lv-AQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574166678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eY4x9znae/yNZEegR9GZ1KuMrUhPuKzsnlHdj3AH+Xg=;
 b=Z2kCkSwtkyLNG59vffzdYhDfJ3tt35K+48eW0aohQT+P8ADJexFVzegdH+zzvQQWJi5Krd
 GBKvhP1zJrIkQ2OxtOCcedoPf+XHMcCNZwuikjO0yIn3WEJHr2S2AzSDkKe6upGdZScKYk
 zHrHo7aa+tHVbhWY/7SyQcsSC1Ebo1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-LTrpXidYPpC6_vjSB9Uo_w-1; Tue, 19 Nov 2019 07:31:14 -0500
X-MC-Unique: LTrpXidYPpC6_vjSB9Uo_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17E71005502;
 Tue, 19 Nov 2019 12:31:13 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC5D5E276;
 Tue, 19 Nov 2019 12:31:11 +0000 (UTC)
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com> <87h837ucxa.fsf@redhat.com>
 <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com> <87d0docf0s.fsf@redhat.com>
 <20191119111840.GA5910@linux.fritz.box> <87blt8cd4r.fsf@redhat.com>
 <20191119121357.GC5910@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
In-reply-to: <20191119121357.GC5910@linux.fritz.box>
Date: Tue, 19 Nov 2019 13:31:09 +0100
Message-ID: <878soccak2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.11.2019 um 12:35 hat Sergio Lopez geschrieben:
>>=20
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 19.11.2019 um 11:54 hat Sergio Lopez geschrieben:
>> >>=20
>> >> Max Reitz <mreitz@redhat.com> writes:
>> >>=20
>> >> > On 13.11.19 14:24, Sergio Lopez wrote:
>> >> >>=20
>> >> >> Sergio Lopez <slp@redhat.com> writes:
>> >> >>=20
>> >> >>> no-reply@patchew.org writes:
>> >> >>>
>> >> >>>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp=
@redhat.com/
>> >> >>>>
>> >> >>>>
>> >> >>>>
>> >> >>>> Hi,
>> >> >>>>
>> >> >>>> This series failed the docker-quick@centos7 build test. Please f=
ind the testing commands and
>> >> >>>> their output below. If you have Docker installed, you can probab=
ly reproduce it
>> >> >>>> locally.
>> >> >>>>
>> >> >>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> >> >>>> #!/bin/bash
>> >> >>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> >> >>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=
=3D1
>> >> >>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>> >> >>>>
>> >> >>>>   TEST    iotest-qcow2: 268
>> >> >>>> Failures: 141
>> >> >>>
>> >> >>> Hm... 141 didn't fail in my test machine. I'm going to have a loo=
k.
>> >> >>=20
>> >> >> So here's the output:
>> >> >>=20
>> >> >> --- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.65=
1557587 -0500
>> >> >> +++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 0=
8:12:06.575967337 -0500
>> >> >> @@ -10,6 +10,8 @@
>> >> >>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backi=
ng_file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}=
, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}=
}
>> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}=
, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}=
}
>> >> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}=
, "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
>> >> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}=
, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}=
}
>> >> >>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy:=
 node is used as backing hd of 'NODE_NAME'"}}
>> >> >>  {"return": {}}
>> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}=
, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"=
}}
>> >> >>=20
>> >> >> Those extra lines, the "paused" and "running", are a result of the=
 job
>> >> >> being done in a transaction, within a drained section.
>> >> >>=20
>> >> >> We can update 141.out, but now I'm wondering, was it safe creating=
 the
>> >> >> job at do_drive_backup() outside of a drained section, as
>> >> >> qmp_drive_backup was doing?
>> >> >
>> >> > I think it is.  Someone needs to drain the source node before attac=
hing
>> >> > the job filter (which intercepts writes), and bdrv_backup_top_appen=
d()
>> >> > does precisely this.
>> >> >
>> >> > If the source node is in an I/O thread, you could argue that the dr=
ain
>> >> > starts later than when the user has invoked the backup command, and=
 so
>> >> > some writes might slip through.  That=E2=80=99s correct.  But at th=
e same time,
>> >> > it=E2=80=99s impossible to drain it the instant the command is rece=
ived.  So
>> >> > some writes might always slip through (and the drain will not stop =
them
>> >> > either, it will just let them happen).
>> >> >
>> >> > Therefore, I think it=E2=80=99s fine the way it is.
>> >> >
>> >> >> Do you think there may be any potential drawbacks as a result of a=
lways
>> >> >> doing it now inside a drained section?
>> >> >
>> >> > Well, one drawback is clearly visible.  The job goes to paused for =
no
>> >> > reason.
>> >>=20
>> >> This is something that already happens when requesting the drive-back=
up
>> >> through a transaction:
>> >>=20
>> >> {"execute":"transaction","arguments":{"actions":[{"type":"drive-backu=
p","data":{"device":"drv0","target":"o.qcow2","sync":"full","format":"qcow2=
"}}]}}
>> >>=20
>> >> I don't think it makes sense to have two different behaviors for the
>> >> same action. So we either accept the additional pause+resume iteratio=
n
>> >> for qmp_drive_backup, or we remove the drained section from the
>> >> transaction based one.
>> >>=20
>> >> What do you think?
>> >
>> > Draining all involved nodes is necessary for transactions, because you
>> > want a consistent backup across all involved disks. That is, you want =
it
>> > to be a snapshot at the same point in time for all of them - no reques=
ts
>> > may happen between starting backup on the first and the second disk.
>> >
>> > For a single device operation, this requirement doesn't exist, because
>> > there is nothing else that must happen at the same point in time.
>>=20
>> This poses a problem with the unification strategy you suggested for qmp
>> commands and transactions. I guess that, if we really want to preserve
>> the original behavior, we can extend DriveBackup to add a flag to
>> indicate whether the transaction should create a drained section or not.
>>=20
>> Does this sound reasonable to you?
>
> I think we can accept an unnecessary drain for the single-device case.
> It's only minimally worse than not draining early (because, as Max said,
> we'll drain the node anyway later).
>
> I'm not sure what the code looks like, but does the job go to paused
> even when it's already created inside the drained section? (As opposed
> to first creating the job and then draining.) I assume that this is what
> you're already doing, just double-checking.

Yes, that's the case. drive_backup_prepare() calls to
bdrv_drained_begin() first, and then to do_backup_common(), which creates
the job.

> If this is how things work, I'd just adjust the test output and explain
> the change in the commit message.

OK, I'll prepare a v4 with a rework of the patchset and an update to the
job.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3T4I0ACgkQ9GknjS8M
AjV/QRAAqzPP2BQLesHr/671Nniyh8gFrydEvoH24mXFOSAKFDr/ELQFtjZaLTud
+GBRLPs2yZq3OY0KsxqfFFYqz9PzxMSTXxRXdxuFmZX6xBtf+I7+0rvMKVpr+SF3
gsQQVwy2FcdUaD1Moai5M+KVpI5WPKo9pgeaZ6KulKxVPce7TCX38R5qpkmGFshG
1Olu0EFUA2WdmCOFfZ9uGphh7nun65zfv83Y/bAj88f7mHE5gp4J/Q0iRP5DjQe3
TYM12rC5QJ0N+rKXyZ+az0we+OuHweR3s+zEiBcbj+fIrVT40rOaWgo0Sja32N1T
FFC/eLLB1JYLbrTD3w06jokI9e5mpdCkxzOdlGsj6DXM6PTMkiWGnE5nAqoW7ZXO
l4CJpgfDqcZLgim9XWhOuI3YhWOSdPXA2ABDxBiYxc4UJhdqyS+NyYfGzDjCPKgU
0feKgqwdJcNUq4YqR4RuEy5YI3S7UZ6KAfdDIrzMesX+AwnV231HvE4+w70HG+R9
cyvJQnkNSAC97hHT7BunYZE1S53bJAzFcm1PhVmgo3V1bjLAGOgskn0DWfMjAs8i
CRNxeneM049F53d1DWKfgqEKM6HtUxvRGEQ4FsVIzst+AuoItns7DHj1wDOKo7A8
ran42DsbIKnIr2HFQnCm4rV03ovLNfOHc9+Yo23BRhjQZ3CNkPY=
=yF/W
-----END PGP SIGNATURE-----
--=-=-=--


