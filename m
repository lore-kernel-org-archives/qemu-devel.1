Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F143C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0FF20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+hzLz8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0FF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioW0E-0001sB-TV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioVyR-00007F-OG
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioVyM-0007rT-T8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:15:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioVyL-0007pi-EU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578330920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=ew1pOkciK0fbTIu+QGVVcSiYtKvEwOp/21QyqZpwqbI=;
 b=H+hzLz8xkhCN3/ELR9v4mlcPseyOwJXnNQxQT9/v7Exeu4+TIDPe7AP9HdmRmb76cJ0GiQ
 r1UpKTQcxhLMdZKs0fFH+tlbic5QK9OF6uE8TVTXkiRk8KujhaiofySAQygeXhgjM6woRk
 pdgiHx/2UU8Ih2HR6dNsUsW28Er6v3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-jz1-xFqUOHi2Eba8rFArnA-1; Mon, 06 Jan 2020 12:15:14 -0500
X-MC-Unique: jz1-xFqUOHi2Eba8rFArnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63600107ACCC;
 Mon,  6 Jan 2020 17:15:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-91.ams2.redhat.com
 [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A22460E3E;
 Mon,  6 Jan 2020 17:15:08 +0000 (UTC)
To: Qemu-block <qemu-block@nongnu.org>
From: Max Reitz <mreitz@redhat.com>
Subject: Pre-Christmas meeting notes
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <eee7656f-8de1-9d44-7de2-db1b5ed68148@redhat.com>
Date: Mon, 6 Jan 2020 18:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zfetyiFEleAId57kvRrVk5PBpXhgyISgP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zfetyiFEleAId57kvRrVk5PBpXhgyISgP
Content-Type: multipart/mixed; boundary="k6C03UxP1GwKtCBMIlwhBrixGTvvkn1ka"

--k6C03UxP1GwKtCBMIlwhBrixGTvvkn1ka
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Pre-Christmas meeting of Kevin, Markus, and me
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hi,

As we have done in some other years before, Kevin, Markus, and me got
together before Christmas (Dec 12, to be exact) and talked about a
couple of things concerning the block layer.  These are the notes we
took, maybe you find them useful.

(Kevin, Markus, of course, if you find something wrong or amiss,
please correct me :-))


The -drive story
----------------

We want deprecate it, or at least parts of it.  How?

Markus made some analysis of the existing -drive options and their
replacements. A few parts could be deprecated now (including if=3Dnone,
which is probably the most irregular configuration compared to
-blockdev/-device).

We know that at least SD card support is still missing before we have
a full replacement of -drive.

Should we consider a file=3Dbackend:<node-name> syntax where -drive
configures only the frontend part that cannot be configured with
-device/-machine, but refers to a node-name created with -blockdev?
Might be simpler than actually converting all those boards we don=E2=80=99t
care about, but obviously would leave a stub -drive behind instead of
fully getting rid of it.

How much work is deprecating -drive actually worth? Or in other words:
How much does it get in the way when we want to do new things?
Apparently quite a bit, though removing it only partially would be a
daunting task, too. We might have to deprecate it fully and then
replace with something simpler.


qemu-storage-daemon
-------------------

Next steps:

1. Split off monitor changes that make sense on their own and send
   them to Markus so they can be merged before the rest.

2. QAPIfy --monitor command line option: Trivial (turn the options
   into a QAPI struct type, run a keyval visitor on the input to parse
   it)

3. QAPIfy --object command line option: Not much to be done there
   because we=E2=80=99re unlikely to ever get a schema for QOM things (in p=
art
   because it has dynamic properties), so we also don=E2=80=99t get QAPI C =
types.

   Instead, just change object-add to accept flat input (in QDict
   form) to make it nicely usable on the command line and then call
   qmp_object_add() from the storage daemon=E2=80=99s command line parser.

4. QAPIfy --chardev command line option: This one requires probably
   the most work because it=E2=80=99s complex, but actually described by a
   schema. The existing chardev-add options are deeply nested and
   nasty to use on the command line. Some flattening needed.

   Markus is going to have a look at flattening simple unions, which
   is a more general problem in existing QAPI interfaces, and will be
   needed in more places for a fully QAPIfied QEMU command line
   parser.


block-stream as concerned by the =E2=80=9CDeal with filters=E2=80=9D series
-----------------------------------------------------------

Our discussion was centered around what edges block-stream should
freeze and what base nodes actually make sense.

