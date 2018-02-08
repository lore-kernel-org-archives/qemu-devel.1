Received: from eggs.gnu.org ([2001:4830:134:3::10]:57548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejqBa-00035M-0w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejqBY-0000Yk-T8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejqBY-0000YG-Jo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:40:36 -0500
References: <20180208051601.12800-1-armbru@redhat.com>
	<CAFEAcA9L8HK-9Gi5Ug4xHNYtfj1E3E4ttgzFSU7LVESZDnwa6w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <820e8f77-22f0-0931-5b1c-516c28cc5ece@redhat.com>
Date: Thu, 8 Feb 2018 11:40:20 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9L8HK-9Gi5Ug4xHNYtfj1E3E4ttgzFSU7LVESZDnwa6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/20] Miscellaneous patches for
 2018-02-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/08/2018 10:22 AM, Peter Maydell wrote:
> 2018-02-08 5:16 GMT+00:00 Markus Armbruster <armbru@redhat.com>:
>> The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c=
68962:
>>
>>    Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' =
into staging (2018-02-06 14:21:41 +0000)
>>
>> are available in the git repository at:
>>
>>    git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07-v2
>>
>> for you to fetch changes up to 2416be0431db85663d69d58824b26618470786d=
c:
>>
>>    Move include qemu/option.h from qemu-common.h to actual users (2018=
-02-08 06:12:45 +0100)
>>
>> ----------------------------------------------------------------
>> Miscellaneous patches for 2018-02-07
>=20
> Build failures everywhere in nvme.c:
>=20
>=20
> /home/pm215/qemu/block/nvme.c:118:1: error: variable =E2=80=98runtime_o=
pts=E2=80=99
> has initializer but incomplete type
>   static QemuOptsList runtime_opts =3D {
>   ^

Semantic conflict based on pull request ordering: nvme.c was just barely=20
added, and was written prior to this series cleaning up headers that=20
used to be available implicitly.  Should be an easy cleanup, but yes, it=20
means a v3 pull request will be needed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
