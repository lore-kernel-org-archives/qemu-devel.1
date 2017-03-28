Received: from eggs.gnu.org ([2001:4830:134:3::10]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csnB5-0002Za-92
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csnB0-00069C-Bv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:12:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csnB0-00067o-6Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:12:30 -0400
References: <20170328083623.10396-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78ccee4a-86a9-3db6-8e3c-5e4cf65ef330@redhat.com>
Date: Tue, 28 Mar 2017 11:12:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170328083623.10396-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] MTTCG fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com



On 28/03/2017 10:36, Alex Benn=C3=A9e wrote:
>=20
> Here is the current batch of fixes for MTTCG regressions for the next
> release candidate. I've dropped the speculative atomic cputlb patch
> and included 2 fixes to the console code. The first fixes the taking
> of the BQL (which I missed) and the second uses the exclusive
> mechanism directly in the main thread rather than queuing the work to
> run in the vCPU context. I kept them separate as they are logically
> discreet changes.
>=20
> The user-exec and bsd-user fixes have been posted separately before in
> the various report threads.
>=20
> Finally I claim a checkpatch exception for Pranith's newline fix. It
> didn't seem worth splitting the string for the sake of a semicolon on
> column 81 ;-)

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
