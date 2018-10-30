Received: from eggs.gnu.org ([2001:4830:134:3::10]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHUOM-0005m5-W8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHUOI-0001yx-17
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHUOG-0001vs-RG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:49:05 -0400
References: <20180209104546.29401-1-pbonzini@redhat.com>
	<87va5j8w1m.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81885166-a1a6-ca2c-5330-b3d39330fb7a@redhat.com>
Date: Tue, 30 Oct 2018 14:48:58 +0100
MIME-Version: 1.0
In-Reply-To: <87va5j8w1m.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] tcg: fix dirty bitmap race with MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On 30/10/2018 13:21, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> This is a race that can happen when migrating TCG guests under load.
>> It was introduced by the change to run vCPUs outside the big QEMU
>> lock.
>=20
> Did this ever get re-spun?

No, the issue is that *without MTTCG* all work items must come from the
same list, otherwise you get a deadlock.  However the cleanup part of
the series was applied.

Paolo
