Received: from eggs.gnu.org ([2001:4830:134:3::10]:46368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lpetrut@cloudbasesolutions.com>) id 1fItvY-000855-Rz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lpetrut@cloudbasesolutions.com>) id 1fItvV-0004em-Oa
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:45:00 -0400
Received: from mail.cloudbasesolutions.com ([91.232.152.5]:37024)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lpetrut@cloudbasesolutions.com>) id 1fItvV-0004eR-Cx
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:44:57 -0400
From: Lucian Petrut <lpetrut@cloudbasesolutions.com>
Date: Wed, 16 May 2018 10:44:27 +0000
Message-ID: <64050966FCE0B948BCE2B28DB6E0B7D541340A96@CBSEX1.cloudbase.local>
References: <64050966FCE0B948BCE2B28DB6E0B7D541340A17@CBSEX1.cloudbase.local>,
	<af1bfcca-322d-094b-0997-7b9c635e8683@redhat.com>
In-Reply-To: <af1bfcca-322d-094b-0997-7b9c635e8683@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] WHPX: fix some compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>
Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Oh, right, got it. Sorry for the confusion, I=92ll take that out of the pat=
ch.



Thanks,

Lucian Petrut



From: Paolo Bonzini<mailto:pbonzini@redhat.com>
Sent: Wednesday, May 16, 2018 1:42 PM
To: Lucian Petrut<mailto:lpetrut@cloudbasesolutions.com>; petrutlucian94@gm=
ail.com<mailto:petrutlucian94@gmail.com>
Cc: Alessandro Pilotti<mailto:apilotti@cloudbasesolutions.com>; Justin Terr=
y<mailto:juterry@microsoft.com>; Richard Henderson<mailto:rth@twiddle.net>;=
 Eduardo Habkost<mailto:ehabkost@redhat.com>; open list:All patches CC here=
<mailto:qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/3] WHPX: fix some compiler warnings



On 16/05/2018 12:21, Lucian Petrut wrote:
> Hi,
>
> Thanks for reviewing those changes.
>
> /=93can you send a patch with the bugfix only=94/
>
> By =93the bugfix only=94 you mean the previous commit, the one that
> dynamically loads the DLLs?
>
> FWIW, without this patch, i386 targets won=92t compile, so I=92d consider
> that an improvement. Probably I should=92ve explicitly mentioned this in
> the commit message.

I mean this patch, but without the switch from {0} initializers to memset.

I've already queued patch 2 independently, so you are set with that one!

Thanks,

Paolo
