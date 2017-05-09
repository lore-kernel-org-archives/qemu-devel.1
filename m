Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d85bZ-0005Er-MY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d85bW-0003aF-Mf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d85bW-0003Zq-Gs
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:55:06 -0400
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
	<9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
	<87pofnmgzl.fsf@linaro.org>
	<20170508175217.GO22428@stefanha-x1.localdomain>
	<87fuge87hv.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4c9bbe3-8901-c593-7c7b-c40a35a84225@redhat.com>
Date: Tue, 9 May 2017 15:55:00 +0200
MIME-Version: 1.0
In-Reply-To: <87fuge87hv.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org



On 09/05/2017 15:50, Alex Benn=C3=A9e wrote:
>> No, it doesn't.  I would make the trace event take const char * and pa=
ss
>> in the string.
> It would be nice to avoid having the string for non-trace builds.

It can help with gdb as well (e.g. having gdb printers that print the
name of a mutex), and it shouldn't be a burden.

Paolo

> I was
> thinking of something like:
>=20
>   trace_register_human_name(void *ptr, const char *name)
>=20
> Which compiles away to nothing when tracing is not enabled.
>=20
