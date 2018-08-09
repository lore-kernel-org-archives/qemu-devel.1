Received: from eggs.gnu.org ([2001:4830:134:3::10]:33203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnhV0-0005yh-SB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnhUw-0004k8-SV
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:44:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fnhUw-0004k2-MK
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:44:50 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<e165d2c3-814d-e8b5-3691-af0225ee981d@redhat.com>
	<581443fd-c054-06ad-94d6-7285b2713cd6@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af774599-c03a-c839-5190-1e1809d1216b@redhat.com>
Date: Thu, 9 Aug 2018 11:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <581443fd-c054-06ad-94d6-7285b2713cd6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/34] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 11:20, Emanuele wrote:
>>
> Why this? Shouldn't it be:
>=20
> if (g_strcmp0(old_path, path)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_end(); /* handles glob=
al_qtest =3D NULL */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(old_path); /* handles=
 NULL */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_path =3D path;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global_qtest =3D qtest_start=
(path);
> } else ....

Yes, of course.  Though I'd have thought that my version has "just" a
memory leak.  Even better, this could call qos_invalidate_command_line.

Can you post the fixes to a separate commit on github?

Paolo
