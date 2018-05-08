Received: from eggs.gnu.org ([2001:4830:134:3::10]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxLX-0008MU-Ho
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxLT-0005bR-9J
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:47:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fFxLT-0005ar-3E
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D6F1818533A
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 07:47:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180413115451.GD16263@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 13 Apr 2018 12:54:51 +0100")
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-2-quintela@redhat.com>
	<20180413115451.GD16263@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 09:49:37 +0200
Message-ID: <87zi1aa8oe.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/8] qemu-sockets: Export
 SocketAddress_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Apr 04, 2018 at 01:27:24PM +0200, Juan Quintela wrote:
>> Migration code needs that function in hmp.c (so we need to export it),
>> and it needs it on tests/migration-test.c, so we need to move it to a
>> place where it is compiled into the test framework.
>
> This code really does not belong in qemu-sockets.h - the syntax being
> printed here is the chardev specific syntax, hence those is_listen and
> is_telnet parameters. If we want a way to string-ify SocketAddress then
> it should be a generic format, not the chardev format.

Hi

Dropeed.  Don't make sense to try to generalize it for two users.  Just
copy to hmp.c one simplified copy.

Thanks, Juan.
