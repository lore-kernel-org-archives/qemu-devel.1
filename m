Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0s5E-0003sL-1T
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0s58-0008FQ-1g
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0s4z-0008BE-P1
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:40:33 -0400
References: <5aae1837-f6b9-a48b-7401-3aa623a084b2@adacore.com>
	<MWHPR21MB0189D5FC1EA87DBDB0F040409E1A0@MWHPR21MB0189.namprd21.prod.outlook.com>
	<526ea449-6a67-605f-70c5-b90f2bacd280@adacore.com>
	<53a9113b-62a0-a7fe-7c08-3edab38cfebc@adacore.com>
	<MWHPR21MB018954067574FC9D27C535389E190@MWHPR21MB0189.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f546599-0da1-f674-38c3-6ceb0a5b096f@redhat.com>
Date: Fri, 14 Sep 2018 19:40:23 +0200
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB018954067574FC9D27C535389E190@MWHPR21MB0189.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] crashes with win2008 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Andrey Shedel <ashedel@microsoft.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14/09/2018 18:54, Andrew Baumann wrote:
> On the other hand, since these OSes are a decade old (mainstream suppor=
t
> ended; will drop out of extended support in just over a year from now),
> and you are the first person to report a problem in 1.5 years since the
> patch went in, I wonder if we could =93fix=94 the problem by updating t=
he
> required OS versions for QEMU on Windows to Windows 7 / Server 2008 R2.=
..

I agree.

> Paolo, do you have any opinion? Note that backing out the patch isn=92t=
 a
> great idea either =96 it fixed a deadlock.

No way we're going to back it out. :)  SRWLocks are great.

Paolo
