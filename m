Received: from eggs.gnu.org ([2001:4830:134:3::10]:48768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8Psg-0002Qo-61
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8Psf-0005pp-C8
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:38:42 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f8Psf-0005pc-3u
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:38:41 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u11so35071460wri.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 05:38:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417153548.53b08fa1@vp-pc>
References: <20180416194011.11969-1-viktor.prutyanov@virtuozzo.com>
	<CAJ+F1CKf=GCJBOqAc5mTs1G7V7+KsPSukcCYjQAnUFdFa-dhEw@mail.gmail.com>
	<20180417153548.53b08fa1@vp-pc>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Apr 2018 14:38:39 +0200
Message-ID: <CAJ+F1C+nxVO2yBtvtmXiB2z2kq6+-x53qvpJ0M-p_z=5BkTeLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Hi

On Tue, Apr 17, 2018 at 2:35 PM, Viktor Prutyanov
<viktor.prutyanov@virtuozzo.com> wrote:
> On Tue, 17 Apr 2018 14:03:18 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
>> Hi
>>
>> On Mon, Apr 16, 2018 at 9:40 PM, Viktor Prutyanov
>> <viktor.prutyanov@virtuozzo.com> wrote:
>> > This patch adds Windows crashdumping feature. Now QEMU can produce
>> > crashdump file understandable for WinDbg. The crashdump will be
>> > obtained by joining physical memory dump and 8K header exposed
>> > through vmcoreinfo/fw_cfg device by guest driver at BSOD time.
>> > Option '-w' was added to dump-guest-memory command. At the moment,
>> > only x64 configuration is supported. Suitable driver can be found at
>> > https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/fw=
cfg64
>> >
>> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
>>
>> Why do you reuse VMCOREINFO_FORMAT_ELF ? It looks like a hack to me. I
>> can imagine there is some code similarity for new format support, like
>> the cpu_physical_memory_read(addr, s->guest_note, size), but what else
>> do you gain from reusing VMCOREINFO_FORMAT_ELF instead of introducing
>> explicitely a new windows dump specific format ? This could really
>> help avoiding some confusion imho
>
> Reuse of VMCOREINFO_FORMAT_ELF makes possible to produce valid ELF-dump
> which can be converted to Windows dump format later with another tool.
>

Ah I didn't get that! could you update the commit message, and/or the
HMP/QMP documentation?

--=20
Marc-Andr=C3=A9 Lureau
