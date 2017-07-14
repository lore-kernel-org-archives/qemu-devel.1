Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVvuJ-00052G-4j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVvuG-0003SN-0a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVvuF-0003S2-QL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:24:59 -0400
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
	<1499955874-10954-24-git-send-email-pbonzini@redhat.com>
	<87tw2gv03n.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f9271f5-8594-7aa9-fb9f-9afa41f48ea6@redhat.com>
Date: Fri, 14 Jul 2017 10:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <87tw2gv03n.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 23/41] mttcg/i386: Patch instruction using
 async_safe_* framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, qemu-devel@nongnu.org

On 13.07.2017 17:16, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> From: Pranith Kumar <bobby.prani@gmail.com>
>>
>> In mttcg, calling pause_all_vcpus() during execution from the
>> generated TBs causes a deadlock if some vCPU is waiting for exclusive
>> execution in start_exclusive(). Fix this by using the aync_safe_*
>> framework instead of pausing vcpus for patching instructions.
>>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> Reviewed-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
>=20
> Looks like some UTF-8 mangling has occurred somewhere here.

Not sure whether it would help here, but I had a patch for checkpatch.pl
posted a while ago that should at least help to catch some of the UTF-8
problems:

 https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05741.html

Maybe we should at least include that (without the final two MAINTAINERS
patches in that series)?

 Thomas
