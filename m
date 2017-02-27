Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLWe-00079C-Vv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLWe-0000T2-6S
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:40 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciLWd-0000Sx-V3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:40 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so61526426wmd.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:39:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227130120.6ec54cc2@bahia.lan>
References: <20170227111726.9237-1-pbonzini@redhat.com>
	<20170227130120.6ec54cc2@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 13:39:18 +0000
Message-ID: <CAFEAcA8JzkpOvhLaoMX21gqb+0t2Dqc+a2F-Ens-GyEEtTC_4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests-aio-multithread: use atomic_read
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 27 February 2017 at 12:01, Greg Kurz <groug@kaod.org> wrote:
> On Mon, 27 Feb 2017 12:17:26 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> nodes[id].next is written by other threads.  If atomic_read is not used
>> (matching atomic_set in mcs_mutex_lock!) the compiler can optimize the
>> whole "if" away!
>>
>> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>
> Cool ! I can use travis again :)
>
> Tested-by: Greg Kurz <groug@kaod.org>
>

Thanks; applied to master as a build fix.

-- PMM
