Received: from eggs.gnu.org ([209.51.188.92]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqc4i-000067-R8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqc4h-0007lU-Vu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:06:04 -0500
References: <1549268045-11861-1-git-send-email-thuth@redhat.com>
	<20190204102213.GF1905@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e9068f3c-d4a6-b3a7-d34a-c036e9be86e4@redhat.com>
Date: Mon, 4 Feb 2019 12:06:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190204102213.GF1905@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/sdl_keysym: Remove obsolete SDL1.2
 related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2019-02-04 11:22, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 04, 2019 at 09:14:05AM +0100, Thomas Huth wrote:
>> Support for SDL1.2 has been removed recently in commit:
>>
>>   0015ca5cbabe0b31d31610ddfaafd90a9e5911a4
>>   ("ui: remove support for SDL1.2 in favour of SDL2")
>>
>> So we can drop the SDL1.2-specific code in sdl_keysym.h now, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  ui/sdl_keysym.h | 73 ------------------------------------------------=
---------
>>  1 file changed, 73 deletions(-)
>>
>> diff --git a/ui/sdl_keysym.h b/ui/sdl_keysym.h
>> index 599d9fc..6994180 100644
>> --- a/ui/sdl_keysym.h
>> +++ b/ui/sdl_keysym.h
>> @@ -200,79 +200,6 @@ static const name2keysym_t name2keysym[]=3D{
>>  { "yacute",               0x0fd},
>>  { "thorn",                0x0fe},
>>  { "ydiaeresis",           0x0ff},
>> -#if SDL_MAJOR_VERSION =3D=3D 1
>=20
> Don't why this was ever here, because this file is never used by SDL2.
> SDL1 passed window system native scan codes, while SDL2 always passes
> USB HID scancodes.
>=20
> IOW, you can delete this whole file.

Right, seems like this file is not needed anymore. I'll send a v2...

 Thanks,
  Thomas
