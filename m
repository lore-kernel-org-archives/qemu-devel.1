Received: from eggs.gnu.org ([2001:4830:134:3::10]:39710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJKMS-0001wF-5x
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJKMO-0004D1-Bx
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:58:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJKMO-0004Ci-7p
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:58:28 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
	<CAMxuvazHGsPv9KWQTp7p6JxaPaLPBdw-NgrPN83ne0=SsodVRw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ad78160c-a5d8-18cc-e2ac-9bb97a0c76eb@redhat.com>
Date: Thu, 17 May 2018 16:58:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAMxuvazHGsPv9KWQTp7p6JxaPaLPBdw-NgrPN83ne0=SsodVRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: edk2-devel@lists.01.org, qemu-devel <qemu-devel@nongnu.org>, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 05/17/18 16:43, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, May 16, 2018 at 11:29 AM, Laszlo Ersek <lersek@redhat.com> wrot=
e:

>>   - the "xfuncname"-related settings, so that git diff hunk headers @@
>>     are useful for DSC and INF files too,
>>
>=20
> This is already in my .git/config, I hope it takes it by default in
> format-patch?

You also need to classify files appropriately so that the xfuncname
setting apply to them:

https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt-gi=
t-guide-for-edk2-contributors-and-maintainers#contrib-09

>> Not much of a review, I know; this is all I can offer right now. If yo=
u
>> have the time to respin just with these superficial changes, that migh=
t
>> make my life easier. If you prefer to delay them, that's 100% fine too=
.
>>
>=20
> I am going to resend with the style fixes.

I managed to review your v1 in full earlier today, so I'd prefer to
review your v3, with my more in-depth comments addressed as well.

Thanks!
Laszlo
