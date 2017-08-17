Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNi3-0001yo-Nj
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNi0-0000Pf-L3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:31:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diNi0-0000P6-EZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:31:48 -0400
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
	<2e763f07-c688-ce55-2824-c2d0d7562edb@redhat.com>
	<CAFEAcA_H7_qbjTma9sUmKxpkCy7UP2+tbwJVEOwKLNodA7HQhA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b790304-5ff6-ecfa-fb8a-958bdf4c8f2b@redhat.com>
Date: Thu, 17 Aug 2017 18:31:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_H7_qbjTma9sUmKxpkCy7UP2+tbwJVEOwKLNodA7HQhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 17/08/2017 18:17, Peter Maydell wrote:
> On 17 August 2017 at 17:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 17/08/2017 18:14, Igor Mammedov wrote:
>>> travis builds fail at HEAD at rc3 master with
>>>
>>>   block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=
=99:
>>>   block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used =
uninitialized in this function [-Werror=3Duninitialized]
>>>
>>> fix it by initializing 'ret' to 0
>>
>> This is a false positive, but it's understandably impossible for the
>> compiler to figure it out.
>>
>> Even though we disable -Werror on release builds, it may be worth fixi=
ng
>> this in 2.10 if it doesn't delay the release.  Peter, what do you thin=
k
>> about applying this on top of -rc3 without doing a fourth candidate?
>=20
> I don't like doing releases which haven't had an rc,
> but we've had abbreviated "just a couple of days" rc-to-final
> cycles before.

It's just a matter of "looking unpolished".  It doesn't deserve -rc4,
not even for just a couple of days.

Paolo
