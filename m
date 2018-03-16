Received: from eggs.gnu.org ([2001:4830:134:3::10]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ewqAq-0007fT-JA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ewqAp-0005lv-QU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:17:36 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ewqAp-0005lT-JG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:17:35 -0400
Received: by mail-wr0-x241.google.com with SMTP id s18so11832877wrg.9
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:17:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cf62af9e-39f8-deeb-0465-118a9547c212@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-4-marcandre.lureau@redhat.com>
	<cf62af9e-39f8-deeb-0465-118a9547c212@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 16 Mar 2018 15:17:33 +0100
Message-ID: <CAJ+F1CL5xkEaD9Tkzy=zkJKBejOwYEEBhB=1q36d53=xgdgYLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost-user-test: add back memfd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

Hi Paolo,

Could you pick the remaining fixes acked by Maxime?

thanks

On Fri, Feb 23, 2018 at 3:23 PM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
> On 02/15/2018 10:25 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> This revert commit fb68096da3d35e64c88cd610c1fa42766c58e92a, and
>> modify test_read_guest_mem() to use different chardev names, when
>> using memfd (_test_server_free(), where the chardev is removed, runs
>> in idle).
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
>> ---
>>   tests/vhost-user-test.c | 93
>> +++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 66 insertions(+), 27 deletions(-)
>
>
> Looks good to me:
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

--=20
Marc-Andr=C3=A9 Lureau
