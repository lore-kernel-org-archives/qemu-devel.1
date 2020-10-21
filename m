Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6606C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3B922249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RpSz+HfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B922249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBe1-0002Eh-8o
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVBdA-0001ni-BP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:46:09 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kVBd3-00008C-UT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ytQeaLsLElqzCFd7vg81UeRSZnDGjiW4a4e2zd40Z4o=; b=RpSz+HfKTkkTwUjgfXDJyLJa7I
 a3aG6CXrHYiUD2kNqllnS1QKycsVPsyNwXzILGTvYMjvG8iAhLww9QZTEnFVGujaPCuvBZkoVyG4a
 JZiqg4WxXL2O+CfCdZaUXlkpv23loP2gGv8gKCkpbqarFe7r2ySf5PEET0e2kBBPLB3wqKvgWU1RH
 dUWUxyqKe/MXbL3Pl4fwvPQAIOwM1/VPpqQxrpKpIbVOqJU2KEq0TIhb/3CEjuCgoJMfSY/lGVg3P
 a7Isoj2zcpw7jhFAgnMTrtljO4FdqKs8rgBrEvEED0Y8vPv2A4koFES4gjm3RDZlrGaIFqBXoWENh
 7NKB9JsA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
Date: Wed, 21 Oct 2020 12:45:53 +0200
Message-ID: <39105758.aq4bFRisbS@silver>
In-Reply-To: <a32254c2-7428-0889-d76b-6bc35e2a619a@redhat.com>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <2028136.PJCruPdmoF@silver> <a32254c2-7428-0889-d76b-6bc35e2a619a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 06:45:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 21. Oktober 2020 08:15:55 CEST Philippe Mathieu-Daud=E9 wrote:
> Hi Cristian,
>=20
> On 10/20/20 1:54 PM, Christian Schoenebeck wrote:
> > On Dienstag, 20. Oktober 2020 12:00:57 CEST Greg Kurz wrote:
> >> On Tue, 20 Oct 2020 11:43:18 +0200
> >>=20
> >> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> >>> On Dienstag, 20. Oktober 2020 09:36:10 CEST Philippe Mathieu-Daud=E9=
=20
wrote:
> >>>> On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
> >>>>> All existing 9pfs test cases are using the 'synth' fs driver so far,
> >>>>> which
> >>>>> means they are not accessing real files, but a purely simulated (in
> >>>>> RAM
> >>>>> only) file system.
> >>>>>=20
> >>>>> Let's make this clear by changing the prefix of the individual qtest
> >>>>> case
> >>>>> names from 'fs/' to 'synth/'. That way they'll be easily
> >>>>> distinguishable
> >>>>> from upcoming new 9pfs test cases supposed to be using a different =
fs
> >>>>> driver.
> >>>>>=20
> >>>>> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >>>>> Message-Id:
> >>>>> <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@c=
rud
> >>>>> eby
> >>>>> te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.co=
m>
> >>>>=20
> >>>> Harmless, but don't need to sign twice ;)
> >>>=20
> >>> Ah, I thought that's the common way, as Greg's PRs contained 2 SOBs as
> >>> well, i.e. I thought this was intended to outline the patch author and
> >>> submaintainer were the same person.
> >>>=20
> >>> BTW I actually did not explicitly add the 2nd SOB. It was rather added
> >>> by
> >>> the patchwork client automatically. So maybe it should be fixed in the
> >>> client to detect an already existing SOB line? Or am missing something
> >>> here?
> >>=20
> >> Yeah this is the reason why my sob appears twice on patches authored by
> >> me, and since this is harmless I never really investigated how to fix
> >> pwclient :)
> >=20
> > Well, I would usually offer my 'I can look at it' at this point, but I =
am
> > reluctant this time as I assume it will end up as my recently suggested
> > libqos patches where I did not get any response from the officially
> > assigned maintainers; not even a simple 'nack'.
>=20
> I was just watching your contributions and suggested an improvement
> because something in your new workflow seems mis-configured (other
> maintainers don't have this problem). I didn't asked you to fix a
> bug in a different tool. I apologize if I was unclear and you
> understood it this way.

You actually did not raise that expectation to me Philippe, so definitely n=
o=20
need to apologize. But I appreciate it!

Correct me if I'm wrong, but AFAICS I'm actually not the only one being=20
affected by this double-SOB issue. A short glimpse at the logs and I see fo=
r=20
instance 3e7e134d827790c3714cae1d5b8aff8612000116 having it as well.

So I guess everyone having the following two options enabled in pwclientrc:

msgid=3Don
signoff=3Don

will have that issue.

> Regarding your issue with a different series, I suppose you already
> read:
> https://wiki.qemu.org/Contribute/SubmitAPatch#If_your_patch_seems_to_have=
_be
> en_ignored and
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
>=20
> You'll see that maintenance can be very time consuming, and we are
> overcrowded from time to time when there is rush. I doubt maintainers
> are ignoring your patches, as most of them try to do their best.
> You might help them by reviewing patches for them, so they have time
> to process your series.

Yes, I am aware of these. And once I got used to a new code base tree I als=
o=20
look at other ones' patches there.

I've recently been thinking whether it would be possible for QEMU=20
submaintainers to make use of patchwork's status feature:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg737917.html

Maybe that could help preventing patches of high traffic components ending =
up=20
unseen.

Best regards,
Christian Schoenebeck



