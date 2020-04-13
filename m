Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD1C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6347F20735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1ZQWfjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6347F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3Lb-000769-Iv
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 13:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leoluan@gmail.com>) id 1jO3Kq-0006FF-IB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leoluan@gmail.com>) id 1jO3Ko-0004NX-TX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:57:28 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leoluan@gmail.com>) id 1jO3Ko-0004Mt-NU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 13:57:26 -0400
Received: by mail-io1-xd43.google.com with SMTP id w20so10299197iob.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/GNTpfrSjc4Ht1mXmIdGnXKWKkiZZ0w3HE6Ze5Acgrc=;
 b=j1ZQWfjUfjNHG1siqaHoVeDRIKWqXuWBJdh6bnImVRV3x4BuHFUauZ5vQx65xkfBU5
 e0ZtbSZRIykJ5e/3e4fiBWf9TXPGiXDgMkNvxOy0LLzJ6lNhUyhqQT/zheW7RxxrUCyc
 5fsDApJ1iGIlGb8fh+JA4oVzS+muodL/WW9DND3gE6uu5TXxV0PSkRzZBSE/CQB1G38e
 oRF+rK8aCzEr5hIBYxL+cjgWlumhWdlrK4ZaXoaKclKxE+aBjKI2myKDBC/KCn7Qk0Pd
 D/9jN/edNBxOMtnDPshAIcQsg4tbYqY6lvpDagqWl3A7/7cqoFvXJhVi5JlnJVS9dE54
 qeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/GNTpfrSjc4Ht1mXmIdGnXKWKkiZZ0w3HE6Ze5Acgrc=;
 b=deqWRYlxEYiKtioCoDUKMRcPfyNKHqC8JYUH6DvD3wd7CTgsuwEWF9+nGBQBR9Y34i
 4kF+nDOnYT3gQyhRpDtoShSBO4Hf96tyNS5HIylGfPVxM/n9qA6IH2ky8p/CQxNNIA+r
 cBphlRR6wIEjJGr98JaIVexBiZzkxkc1j/CGTLpv9lTQJ3IubTp1mZDYrHfl8w+Flt1/
 B7WCgLjS/niFpnBEbsW2JM5yz7OICRt9sJnHRlgRe1M0kKA4b02g+pTYFE9/DZ5i15xS
 LGpOtjiL9SnyuO5XLKKVgR8ee+h2m1kX1mJCymmMst5ta14YcPBRM/Jory8zGj9LIkBv
 InHQ==
X-Gm-Message-State: AGi0PuYygtT+GusU+PD/DSJrtACt3ObFf5jK4CaUFaZEhv3YzexZ7Iz5
 7nD48WUYX41Ak9uuqrMAQCxHlJozx0ZxjdvC+cvj7Q7gR0c=
X-Google-Smtp-Source: APiQypLzxQVwoyVV2gpWCz9TvB14/gUhTbT0pMaPpEL9zLZtVgAavFiJ+glAR/mUTB5HOmJ4FXitUK64wMvUXdjfN9M=
X-Received: by 2002:a02:2944:: with SMTP id p65mr16425729jap.89.1586800644931; 
 Mon, 13 Apr 2020 10:57:24 -0700 (PDT)
MIME-Version: 1.0
From: Leo Luan <leoluan@gmail.com>
Date: Mon, 13 Apr 2020 10:57:13 -0700
Message-ID: <CAD_3s9+qPyt+9dyo9xuH=iXHHyny9dWQ2XhNUkfgKJcX+bz+DA@mail.gmail.com>
Subject: Re: Domain backup file explodes on s3fs
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c545ac05a32fd027"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c545ac05a32fd027
Content-Type: text/plain; charset="UTF-8"

Hi Eric and all,


When invoking "virsh backup-begin" to do a full backup using qcow2
driver to a new backup

target file that does not have a backing chain, is it safe to not zero
the unallocated

parts of the virtual disk?  Do we still depend on SEEK_DATA support in
this case to avoid

forcing zeros?


It looks like backup_run() in block/backup.c unsets the unallocated
parts of a copy bitmap

before starting the backup loop if s->sync_mode ==
MIRROR_SYNC_MODE_TOP. In a virsh backup-begin

full backup scenario, we observe that the mode is
MIRROR_SYNC_MODE_FULL, and the backup_loop()

function subsequently copies zeros for the entire virtual size,
including the unallocated parts

in the source qcow2 file.  Would it be safe to also unset the
unallocated parts in the copy

map when the sync_mode is MIRROR_SYNC_MODE_FULL if we know there is no
need to force zeros

because the target file is a new empty qcow2 file without a backing
file?  If so, maybe a

knob can be added to effect this behavior?


I guess the related code is changing in 5.0 and this issue may already
be adddressed.

Any updates/insights would be appreciated!


Thanks,

Leo


*From*: Eric Blake
*Subject*: Re: Domain backup file explodes on s3fs
*Date*: Tue, 7 Apr 2020 14:37:26 -0500
*User-agent*: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
Thunderbird/68.6.0
------------------------------

