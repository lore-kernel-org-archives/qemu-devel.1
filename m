Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25602C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9429205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9429205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnid3-0000r5-US
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnick-0000Rv-Va
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnicc-0001Xw-MQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnicX-0001Ty-Ei; Wed, 17 Jul 2019 08:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD753307D844;
 Wed, 17 Jul 2019 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-47.ams2.redhat.com
 [10.36.117.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 777B25D9D5;
 Wed, 17 Jul 2019 12:01:13 +0000 (UTC)
Date: Wed, 17 Jul 2019 14:01:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190717120112.GC6471@localhost.localdomain>
References: <20190703172813.6868-1-mreitz@redhat.com>
 <20190703172813.6868-7-mreitz@redhat.com>
 <20190716170156.GJ7297@linux.fritz.box>
 <22745e99-6b6e-53d5-91b7-e1156782e55e@redhat.com>
 <20190717081702.GA6471@localhost.localdomain>
 <6b55a6ee-c889-8454-d941-866388d9546a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <6b55a6ee-c889-8454-d941-866388d9546a@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 17 Jul 2019 12:01:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/12] block: Deep-clear inherits_from
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.07.2019 um 11:07 hat Max Reitz geschrieben:
> On 17.07.19 10:17, Kevin Wolf wrote:
> > Am 17.07.2019 um 09:47 hat Max Reitz geschrieben:
> >> On 16.07.19 19:01, Kevin Wolf wrote:
> >>> Am 03.07.2019 um 19:28 hat Max Reitz geschrieben:
> >>>> BDS.inherits_from does not always point to an immediate parent node.
> >>>> When launching a block job with a filter node, for example, the node
> >>>> directly below the filter will not point to the filter, but keep its=
 old
> >>>> pointee (above the filter).
> >>>>
> >>>> If that pointee goes away while the job is still running, the node's
> >>>> inherits_from will not be updated and thus point to garbage.  To fix
> >>>> this, bdrv_unref_child() has to check not only the parent node's
> >>>> immediate children for nodes whose inherits_from needs to be cleared,
> >>>> but its whole subtree.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>
> >>> Isn't the real bug that we keep pointing to a node that isn't a parent
> >>> of the node any more? I think this will effectively disable option
> >>> inheritance in bdrv_reopen() as long as the filter node is present,
> >>> which is certainly not what we intended.
> >>
> >> Well, it breaks it while a block job is running.  I don=E2=80=99t know=
 whether I
> >> would advise doing a reopen across a block job filter.  It=E2=80=99s a=
 case of
> >> =E2=80=9CWhy wouldn=E2=80=99t it work?=E2=80=9D, but I=E2=80=99m sure =
there=E2=80=99s something that doesn=E2=80=99t.
> >> (Like this here, for example, but it at least has the decency of just
> >> letting the reopen fail.)
> >=20
> > Why would it let the reopen fail? Failing would be justifiable, but I
> > expect it just succeeds without updating the options of the child node.
>=20
> I actually don=E2=80=99t know what you=E2=80=99re referring to, because I=
=E2=80=99m not familiar
> with either the inherits_from paths nor with bdrv_reopen.
>=20
> I took it you meant the loop over the children in
> bdrv_reopen_queue_child(), and the fact that it skips the children that
> do not inherit from this node.
>=20
> So I took it that options that do not get passed to children remain at
> the parent level and would throw an error at some point, because options
> that cannot be handled should throw an error at some point.  (Which does
> happen, as far as I can tell.)

I'm talking about cases where you don't explicitly set an option for a
child, but it inherits the (possibly changed) option from its parent.

For example, consider a qcow2 image that was originally opened as a
backing file, so both its qcow2 node and its file-posix node are
read-only; the file-posix node inherits its read-only=3Don setting from
the qcow2 node. Now you reopen the qcow2 node read-write (starting a
commit job) and the expected result is that the file-posix node
automatically inherits the updated value and becomes read-write, too.

This happens indeed in bdrv_reopen_queue_child(), but the interesting
case is where an option isn't explicitly set in the recursive call for
the child node. This happens in the following line in the nested call:

    role->inherit_options(&flags, options, parent_flags, parent_options);

If child->bs->inherits_from didn't point to the parent that is being
reopened, we wouldn't even recurse, so .inherit_options would never be
called.

> >>> The intuitive thing would be that after inserting a filter, the image
> >>> now inherits from the filter node, and when the filter is removed, it
> >>> inherits from the filter's bs->inherit_from if that becomes a parent =
of
> >>> the node. (Though I'm not necessarily saying that my intuition is to =
be
> >>> trusted here.)
> >>
> >> I tried that first, but I couldn=E2=80=99t get it to work.  I don=E2=
=80=99t remember
> >> why, though.  I suppose my problem was that removing the filter node
> >> make inherits_from NULL.  I guess I stopped at that point and went this
> >> route instead.
> >>
> >> I suppose we could add a flag to the BDS that says whether an heir
> >> node=E2=80=99s inherits_from should be cleared or set to the bequeathe=
r=E2=80=99s
> >> inherits_from, like so:
> >>
> >>     if (parent->inherit_inherits_from) {
> >>         child->bs->inherits_from =3D parent->inherits_from;
> >>     } else {
> >>         child->bs->inherits_from =3D NULL;
> >>     }
> >>
> >> And then, if you insert a node between a child and its inherits_from
> >> parent, that node copies inherits_from from the child and gets its
> >> inherit_inherits_from set to true.
> >>
> >> The problem I see is that it doesn=E2=80=99t always appear clear to me=
 that this
