Received: from eggs.gnu.org ([2001:4830:134:3::10]:56612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdXNj-00083g-SJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdXNg-0000ga-Lk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:18:35 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdXNg-0000fq-Bu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:18:32 -0500
Message-Id: <58A31FBE02000062000CFB96@prv-mh.provo.novell.com>
Date: Tue, 14 Feb 2017 00:18:22 -0700
From: "Lin Ma" <lma@suse.com>
References: <20170213095148.25500-1-lma@suse.com>
	<d244306c-36df-bb23-3dad-6706545e2476@redhat.com>
	<58A20ED302000062000CF528@prv-mh.provo.novell.com>
	<8067935c-fcc6-8b52-d4c8-19813a390ec8@redhat.com>
In-Reply-To: <8067935c-fcc6-8b52-d4c8-19813a390ec8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSN77yaIFJlOiAgW1BBVENIIHYyIFJFU0VO?=
 =?utf-8?q?D=5D_Makefile=3A_Fix_owner_and_group_for_qemu-version=2Eh=2Etmp?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: famz@redhat.com, stefanha@redhat.com



>>> Paolo Bonzini <pbonzini@redhat.com> 2017/2/13 =E6=98=9F=E6=9C=9F=E4=B8=
=80 =E4=B8=8B=E5=8D=88 7:55 >>>
>
>
>On 13/02/2017 12:53, Lin Ma wrote:
>>=20
>> The content of qemu-version.h recorded the git head info of last build.
>> After 'git pull && make ', Because the content of qemu-version.h.tmp is
>> generated
>> based on the lastest git describe, Now this .h.tmp and the old .h =
aren't
>> consistent,
>> So this .h.tmp will be renamed to qemu-version.h.
>> Then during 'sudo make install', because there is no .h.tmp any more, a
>> new one will be
>> generated with privileged permissions.
>
>So is the bug that the "cmp || mv" should be changed to "if cmp ...;
>then mv ...; else rm ..."?
Yes, It makes sense, and this way can avoid leaving the qemu-version.h.tmp =
in
the folder after build. I'll send patch v3 based on it and the patch title =
will be
changed to 'avoid leaving the temporary QEMU_PKGVERSION header file'.
=20
Thanks,
Lin
