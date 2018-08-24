Received: from eggs.gnu.org ([2001:4830:134:3::10]:55136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftECP-0004yv-8I
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftECO-00061Y-Fc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:40:33 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftECO-00060s-2e
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:40:32 -0400
Received: by mail-oi0-x244.google.com with SMTP id c190-v6so16043811oig.6
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:40:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824153648.GX3430@redhat.com>
References: <20180824073256.19626-1-kraxel@redhat.com>
	<CAFEAcA-ZtP8CUSJAE5quaE9Sr=EY9BJcoGqQRH_3EgMXi7y6ww@mail.gmail.com>
	<20180824153648.GX3430@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:40:10 +0100
Message-ID: <CAFEAcA9HfDMTeUyC2FOwVk=9wz9uJYy2_iR_8dt_eOjCxsOrEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Ui2 20180824 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>

On 24 August 2018 at 16:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> On Fri, Aug 24, 2018 at 04:32:54PM +0100, Peter Maydell wrote:
>> On 24 August 2018 at 08:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > The following changes since commit 5ccac548faf041ff5229a8e8342e3be14a3=
4c8af:
>> >
>> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' =
into staging (2018-08-23 17:35:48 +0100)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kraxel.org/qemu tags/ui2-20180824-pull-request
>> >
>> > for you to fetch changes up to eb01505ea6c8330273d189acc053cc60d00bfa1=
a:
>> >
>> >   ui: remove support for SDL1.2 in favour of SDL2 (2018-08-24 09:31:39=
 +0200)
>> >
>> > ----------------------------------------------------------------
>> > ui: remove deprecated UI frontends
>> >
>> > ----------------------------------------------------------------
>> >
>> > Daniel P. Berrang=C3=A9 (3):
>> >   ui: remove support for GTK2 in favour of GTK3
>> >   ui: increase min required GTK3 version to 3.14.0
>> >   ui: remove support for SDL1.2 in favour of SDL2
>>
>> Doesn't the last one of these depend on our fixing the
>> OpenBSD VM first ?
>
> Yep, i mentioned that in my posting of the patch series.

Thought so; dropped from my queue of pullreqs to process. Please
resubmit it when the OpenBSD VM has been fixed. (That is one of my
buildtest setups so this would just fail the pullreq buildtest
otherwise.)

thanks
-- PMM
