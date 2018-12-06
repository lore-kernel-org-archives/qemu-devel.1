Received: from eggs.gnu.org ([2001:4830:134:3::10]:43073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUmJG-0007nm-OT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUmJ9-0006kA-NT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUmJ7-0006UD-T3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:34:42 -0500
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-2-git-send-email-thuth@redhat.com>
	<31b42ffd-40bb-47c8-4ad4-e8e696596473@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d2072f0-d497-5e56-f0aa-2ec17d6f896d@redhat.com>
Date: Thu, 6 Dec 2018 06:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <31b42ffd-40bb-47c8-4ad4-e8e696596473@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 2018-12-05 18:30, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/3/18 3:05 PM, Thomas Huth wrote:
>> So far we only had implicit requirements for the minimum compiler vers=
ion,
>> e.g. we require at least GCC 4.1 for the support of atomics. However,
>> such old compiler versions are not tested anymore by the developers, s=
o
>> they are not really supported anymore. Since we recently declared expl=
icitly
>> what platforms we intend to support, we can also get more explicit on =
the
>> compiler version now. The supported distributions use the following ve=
rsion
>> of GCC:
>>
>>       RHEL-7: 4.8.5
>>       Debian (Stretch): 6.3.0
>>       Debian (Jessie): 4.8.4
>>       OpenBSD (ports): 4.9.4
>>       FreeBSD (ports): 8.2.0
>>       OpenSUSE Leap 15: 7.3.1
>>       Ubuntu (Xenial): 5.3.1
>>       macOS (Homebrew): 8.2.0
>=20
> I'd like to track this in a machine parsable format, but sure where it
> better fits however, I'd prefer the git repo, and having the wiki
> pointing to the git repo.

I don't think that it makes sense to put fixed version numbers into the
git or wiki - the information will expire soon, and it is additional
maintenance to keep them up to date. We already got the generic
description here:

https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

So you just have to follow these instructions to get to the supported
versions.

 Thomas