Using a filter as the base is fine, as long as the job then streams
from the first COW overlay on top (AFAIR this is what the series=E2=80=99s
current version does).  Otherwise, everything would be copied from the
filter, and this includes all data allocated in the first non-filter
below the base (the filter).  It then wouldn=E2=80=99t make sense to keep t=
hat
non-filter around.

All in all, what the series currently does is fine (i.e. freezing
everything directly above the base, even if that node above the base
is a filter, too).  The actual problem is probably that the stream job
shouldn=E2=80=99t have taken a @base parameter, but @above-base instead (fr=
om
the start).  Now the damage is done and we just need to document how
all of this works (i.e., that the job looks for the node directly
above @base, and that this node is then going to be the backing node
of @top when the job settles).


QOM
---

=E2=80=9EGanz schrecklich.=E2=80=9C (Very terrible.)
(Not least the situation regarding documentation and help.)


QemuOpts
--------

See =E2=86=92QOM.


Asynchronous execution of synchronous block QMP commands
--------------------------------------------------------

(like block_resize)

Block layer QMP commands often do I/O while holding the BQL,
potentially blocking the guest. This is a similar problem to what
Marc-Andr=C3=A9 tried to solve with his async QMP commands (and which
Markus failed to review so far because it=E2=80=99s a too long series).

After discussion that executing stuff in a coroutine would solve the
problem for block layer commands almost automatically, I [Kevin]
hacked up a prototype to do just that. It seemed to do its job (though
it needs to be conditional because you can=E2=80=99t run everything in a
coroutine, so some work left to do) and looked much simpler than the
async QMP commands series. It should be easily usable for screendump
(Marc-Andr=C3=A9=E2=80=99s problem), too.

Asked Marc-Andr=C3=A9 about the approach and he told me [Kevin] he=E2=80=99=
d look
into it.


Incomplete handling of inactive/unavailable nodes
-------------------------------------------------

1. How can be prevent execution of certain QMP commands on inactive
   BDSs?  Probably not at all, we may have to just have to check
   INACTIVE everywhere (possibly with a new function checking that the
   BDS is usable, including !INACTIVE).

   Alternative ideas:
   - Setting RO: Requires a reopen on switch-over, which may fail
   - Unsharing the WRITE permission: Does not work, because the
     permissions are enforced outside of the current qemu instance
     through file locks.  The source VM still has and needs a WRITE
     permission, though, so we cannot let anything on the destination
     unshare it.

2. We still have BDS.drv =3D=3D NULL.  We=E2=80=99ve wanted to add an =E2=
=80=9Cerror=E2=80=9D
   driver for quite some time that returns -EIO to everything.  (We=E2=80=
=99d
   then replace all errored nodes (where BDS.drv =3D NULL is set) by
   such an error node).


Query function situation
------------------------

Well, it kind of works right now.  Perhaps we=E2=80=99d like a variant of
bdrv-query-named-nodes that just queries a single node and returns
something nicely structured (i.e. a BlockdevOptions object with
references to child nodes).

OTOH, as long as noone complains, is it really important?


Misc
----

The Wiki=E2=80=99s TODO list is horribly outdated.  What should we do about
it?  Maybe archive it and start a new one?  (Most of the things on the
current list are either done or we don=E2=80=99t want to do anymore.)


--k6C03UxP1GwKtCBMIlwhBrixGTvvkn1ka--

--zfetyiFEleAId57kvRrVk5PBpXhgyISgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4TaxsACgkQ9AfbAGHV
z0AGwQf/T8FhzqcZ/J1nQJ1REJ5O3IsWKndn/6IsfbE8+d/3kXoQ7khOHxf4mfU5
XKOk51+9BYQPpV2D3dWJIshqjVnGXJF0W4FdSahPNkycInhELCHj+6NROx+pTPKL
qui+l2N4VVI5P8Kt5YGUUBRuBO4P/36PC1KCGCgNUZtuO890LVpte/U/Zb4adZyK
SN4AeccVvDDhigQUP43eVIizzPycMCyrU2BoqQURejSv89ajFZPI1gGNvD/h1lVL
MnLSw94ux49VpNh7A1PJx/HqHHVglo/RVrtSJxU4hOOpS9cFfAX0awWdu7N3H/qf
9Iyn0qiyTJPbDXLJx+PEDbv+ZbZGuw==
=mG8T
-----END PGP SIGNATURE-----

--zfetyiFEleAId57kvRrVk5PBpXhgyISgP--


