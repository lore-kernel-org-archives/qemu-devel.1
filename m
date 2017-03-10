Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmG0Q-0006mR-5I
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmG0O-0005Zd-O9
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmG0O-0005ZV-Id
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:34:32 -0500
References: <20170303113255.28262-1-berrange@redhat.com>
	<20170310043048.GC4589@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8eba7fae-6443-62b7-1ac9-ebcfd5d5f481@redhat.com>
Date: Fri, 10 Mar 2017 09:34:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170310043048.GC4589@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/03/2017 05:30, Stefan Hajnoczi wrote:
> On Fri, Mar 03, 2017 at 11:32:55AM +0000, Daniel P. Berrange wrote:
>> When using a memory-backend object with prealloc turned on, QEMU
>> will memset() the first byte in every memory page to zero. While
>> this might have been acceptable for memory backends associated
>> with RAM, this corrupts application data for NVDIMMs.
>>
>> Instead of setting every page to zero, read the current byte
>> value and then just write that same value back, so we are not
>> corrupting the original data. Directly write the value instead
>> of memset()ing it, since there's no benefit to memset for a
>> single byte write.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>
>> Changed in v3:
>>
>>  - Mark the target of the write as volatile, instead of the intermedia
>>    variable (Andrea)
>>
>>  util/oslib-posix.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> There are no official maintainers for this source file.  I want to make
> sure this patch goes into QEMU 2.9, so...
>=20
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block

Yeah, I was leaving it to you because it's related to NVDIMM.  Thanks,

Paolo
