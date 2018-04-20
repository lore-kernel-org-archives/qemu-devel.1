Received: from eggs.gnu.org ([2001:4830:134:3::10]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9YiZ-0001LB-GL
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9YiW-0002pS-Dm
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:16:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9YiW-0002kh-9O
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:16:56 -0400
References: <20180420155045.18862-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66a3799d-aa29-9dca-18eb-e1b4ecbcef65@redhat.com>
Date: Fri, 20 Apr 2018 18:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into
 normal code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org

On 20/04/2018 17:50, Alex Benn=C3=A9e wrote:
>=20
> Why go through all of this hassle? Some justifications:
>=20
>   - no more "where is helper_le_stw_mmu defined?"
>   - easier debugging in gdb
>   - no duplicate code for be/le cases
>   - more accessible code
>=20
> I think there is also scope for more re-factoring and clean-up in the
> code generally. I considered looking at the atomic and ldst templates
> as well but decided to see what reaction the softmmu conversion got
> first.

Awesome! :)

Paolo
