Received: from eggs.gnu.org ([2001:4830:134:3::10]:55112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUrom-0000lo-CW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUrol-0006sh-4l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:55:28 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUrok-0006s6-HD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:55:26 -0400
Received: by mail-oi0-x242.google.com with SMTP id k190-v6so14385558oib.9
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 03:55:26 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Jun 2018 11:55:05 +0100
Message-ID: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] enabling smart-http git protocol on git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Iliya Dyachenko <gandalfthewhite@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 18 June 2018 at 10:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Mon, Jun 18, 2018 at 12:32:01PM +0300, Iliya Dyachenko wrote:
>> Signed-off-by: Iliya Dyachenko <gandalfthewhite@mail.ru>
>> ---
>>  .gitmodules | 32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index 49e9c2e3f4..e6bc732d16 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -1,48 +1,48 @@
>>  [submodule "roms/vgabios"]
>>       path =3D roms/vgabios
>> -     url =3D git://git.qemu-project.org/vgabios.git/
>> +     url =3D https://git.qemu.org/git/vgabios.git
>
> [snip]
>
> This is highly desirable, however, we cannot do it right now.
>
> The git.qemu.org server is still using the dumb git http protocol, so it
> would be a performance regression over git://
>
> We need the server config fixing to use the smart http protocol.
>
> Essentially this just involves configuring apache to add
>
>   <Directory /usr/libexec/git-core>
>     Allow from all
>   </Directory>
>
>   SetEnv GIT_PROJECT_ROOT /data/git
>
>   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
>     /usr/libexec/git-core/git-http-backend/$1
>   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
>     /usr/libexec/git-core/git-http-backend/$1

Sounds like a good idea -- I've cc'd Jeff and Stefan (who
are the people who care for our git server)...

thanks
-- PMM
