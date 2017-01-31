Received: from eggs.gnu.org ([2001:4830:134:3::10]:60100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYYP1-00029I-LF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYYOx-0001o2-O7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:23:19 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:30234 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYYOx-0001ne-AE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:23:15 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <s9dlgtr8jdg.fsf@redhat.com>
References: <20170131100945.8189-1-kwolf@redhat.com>
	<w51mve7o4n1.fsf@maestria.local.igalia.com>
	<s9dlgtr8jdg.fsf@redhat.com>
Date: Tue, 31 Jan 2017 14:23:13 +0100
Message-ID: <w51h94fnz26.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike FABIAN <mfabian@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com

On Tue 31 Jan 2017 02:11:07 PM CET, Mike FABIAN <mfabian@redhat.com> wrote:

>> - Is it C.utf-8 or C.UTF-8 ? 'locale -a' shows only the latter in my
>>   system.
>
> Both work:

Hmmm... apparently not in my system:

$ LC_CTYPE=3DC.utf-8 locale
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
LANG=3Den_US.utf8
LANGUAGE=3D
LC_CTYPE=3DC.utf-8
[...]

$ LC_CTYPE=3DC.UTF-8 locale
LANG=3Den_US.utf8
LANGUAGE=3D
LC_CTYPE=3DC.UTF-8

I have glibc 2.24-8 (Debian).

>> - When was this added? This bug seems to be still open:
>>   https://sourceware.org/bugzilla/show_bug.cgi?id=3D17318
>
> Fedora has it since Fedora 24 (spring 2016), Debian for a while
> longer.
>
> I=E2=80=99ll ping again to get it included upstream.

Ah ok, so it's a distro-specific change at the moment.

Thanks,

Berto
