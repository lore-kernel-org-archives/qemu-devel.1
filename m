Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvM5g-0005JP-0t
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvM5c-000382-Rq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvM5c-00037A-MO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:53:32 -0400
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
	<000201d2ad05$e28626d0$a7927470$@ru> <8760ikblf7.fsf@linaro.org>
	<874ly4bgbu.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c4f3f42-3b33-8e0a-b3f4-0963670b47de@redhat.com>
Date: Tue, 4 Apr 2017 12:53:26 +0200
MIME-Version: 1.0
In-Reply-To: <874ly4bgbu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 7/9] cpus: move icount preparation
 out of tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>



On 04/04/2017 12:46, Alex Benn=C3=A9e wrote:
>> In theory the main-loop should be sequenced before or after vCPU event=
s
>> because of the BQL. I'm not sure why this is not currently the case.
>=20
> It seems cpu_handle_exception doesn't take the BQL until
> replay_exception() has done its thing. This is fixable but the function
> is a mess so I'm trying to neaten that up first.

Long term neither cpu_handle_exception nor cpu_handle_interrupt need the
BQL at all.

Paolo