[adding libvirt list]

On 4/7/20 2:13 PM, Tim Haley wrote:

Hi all,


Have been playing with `virsh backup-begin` of late and think it's an excellent
feature. I've noticed one behavior I'm not sure I understand.

It looks like https://bugzilla.redhat.com/show_bug.cgi?id=1814664 is a similar
description of the same problem: namely, if qemu is not able to determine
that the destination already reads as zero, then it forcefully zeroes the
destination of a backup job. We may want to copy the fact that qemu 5.0 is
adding 'qemu-img convert --target-is-zero' to add a similar knob to the QMP
commands that trigger disk copying (blockdev-backup, blockdev-mirror,
possibly others) as well as logic to avoid writing zeroes when the
destination is already treated as zero (whether by a probe, or by the knob
being set).

...


If my /backups directory is just XFS, I get a backup file that looks like
it is just the size of data blocks in use

-rw------- 1 root  root  2769551360 Mar 19 16:56
vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

For a local file, qemu is easily able to probe whether the destination starts
as all zeroes (thanks to lseek(SEEK_DATA));

but if I write to an s3fs (object storage backend) the file blows up to the
whole size of the disk

-rw------- 1 root  root  8591507456 Mar 18 19:03
vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

whereas for s3fs, it looks like qemu does not have access to a quick test
to learn if the image starts all zero (POSIX does not provide a quick way
for doing this on a generic block device, but if you are aware of an ioctl
or otherwise that qemu could use, that might be helpful). Or maybe the s3fs
really is random contents rather than all zero, in which case forcefully
writing zeroes is the only correct behavior.

--
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

--000000000000c545ac05a32fd027
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"color:rgb(0,0,0);margin:0em">Hi Eric and all=
,</pre><pre style=3D"color:rgb(0,0,0);margin:0em"><br></pre><pre style=3D"c=
olor:rgb(0,0,0);margin:0em">When invoking &quot;virsh backup-begin&quot; to=
 do a full backup using qcow2 driver to a new backup </pre><pre style=3D"co=
lor:rgb(0,0,0);margin:0em">target file that does not have a backing chain, =
is it safe to not zero the unallocated </pre><pre style=3D"color:rgb(0,0,0)=
;margin:0em">parts of the virtual disk?  Do we still depend on SEEK_DATA su=
pport in this case to avoid</pre><pre style=3D"color:rgb(0,0,0);margin:0em"=
>forcing zeros? </pre><pre style=3D"color:rgb(0,0,0);margin:0em"><br></pre>=
<pre style=3D"color:rgb(0,0,0);margin:0em">It looks like backup_run() in bl=
ock/backup.c unsets the unallocated parts of a copy bitmap </pre><pre style=
=3D"color:rgb(0,0,0);margin:0em">before starting the backup loop if s-&gt;s=
ync_mode =3D=3D MIRROR_SYNC_MODE_TOP. In a virsh backup-begin </pre><pre st=
yle=3D"color:rgb(0,0,0);margin:0em">full backup scenario, we observe that t=
he mode is MIRROR_SYNC_MODE_FULL, and the backup_loop() </pre><pre style=3D=
"color:rgb(0,0,0);margin:0em">function subsequently copies zeros for the en=
tire virtual size, including the unallocated parts </pre><pre style=3D"colo=
r:rgb(0,0,0);margin:0em">in the source qcow2 file.  Would it be safe to als=
o unset the unallocated parts in the copy </pre><pre style=3D"color:rgb(0,0=
,0);margin:0em">map when the sync_mode is MIRROR_SYNC_MODE_FULL if we know =
there is no need to force zeros </pre><pre style=3D"color:rgb(0,0,0);margin=
:0em">because the target file is a<span style=3D"font-family:Arial,Helvetic=
a,sans-serif"> </span>new empty qcow2 file without a backing file?  If so, =
maybe a </pre><pre style=3D"color:rgb(0,0,0);margin:0em">knob can be added =
to effect this behavior?</pre><pre style=3D"color:rgb(0,0,0);margin:0em"><b=
r></pre><pre style=3D"color:rgb(0,0,0);margin:0em">I guess the related code=
 is changing in 5.0 and this issue may already be adddressed. </pre><pre st=
yle=3D"color:rgb(0,0,0);margin:0em">Any updates/insights would be appreciat=
ed!</pre><pre style=3D"color:rgb(0,0,0);margin:0em"><br></pre><pre style=3D=
"color:rgb(0,0,0);margin:0em">Thanks,</pre><pre style=3D"color:rgb(0,0,0);m=
argin:0em">Leo</pre><pre style=3D"color:rgb(0,0,0);margin:0em"><br></pre><p=
re style=3D"color:rgb(0,0,0);margin:0em"><table border=3D"0" style=3D"font-=
family:Times;font-size:medium"><tbody><tr><td align=3D"right" valign=3D"top=
"><b>From</b>:</td><td align=3D"left">Eric Blake</td></tr><tr><td align=3D"=
right" valign=3D"top"><b>Subject</b>:</td><td align=3D"left">Re: Domain bac=
kup file explodes on s3fs</td></tr><tr><td align=3D"right" valign=3D"top"><=
b>Date</b>:</td><td align=3D"left">Tue, 7 Apr 2020 14:37:26 -0500</td></tr>=
<tr><td align=3D"right" valign=3D"top"><b>User-agent</b>:</td><td align=3D"=
left">Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Thunderbird/6=
8.6.0</td></tr></tbody></table><hr style=3D"font-family:Times;font-size:med=
ium"><pre style=3D"margin:0em"></pre></pre><pre style=3D"color:rgb(0,0,0);m=
argin:0em">[adding libvirt list]

