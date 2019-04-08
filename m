Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C7C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C5820870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDN0V-0001qy-W1
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 01:39:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDMzg-0001ZO-3R
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDMze-0004dm-9b
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDMzb-0004Zp-Hm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D75FF74A7;
	Mon,  8 Apr 2019 05:38:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B50185DA2A;
	Mon,  8 Apr 2019 05:38:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 173401138648; Mon,  8 Apr 2019 07:38:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
	<ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
Date: Mon, 08 Apr 2019 07:38:37 +0200
In-Reply-To: <ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
	(=?utf-8?Q?=22Herv=C3=A9?=
	Poussineau"'s message of "Fri, 5 Apr 2019 18:35:41 +0200")
Message-ID: <87o95hjbtu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 08 Apr 2019 05:38:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408053837.-vUx9eb2Mxf7FQBWA0CKJMueHGLPcsBlpG89m_2HRoE@z>

Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:

> Le 05/04/2019 =C3=A0 12:29, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> Hi,
>>
>> I am trying to understand the possible values for the MAX_FD variable
>> used by the floppy controller model (hw/block/fdc.c).
>>
>> Looking at git history:
>>
>> - 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
>>    FDC introduced with "#define MAX_FD 2"
>>
>> - 2008-04-29 78ae820cfeb0 (Herv=C3=A9 Poussineau):
>>    Supports up to 4 floppy drives if MAX_FD is set to 4
>>    Migration stream knows about runtime value of MAX_FD
>>
>> - 2009-09-10 d7a6c2703577 (Juan Quintela):
>>    FDC vmstate-ified
>>    Migration stream use compile time value of MAX_FD
>>
>> Since 7138fcfbf7dd MAX_FD has always been defined as 2.
>>
>> Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
>> migration.
>>
>> If I understand correctly migration, first we should change in
>> vmstate_fdc the user-definable MAX_FD by a constant 2 value.
>>
>> Then to be able to use >2 floppy disks I have to modify the the
>> vmstate.version_id, and
>>
>> 1/ add a new field in the vmstate_fdc containing the number of drives
>> and add code to check >2 and adapt
>>
>> or
>>
>> 2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
>> to older FDC with only 2 disks...
>>
>> Another option I don't like is:
>>
>> 3/ get ride of MAX_FD !=3D 2 and clean the codebase...
>>
>> $ git grep '#if MAX_FD'
>> hw/block/fdc.c:744:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:758:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:1317:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:1340:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:2041:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:2079:#if MAX_FD =3D=3D 4
>> hw/block/fdc.c:2104:#if MAX_FD =3D=3D 4
>>
>> Herv=C3=A9, what board are/were you using with 4 floppy drives?
>
> That was only an attempt to support 4 drives in code, as controller was a=
ble to do it.
> However, no emulated board took advantage of it, so that's why it kind-of=
 regressed.
>
> Feel free to choose the solution you prefer.

Since no user has appeared since 2008, it feels safe enough to assume
that none will appear going forward.  I lean towards your "3/ get ride
of MAX_FD !=3D 2 and clean the codebase..."  Explain in a comment that we
emulate only a 2-drive floppy controller, not the genuine IBM PC 4-drive
floppy controller.

