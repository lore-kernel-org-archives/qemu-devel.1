Received: from eggs.gnu.org ([2001:4830:134:3::10]:40705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrbj-0006yb-6X
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrbf-000587-Ud
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cxrbf-00057l-OG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:56:59 -0400
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-4-pbonzini@redhat.com>
	<20170410092255.GD2567@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcc280a6-ee64-38d9-512d-24a2be8e566a@redhat.com>
Date: Tue, 11 Apr 2017 12:00:36 +0800
MIME-Version: 1.0
In-Reply-To: <20170410092255.GD2567@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] blockjob: introduce block_job_fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com



On 10/04/2017 17:22, Stefan Hajnoczi wrote:
>>
>> Later on, block_job_fail will also have different locking than
>> block_job_unref.
> block_job_fail() sounds like it's *the* job failure API.
> How about block_job_fail_early()?
>=20
> It indicates the API is only for the beginning of the job's lifecycle.

Can't disagree and I'll apply your suggestion.  Thanks,

Paolo
