Received: from eggs.gnu.org ([2001:4830:134:3::10]:46543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrsV-0000v7-Ri
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrsV-0003V0-12
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cxrsU-0003Ur-Ql
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E50F47AE90
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 09:14:21 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-6-pbonzini@redhat.com>
	<48253fa9-d5eb-f750-6dfc-e478bfd85277@redhat.com>
	<a9195765-0f0b-7aac-a403-9dc4ebd376f4@redhat.com>
	<271d6d98-55f6-3a32-f8c1-b60a901e21ff@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0cf5b0c-9408-0a32-407d-f693269b9338@redhat.com>
Date: Tue, 11 Apr 2017 12:57:55 +0800
MIME-Version: 1.0
In-Reply-To: <271d6d98-55f6-3a32-f8c1-b60a901e21ff@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 11/04/2017 00:05, John Snow wrote:
>=20
>=20
> On 04/08/2017 05:52 AM, Paolo Bonzini wrote:
>>
>>
>> On 08/04/2017 08:03, John Snow wrote:
>>> Looks clean, though it may be useful to do a few more things;
>>>
>>> - Demarcate what you think is the monitor API in this file
>>
>> It's already there:
>>
>> +/*
>> + * API for block job drivers and the block layer.
>> + */
>> +
>>
>> where everything before is for the monitor.
>>
>=20
> I meant explicitly, with a comment at the top explaining the demarcatio=
n.

Oh, sure.

>>> - Organize blockjob.h to match to serve as a useful reference.
>>
>> Hmm, yes.

As it turns out, no headers are necessary---but yours was a very good
remark still, because a couple mistakes in this series stood out when
checking.

The "API for block job drivers and the block layer" is already in
blockjob_int.h while the rest is in blockjob.h.  This is nice because it
provides some validation of the concept behind the patch, and also of
the locking policy I chose for the rest of the work.

But, there are two exceptions.  Both of them are introduced by this
series and they shouldn't be:

- blockjob_pause/resume_all should have its declaration in block_int.h,
so I've fixed patch 4 accordingly

- blockjob_create is in blockjob_int.h, but this patch should move it to
the second part of the file, too.

Thanks,

Paolo