> >> intermediate node should actually copy its inherits_from from the chil=
d.
> >>
> >> So the same question applies here, too, I guess; should the filter node
> >> even inherit its options from the parent?
> >=20
> > An explicitly created filter node that is inserted with blockdev-reopen
> > certainly doesn't inherit from its parent. An automatically created
> > filter node where you didn't have control of its options - hm... good
> > question.
> >=20
> > If we want to keep it simple, maybe it would be defensible if we just
> > break the inheritance relationship as soon as the parent is detached
> > (i.e. when inserting the filter). At least that would be more consistent
> > than silently disabling option inheritance while a filter is present and
> > then suddenly reenabling it when the filter goes away.
>=20
> That sounds wrong to me.
>=20
> As I said, doing a reopen across a block job filter sounds like there
> can be many things to go wrong.  I don=E2=80=99t know why anyone would do=
 so
> (and live to tell the tale).

You do reopen on a single node that could be way up the graph, not
really related to the job. The question is what this reopen can do to
the subtree below it, including the job filter.

> So from that perspective, if you do a reopen before or after, it would
> work.  You don=E2=80=99t do anything while the filter is there because it=
=E2=80=99s a
> bad idea anyway.  If it just failed while the job is running and then
> started working again afterwards, that would actually sound good to me.
>=20
>=20
> What does sound bad to me is breaking it just because you ran a block
> job in the meantime.
>=20
> Well, it doesn=E2=80=99t really sound bad, but it doesn=E2=80=99t sound i=
deal either.

Fair enough (though I'm not completely convinced that a filter job
somewhere down the tree can reasonably block all of its parent nodes
=66rom being reopened), but at the very least we must make sure that
reopen actually does report an error instead of returning success and
silently ignoring the subtrees that contain filter nodes.

> > The other option would be making it actually work, i.e. the child node
> > keeps inheriting from its original parent node. This would not only
> > require modifications to bdrv_reopen(), but also to the data structures
> > so that the parent has a list of nodes that inherit from it: Nobody can
> > even guarantee that the child node always stays in the subtree of the
> > original parent.
>=20
> I don=E2=80=99t quite see how that cannot be guaranteed.  If the child go=
es out
> of the subtree, we should clear inherits_from.
>=20
> The only way the child can go out of the subtree is by virtue of it or
> one of its recursive parents until the inherits_from pointee being detach=
ed.
>=20
> I don=E2=80=99t see how that can happen without going through
> bdrv_unref_child(), which will clear all of those inherits_from pointers.
>=20
> bdrv_replace_node() comes to mind, but currently it=E2=80=99s actually on=
ly
> called by bdrv_append(), by the block jobs to undo bdrv_append(), and by
> mirror to take the to_replace node.  The last case may be an issue.

Hm, okay. Maybe it's actually not possible. I'd have to have a closer
look at the code.

> > This is in fact a reason why this patch isn't only ugly, but actually
> > wrong - you may still miss some inherits_from references.
>=20
> Well, the unfortunate thing is that this patch is in master now because
> I preferred fixing access of a dangling pointer over being sure to keep
> inherits_from working in all cases.
>=20
> I know, that=E2=80=99s all the more reason for me to fix it now.  But as =
I said,
> I don=E2=80=99t have much experience with bdrv_reopen.

Yeah, let's see if we can improve the situation a bit at least for 4.1.

Kevin

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdLw4HAAoJEH8JsnLIjy/Wo4AQAI4Od4Htk+YIaLdV5D8RO9bx
fxSs5v0YO134ws/gQcPmlnSLaafns9fvfzWS+J6yWrWO8/RrP3TsTz9ysV+MvIr4
DmRi+4nH0pcBjTgNJeqPEVDxznI7bycc0w6j+T2leGFBDUf2v66wfN2mbMtvOnh5
zbE5nVgYUKo5Qje+8/wp1IOcH1b9Vhoisch60Acpd7VMyFvQzhGwaRzgyTzNm19N
ZU0YjsrhWCjmZL7G+36j2rI8k1rsHWVG9/f1b0A7/lV8QTrIL2Piq3sOwM2fcIPa
VG4tcQCN7PX5T3yDEwnezpWDre5o2LbPZs8jOBJlss7tzRCdpp8scrZCT/8Un04G
NnZQHnIrG66j3dI6qCsrE2AGeUaKA1nM/OST723NPZ+OYHd2v5otgRJYc4dPpIEX
tsu+61IKXBHwdLsbJXsW8FM6LY2wyeZyQo1aMVb4OzkfDFkPeETkHvT4fZAUkoCN
Qt40lhuA3Tcb7PC8ui3dLBMKhJyB/i2YZGQBSpQe987poug08qh045HVnrVl/1dl
oEBzqW7UNe8xxLVBWWNP9VBYCJzq/hQv16jqXJc1jBCPgiPWm53efYF1P//PWxkr
MLAK8W6/UvGxXhWYGCGE4GZR3eQxQKzjoETwFNfDfWOYPLaf4M/X+6m+7VZzUP7z
MVZ6/lq9AmtCnNfsePjG
=yUnZ
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

