Received: from eggs.gnu.org ([2001:4830:134:3::10]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6tIV-0003Uh-UF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6tIS-0005uR-Jg
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g6tIS-0005tv-Bz
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:11:16 -0400
References: <1538295197-23704-1-git-send-email-pbonzini@redhat.com>
	<572f8674-1712-686a-278e-9eae5947a233@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a4400ff-5eed-6deb-9986-a63abca495b6@redhat.com>
Date: Mon, 1 Oct 2018 10:11:10 +0200
MIME-Version: 1.0
In-Reply-To: <572f8674-1712-686a-278e-9eae5947a233@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/79] Misc QEMU patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 30/09/2018 16:54, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Paolo, Peter.
>=20
> On 9/30/18 10:11 AM, Paolo Bonzini wrote:
>> The following changes since commit 042938f46e1c477419d1931381fdadffaa4=
9d45e:
>>
>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2=
0180926a' into staging (2018-09-28 17:07:23 +0100)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 54b570779677ff8620a79ed81ddf0906b1d23f4=
e:
>>
>>   hw/scsi/mptendian: Avoid taking address of fields in packed structs =
(2018-09-30 10:08:28 +0200)
>>
>> ----------------------------------------------------------------
>> * configure fix for environment variables (Daniel)
>> * fix memory leaks (Alex)
>> * x86_64 MTTCG (Emilio)
>> * introduce atomic64 (Emilio)
>> * Fix for virtio hang (Fam, myself)
>> * SH serial port fix (Geert)
>> * Deprecate rotation_rate for scsi-block (Fam)
>> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
>> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
>> * MSI/IOMMU fix (Jan)
>> * Socket reconnection fixes (Marc-Andr=C3=A9)
>> * icount fixes (Emilio, myself)
>> * QSP fixes for Coverity (myself)
>> * Some record/replay improovements (Pavel)
>> * Packed struct fixes (Peter)
>> * Windows dump fixes and elf2dmp (Viktor)
>> * kbmclock fix (Yongji)
>=20
> Paolo, thanks for queuing all of this, however I note some UTF-8 issues=
.
>=20
> Alex got lucky:
>=20
>  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> But Marc-Andr=C3=A9 and myself have:
>=20
>  Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
>  Signed-off-by: Marc-Andr=C3=83=C2=A9 Lureau <marcandre.lureau@redhat.c=
om>

I'll fix it.  In the meanwhile, I'll note that we're also improving
Patchew so that it is much better at applying patches via three-way
merge (basically the adding of *-by tags moves from "patchew apply" to
the web stuff) and that should make these UTF-8 issues a thing of the pas=
t.

Paolo
