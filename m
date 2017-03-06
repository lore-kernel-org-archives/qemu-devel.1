Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckvM1-0000p0-Rn
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckvLy-0008UY-Lb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:19:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ckvLy-0008UL-Ez
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:19:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26GDu4W101407
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 11:19:17 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2918mm01xm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 11:19:17 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 09:19:15 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87fuknruky.fsf@dusky.pond.sub.org>
References: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<87fuknruky.fsf@dusky.pond.sub.org>
Date: Mon, 06 Mar 2017 10:19:06 -0600
Message-Id: <148881714611.18371.8435935511376017475@loki>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Quoting Markus Armbruster (2017-01-13 06:51:57)
> Andreas, please have a look.  Feel free to ask me to take it through my
> tree.

Ping for 2.9. (sorry for not noticing this sooner)

> =

> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
> =

> > hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
> > duplicate ID error if the previous object shared the same ID and was ad=
ded
> > via the command-line. Please see patch 2/2 for more details.
> >
> > This patchset fixes the issue in question and adds some general unit te=
sts
> > for object created via -object, which we later extend to verify the fix=
 in
> > question.
> >
> > Changes since v3:
> >
> >   - Fixed up comment formating (Markus)
> >   - Instead of segfaulting, use &error_abort if assumptions about
> >     'object' property group existence change (Markus)
> >   - Use g_assert_null in place of g_assert(... =3D=3D NULL) (Markus)
> >
> > Changes since v2:
> >
> >   - Moved the generic unit tests ahead of the fix patch, with a FIXME
> >     in place of the actual check for the failure addressed in patch
> >     2/2 (Daniel/Markus)
> >   - Dropped check for existence of objects' QemuOptsList (Markus)
> >   - Dropped unintended whitespace removal in PATCH 1/2
> >   - Slight rewording of commit messages to reflect the changes and fix
> >     minor grammar errors.
> >
> > Changes since v1:
> >
> >   - Moved QemuOpt cleanup out of {qmp,hmp}_object_del() and into common
> >     user_creatable_del() path (Daniel, David)
> >   - Added corresponding test case in check-qom-proplist
>=20
