Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cRfjY-00038q-Np
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cRfjT-0001vO-VD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:48:04 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:33786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cRfjT-0001ug-Nb
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:47:59 -0500
Received: by mail-io0-x22f.google.com with SMTP id v96so18527295ioi.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 05:47:59 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <20170112132558.GL3565@thinpad.lan.raisama.net>
References: <20170104205722.26492-1-marcandre.lureau@redhat.com>
	<20170112132558.GL3565@thinpad.lan.raisama.net>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Thu, 12 Jan 2017 14:47:37 +0100
Message-ID: <CAP_ceTy5QZZ=by5vzfT51KyHm0M2-4_LyR-LFQk1-fQfDOVtXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "win32: don't run subprocess tests
 on Mingw32 platform"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jan 12, 2017 at 2:25 PM, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> On Wed, Jan 04, 2017 at 09:57:22PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.
>>
>> The error "Failed to execute helper program (No such file or directory)"
>> is due to broken glib installation, missing windows gspawn helpers.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Daniel, are you still unable to run subprocess tests on Migw32?
>
> Anybody else able to test this and send a Tested-by line?

Works on my setup (mingw32-w64 build on Windows 10, with glib-2.46.2)

Tested-by: Vincent Palatin <vpalatin@chromium.org>

>
>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 218df87d21..54a222d5e7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3077,7 +3077,7 @@ fi
>>
>>  # g_test_trap_subprocess added in 2.38. Used by some tests.
>>  glib_subprocess=3Dyes
>> -if test "$mingw32" =3D "yes" || ! $pkg_config --atleast-version=3D2.38 =
glib-2.0; then
>> +if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
>>      glib_subprocess=3Dno
>>  fi
>>
>> --
>> 2.11.0
>>
>
> --
> Eduardo
>
