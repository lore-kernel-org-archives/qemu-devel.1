Received: from eggs.gnu.org ([2001:4830:134:3::10]:52853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6uw1-0005q8-GF
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6uvy-0000WR-CF
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6uvy-0000WN-5x
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:19:22 -0400
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
	<9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
	<87pofnmgzl.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16f233b4-112c-ea5a-daa3-e61bbaef3570@redhat.com>
Date: Sat, 6 May 2017 10:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <87pofnmgzl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add
 qemu_lock, locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, "stefanha@redhat.com" <stefanha@redhat.com>, pavel.dovgaluk@ispras.ru, boost.lists@gmail.com, qemu-devel@nongnu.org



On 05/05/2017 17:59, Alex Benn=C3=A9e wrote:
> I'll re-spin my trace analysis script and the lock trace point once tha=
t
> pull request is merged. I would be nice if we could associate locks wit=
h
> names though as the QemuMutex * is basically just an anonymous handle.
> Would it be overly extravagant to add a const char * to QemuMutex to ca=
n
> be init'ed with a human readable name?

Sure, why not.  But please do make it a constant (as you suggest) so
that qemu_mutex_destroy does not need to g_free.

Paolo