On 4/7/20 2:13 PM, Tim Haley wrote:
</pre><blockquote style=3D"color:rgb(0,0,0);font-family:Times;font-size:med=
ium;border-left:0.2em solid rgb(85,85,238);margin:0em;padding-left:0.85em">=
<pre style=3D"margin:0em">Hi all,

</pre><tt>Have been playing with `virsh backup-begin` of late and think it&=
#39;s an=C2=A0</tt><tt>excellent feature. I&#39;ve noticed one behavior I&#=
39;m not sure I understand.</tt></blockquote><pre style=3D"color:rgb(0,0,0)=
;margin:0em"></pre><tt style=3D"color:rgb(0,0,0)">It looks like=C2=A0<a rel=
=3D"nofollow" href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1814664=
" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D1814664</=
a>=C2=A0is a=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">similar description o=
f the same problem: namely, if qemu is not able to=C2=A0</tt><tt style=3D"c=
olor:rgb(0,0,0)">determine that the destination already reads as zero, then=
 it forcefully=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">zeroes the destinat=
ion of a backup job. We may want to copy the fact=C2=A0</tt><tt style=3D"co=
lor:rgb(0,0,0)">that qemu 5.0 is adding &#39;qemu-img convert --target-is-z=
ero&#39; to add a=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">similar knob to =
the QMP commands that trigger disk copying=C2=A0</tt><tt style=3D"color:rgb=
(0,0,0)">(blockdev-backup, blockdev-mirror, possibly others) as well as log=
ic to=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">avoid writing zeroes when th=
e destination is already treated as zero=C2=A0</tt><tt style=3D"color:rgb(0=
,0,0)">(whether by a probe, or by the knob being set).</tt><pre style=3D"co=
lor:rgb(0,0,0);margin:0em">...

</pre><blockquote style=3D"color:rgb(0,0,0);font-family:Times;font-size:med=
ium;border-left:0.2em solid rgb(85,85,238);margin:0em;padding-left:0.85em">=
<tt>If my /backups directory is just XFS, I get a backup file that looks=C2=
=A0</tt><tt>like it is just the size of data blocks in use</tt><pre style=
=3D"margin:0em"></pre><tt>-rw------- 1 root=C2=A0 root=C2=A0 2769551360 Mar=
 19 16:56=C2=A0</tt><tt>vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a</tt></bloc=
kquote><pre style=3D"color:rgb(0,0,0);margin:0em"></pre><tt style=3D"color:=
rgb(0,0,0)">For a local file, qemu is easily able to probe whether the dest=
ination=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">starts as all zeroes (than=
ks to lseek(SEEK_DATA));</tt><pre style=3D"color:rgb(0,0,0);margin:0em"></p=
re><blockquote style=3D"color:rgb(0,0,0);font-family:Times;font-size:medium=
;border-left:0.2em solid rgb(85,85,238);margin:0em;padding-left:0.85em"><pr=
e style=3D"margin:0em"></pre><tt>but if I write to an s3fs (object storage =
backend) the file blows up to=C2=A0</tt><tt>the whole size of the disk</tt>=
<pre style=3D"margin:0em"></pre><tt>-rw------- 1 root=C2=A0 root=C2=A0 8591=
507456 Mar 18 19:03=C2=A0</tt><tt>vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a<=
/tt></blockquote><pre style=3D"color:rgb(0,0,0);margin:0em"></pre><tt style=
=3D"color:rgb(0,0,0)">whereas for s3fs, it looks like qemu does not have ac=
cess to a quick=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">test to learn if t=
he image starts all zero (POSIX does not provide a=C2=A0</tt><tt style=3D"c=
olor:rgb(0,0,0)">quick way for doing this on a generic block device, but if=
 you are aware=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">of an ioctl or othe=
rwise that qemu could use, that might be helpful).=C2=A0</tt><tt style=3D"c=
olor:rgb(0,0,0)">Or maybe the s3fs really is random contents rather than al=
l zero, in=C2=A0</tt><tt style=3D"color:rgb(0,0,0)">which case forcefully w=
riting zeroes is the only correct behavior.</tt><pre style=3D"color:rgb(0,0=
,0);margin:0em">--
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  <a href=3D"http://qemu.org" target=3D"_blank">qemu.org</a>=
 | <a href=3D"http://libvirt.org" target=3D"_blank">libvirt.org</a></pre></=
div>

--000000000000c545ac05a32fd027--

